# API: Profile

## GET `/api/profile`

**Xem hồ sơ của mình**

### Responses

**200** — Phản hồi thành công

Response data schema:

#### `ProfileResponseDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `user` | `ProfileUserSummaryDto` | Yes |  |
| `profile` | object | Yes |  |
| `isComplete` | boolean | Yes | true khi đã có gender + age — đủ điều kiện matchmaking |

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

## POST `/api/profile`

**Tạo hồ sơ (lần đầu)**

### Request Body

Content-Type: `application/json`

#### `CreateProfileDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `displayName` | string | No |  |
| `gender` | enum: male, female, other | Yes |  |
| `age` | number | Yes |  |
| `bio` | string | No |  |
| `chatPreference` | enum: male, female, other | No |  |


### Responses

**201** — Phản hồi thành công

Response data schema:

#### `ProfileResponseDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `user` | `ProfileUserSummaryDto` | Yes |  |
| `profile` | object | Yes |  |
| `isComplete` | boolean | Yes | true khi đã có gender + age — đủ điều kiện matchmaking |

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

## PUT `/api/profile`

**Tạo mới hoặc cập nhật toàn bộ hồ sơ**

### Request Body

Content-Type: `application/json`

#### `CreateProfileDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `displayName` | string | No |  |
| `gender` | enum: male, female, other | Yes |  |
| `age` | number | Yes |  |
| `bio` | string | No |  |
| `chatPreference` | enum: male, female, other | No |  |


### Responses

**200** — Phản hồi thành công

Response data schema:

#### `ProfileResponseDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `user` | `ProfileUserSummaryDto` | Yes |  |
| `profile` | object | Yes |  |
| `isComplete` | boolean | Yes | true khi đã có gender + age — đủ điều kiện matchmaking |

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

## PATCH `/api/profile`

**Cập nhật một phần hồ sơ**

### Request Body

Content-Type: `application/json`

#### `UpdateProfileDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `displayName` | string | No |  |
| `gender` | enum: male, female, other | No |  |
| `age` | number | No |  |
| `bio` | string | No |  |
| `chatPreference` | enum: male, female, other | No |  |


### Responses

**200** — Phản hồi thành công

Response data schema:

#### `ProfileResponseDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `user` | `ProfileUserSummaryDto` | Yes |  |
| `profile` | object | Yes |  |
| `isComplete` | boolean | Yes | true khi đã có gender + age — đủ điều kiện matchmaking |

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

## DELETE `/api/profile`

**Xóa hồ sơ**

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

## POST `/api/profile/avatar`

**Upload ảnh đại diện**

### Request Body

Content-Type: `multipart/form-data`

```json
{
  "type": "object",
  "required": [
    "avatar"
  ],
  "properties": {
    "avatar": {
      "type": "string",
      "format": "binary",
      "description": "JPEG, PNG, WebP, GIF"
    }
  }
}
```

### Responses

**200** — Phản hồi thành công

Response data schema:

#### `ProfileAvatarUploadResponseDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `avatarUrl` | string | Yes | /uploads/avatars/abc.jpg |
| `fullUrl` | string | Yes | http://localhost:3000/uploads/avatars/abc.jpg |
| `profile` | `ProfileResponseDto` | Yes |  |

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

## Schemas

#### `ProfileResponseDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `user` | `ProfileUserSummaryDto` | Yes |  |
| `profile` | object | Yes |  |
| `isComplete` | boolean | Yes | true khi đã có gender + age — đủ điều kiện matchmaking |

#### `CreateProfileDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `displayName` | string | No |  |
| `gender` | enum: male, female, other | Yes |  |
| `age` | number | Yes |  |
| `bio` | string | No |  |
| `chatPreference` | enum: male, female, other | No |  |

#### `UpdateProfileDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `displayName` | string | No |  |
| `gender` | enum: male, female, other | No |  |
| `age` | number | No |  |
| `bio` | string | No |  |
| `chatPreference` | enum: male, female, other | No |  |

#### `ProfileAvatarUploadResponseDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `avatarUrl` | string | Yes | /uploads/avatars/abc.jpg |
| `fullUrl` | string | Yes | http://localhost:3000/uploads/avatars/abc.jpg |
| `profile` | `ProfileResponseDto` | Yes |  |

