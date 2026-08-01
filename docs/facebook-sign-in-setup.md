# Facebook Sign-In setup

The app uses `flutter_facebook_auth` and exchanges the Facebook token at
`POST /api/auth/facebook`. Android normally sends a classic access token. iOS
uses privacy-preserving Limited Login and sends its signed OIDC token plus the
nonce to the backend.

## 1. Meta Developer Dashboard

Create or select a Meta app with Facebook Login enabled, then configure both
mobile platforms:

### Android

- Package name: `com.cyr.stranger_confide`
- Default activity: `com.cyr.stranger_confide.MainActivity`
- Add key hashes for every signing identity used by debug, release, CI and
  Google Play App Signing.

Debug key hash on macOS/Linux:

```bash
keytool -exportcert \
  -alias androiddebugkey \
  -keystore ~/.android/debug.keystore \
  -storepass android \
  | openssl sha1 -binary \
  | openssl base64
```

When `android/key.properties` exists, this project also uses that upload key for
debug builds; generate and register its hash as well. If Google Play App Signing
is enabled, also register the key hash derived from the Play Console app-signing
certificate.

### iOS

- Bundle ID: `com.cyr.strangerConfide`
- Enable Facebook Login for this iOS app.
- Minimum deployment target: iOS 15 (required by the current Firebase SDK in
  this project).

The iOS implementation deliberately uses Limited Login, so authentication does
not require App Tracking Transparency permission.

While the Meta app is in Development mode, only app admins, developers,
testers and Meta test users can sign in. Complete Meta's required app details
and switch it to Live before testing with public accounts.

## 2. Backend secrets

Set these in `findu-backend/.env.dev` for local development and
`findu-backend/.env.pod` in production:

```dotenv
FACEBOOK_APP_ID=YOUR_FACEBOOK_APP_ID
FACEBOOK_APP_SECRET=YOUR_FACEBOOK_APP_SECRET
FACEBOOK_CALLBACK_URL=https://api.chatvn.online/api/auth/facebook/callback
```

Add the same callback URL to the valid OAuth redirect URI list in Meta if the
web redirect flow is used. `FACEBOOK_APP_SECRET` is server-only and must never
be copied into Flutter, Android resources or `Info.plist`.

## 3. Android local configuration

Add the following to the ignored file `android/local.properties`:

```properties
facebook.appId=YOUR_FACEBOOK_APP_ID
facebook.clientToken=YOUR_FACEBOOK_CLIENT_TOKEN
```

The client token is available under the Meta app's advanced settings. Gradle
turns these properties into the Android string resources consumed by the
Facebook SDK.

## 4. iOS local configuration

Copy the checked-in template:

```bash
cp ios/Flutter/FacebookAuth.xcconfig.example \
  ios/Flutter/FacebookAuth.xcconfig
```

Then set:

```xcconfig
FACEBOOK_APP_ID=YOUR_FACEBOOK_APP_ID
FACEBOOK_CLIENT_TOKEN=YOUR_FACEBOOK_CLIENT_TOKEN
FACEBOOK_DISPLAY_NAME=Talk First
```

`FacebookAuth.xcconfig` is ignored by Git. Debug, Profile and Release build
configurations include it and expose the values to `ios/Runner/Info.plist`.

## 5. Verification

```bash
flutter pub get
flutter analyze
flutter test test/features/auth/bloc/login_bloc_google_test.dart
flutter build apk --debug
```

For an end-to-end check, sign in from a physical device with a Meta role/test
account, then confirm the app reaches the authenticated profile/matchmaking
flow. A successful backend response contains the app's own access token,
refresh token and user object; the Facebook token is never stored as the app
session token.

References:

- https://facebook.meedu.app/docs/7.x.x/android/
- https://facebook.meedu.app/docs/7.x.x/ios/
- https://facebook.meedu.app/docs/7.x.x/login/
