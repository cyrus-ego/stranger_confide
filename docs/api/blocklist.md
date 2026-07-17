# API: Blocklist

## POST `/api/blocklist/{targetUserId}`

**Chặn user**

### Parameters

| Name | In | Type | Required | Description |
|------|----|------|----------|-------------|
| targetUserId | path | string | true |  |

### Responses

**201** — Phản hồi thành công

Response data schema:

#### `BlocklistEntryResponseDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `_id` | string | Yes | 665a1b2c3d4e5f6789012349 |
| `blockerId` | string | Yes | 665a1b2c3d4e5f6789012345 |
| `blockedId` | string | Yes | 665a1b2c3d4e5f6789012347 |
| `createdAt` | string (date-time) | Yes | 2026-05-22T10:00:00.000Z |
| `updatedAt` | string (date-time) | Yes | 2026-05-22T10:00:00.000Z |

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

## DELETE `/api/blocklist/{targetUserId}`

**Bỏ chặn user**

### Parameters

| Name | In | Type | Required | Description |
|------|----|------|----------|-------------|
| targetUserId | path | string | true |  |

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

## Schemas

#### `BlocklistEntryResponseDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `_id` | string | Yes | 665a1b2c3d4e5f6789012349 |
| `blockerId` | string | Yes | 665a1b2c3d4e5f6789012345 |
| `blockedId` | string | Yes | 665a1b2c3d4e5f6789012347 |
| `createdAt` | string (date-time) | Yes | 2026-05-22T10:00:00.000Z |
| `updatedAt` | string (date-time) | Yes | 2026-05-22T10:00:00.000Z |

