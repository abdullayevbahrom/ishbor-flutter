# ish_bor

keyPassword=123456
keyAlias=ishbor-alias

A new Flutter project. 

## API Environment

Flutter API client local/staging/prod muhitlari `--dart-define` orqali boshqariladi:

```bash
flutter run \
  --dart-define=APP_ENV=local \
  --dart-define=API_BASE_URL=https://api.local.ishbor.uz \
  --dart-define=WS_URL=wss://ws.local.ishbor.uz \
  --dart-define=API_SIGNATURE_SECRET=dev-secret
```

### Tavsiya etilgan qiymatlar

| Muhit | `API_BASE_URL` | `WS_URL` | `API_SIGNATURE_SECRET` |
|-------|----------------|----------|-------------------------|
| local | `https://api.local.ishbor.uz` | `wss://ws.local.ishbor.uz` | local/dev secret |
| staging | `https://api.staging.ishbor.uz` | `wss://ws.staging.ishbor.uz` | staging secret |
| prod | `https://api.ishbor.uz` | `wss://ws.ishbor.uz` | production secret |

`APP_ENV` uchun odatiy qiymatlar: `local`, `staging`, `prod`.

## Realtime / WebSocket

WebSocket client avval `Authorization: Bearer <token>` va `X-Device-Token` headerlari bilan ulanadi.
Agar socket handshake yoki stream yopilsa, user status oqimi HTTP `heartbeat` + `checkUserStatus` fallbackiga o'tadi.
Ulanish urinishlari exponential backoff bilan qayta sinab ko‘riladi; token log qilinmaydi.

# Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# to generate new app icon

dart run flutter_launcher_icons

# for easy localization

flutter pub run easy_localization:generate -f keys -o locale_keys.g.dart -O lib/core/constants -S
assets/translations

# to remove unused imports from project

dart fix --apply

# build freezed bloc or cubits

flutter pub run build_runner watch --delete-conflicting-outputs

flutter build apk --release

# Bu komandadan keyin fayl shu joyda paydo bo‘ladi:

build/app/outputs/flutter-apk/app-release.apk

adb install -r build/app/outputs/flutter-apk/app-release.apk

# for build app for ios

flutter build ios --config-only --release

# to see keys

cd android
./gradlew signingReport
