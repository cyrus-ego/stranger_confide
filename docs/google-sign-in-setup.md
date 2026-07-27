# Thiết lập đăng nhập bằng Google

Ứng dụng sử dụng Google SDK trên thiết bị để đăng nhập, sau đó gửi ID token nhận
được tới endpoint `POST /api/auth/google`. Backend xác minh token này và trả về
access token cùng refresh token của ứng dụng.

## Cấu hình chung

Sao chép các biến cấu hình Google từ `.env.example` vào file `.env` trên máy:

```dotenv
GOOGLE_SERVER_CLIENT_ID=<Web OAuth Client ID>
GOOGLE_IOS_CLIENT_ID=<iOS OAuth Client ID>
```

Giá trị `GOOGLE_SERVER_CLIENT_ID` phải là Web Client ID mà backend sử dụng làm
`audience` khi xác minh Google ID token.

## Android

Tạo một Android OAuth client cho application ID `com.cyr.stranger_confide`.
Đăng ký SHA-1 của tất cả signing key được dùng để chạy hoặc phát hành ứng dụng,
bao gồm debug, upload và release nếu có.

Biến `GOOGLE_SERVER_CLIENT_ID` vẫn phải chứa **Web Client ID**. Không đặt Android
Client ID vào biến này.

## iOS

Tạo một iOS OAuth client cho bundle ID `com.cyr.strangerConfide`, sau đó:

1. Điền iOS Client ID vào biến `GOOGLE_IOS_CLIENT_ID` trong `.env`.
2. Sao chép `ios/Flutter/GoogleAuth.xcconfig.example` thành
   `ios/Flutter/GoogleAuth.xcconfig`.
3. Trong file vừa tạo, đặt `GOOGLE_REVERSED_CLIENT_ID` bằng reversed client ID
   của iOS OAuth credential.

File `GoogleAuth.xcconfig` được Git bỏ qua có chủ đích để mỗi môi trường có thể
sử dụng credential riêng.
