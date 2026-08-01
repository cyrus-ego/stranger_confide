# Stranger Confide

Flutter mobile app for anonymous one-to-one chat.

## Local setup

Copy `.env.example` to `.env`, fill the required OAuth values, then run:

```bash
flutter pub get
dart run build_runner build
flutter run
```

Provider-specific setup:

- [Google Sign-In](docs/google-sign-in-setup.md)
- [Facebook Sign-In](docs/facebook-sign-in-setup.md)
