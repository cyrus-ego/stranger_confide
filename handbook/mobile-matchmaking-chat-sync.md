# Mobile handoff: đồng bộ Matchmaking và Chat với Backend

> Tài liệu bàn giao cho mobile dựa trên commit `e22fc41c31fc41497ffa7f55b5b88edc67d5aa0f` và trạng thái backend hiện tại tại commit `56a1da3`.
>
> Cập nhật: 27/07/2026.

## 1. Phạm vi thay đổi

Commit `e22fc41` có tên `upgrade socket`. Commit này **không thay đổi thuật toán matchmaking**. Các thay đổi chính nằm ở socket chat:

- Thêm grace period 60 giây cho trạng thái online/offline trong phòng chat.
- Disconnect khỏi chat không còn đồng nghĩa với rời hoặc đóng phòng.
- Phân biệt rõ phòng đã đóng (`room:closed`) và không có quyền truy cập (`room:access_denied`).
- Chuẩn hóa lỗi chat với `code` ổn định.
- Kiểm tra active room và quyền participant trước khi gửi tin, typing, leave hoặc block.
- Bỏ cache room 60 giây để tránh thao tác trên room vừa bị đóng.
- Thống nhất quy trình đóng phòng giữa Socket.IO và REST.
- Khi join room, trả 100 tin nhắn mới nhất theo thứ tự cũ đến mới.

Backend hiện tại có thêm commit `56a1da3`, bổ sung REST API load-more tin nhắn cũ. Commit này không thay đổi logic ghép đôi hoặc presence.

## 2. Hai loại trạng thái chờ cần phân biệt

Mobile phải phân biệt hai trạng thái hoàn toàn khác nhau:

1. **Đang chờ ghép đôi** trên namespace `/matchmaking`.
2. **Đã có phòng nhưng đối phương đang offline/reconnect** trên namespace `/chat`.

| Trạng thái | Timeout/grace | Khi socket disconnect |
| --- | ---: | --- |
| Đang chờ ghép đôi | Tối đa 300 giây | Bị xóa khỏi queue ngay |
| Đã ghép và đang chat | Grace presence mặc định 60 giây | Room vẫn active, chưa báo offline ngay |

Không được áp dụng grace 60 giây của chat cho hàng đợi matchmaking.

## 3. Kết nối Socket.IO

Backend dùng hai namespace riêng:

```text
/matchmaking
/chat
```

Token được truyền trong Socket.IO handshake:

```json
{
  "auth": {
    "token": "<access_token>"
  }
}
```

Backend cũng chấp nhận header:

```http
Authorization: Bearer <access_token>
```

Nếu token thiếu hoặc không hợp lệ, backend chủ động disconnect socket.

## 4. State machine đề xuất cho mobile

```text
IDLE
  -> MATCHMAKING_CONNECTING
  -> IN_QUEUE
       -> MATCH_FOUND
       -> QUEUE_TIMEOUT
       -> QUEUE_LEFT
       -> SOCKET_DISCONNECTED (không còn trong queue)
  -> CHAT_CONNECTING
  -> ROOM_JOINING
  -> IN_ROOM
       -> PARTNER_OFFLINE
       -> RECONNECTING (room vẫn active)
       -> ROOM_CLOSED
       -> ACCESS_DENIED
```

Khi app resume hoặc socket reconnect, không nên chỉ dựa vào state lưu local. Mobile phải hỏi backend để khôi phục trạng thái thật.

## 5. Luồng matchmaking khuyến nghị

### 5.1 Socket-first

Đây là luồng khuyến nghị vì đơn giản và ít race condition hơn:

1. Đăng ký toàn bộ listener của namespace `/matchmaking`.
2. Connect socket với access token.
3. Khi nhận `connect`, emit `queue:join`.
4. Dựng UI từ `queue:joined` và `queue:position`.
5. Khi nhận `match:found`, chuyển sang luồng chat.

Mobile emit:

```text
event: queue:join
```

```json
{
  "preference": "male"
}
```

Giá trị hợp lệ:

```text
male
female
other
```

Backend yêu cầu profile có cả `gender` và `age`. Nếu thiếu, join queue thất bại.

### 5.2 REST-first

REST endpoint:

```http
POST /api/matchmaking/join
Authorization: Bearer <access_token>
Content-Type: application/json
```

```json
{
  "preference": "female"
}
```

Sau đó mobile phải:

1. Connect namespace `/matchmaking`.
2. Emit `queue:sync` không kèm payload.

```text
event: queue:sync
payload: none
```

Khi xử lý `queue:sync`, backend sẽ:

1. Kiểm tra pending match trước.
2. Nếu có pending match, gửi ngay `match:found`.
3. Nếu chưa match, cập nhật socket ID cho queue entry.
4. Nếu entry vẫn còn trong queue, gửi `queue:joined` và tiếp tục tìm người.
5. Nếu entry đã timeout, gửi `queue:timeout`.

Pending match chỉ được giữ trong Redis 120 giây.

Mobile nên chọn một trong hai luồng Socket-first hoặc REST-first, không gọi cả `queue:join` và REST join cho cùng một thao tác người dùng nếu không cần thiết.

## 6. Logic ghép đôi phía backend

### 6.1 Điều kiện hợp lệ

Hai user A và B chỉ match khi đồng thời thỏa mãn:

```text
A.preference == B.gender
B.preference == A.gender
```

Ngoài ra:

- A và B không được là cùng một user.
- Không có block giữa hai user ở bất kỳ chiều nào.
- Queue entry của cả hai còn hạn.
- Profile lúc join queue có `gender` và `age`.

Ví dụ:

| User | Gender | Preference | Kết quả |
| --- | --- | --- | --- |
| A | male | female | Chỉ match B có gender=female và preference=male |
| B | female | male | Match được A |

Nếu A chọn `female` nhưng B không chọn `male`, hai người không match.

### 6.2 FIFO và position

Backend lưu queue bằng Redis sorted set, score là thời điểm join. Khi tìm candidate, backend duyệt từ người chờ lâu nhất.

`position` là rank trong **toàn bộ queue**, không phải rank trong nhóm candidate tương thích. Vì vậy position giảm không đảm bảo user kế tiếp chắc chắn match được.

### 6.3 Chống ghép trùng

Backend dùng Redis lock và Lua script để claim đồng thời cả hai queue entry. Khi claim thành công:

- Cả hai bị xóa khỏi queue.
- Không user nào có thể bị claim lần thứ hai.
- Backend tạo một room mới cho hai người.

## 7. Contract event matchmaking

### 7.1 `queue:joined`

Backend gửi khi user vào queue hoặc đồng bộ lại một queue entry đang tồn tại:

```json
{
  "inQueue": true,
  "position": 2,
  "queueSize": 5,
  "waitSeconds": 45,
  "expiresInSeconds": 255,
  "preference": "female",
  "timedOut": false
}
```

### 7.2 `queue:position`

Backend gửi khoảng mỗi 3 giây, payload cùng cấu trúc với `queue:joined`.

Mobile nên dùng `waitSeconds` và `expiresInSeconds` từ server làm nguồn dữ liệu chuẩn. Có thể chạy countdown local giữa hai lần event để UI mượt, nhưng phải hiệu chỉnh lại khi event mới đến.

### 7.3 `match:found`

```json
{
  "roomId": "f47ac10b-58cc-4372-a567-0e02b2c3d479",
  "partnerId": "665a1b2c3d4e5f6789012347"
}
```

Khi nhận event này:

1. Lưu `roomId` vào state phiên hiện tại.
2. Dừng countdown/animation matchmaking.
3. Chuyển sang namespace `/chat`.
4. Đăng ký listener chat trước khi emit `room:join`.

### 7.4 `queue:timeout`

Queue timeout cố định sau 300 giây tính từ `joinedAt` ban đầu:

```json
{
  "message": "Hết thời gian chờ (5 phút)"
}
```

Emit lại `queue:join` trong lúc queue entry vẫn tồn tại chỉ cập nhật socket ID và preference; thao tác này không reset 5 phút.

### 7.5 `queue:leave` và `queue:left`

Mobile chủ động rời queue:

```text
emit: queue:leave
payload: none
```

Backend xác nhận:

```text
event: queue:left
payload: none
```

REST fallback:

```http
DELETE /api/matchmaking/leave
```

### 7.6 `error` trên matchmaking

Hiện tại lỗi socket matchmaking chưa dùng bộ code chuẩn như chat. Payload thường là:

```json
{
  "message": "Không thể vào hàng đợi"
}
```

Mobile không nên giả định matchmaking `error` luôn có `code`.

## 8. Disconnect, background và khôi phục matchmaking

### 8.1 Hành vi hiện tại

Khi socket `/matchmaking` disconnect, backend:

- Dừng position timer.
- Xóa queue entry khỏi Redis.
- Xóa user khỏi sorted set.

Điều này xảy ra ngay lập tức, không có grace period.

### 8.2 Luồng resume/reconnect bắt buộc

Khi app được mở lại hoặc mạng hồi phục:

1. Gọi `GET /api/rooms/active`.
2. Nếu `hasActiveRoom=true`, vào lại room đó.
3. Nếu không có active room, có thể gọi `GET /api/matchmaking/status` để đồng bộ UI.
4. Nếu `inQueue=false`, hiển thị trạng thái đã dừng tìm hoặc emit `queue:join` lại nếu UX yêu cầu và người dùng đã đồng ý.

Không nên tự động hiển thị “đang tìm người” chỉ dựa trên state lưu trong máy.

API kiểm tra active room:

```http
GET /api/rooms/active
```

Phần `data` của REST response:

```json
{
  "hasActiveRoom": true,
  "roomId": "f47ac10b-58cc-4372-a567-0e02b2c3d479"
}
```

Việc kiểm tra active room trước rất quan trọng vì có thể room đã được tạo nhưng mobile mất kết nối đúng lúc `match:found` được gửi.

## 9. Luồng vào phòng chat

Namespace:

```text
/chat
```

Sau khi connect, mobile emit:

```text
event: room:join
```

```json
{
  "roomId": "f47ac10b-58cc-4372-a567-0e02b2c3d479"
}
```

Backend có auto-join socket vào active Socket.IO room khi kết nối, nhưng **không tự gửi `room:joined`**. Mobile vẫn phải emit `room:join` sau mỗi lần connect/reconnect để nhận session và message history.

Thứ tự bắt buộc:

1. Đăng ký `room:joined`, `room:closed`, `room:access_denied`, `room:presence`, `chat:message`, `chat:typing` và `error`.
2. Connect `/chat`.
3. Khi nhận `connect`, emit `room:join`.

## 10. Contract event chat

### 10.1 `room:joined`

```json
{
  "session": {
    "roomId": "f47ac10b-58cc-4372-a567-0e02b2c3d479",
    "myAlias": "Stranger#7482",
    "myAvatar": "https://...",
    "partnerAlias": "Stranger#2910",
    "partnerAvatar": "https://...",
    "partnerOnline": true,
    "isAnonymous": true
  },
  "partnerUserId": "665a1b2c3d4e5f6789012347",
  "messages": []
}
```

`messages` chứa tối đa 100 tin nhắn mới nhất, loại trừ system message đã lưu. Mảng được trả theo thứ tự từ cũ đến mới để mobile append trực tiếp vào danh sách chat.

`partnerOnline` có thể vẫn là `true` trong grace period 60 giây dù socket của partner vừa disconnect.

### 10.2 `room:presence`

```json
{
  "userId": "665a1b2c3d4e5f6789012347",
  "online": true
}
```

Mobile chỉ cập nhật presence của partner khi `userId` bằng `partnerUserId` của room hiện tại.

### 10.3 `chat:send`

Socket event này chỉ dùng cho text:

```text
event: chat:send
```

```json
{
  "roomId": "f47ac10b-58cc-4372-a567-0e02b2c3d479",
  "type": "text",
  "content": "Xin chào"
}
```

Backend trim content, kiểm tra active room, participant, blocklist và moderation trước khi lưu.

Không emit ảnh qua `chat:send`. Ảnh dùng REST upload:

```http
POST /api/chat/:roomId/image
Content-Type: multipart/form-data
```

### 10.4 `chat:message`

```json
{
  "id": "665a1b2c3d4e5f6789012348",
  "senderAlias": "Stranger#7482",
  "type": "text",
  "content": "Xin chào",
  "createdAt": "2026-07-27T10:00:00.000Z"
}
```

Tin ảnh có thêm `imageUrl`. Tin system có `type="system"`.

### 10.5 `chat:typing`

Mobile emit:

```json
{
  "roomId": "f47ac10b-58cc-4372-a567-0e02b2c3d479",
  "isTyping": true
}
```

Đối phương nhận:

```json
{
  "isTyping": true
}
```

Backend chỉ broadcast typing nếu room còn active và sender là participant.

### 10.6 `room:access_denied`

Event này chỉ biểu thị user không phải participant của room:

```json
{
  "code": "ACCESS_DENIED",
  "roomId": "f47ac10b-58cc-4372-a567-0e02b2c3d479",
  "message": "Không có quyền vào phòng này"
}
```

Mobile phải xóa room state local và điều hướng khỏi màn chat.

### 10.7 `room:closed`

Phòng không tồn tại, đã đóng hoặc vừa được một bên đóng:

```json
{
  "roomId": "f47ac10b-58cc-4372-a567-0e02b2c3d479",
  "reason": "ROOM_CLOSED",
  "message": "Phòng đã đóng"
}
```

Đây là terminal event. Khi nhận event, mobile phải:

- Dừng typing và presence timer.
- Xóa room/session/draft state.
- Không gửi thêm event vào room cũ.
- Điều hướng về màn matchmaking hoặc màn kết thúc phiên.

Mobile không được tiếp tục dùng logic cũ coi room đã đóng là `room:access_denied`.

### 10.8 `error` trên chat

Payload chuẩn:

```json
{
  "code": "MODERATION_BLOCKED",
  "message": "Nội dung không phù hợp với quy tắc cộng đồng"
}
```

Các code hiện có:

| Code | Ý nghĩa | Xử lý mobile đề xuất |
| --- | --- | --- |
| `MODERATION_BLOCKED` | Nội dung hoặc ảnh bị moderation chặn | Giữ room, hiển thị message lỗi |
| `SPAM_DETECTED` | Phát hiện spam | Giữ room, chặn/retry theo UX |
| `ROOM_CLOSED` | Room không còn active | Dọn room và điều hướng ra ngoài |
| `ACCESS_DENIED` | Không có quyền hoặc bị block | Không retry thao tác hiện tại |
| `MESSAGE_SEND_FAILED` | Dữ liệu không hợp lệ hoặc gửi thất bại | Hiển thị lỗi và cho retry nếu phù hợp |

Mobile phải switch theo `code`; `message` chỉ dùng để hiển thị.

## 11. Presence và reconnect trong phòng chat

Biến cấu hình backend:

```env
CHAT_PRESENCE_TTL_MS=60000
```

Logic khi mất kết nối:

1. Backend xóa socket vừa disconnect khỏi presence map.
2. Nếu user vẫn còn socket khác trong cùng room, user vẫn online.
3. Nếu không còn socket nào, backend bắt đầu grace timer.
4. Nếu user reconnect trong grace period, timer bị hủy.
5. Nếu quá grace period vẫn không có socket, backend gửi `room:presence` với `online=false`.

Điểm cần lưu ý:

- Disconnect chat không đóng room.
- Mobile không được điều hướng khỏi room chỉ vì event `disconnect`.
- Khi reconnect, mobile phải emit lại `room:join`.
- Có thể hiển thị trạng thái “Đang kết nối lại…” trong lúc socket mất kết nối.
- Chỉ hiển thị đối phương offline khi nhận `room:presence { online: false }` hoặc khi `room:joined.session.partnerOnline=false`.

## 12. Chủ động đóng phòng

### 12.1 Leave bằng socket

```text
event: room:leave
```

```json
{
  "roomId": "f47ac10b-58cc-4372-a567-0e02b2c3d479"
}
```

### 12.2 Leave bằng REST fallback

```http
POST /api/rooms/:roomId/leave
```

### 12.3 Block trong room

```text
event: room:block
```

```json
{
  "roomId": "f47ac10b-58cc-4372-a567-0e02b2c3d479",
  "targetUserId": "665a1b2c3d4e5f6789012347"
}
```

Khi leave hoặc block thành công, backend:

1. Gửi `chat:message` loại `system`.
2. Gửi `room:closed`.
3. Đóng room trong database.
4. Xóa tin nhắn tạm của room.
5. Xóa moderation spam tracker.
6. Cho toàn bộ socket rời Socket.IO room.

System message có đầy đủ contract:

```json
{
  "id": "system-<roomId>-<timestamp>",
  "senderAlias": "System",
  "type": "system",
  "content": "Đối phương đã rời phòng.",
  "createdAt": "2026-07-27T10:00:00.000Z"
}
```

Mobile vẫn phải dùng `room:closed` làm tín hiệu terminal, không phụ thuộc việc có nhận được system message hay không.

## 13. Load-more tin nhắn cũ

Backend hiện tại hỗ trợ:

```http
GET /api/chat/:roomId/messages?beforeMessageId=<oldestMessageId>&limit=50
```

Quy tắc:

- `limit` mặc định 50.
- `limit` hợp lệ từ 1 đến 100.
- `beforeMessageId` là ID tin nhắn cũ nhất mobile đang có.
- Response `messages` luôn theo thứ tự cũ đến mới.
- Chỉ participant của active room được đọc.

Phần `data` trong REST envelope:

```json
{
  "messages": [],
  "nextBeforeMessageId": "665a1b2c3d4e5f6789012340",
  "hasMore": true
}
```

Page kế tiếp:

```text
beforeMessageId = nextBeforeMessageId
```

Khi prepend page cũ vào UI, mobile nên deduplicate theo `message.id`.

## 14. REST response envelope

Mọi REST API được bọc trong cấu trúc chung:

```json
{
  "success": true,
  "statusCode": 200,
  "code": "OK",
  "message": "Thành công",
  "data": {},
  "errors": null,
  "meta": null,
  "requestId": "...",
  "path": "/api/...",
  "timestamp": "2026-07-27T10:00:00.000Z"
}
```

Các payload REST được mô tả trong tài liệu này đều nằm trong field `data`. Socket.IO payload không dùng envelope này.

## 15. Checklist triển khai cho mobile

### Matchmaking

- [ ] Kết nối đúng namespace `/matchmaking` và truyền access token trong handshake.
- [ ] Đăng ký listener trước khi emit `queue:join` hoặc `queue:sync`.
- [ ] Dùng đúng preference: `male`, `female`, `other`.
- [ ] Dùng `waitSeconds` và `expiresInSeconds` từ server.
- [ ] Xử lý `queue:joined`, `queue:position`, `match:found`, `queue:timeout`, `queue:left` và `error`.
- [ ] Hiểu rằng disconnect matchmaking sẽ rời queue ngay.
- [ ] Khi app resume, kiểm tra active room trước khi join queue lại.
- [ ] Không giả định `position` là vị trí trong nhóm tương thích.

### Chat

- [ ] Sau `match:found`, connect namespace `/chat`.
- [ ] Đăng ký listener chat trước khi emit `room:join`.
- [ ] Emit lại `room:join` sau mỗi lần chat socket reconnect.
- [ ] Dựng room state từ `room:joined`, không chỉ từ `match:found`.
- [ ] Phân biệt `room:closed` với `room:access_denied`.
- [ ] Xử lý chat `error` theo `code`.
- [ ] Không đóng room khi chỉ nhận socket `disconnect`.
- [ ] Chỉ đánh dấu partner offline theo `room:presence` hoặc `session.partnerOnline`.
- [ ] Khi nhận `room:closed`, dọn toàn bộ room state và điều hướng ra ngoài.
- [ ] Chỉ emit text qua `chat:send`; ảnh dùng REST upload.
- [ ] Deduplicate message theo `id` khi reconnect hoặc load-more.

## 16. Các file backend tham chiếu

- `src/modules/matchmaking/matchmaking.gateway.ts`
- `src/modules/matchmaking/matchmaking.service.ts`
- `src/modules/matchmaking/matchmaking.controller.ts`
- `src/modules/matchmaking/dto/queue-status.dto.ts`
- `src/modules/chat/chat.gateway.ts`
- `src/modules/chat/chat.service.ts`
- `src/modules/chat/chat-error-code.ts`
- `src/modules/chat/dto/chat-response.dto.ts`
- `src/modules/room/room.controller.ts`
- `src/modules/room/room.service.ts`

