# StrangerConfide

Flutter mobile app — anonymous chat with strangers.

## Tech Stack

- Flutter 3.x / Dart (SDK ^3.9.0)
- State management: flutter_bloc
- Networking: Dio + Retrofit (code gen)
- Realtime: socket_io_client
- DI: get_it + injectable
- Routing: go_router
- Models: freezed + json_serializable

## Project Structure

- `lib/` — Main app source
- `assets/translations/` — i18n files (easy_localization)
- `docs/api/` — API reference docs (auto-generated from Swagger)
- `tool/generate_api_docs.dart` — Script to regenerate API docs

## API Reference

API docs are split by domain in `docs/api/`:

- `docs/api/api-index.md` — **Đọc file này trước** để biết endpoint nào nằm ở file nào
- `docs/api/auth.md` — Authentication & registration (12 endpoints)
- `docs/api/profile.md` — User profile management (6 endpoints)
- `docs/api/matchmaking.md` — Queue & matchmaking (3 endpoints)
- `docs/api/rooms.md` — Chat rooms (3 endpoints)
- `docs/api/chat.md` — Chat media upload (1 endpoint)
- `docs/api/users.md` — User account (2 endpoints)
- `docs/api/blocklist.md` — Block/unblock users (2 endpoints)
- `docs/api/moderation.md` — Report users (1 endpoint)
- `docs/api/common.md` — Shared error response schemas

### Quy tắc đọc API docs

- **KHÔNG** preload tất cả file API — chỉ đọc file liên quan đến task hiện tại
- Đọc `docs/api/api-index.md` trước để xác định cần file nào
- Sau đó đọc đúng file domain cần thiết
- Error schema chung nằm ở `docs/api/common.md`

## Regenerate API Docs

Khi API backend thay đổi, chạy:

```bash
dart run tool/generate_api_docs.dart
```

## Coding Conventions

- Sử dụng BLoC pattern cho state management
- Models dùng freezed + json_serializable
- API client dùng Retrofit annotations
- DI dùng injectable annotations
- Code gen: `dart run build_runner build --delete-conflicting-outputs`
