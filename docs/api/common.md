# Common Schemas

Các schema dùng chung cho tất cả endpoints.

#### `ApiErrorResponseDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `success` | boolean | Yes | false |
| `statusCode` | number | Yes | 401 |
| `code` | string | Yes | Mã lỗi machine-readable |
| `message` | string | Yes | Bạn cần đăng nhập để tiếp tục |
| `data` | object | Yes | Luôn null khi lỗi |
| `errors` | `FieldErrorDto[]` | Yes | Danh sách lỗi field — chỉ có khi VALIDATION_ERROR |
| `meta` | object | Yes |  |
| `requestId` | string | Yes | req_8af2c1de9012ab34 |
| `path` | string | Yes | /api/profile |
| `timestamp` | string (date-time) | Yes | 2026-05-22T16:21:01.289Z |

#### `FieldErrorDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `field` | string | Yes | email |
| `message` | string | Yes | Email không hợp lệ |

#### `MessageResponseDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `message` | string | Yes | OTP đã được gửi lại. Kiểm tra hộp thư của bạn. |

