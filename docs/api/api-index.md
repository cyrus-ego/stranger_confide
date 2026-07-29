# API Endpoints Index

Base URL: `https://api.chatvn.online`

Chi tiết từng domain xem file tương ứng trong `docs/api/`.

## Auth

File: `docs/api/auth.md`

| Method | Path | Summary |
|--------|------|---------|
| POST | `/api/auth/register` | Đăng ký tài khoản |
| POST | `/api/auth/verify-email` | Xác thực OTP email |
| POST | `/api/auth/resend-otp` | Gửi lại OTP |
| POST | `/api/auth/login` | Đăng nhập email/password |
| POST | `/api/auth/refresh` | Làm mới access token |
| GET | `/api/auth/me` | Thông tin user đang đăng nhập |
| POST | `/api/auth/google` | Đăng nhập Google (mobile) |
| GET | `/api/auth/google` | OAuth Google — redirect (web) |
| POST | `/api/auth/facebook` | Đăng nhập Facebook (mobile) |
| GET | `/api/auth/facebook` | OAuth Facebook — redirect |
| GET | `/api/auth/google/callback` | OAuth Google callback — redirect frontend |
| GET | `/api/auth/facebook/callback` | OAuth Facebook callback — redirect frontend |

## Blocklist

File: `docs/api/blocklist.md`

| Method | Path | Summary |
|--------|------|---------|
| POST | `/api/blocklist/{targetUserId}` | Chặn user |
| DELETE | `/api/blocklist/{targetUserId}` | Bỏ chặn user |

## Chat

File: `docs/api/chat.md`

| Method | Path | Summary |
|--------|------|---------|
| GET | `/api/chat/{roomId}/messages` | Lấy thêm tin nhắn cũ hơn trong phòng chat |
| POST | `/api/chat/{roomId}/image` | Upload ảnh trong phòng chat |

## Matchmaking

File: `docs/api/matchmaking.md`

| Method | Path | Summary |
|--------|------|---------|
| POST | `/api/matchmaking/join` | Vào hàng đợi ghép đôi |
| DELETE | `/api/matchmaking/leave` | Rời hàng đợi |
| GET | `/api/matchmaking/status` | Trạng thái hàng đợi |

## Moderation

File: `docs/api/moderation.md`

| Method | Path | Summary |
|--------|------|---------|
| POST | `/api/moderation/report` | Báo cáo user trong phòng chat |

## Profile

File: `docs/api/profile.md`

| Method | Path | Summary |
|--------|------|---------|
| GET | `/api/profile` | Xem hồ sơ của mình |
| POST | `/api/profile` | Tạo hồ sơ (lần đầu) |
| PUT | `/api/profile` | Tạo mới hoặc cập nhật toàn bộ hồ sơ |
| PATCH | `/api/profile` | Cập nhật một phần hồ sơ |
| DELETE | `/api/profile` | Xóa hồ sơ |
| POST | `/api/profile/avatar` | Upload ảnh đại diện |

## Rooms

File: `docs/api/rooms.md`

| Method | Path | Summary |
|--------|------|---------|
| GET | `/api/rooms/active` | Kiểm tra user có phòng chat đang hoạt động không |
| POST | `/api/rooms/{roomId}/leave` | Rời phòng chat (REST fallback cho mobile khi socket không khả dụng) |
| GET | `/api/rooms/{roomId}` | Thông tin phiên chat ẩn danh |

## Users

File: `docs/api/users.md`

| Method | Path | Summary |
|--------|------|---------|
| GET | `/api/users/me` | Thông tin tài khoản đang đăng nhập |
| PATCH | `/api/users/me` | Cập nhật tên hiển thị / avatar URL |
| POST | `/api/users/me/fcm-tokens` | Dang ky FCM token cua thiet bi hien tai |
| DELETE | `/api/users/me/fcm-tokens` | Go FCM token khoi tai khoan hien tai |

## Common Schemas

File: `docs/api/common.md` — Error response, field errors, generic message.

