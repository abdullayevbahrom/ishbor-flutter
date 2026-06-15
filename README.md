# ish_bor

keyPassword=123456
keyAlias=ishbor-alias

A new Flutter project. 

## API Environment

Flutter API client local/staging/prod muhitlari `--dart-define` orqali boshqariladi:

```bash
flutter run \
  --dart-define=APP_ENV=local \
  --dart-define=API_BASE_URL=http://api.ishbor.test:8080 \
  --dart-define=MERCURE_PUBLIC_URL=http://ws.ishbor.test:8080/.well-known/mercure \
  --dart-define=API_SIGNATURE_SECRET=dev-secret
```

### Tavsiya etilgan qiymatlar

| Muhit | `API_BASE_URL` | `MERCURE_PUBLIC_URL` | `API_SIGNATURE_SECRET` |
|-------|----------------|----------------------|-------------------------|
| local | `http://api.ishbor.test:8080` | `http://ws.ishbor.test:8080/.well-known/mercure` | local/dev secret |
| staging | `https://api.staging.ishbor.uz` | `https://ws.staging.ishbor.uz/.well-known/mercure` | staging secret |
| prod | `https://api.ishbor.uz` | `https://ws.ishbor.uz/.well-known/mercure` | production secret |

`APP_ENV` uchun odatiy qiymatlar: `local`, `staging`, `prod`.

## Realtime / Mercure SSE

Mercure subscriber avval `Authorization: Bearer <token>` va `X-Device-Token` headerlari bilan ulanadi.
Topiclar query string orqali yuboriladi: chat uchun `chats/{dialogId}/messages`, user status uchun `users/status/{userId}`, status check uchun `users/status/check/{userId}`.
Stream yopilsa, user status oqimi HTTP `heartbeat` + `checkUserStatus` fallbackiga o'tadi.
Ulanish urinishlari exponential backoff bilan qayta sinab ko‘riladi; token log qilinmaydi.

## Manual QA Checklist

Quyidagi oqimlar `flutter run` yoki staging build’da qo'lda tekshiriladi:

- Auth: request code, verify code, register, refresh, logout.
- Feed va detail: vacancies, services, tasks ro'yxat, detail va similar bloklari.
- Create/edit: vacancy, service, task create/update/status/favorite/lift-up.
- Upload/remove: avatar, verification doc, portfolio, vacancy/service/task image upload va remove.
- Messaging: messages list, chat open, send, attachment upload, read ack, Mercure/SSE fallback.
- Payment: top balance, transaction create/read/check, provider link, balance payment.
- Notifications: list, detail, deep-link navigation.
- Offline/retry: 401 refresh, transient network retry, device token bootstrap/persist.

## Smoke Commands

Local tekshiruvlar uchun root `Makefile` targetlaridan foydalaning:

- `make flutter-pub-get`
- `make flutter-analyze`
- `make flutter-test`
- `make flutter-format`
- `make flutter-smoke`
- `make flutter-contract-guard`
- `make flutter-check`
- `make flutter-doctor`

Docker UI E2E runner:

- `make flutter-e2e-ui`
- `make flutter-e2e-ui DEVICE=adb`
- `make flutter-e2e-ui API_BASE_URL=http://api.ishbor.test:8080`
- `make flutter-e2e-ui MERCURE_PUBLIC_URL=http://ws.ishbor.test:8080/.well-known/mercure`
- `make flutter-e2e-ui E2E_ADB_SERVER_SOCKET=tcp:host.docker.internal:5037`
- `make flutter-e2e-ui E2E_CACHE_PREFIX=ishbor-flutter-e2e`
- `make flutter-e2e-ui E2E_DEVICE_SCREENSHOTS_ROOT=/sdcard/Download/ishbor-e2e/screenshots`

Hot reload device runner:

- `make flutter-hot-reload`
- `make flutter-hot-reload FLUTTER_DEVICE_ID=<device-id>`
- `make flutter-hot-reload FLUTTER_TARGET=lib/main.dart`

Bu target Docker ichida `flutter run --debug` ni ishga tushiradi, `adb reverse` bilan local API/Mercure domenga ulanadi va `pub-cache`, `.dart_tool`, Gradle hamda Android SDK cache’larini volume’da ushlab turadi. App loglari terminalga live oqadi.

ADB ulanish variantlari:

- Hostdagi real qurilma uchun `E2E_ADB_SERVER_SOCKET=tcp:host.docker.internal:5037`
- Docker-Android yoki Waydroid uchun `E2E_ADB_SERVER_SOCKET=tcp:<emulator-host>:5037` va kerak bo‘lsa `E2E_EMULATOR_SERIAL=<host>:5555`
- `DEVICE=adb` rejimida runner avtomatik `adb reverse tcp:8080 tcp:8080` qiladi; shu sabab app ichida `API_BASE_URL` va `MERCURE_PUBLIC_URL` localhost orqali ishlaydi, ammo `E2E_API_BASE_URL` va `E2E_MERCURE_PUBLIC_URL` artifact/report uchun saqlanadi.
- Runner `E2E_CACHE_PREFIX` asosida Docker volume’larda `pub-cache`, Flutter build output, Gradle va Android SDK cache’larini saqlaydi.
- Runner artefaktlarni device’dagi `E2E_DEVICE_SCREENSHOTS_ROOT` ga yozadi va keyin hostdagi `E2E_HOST_SCREENSHOTS_ROOT` ga ko‘chiradi.

Required env:

- `E2E_API_BASE_URL`
- `E2E_MERCURE_PUBLIC_URL`
- `E2E_API_SIGNATURE_SECRET`
- `E2E_ACCESS_TOKEN` or `E2E_TEST_PHONE` + `E2E_TEST_OTP`
- `E2E_APP_VERSION`
- `E2E_RUN_ID`
- `E2E_ADB_SERVER_SOCKET` when the runner must attach to a non-local adb server
- `E2E_CACHE_PREFIX` for persistent Docker cache volume names used by Flutter/Android tooling, including build output and SDK caches
- `E2E_DEVICE_SCREENSHOTS_ROOT` for the device-side artifact root
- `E2E_HOST_SCREENSHOTS_ROOT` for the host-side pulled artifact root

Verbose logging faqat kerakli muhitda yoqiladi; secret, token va signature matnlari loglarga to'liq chiqarilmaydi.

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
