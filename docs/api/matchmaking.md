# API: Matchmaking

## POST `/api/matchmaking/join`

**Vào hàng đợi ghép đôi**

Kết nối WebSocket /matchmaking để nhận match:found realtime

### Request Body

Content-Type: `application/json`

#### `JoinQueueDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `preference` | enum: male, female, other | Yes | female |


### Responses

**200** — Phản hồi thành công

Response data schema:

#### `QueueStatusResponseDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `inQueue` | boolean | Yes | true |
| `position` | number | Yes | Vị trí trong hàng (1 = sắp được ghép) |
| `queueSize` | number | Yes | 5 |
| `waitSeconds` | number | Yes | Số giây đã chờ |
| `expiresInSeconds` | number | Yes | Số giây còn lại trước timeout 5 phút |
| `preference` | enum: male, female, other | Yes | female |
| `timedOut` | boolean | Yes | false |

**400** — Dữ liệu không hợp lệ

Schema: `ApiErrorResponseDto` (xem `common.md`)

**401** — Chưa xác thực

Schema: `ApiErrorResponseDto` (xem `common.md`)

**403** — Không có quyền

Schema: `ApiErrorResponseDto` (xem `common.md`)

**404** — Không tìm thấy

Schema: `ApiErrorResponseDto` (xem `common.md`)

**429** — Quá nhiều yêu cầu

Schema: `ApiErrorResponseDto` (xem `common.md`)

---

## DELETE `/api/matchmaking/leave`

**Rời hàng đợi**

### Responses

**200** — Phản hồi thành công

Response data schema:

#### `MessageResponseDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `message` | string | Yes | OTP đã được gửi lại. Kiểm tra hộp thư của bạn. |

**400** — Dữ liệu không hợp lệ

Schema: `ApiErrorResponseDto` (xem `common.md`)

**401** — Chưa xác thực

Schema: `ApiErrorResponseDto` (xem `common.md`)

**403** — Không có quyền

Schema: `ApiErrorResponseDto` (xem `common.md`)

**404** — Không tìm thấy

Schema: `ApiErrorResponseDto` (xem `common.md`)

**429** — Quá nhiều yêu cầu

Schema: `ApiErrorResponseDto` (xem `common.md`)

---

## GET `/api/matchmaking/status`

**Trạng thái hàng đợi**

### Responses

**200** — Phản hồi thành công

Response data schema:

#### `QueueStatusResponseDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `inQueue` | boolean | Yes | true |
| `position` | number | Yes | Vị trí trong hàng (1 = sắp được ghép) |
| `queueSize` | number | Yes | 5 |
| `waitSeconds` | number | Yes | Số giây đã chờ |
| `expiresInSeconds` | number | Yes | Số giây còn lại trước timeout 5 phút |
| `preference` | enum: male, female, other | Yes | female |
| `timedOut` | boolean | Yes | false |

**400** — Dữ liệu không hợp lệ

Schema: `ApiErrorResponseDto` (xem `common.md`)

**401** — Chưa xác thực

Schema: `ApiErrorResponseDto` (xem `common.md`)

**403** — Không có quyền

Schema: `ApiErrorResponseDto` (xem `common.md`)

**404** — Không tìm thấy

Schema: `ApiErrorResponseDto` (xem `common.md`)

**429** — Quá nhiều yêu cầu

Schema: `ApiErrorResponseDto` (xem `common.md`)

---

## Schemas

#### `JoinQueueDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `preference` | enum: male, female, other | Yes | female |

#### `QueueStatusResponseDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `inQueue` | boolean | Yes | true |
| `position` | number | Yes | Vị trí trong hàng (1 = sắp được ghép) |
| `queueSize` | number | Yes | 5 |
| `waitSeconds` | number | Yes | Số giây đã chờ |
| `expiresInSeconds` | number | Yes | Số giây còn lại trước timeout 5 phút |
| `preference` | enum: male, female, other | Yes | female |
| `timedOut` | boolean | Yes | false |

