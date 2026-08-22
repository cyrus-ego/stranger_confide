# Talk First

Flutter mobile app for private one-to-one social conversations.

Application identifiers:

- Dart package: `talk_first`
- Android application ID: `com.cyr.talkfirst`
- Apple bundle ID: `com.cyr.talkfirst`

The existing Firebase/Google Cloud project ID remains `stranger-confide`
because Google project IDs are permanent internal identifiers. User-facing
Firebase apps are registered under the Talk First name.

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

## Android release builds

Configure `.env`, `android/local.properties`, and the ignored
`android/key.properties` upload signing file. Then build both Play Console AAB
and a universal release APK:

```bash
./build_release.sh
```

Build only one artifact with `./build_release.sh aab` or
`./build_release.sh apk`. Extra arguments after the target are forwarded to
`flutter build`, for example `./build_release.sh aab --obfuscate
--split-debug-info=build/symbols`.

The script also prints the generated R8 mapping and native debug-symbol archive
paths. Keep those artifacts with each release for Play Console diagnostics.
