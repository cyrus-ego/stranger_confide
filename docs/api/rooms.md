# API: Rooms

## GET `/api/rooms/active`

**Kiểm tra user có phòng chat đang hoạt động không**

### Responses

**200** — Phản hồi thành công

Response data schema:

#### `ActiveRoomResponseDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `hasActiveRoom` | boolean | Yes | User có phòng active hay không |
| `roomId` | string | Yes | roomId nếu có, null nếu không |

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

## POST `/api/rooms/{roomId}/leave`

**Rời phòng chat (REST fallback cho mobile khi socket không khả dụng)**

### Parameters

| Name | In | Type | Required | Description |
|------|----|------|----------|-------------|
| roomId | path | string | true |  |

### Responses

**200** — Đã rời phòng

Response data schema:

#### `MessageResponseDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `message` | string | Yes | OTP đã được gửi lại. Kiểm tra hộp thư của bạn. |

**201** — 

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

## GET `/api/rooms/{roomId}`

**Thông tin phiên chat ẩn danh**

### Parameters

| Name | In | Type | Required | Description |
|------|----|------|----------|-------------|
| roomId | path | string | true |  |

### Responses

**200** — Phản hồi thành công

Response data schema:

#### `RoomDetailResponseDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `roomId` | string | Yes | f47ac10b-58cc-4372-a567-0e02b2c3d479 |
| `myAlias` | string | Yes | Stranger#7482 |
| `myAvatar` | string | Yes | https://api.dicebear.com/7.x/avataaars/svg?seed=me |
| `partnerAlias` | string | Yes | Stranger#2910 |
| `partnerAvatar` | string | Yes | https://api.dicebear.com/7.x/avataaars/svg?seed=partner |
| `partnerOnline` | boolean | Yes | true |
| `isAnonymous` | boolean | Yes | true |
| `partnerUserId` | string | No | ID đối phương — dùng report/block, không hiển thị UI |

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

#### `ActiveRoomResponseDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `hasActiveRoom` | boolean | Yes | User có phòng active hay không |
| `roomId` | string | Yes | roomId nếu có, null nếu không |

#### `RoomDetailResponseDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `roomId` | string | Yes | f47ac10b-58cc-4372-a567-0e02b2c3d479 |
| `myAlias` | string | Yes | Stranger#7482 |
| `myAvatar` | string | Yes | https://api.dicebear.com/7.x/avataaars/svg?seed=me |
| `partnerAlias` | string | Yes | Stranger#2910 |
| `partnerAvatar` | string | Yes | https://api.dicebear.com/7.x/avataaars/svg?seed=partner |
| `partnerOnline` | boolean | Yes | true |
| `isAnonymous` | boolean | Yes | true |
| `partnerUserId` | string | No | ID đối phương — dùng report/block, không hiển thị UI |

