# Mobile Chat Room — Specification cho Agent Flutter

> Tài liệu mô tả đầy đủ tính năng Chat Room trên mobile.
> Agent đọc file này + `ERROR_RESPONSE.md` + `MATCHMAKING.md` để implement.

---

## 1. Tổng quan

App "Talk First" — kết nối trò chuyện riêng tư 1:1 real-time.
Sau matchmaking thành công, cả 2 user vào phòng chat qua `roomId`.

**Nguyên tắc bất biến:**
- Dùng bí danh — UI chỉ hiện `senderAlias` (Member#XXXX) + avatar DiceBear
- Phòng chỉ đóng khi chủ động rời/block — mất mạng/background KHÔNG đóng phòng
- Tin nhắn tạm — server xoá khi phòng đóng
- Socket ưu tiên, REST fallback — gửi tin qua socket; rời/block dùng REST nếu socket chết

---

## 2. Socket Protocol — Namespace `/chat`

### 2.1 Connect

```dart
socket = io("http://<host>:3000/chat", {
  "auth": { "token": accessToken },
  "autoConnect": false,
  "transports": ["websocket"],
});
```

JWT verify lúc handshake. Token invalid/expired → server disconnect ngay.

### 2.2 Events: Client → Server

| Event | Payload | Khi nào |
|-------|---------|---------|
| `room:join` | `{ "roomId": "uuid" }` | Vào phòng / reconnect |
| `chat:send` | `{ "roomId": "uuid", "type": "text", "content": "..." }` | Gửi tin text |
| `chat:typing` | `{ "roomId": "uuid", "isTyping": true\|false }` | User đang gõ |
| `room:leave` | `{ "roomId": "uuid" }` | Chủ động rời phòng |
| `room:block` | `{ "roomId": "uuid", "targetUserId": "id" }` | Block user |

### 2.3 Events: Server → Client

| Event | Payload | Ý nghĩa |
|-------|---------|---------|
| `room:joined` | RoomJoinedPayload | Join thành công |
| `chat:message` | ChatMessage | Tin nhắn mới (text/image/system) |
| `chat:typing` | `{ "isTyping": bool }` | Partner đang gõ |
| `room:presence` | `{ "userId": "...", "online": bool }` | Partner online/offline |
| `room:closed` | `{ "roomId": "..." }` | Phòng đã đóng |
| `room:access_denied` | `{ "roomId": "...", "message": "..." }` | Không có quyền |
| `error` | `{ "message": "..." }` | Lỗi (moderation, spam) |

---

## 3. Data Models

### 3.1 RoomJoinedPayload (nhận từ `room:joined`)

```json
{
  "session": {
    "roomId": "f47ac10b-58cc-4372-a567-0e02b2c3d479",
    "myAlias": "Member#7482",
    "myAvatar": "https://api.dicebear.com/7.x/avataaars/svg?seed=abc",
    "partnerAlias": "Member#1234",
    "partnerAvatar": "https://api.dicebear.com/7.x/avataaars/svg?seed=xyz",
    "partnerOnline": true,
    "isAnonymous": true
  },
  "partnerUserId": "665a1b2c3d4e5f6789012347",
  "messages": [ ChatMessage, ... ]
}
```

- `partnerUserId` dùng cho block/report — **KHÔNG hiển thị trên UI**
- `messages` là lịch sử tạm (nếu reconnect vào phòng đang active)

### 3.2 ChatMessage (nhận từ `chat:message` + trong `messages[]`)

```json
{
  "id": "665a1b2c3d4e5f6789012348",
  "senderAlias": "Member#7482",
  "type": "text | image | system",
  "content": "Xin chào!",
  "imageUrl": "http://host:3000/uploads/chat/abc.jpg",
  "createdAt": "2026-05-26T09:00:01.234Z"
}
```

| Field | Mô tả |
|-------|--------|
| `id` | MongoDB ObjectId dạng string |
| `senderAlias` | Alias ẩn danh của người gửi |
| `type` | `text` (tin text), `image` (tin ảnh), `system` (thông báo hệ thống) |
| `content` | Nội dung text (rỗng nếu image) |
| `imageUrl` | URL ảnh đầy đủ (rỗng nếu text) |
| `createdAt` | ISO 8601 timestamp |

### 3.3 Phân biệt tin mình / tin partner

```dart
final isMe = message.senderAlias == session.myAlias;
// isMe → bubble bên phải (primary color)
// !isMe → bubble bên trái (grey)
// type == "system" → text nhỏ, center, italic
```

---

## 4. Flow chi tiết

### 4.1 Vào phòng chat

```
1. Nhận roomId (từ match:found hoặc GET /api/rooms/active)
2. Đăng ký TẤT CẢ socket listeners TRƯỚC khi connect (tránh race condition!)
3. socket.connect()
4. Khi event "connect" → socket.emit("room:join", { roomId })
5. Nhận "room:joined" → lưu session + render messages history
6. Nếu nhận "room:access_denied" → navigate home
```

**QUAN TRỌNG:** Đăng ký listeners trước connect. Nếu ngược lại sẽ miss events.

### 4.2 Gửi tin nhắn text

```
1. User nhập text + nhấn Send
2. socket.emit("chat:send", { roomId, type: "text", content: text.trim() })
3. Clear input field ngay lập tức
4. KHÔNG thêm tin vào list ngay — chờ server broadcast "chat:message"
5. Nhận "chat:message" (senderAlias == myAlias) → thêm vào list → scroll to bottom
```

**Tại sao không optimistic?**  
Vì tin nhắn phải qua moderation. Nếu vi phạm, server emit `error` thay vì `chat:message`.

### 4.3 Gửi ảnh

```
1. Mở image_picker → chọn ảnh từ gallery/camera
2. Validate client-side: JPEG/PNG/WebP/GIF, max 5MB
3. POST /api/chat/:roomId/image (multipart, field name: "image")
4. Server moderation + lưu + broadcast "chat:message" { type: "image", imageUrl: "..." }
5. Cả 2 user nhận event → hiển thị thumbnail
```

### 4.4 Typing indicator

```
1. User bắt đầu gõ → emit "chat:typing" { roomId, isTyping: true }
2. Debounce 2 giây: nếu ngừng gõ → emit { isTyping: false }
3. Nhận "chat:typing" { isTyping: true } → hiện "Member#1234 đang nhập..."
4. Nhận { isTyping: false } → ẩn indicator
```

Lưu ý: chỉ emit khi trạng thái thay đổi (không spam emit liên tục).

### 4.5 Rời phòng

```dart
if (socket.connected) {
  // Ưu tiên socket — nhanh, partner nhận real-time
  socket.once("room:closed", (_) => socket.disconnect());
  socket.emit("room:leave", { "roomId": roomId });
  // Timeout 3s đề phòng server không phản hồi
  Timer(3s, () => socket.disconnect());
} else {
  // Fallback REST — socket chết (mất mạng, app resume)
  await apiClient.post("/rooms/$roomId/leave");
}
clearLocalState();
navigateHome();
```

### 4.6 Block user

```dart
if (socket.connected) {
  socket.once("room:closed", (_) => socket.disconnect());
  socket.emit("room:block", { "roomId": roomId, "targetUserId": partnerUserId });
  Timer(3s, () => socket.disconnect());
} else {
  await apiClient.post("/rooms/$roomId/block", body: { "targetUserId": partnerUserId });
}
clearLocalState();
navigateHome();
```

### 4.7 Report user

```dart
await apiClient.post("/moderation/report", body: {
  "roomId": roomId,
  "reportedUserId": partnerUserId,
  "reason": selectedReason,         // "spam" | "harassment" | "inappropriate_content" | "personal_info" | "other"
  "description": optionalText,      // max 500 chars
});
showToast("Đã báo cáo");
// KHÔNG đóng phòng — user có thể tiếp tục chat hoặc block sau
```

### 4.8 Partner rời/bị block

```
Nhận "room:closed" →
  showDialog("Cuộc trò chuyện đã kết thúc")
  Nút: "Tìm người mới" → navigate matchmaking
  Nút: "Trang chủ" → navigate home
```

### 4.9 Reconnect (App lifecycle)

```
App resume (foreground):
  1. GET /api/rooms/active
     ├─ hasActiveRoom: true, roomId
     │   → connect socket /chat
     │   → emit room:join { roomId }
     │   → nhận room:joined + messages (tin nhắn missed khi offline)
     └─ hasActiveRoom: false
         → Home screen

App background:
  - OS sẽ kill socket → phòng vẫn active
  - Không cần xử lý gì đặc biệt
```

---

## 5. REST API

| Method | Endpoint | Body | Response | Khi nào |
|--------|----------|------|----------|---------|
| GET | `/api/rooms/active` | — | `{ hasActiveRoom, roomId }` | App startup/resume |
| GET | `/api/rooms/:roomId` | — | RoomSession + partnerUserId | Lấy info phòng |
| POST | `/api/rooms/:roomId/leave` | — | `{ message }` | Rời phòng (REST fallback) |
| POST | `/api/rooms/:roomId/block` | `{ targetUserId }` | `{ message }` | Block (REST fallback) |
| POST | `/api/chat/:roomId/image` | multipart `image` | ChatMessage | Upload ảnh |
| POST | `/api/moderation/report` | `{ roomId, reportedUserId, reason, description? }` | `{ message }` | Báo cáo |

Tất cả cần header `Authorization: Bearer <accessToken>`.

---

## 6. Error Handling

### Socket errors (nhận event `error`):

| Message chứa | Nguyên nhân | UI |
|--------------|-------------|-----|
| "vi phạm" / "nội quy" | Moderation chặn tin | Toast cảnh báo, tin không được gửi |
| "quá nhanh" / "spam" | Anti-spam | Toast + disable input 2-3 giây |
| "Không thể gửi" | User bị block | Room closed |

### REST errors (ApiCode):

| Code | Khi nào | UI |
|------|---------|-----|
| `ROOM_NOT_FOUND` | Phòng đã đóng | Toast + navigate home |
| `ROOM_FORBIDDEN` | Không phải participant | Toast + navigate home |
| `CHAT_MODERATION_BLOCKED` | Tin nhắn vi phạm | Toast cảnh báo |
| `CHAT_SPAM_DETECTED` | Gửi quá nhanh | Toast + cooldown |
| `UPLOAD_INVALID_FILE` | Ảnh sai format | Toast "Chỉ hỗ trợ JPEG/PNG/WebP/GIF" |
| `UPLOAD_TOO_LARGE` | Ảnh > 5MB | Toast "Ảnh tối đa 5MB" |
| `RATE_LIMITED` | Quá nhiều request | Toast "Thử lại sau" |
| `AUTH_UNAUTHORIZED` | Token expired | Refresh token rồi retry |

---

## 7. UI Specification

### 7.1 Header

```
┌─────────────────────────────────────────┐
│ [←]  (●) Member#1234      [online]  [⋮]│
└─────────────────────────────────────────┘
```

- Avatar tròn DiceBear (partnerAvatar)
- `partnerAlias` text
- Dot: xanh (online) / xám (offline) — dựa vào `room:presence`
- Menu [⋮] → Bottom sheet: Report | Block | Rời phòng

### 7.2 Message List

```
┌─────────────────────────────────────────┐
│                                         │
│         ┌──────────────┐                │
│         │ Xin chào!    │  ← partner     │
│         └──────────────┘                │
│                                         │
│                ┌──────────────┐         │
│    mình →     │ Chào bạn :)  │         │
│                └──────────────┘         │
│                                         │
│      --- Member#1234 đang nhập... ---   │
│                                         │
└─────────────────────────────────────────┘
```

- ListView reverse, scroll to bottom on new message
- Bubble trái (partner): border radius top-left = 0, màu grey/surface
- Bubble phải (mình): border radius top-right = 0, màu primary
- Image: thumbnail max-width 200, tap → fullscreen Hero animation
- System: text center, italic, nhỏ, màu muted
- Timestamp group: hiện khi gap giữa 2 tin > 5 phút

### 7.3 Input Bar

```
┌─────────────────────────────────────────┐
│ [📷]  [  Nhập tin nhắn...        ] [➤] │
└─────────────────────────────────────────┘
```

- TextField rounded + icon camera bên trái + icon send bên phải
- Send disabled khi text rỗng (màu muted)
- Khi đang upload: camera icon → CircularProgressIndicator
- Input gọi typing handler (debounced)

### 7.4 Dialogs

**Block confirm:**
```
"Chặn Member#1234?"
"Phòng sẽ bị đóng. Bạn sẽ không ghép lại với người này."
[Huỷ]  [Chặn]
```

**Report bottom sheet:**
```
"Báo cáo Member#1234"
○ Spam
○ Quấy rối
○ Nội dung không phù hợp
○ Lộ thông tin cá nhân
○ Khác
[Mô tả thêm (tuỳ chọn)...]
[Gửi báo cáo]
```

**Room closed:**
```
"Cuộc trò chuyện đã kết thúc"
"Tin nhắn không được lưu."
[Tìm người mới]  [Trang chủ]
```

### 7.5 Theme
- Dark mode mặc định
- Primary color cho bubble mình
- Rounded corners (16px)
- Safe area (notch, bottom bar)
- Haptic feedback: nhấn send, nhận tin mới

---

## 8. Cấu trúc code đề xuất

```
features/chat/
├── data/
│   ├── models/
│   │   ├── chat_message_model.dart
│   │   └── room_session_model.dart
│   ├── socket/
│   │   └── chat_socket_service.dart
│   └── repositories/
│       └── chat_repository.dart
├── domain/
│   └── chat_state.dart
└── presentation/
    ├── providers/
    │   └── chat_provider.dart
    ├── screens/
    │   └── chat_room_screen.dart
    └── widgets/
        ├── message_bubble.dart
        ├── message_input.dart
        ├── typing_indicator.dart
        ├── chat_header.dart
        ├── report_bottom_sheet.dart
        └── room_closed_dialog.dart
```

---

## 9. Tiêu chí hoàn thành

- [ ] Connect socket `/chat` với JWT auth
- [ ] `room:join` → nhận session + history → render đúng
- [ ] Gửi text → nhận broadcast → bubble đúng bên (trái/phải)
- [ ] Gửi ảnh (image_picker → multipart upload → broadcast)
- [ ] Typing indicator (debounce 2s, hiện/ẩn đúng)
- [ ] Online/offline presence dot
- [ ] Rời phòng: socket ưu tiên, REST fallback
- [ ] Block: confirm dialog → socket/REST → navigate home
- [ ] Report: bottom sheet → POST → toast
- [ ] `room:closed` → dialog → navigate
- [ ] Reconnect (app resume → GET /rooms/active → rejoin)
- [ ] Error: moderation toast, spam cooldown, access_denied redirect
- [ ] Scroll to bottom on new message
- [ ] Image tap → fullscreen
- [ ] System message style riêng
- [ ] Dark theme, rounded, modern UI
