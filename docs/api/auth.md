# API: Auth

## POST `/api/auth/register`

**Đăng ký tài khoản**

Tạo user và gửi OTP xác thực email

### Request Body

Content-Type: `application/json`

#### `RegisterDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `email` | string (email) | Yes | user@example.com |
| `password` | string | Yes | password123 |
| `displayName` | string | Yes | Nguyễn Văn A |
| `gender` | enum: male, female, other | Yes | Giới tính |
| `avatar` | string | No |  |


### Responses

**201** — Phản hồi thành công

Response data schema:

#### `RegisterResponseDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `message` | string | Yes | Đăng ký thành công. Vui lòng kiểm tra email để xác thực. |
| `email` | string | Yes | user@example.com |

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

## POST `/api/auth/verify-email`

**Xác thực OTP email**

### Request Body

Content-Type: `application/json`

#### `VerifyEmailDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `email` | string (email) | Yes |  |
| `otp` | string | Yes |  |


### Responses

**200** — Phản hồi thành công

Response data schema:

#### `AuthTokenResponseDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `accessToken` | string | Yes | JWT access token — header Authorization: Bearer <token> |
| `refreshToken` | string | Yes | Refresh token — POST /api/auth/refresh |
| `user` | `AuthUserDto` | Yes |  |

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

## POST `/api/auth/resend-otp`

**Gửi lại OTP**

### Request Body

Content-Type: `application/json`

#### `ResendOtpDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `email` | string (email) | Yes |  |


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

## POST `/api/auth/login`

**Đăng nhập email/password**

### Request Body

Content-Type: `application/json`

#### `LoginDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `email` | string (email) | Yes |  |
| `password` | string | Yes |  |


### Responses

**200** — Phản hồi thành công

Response data schema:

#### `AuthTokenResponseDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `accessToken` | string | Yes | JWT access token — header Authorization: Bearer <token> |
| `refreshToken` | string | Yes | Refresh token — POST /api/auth/refresh |
| `user` | `AuthUserDto` | Yes |  |

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

## POST `/api/auth/refresh`

**Làm mới access token**

### Request Body

Content-Type: `application/json`

#### `RefreshTokenDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `refreshToken` | string | Yes |  |


### Responses

**200** — Phản hồi thành công

Response data schema:

#### `AuthTokenResponseDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `accessToken` | string | Yes | JWT access token — header Authorization: Bearer <token> |
| `refreshToken` | string | Yes | Refresh token — POST /api/auth/refresh |
| `user` | `AuthUserDto` | Yes |  |

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

## GET `/api/auth/me`

**Thông tin user đang đăng nhập**

### Responses

**200** — Phản hồi thành công

Response data schema:

#### `AuthUserDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `id` | string | Yes | 665a1b2c3d4e5f6789012345 |
| `email` | string | Yes | user@example.com |
| `displayName` | string | Yes | Stranger |
| `avatar` | string | Yes |  |
| `role` | enum: user, vip, admin | Yes | user |
| `isEmailVerified` | boolean | Yes | true |

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

## POST `/api/auth/google`

**Đăng nhập Google (mobile)**

Mobile gửi `idToken` từ Google Sign-In SDK. Server xác minh token và trả JWT (access + refresh).

### Request Body

Content-Type: `application/json`

#### `GoogleAuthDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `idToken` | string | Yes | ID token từ Google Sign-In SDK (Android/iOS) hoặc Google One Tap |


### Responses

**200** — Phản hồi thành công

Response data schema:

#### `AuthTokenResponseDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `accessToken` | string | Yes | JWT access token — header Authorization: Bearer <token> |
| `refreshToken` | string | Yes | Refresh token — POST /api/auth/refresh |
| `user` | `AuthUserDto` | Yes |  |

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

## GET `/api/auth/google`

**OAuth Google — redirect (web)**

### Responses

**200** — 

---

## POST `/api/auth/facebook`

**Đăng nhập Facebook (mobile)**

Mobile gửi `accessToken` từ Facebook Login SDK. Server xác minh token qua Graph API và trả JWT (access + refresh).

### Request Body

Content-Type: `application/json`

#### `FacebookAuthDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `accessToken` | string | Yes | Access token từ Facebook Login SDK (Android/iOS) |


### Responses

**200** — Phản hồi thành công

Response data schema:

#### `AuthTokenResponseDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `accessToken` | string | Yes | JWT access token — header Authorization: Bearer <token> |
| `refreshToken` | string | Yes | Refresh token — POST /api/auth/refresh |
| `user` | `AuthUserDto` | Yes |  |

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

## GET `/api/auth/facebook`

**OAuth Facebook — redirect**

### Responses

**200** — 

---

## GET `/api/auth/google/callback`

**OAuth Google callback — redirect frontend**

### Responses

**200** — 

---

## GET `/api/auth/facebook/callback`

**OAuth Facebook callback — redirect frontend**

### Responses

**200** — 

---

## Schemas

#### `RegisterDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `email` | string (email) | Yes | user@example.com |
| `password` | string | Yes | password123 |
| `displayName` | string | Yes | Nguyễn Văn A |
| `gender` | enum: male, female, other | Yes | Giới tính |
| `avatar` | string | No |  |

#### `RegisterResponseDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `message` | string | Yes | Đăng ký thành công. Vui lòng kiểm tra email để xác thực. |
| `email` | string | Yes | user@example.com |

#### `VerifyEmailDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `email` | string (email) | Yes |  |
| `otp` | string | Yes |  |

#### `AuthTokenResponseDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `accessToken` | string | Yes | JWT access token — header Authorization: Bearer <token> |
| `refreshToken` | string | Yes | Refresh token — POST /api/auth/refresh |
| `user` | `AuthUserDto` | Yes |  |

#### `ResendOtpDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `email` | string (email) | Yes |  |

#### `LoginDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `email` | string (email) | Yes |  |
| `password` | string | Yes |  |

#### `RefreshTokenDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `refreshToken` | string | Yes |  |

#### `AuthUserDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `id` | string | Yes | 665a1b2c3d4e5f6789012345 |
| `email` | string | Yes | user@example.com |
| `displayName` | string | Yes | Stranger |
| `avatar` | string | Yes |  |
| `role` | enum: user, vip, admin | Yes | user |
| `isEmailVerified` | boolean | Yes | true |

#### `GoogleAuthDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `idToken` | string | Yes | ID token từ Google Sign-In SDK (Android/iOS) hoặc Google One Tap |

#### `FacebookAuthDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `accessToken` | string | Yes | Access token từ Facebook Login SDK (Android/iOS) |

