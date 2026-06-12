# Flutter UI E2E Coverage Matrix

Source of truth:

- `flutter/lib/core/router/app_routes.dart`
- `flutter/lib/core/router/route_names.dart`
- `flutter/lib/core/constants/api_const.dart`

Purpose:

- This matrix defines the UI coverage contract for the future Docker-based Flutter E2E runner.
- Every item below must produce at least one loaded-state screenshot, plus validation/error/empty-state screenshots where applicable.
- The test bootstrap should emit `DEBUG [E2E][matrix] route=<route> cases=<count>` for each discovered surface.
- Missing or unreachable surfaces must fail with `ERROR [E2E][matrix]`.

## Non-routable or legacy constants

These constants exist in `route_names.dart` but are not registered in `GoRouter.routes`.

| Constant | Status | Note |
|---|---|---|
| `Routes.vacancyView` (`/vacancyView`) | legacy / not routable | Use the registered `/vacancy-view?id=...` deep-link route instead. |
| `Routes.serviceView` (`/serviceView`) | legacy / not routable | Use the registered `/service-view?id=...` deep-link route instead. |
| `Routes.taskView` (`/taskView`) | legacy / not routable | Use the registered `/task-view?id=...` deep-link route instead. |
| `Routes.editInfo` (`/editInfo`) | legacy / not routable | Covered through `/edit-profile` and profile edit sub-flows. |
| `Routes.profileMessages` (`/profileMessages`) | legacy / not routable | Covered through the main shell messages tab. |
| `Routes.otpPage` (`/otp-page`) | legacy / not routable | Covered as an auth subpage inside the splash/auth flow. |
| `Routes.serviceForm` (`/service-form`) | legacy / not routable | Covered by `CreateServicePage` and service edit flow. |
| `Routes.taskForm` (`/task-form`) | legacy / not routable | Covered by `CreateTaskPage` and task edit flow. |

## Route Matrix

### Bootstrap and deep links

#### `/splash`

- Widget: `SplashPage`
- Auth state: public
- Seed/API: app bootstrap, cached auth state, `GET /api/v1/categories`, `GET /api/v1/cities`, `GET /api/v1/me` when token exists
- Coverage: splash loading, first-run bootstrap, redirect to login or main, stale token handling, deep-link dispatch
- Extra contract: none
- Screenshots: `01_splash_loading.png`, `02_splash_redirect_login.png`, `03_splash_redirect_main.png`

#### `/splash/:payload`

- Widget: `SplashPage(payload: Map<String, dynamic>?)`
- Auth state: public
- Seed/API: same as `/splash`, plus payload-based redirect for vacancy/service/task/main token deep links
- Coverage: payload parse success, payload parse failure, redirect to `main`, redirect to deep-link target, invalid JSON fallback
- Extra contract: encoded JSON in path parameter `payload`
- Screenshots: `04_splash_payload_valid.png`, `05_splash_payload_invalid.png`

#### `/main`

- Widget: `MainPage`
- Auth state: authenticated for full shell; guest view may show login prompt for protected tabs/actions
- Seed/API: `GET /api/v1/me`, `GET /api/v1/cities`, `GET /api/v1/notifications`, shell tab data
- Coverage: bottom tabs, add action menu, notifications menu, guest login prompt, tab switching, notification drawer
- Extra contract: `state.extra` may carry deep-link payload map
- Screenshots: `10_main_shell.png`, `11_main_tabs.png`, `12_main_add_menu.png`, `13_main_notifications_menu.png`

#### `/main/:payload`

- Widget: `MainPage(payload: Map<String, dynamic>?)`
- Auth state: authenticated or bootstrap resume
- Seed/API: same as `/main`, plus payload-driven navigation to vacancy/service/task/payment
- Coverage: telegram token payload resume, nested redirect, invalid token payload fallback
- Extra contract: encoded JSON in path parameter `payload`
- Screenshots: `14_main_payload_token.png`, `15_main_payload_redirect.png`

#### `/payment?transaction_id=...`

- Widget: `PaymentPage`
- Auth state: authenticated
- Seed/API: `GET /api/v1/payment-transactions/{id}`, `GET /api/v1/payment-transactions/{id}/check`
- Coverage: transaction lookup, top-up provider selection, callback/deeplink resume, error state
- Extra contract: query parameter `transaction_id`
- Screenshots: `16_payment_initial.png`, `17_payment_loaded.png`, `18_payment_error.png`

### Auth and onboarding flow

#### `RegisterPage` under `/register`

- Widget: `RegisterPage`
- Auth state: unauthenticated
- Seed/API: `POST /api/v1/auth/register`
- Coverage: phone validation, code validation, user type selection, name entry, success navigation, failure state
- Extra contract: none
- Screenshots: `20_register_initial.png`, `21_register_validation.png`, `22_register_success.png`

#### `LoginPage`, `OtpPage`, `VerifyPage`, `UserTypePage`, `NamePage`

- Entry: auth flow launched from splash/main shell
- Auth state: unauthenticated
- Seed/API: `POST /api/v1/auth/request-code`, `POST /api/v1/auth/verify-code`, optional `POST /api/v1/auth/refresh`
- Coverage: phone entry, OTP entry, verify step, user type step, name step, resend OTP, invalid code, expired code
- Extra contract: internal auth flow only; not all pages are public routes
- Screenshots: `23_login.png`, `24_otp.png`, `25_verify.png`, `26_user_type.png`, `27_name.png`

#### `/restorePassword`

- Widget: `RestorePassword`
- Auth state: unauthenticated
- Seed/API: auth recovery flow and OTP request, if enabled by backend
- Coverage: phone entry, code request, resend, error state
- Extra contract: none
- Screenshots: `28_restore_password.png`

### Main shell tabs

#### `VacanciesPage` tab

- Entry: `MainPage` tab 0
- Auth state: public browsing allowed
- Seed/API: `GET /api/v1/vacancies`, `GET /api/v1/vacancies/geo`, `GET /api/v1/categories`, `GET /api/v1/cities`
- Coverage: pagination, pull-to-refresh, empty state, loading skeletons, filter launch
- Extra contract: shell tab state only
- Screenshots: `30_vacancies_loading.png`, `31_vacancies_loaded.png`, `32_vacancies_empty.png`

#### `ServicesPage` tab

- Entry: `MainPage` tab 1
- Auth state: public browsing allowed
- Seed/API: `GET /api/v1/services`, `GET /api/v1/services/geo`, `GET /api/v1/categories`, `GET /api/v1/cities`
- Coverage: pagination, map/geo toggle, empty state, filter launch
- Extra contract: shell tab state only
- Screenshots: `33_services_loading.png`, `34_services_loaded.png`, `35_services_empty.png`

#### `TasksPage` tab

- Entry: `MainPage` tab 2
- Auth state: public browsing allowed
- Seed/API: `GET /api/v1/tasks`, `GET /api/v1/tasks/geo`, `GET /api/v1/tasks/recommended`, `GET /api/v1/categories`, `GET /api/v1/cities`
- Coverage: recommended list, pagination, empty state, filter launch
- Extra contract: shell tab state only
- Screenshots: `36_tasks_loading.png`, `37_tasks_loaded.png`, `38_tasks_empty.png`

#### `MessagesPage` tab

- Entry: `MainPage` tab 3
- Auth state: authenticated
- Seed/API: `GET /api/v1/messages`, `GET /api/v1/messages/{id}`, `GET /api/v1/messages/{id}/records`, Mercure topic `chats/{dialogId}/messages`
- Coverage: list loading, unread indicator, open chat, send message entry point, read mark
- Extra contract: shell tab state only
- Screenshots: `39_messages_loading.png`, `40_messages_loaded.png`

#### `ProfilePage` tab

- Entry: `MainPage` tab 4
- Auth state: authenticated
- Seed/API: `GET /api/v1/me`, `GET /api/v1/notifications`, `GET /api/v1/me/vacancies/customer`, `GET /api/v1/me/services/customer`, `GET /api/v1/me/tasks/customer`
- Coverage: profile summary, locale switch, owner stats, logout, edit/profile shortcuts
- Extra contract: shell tab state only
- Screenshots: `41_profile_summary.png`, `42_profile_actions.png`

### Public detail routes

#### `/vacancy-view?id=...`

- Widget: `WVacancyViewPage`
- Auth state: public browsing, with authenticated actions available
- Seed/API: `GET /api/v1/vacancies/{id}`, `GET /api/v1/vacancies/{id}/similar`, `POST /api/v1/content-contact-click/`, `POST /api/v1/reports`
- Coverage: favorite toggle, phone modal, report modal, message modal, similar vacancies, share/open contact
- Extra contract: query parameter `id`
- Screenshots: `50_vacancy_detail_loading.png`, `51_vacancy_detail_loaded.png`, `52_vacancy_detail_modals.png`

#### `/service-view?id=...`

- Widget: `WServiceViewPage`
- Auth state: public browsing, with authenticated actions available
- Seed/API: `GET /api/v1/services/{id}`, `GET /api/v1/services/{id}/similar`, `POST /api/v1/content-contact-click/`, `POST /api/v1/reports`
- Coverage: favorite toggle, phone modal, report modal, message modal, similar services
- Extra contract: query parameter `id`
- Screenshots: `53_service_detail_loading.png`, `54_service_detail_loaded.png`, `55_service_detail_modals.png`

#### `/task-view?id=...`

- Widget: `WTaskViewPage`
- Auth state: public browsing, authenticated apply/request actions
- Seed/API: `GET /api/v1/tasks/{id}`, `GET /api/v1/tasks/{id}/similar`, `POST /api/v1/task-requests`, `POST /api/v1/content-contact-click/`, `POST /api/v1/reports`
- Coverage: apply modal, own request block, request list, favorite toggle, phone modal, report modal, similar tasks
- Extra contract: query parameter `id`
- Screenshots: `56_task_detail_loading.png`, `57_task_detail_loaded.png`, `58_task_detail_modals.png`

### Create and edit forms

#### `/createVacancy`

- Widget: `CreateVacancyPage`
- Auth state: authenticated
- Seed/API: `GET /api/v1/categories`, `GET /api/v1/cities`, `GET /api/v1/tags`, `POST /api/v1/vacancies`, `PATCH /api/v1/vacancies/{id}/update`, `POST /api/v1/vacancies/{id}/images`
- Coverage: basic info, category picker, salary, employment type, work time, phone, who can respond, image upload/remove, Yandex address select, validation errors
- Extra contract: `state.extra: Vacancy?`
- Screenshots: `60_vacancy_create_initial.png`, `61_vacancy_create_validation.png`, `62_vacancy_create_success.png`

#### `/vacancy-form`

- Widget: `VacancyFormPage`
- Auth state: authenticated
- Seed/API: same as vacancy create plus AI/generate flow if available
- Coverage: generated vacancy draft, stepwise section fill, submit, edit mode, image fixture
- Extra contract: `state.extra: Map<String, dynamic>?`
- Screenshots: `63_vacancy_form_initial.png`, `64_vacancy_form_generated.png`

#### `/generate_vacancy`

- Widget: `WGenerateVacancy`
- Auth state: authenticated
- Seed/API: AI prompt flow or fallback error state
- Coverage: prompt entry, generation loading, generation success/failure
- Extra contract: none
- Screenshots: `65_generate_vacancy.png`

#### `/createService`

- Widget: `CreateServicePage`
- Auth state: authenticated
- Seed/API: `GET /api/v1/categories`, `GET /api/v1/cities`, `POST /api/v1/services`, `PATCH /api/v1/services/{id}/update`, `POST /api/v1/services/{id}/images`
- Coverage: title, description, price, negotiable toggle, address, phone, image upload/remove, validation
- Extra contract: `state.extra: ServiceModel?`
- Screenshots: `66_service_create_initial.png`, `67_service_create_validation.png`, `68_service_create_success.png`

#### `/createTask`

- Widget: `CreateTaskPage`
- Auth state: authenticated
- Seed/API: `GET /api/v1/categories`, `GET /api/v1/cities`, `POST /api/v1/tasks`, `PATCH /api/v1/tasks/{id}/update`, `POST /api/v1/tasks/{id}/images`
- Coverage: title, category, description, price, payment methods, date/time, address, remote, secure deal, image upload/remove, validation
- Extra contract: `state.extra: TaskModel?`
- Screenshots: `69_task_create_initial.png`, `70_task_create_validation.png`, `71_task_create_success.png`

### Private profile and management

#### `/edit-profile`

- Widget: `EditProfile`
- Auth state: authenticated
- Seed/API: `GET /api/v1/me`, `PATCH /api/v1/me/edit`, `POST /api/v1/me/avatar`, `POST /api/v1/me/verification-doc`, `POST /api/v1/me/portfolios`
- Coverage: avatar, verification doc, portfolios, city/category/gender/birthdate pickers, locale updates
- Extra contract: none
- Screenshots: `72_edit_profile_initial.png`, `73_edit_profile_validation.png`, `74_edit_profile_saved.png`

#### `/my-favorites`

- Widget: `FavoritesPage`
- Auth state: authenticated
- Seed/API: `GET /api/v1/me/vacancy/favorites`, `GET /api/v1/me/service/favorites`, `GET /api/v1/me/task/favorites`
- Coverage: vacancy/service/task tabs, empty and loaded states
- Extra contract: none
- Screenshots: `75_favorites_vacancy.png`, `76_favorites_service.png`, `77_favorites_task.png`

#### `/notificationDetails`

- Widget: `NotificationsDetail`
- Auth state: authenticated
- Seed/API: `GET /api/v1/notifications`, `POST /api/v1/notifications/{id}/make-read`
- Coverage: notification detail open, mark-read, back navigation
- Extra contract: `state.extra: Map<String, dynamic>`
- Screenshots: `78_notification_detail.png`

#### `/task-performers`

- Widget: `TaskPerformersPage`
- Auth state: authenticated
- Seed/API: `GET /api/v1/task-requests`, `POST /api/v1/task-requests/{id}/accept`, `POST /api/v1/task-requests/{id}/change-status`
- Coverage: performer list, request accept/reject, status transition, empty state
- Extra contract: `state.extra: TaskModel`
- Screenshots: `79_task_performers.png`

#### `/new-version`

- Widget: `NewVersionPage`
- Auth state: public
- Seed/API: app store link only
- Coverage: update prompt, store-link open, dismiss/continue if supported
- Extra contract: `state.extra: String`
- Screenshots: `80_new_version.png`

### Utility and modal surfaces

#### `/filterForm`

- Widget: `FilterForm`
- Auth state: public
- Seed/API: `GET /api/v1/categories`, `GET /api/v1/cities`
- Coverage: filter chips, validation, apply/reset, list-specific filters
- Extra contract: `state.extra: QueryParams`
- Screenshots: `90_filter_form.png`

#### `/map`

- Widget: `MapPage`
- Auth state: public
- Seed/API: `GET /api/v1/vacancies/geo`, `GET /api/v1/services/geo`, `GET /api/v1/tasks/geo`
- Coverage: type switching, marker tap, expanded list, geolocation loading/error
- Extra contract: `state.extra: String`
- Screenshots: `91_map_vacancies.png`, `92_map_services.png`, `93_map_tasks.png`

#### `/mapFilter`

- Widget: `MapFilterPage`
- Auth state: public
- Seed/API: category/city filtering
- Coverage: map type filtering, modal close/apply
- Extra contract: `state.extra: String`
- Screenshots: `94_map_filter.png`

#### `/yandex-map`

- Widget: `YandexMapPage`
- Auth state: public
- Seed/API: Yandex suggest/geocode external calls
- Coverage: search, select location, fallback error, permission prompt
- Extra contract: none
- Screenshots: `95_yandex_map.png`

#### `/yandex-map-view`

- Widget: `YandexMapViewPage`
- Auth state: public
- Seed/API: geolocation + Yandex map render
- Coverage: map view, selected marker, back navigation
- Extra contract: `state.extra: Map<String, dynamic>`
- Screenshots: `96_yandex_map_view.png`

#### `/expanded-view`

- Widget: `WExpandedViewPage`
- Auth state: public
- Seed/API: no backend; expands an already fetched list
- Coverage: expanded list, item tap, close
- Extra contract: `state.extra: Map<String, dynamic>`
- Screenshots: `97_expanded_view.png`

#### `/chat`

- Widget: `ChatPage`
- Auth state: authenticated
- Seed/API: `GET /api/v1/messages/{id}`, `GET /api/v1/messages/{id}/records`, `POST /api/v1/messages/{id}/records/make-read`, `POST /api/v1/messages/{id}/upload`, Mercure topic `chats/{messageId}/messages`
- Coverage: send text, attach file, mark read, realtime refresh, empty chat, error state
- Extra contract: `state.extra: messageId`
- Screenshots: `98_chat_loading.png`, `99_chat_loaded.png`, `100_chat_message_send.png`

#### `/othersProfile`

- Widget: `OthersProfilePage`
- Auth state: public browsing with authenticated actions
- Seed/API: `GET /api/v1/users/{id}/feedbacks`, `GET /api/v1/users/{id}/feedbacks/count`, `POST /api/v1/feedbacks`, `POST /api/v1/content-contact-click/`
- Coverage: author ads, review modal, like/dislike, message, tabs
- Extra contract: `state.extra: User`
- Screenshots: `101_others_profile.png`, `102_others_profile_review_modal.png`

#### `/categories-page`

- Widget: `WCategoriesPage`
- Auth state: public
- Seed/API: `GET /api/v1/categories`
- Coverage: category picker, search, empty state, selection return
- Extra contract: `state.extra: List<String>`
- Screenshots: `103_categories_page.png`

## Route Coverage Notes

- Every row above must be represented in the final manifest.
- Any screen opened through `state.extra` must have a deterministic fixture or seed contract before the UI test is written.
- The route matrix must stay aligned with `GoRouter.routes`; if a page is added to the app shell, this document should be updated in the same change.
