# API: Users

## GET `/api/users/me`

**Thông tin tài khoản đang đăng nhập**

### Responses

**200** — Phản hồi thành công

Response data schema:

#### `UserResponseDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `id` | string | Yes | 665a1b2c3d4e5f6789012345 |
| `email` | string | Yes | user@example.com |
| `displayName` | string | Yes | Stranger |
| `avatar` | string | Yes | http://localhost:3000/uploads/avatars/abc.jpg |
| `gender` | enum: male, female, other | No | Giới tính |
| `role` | enum: user, vip, admin | Yes | user |
| `provider` | enum: local, google, facebook | Yes | local |
| `isEmailVerified` | boolean | Yes | true |
| `createdAt` | string (date-time) | No | 2026-05-22T10:00:00.000Z |
| `updatedAt` | string (date-time) | No | 2026-05-22T10:00:00.000Z |

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

## PATCH `/api/users/me`

**Cập nhật tên hiển thị / avatar URL**

### Request Body

Content-Type: `application/json`

#### `UpdateUserDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `displayName` | string | No |  |
| `avatar` | string | No |  |


### Responses

**200** — Phản hồi thành công

Response data schema:

#### `UserResponseDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `id` | string | Yes | 665a1b2c3d4e5f6789012345 |
| `email` | string | Yes | user@example.com |
| `displayName` | string | Yes | Stranger |
| `avatar` | string | Yes | http://localhost:3000/uploads/avatars/abc.jpg |
| `gender` | enum: male, female, other | No | Giới tính |
| `role` | enum: user, vip, admin | Yes | user |
| `provider` | enum: local, google, facebook | Yes | local |
| `isEmailVerified` | boolean | Yes | true |
| `createdAt` | string (date-time) | No | 2026-05-22T10:00:00.000Z |
| `updatedAt` | string (date-time) | No | 2026-05-22T10:00:00.000Z |

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

#### `UserResponseDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `id` | string | Yes | 665a1b2c3d4e5f6789012345 |
| `email` | string | Yes | user@example.com |
| `displayName` | string | Yes | Stranger |
| `avatar` | string | Yes | http://localhost:3000/uploads/avatars/abc.jpg |
| `gender` | enum: male, female, other | No | Giới tính |
| `role` | enum: user, vip, admin | Yes | user |
| `provider` | enum: local, google, facebook | Yes | local |
| `isEmailVerified` | boolean | Yes | true |
| `createdAt` | string (date-time) | No | 2026-05-22T10:00:00.000Z |
| `updatedAt` | string (date-time) | No | 2026-05-22T10:00:00.000Z |

#### `UpdateUserDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `displayName` | string | No |  |
| `avatar` | string | No |  |

