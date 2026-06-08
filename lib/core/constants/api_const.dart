import 'package:top_jobs/consts.dart';

sealed class ApiConstants {
  ApiConstants._();

  static String get baseUrl => apiBaseUrl;
  static String get wsUrl => websocketUrl;
  static const String apiPrefix = '/api/v1';

  static String _route(String path) => '$apiPrefix/$path';
  static String _id(Object value) => value.toString();

  /// === OPEN STREET endpoints ===
  static const String reverseLocation =
      'https://nominatim.openstreetmap.org/reverse';
  static const String searchLocation =
      'https://nominatim.openstreetmap.org/search';

  /// === Common endpoints ===
  static const String similar = 'similar';

  /// === Auth ===
  static String get authRequestCode => _route('auth/request-code');
  static String get authVerifyCode => _route('auth/verify-code');
  static String get authRegister => _route('auth/register');
  static String get authRefresh => _route('auth/refresh');
  static String get authLogout => _route('auth/logout');

  /// === Notifications ===
  static String get notifications => _route('notifications');
  static String makeReadNotification(Object id) =>
      '$notifications/${_id(id)}/make-read';

  /// === Vacancies ===
  static String get vacancies => _route('vacancies');
  static String get vacanciesGeo => '$vacancies/geo';
  static String get myVacancies => _route('me/vacancies/customer');
  static String get myVacancyApplies => _route('me/vacancies/performer');
  static String get vacancyFavorite => _route('me/vacancy/favorites');

  static String fetchVacancy(Object id) => '$vacancies/${_id(id)}';
  static String fetchSimilarVacancy(Object id) =>
      '$vacancies/${_id(id)}/$similar';
  static String applyVacancy(Object id) =>
      '$vacancies/${_id(id)}/vacancy-requests';
  static String fetchOwnVacancyRequest(Object id) =>
      '$vacancies/${_id(id)}/vacancy-requests/own';
  static String fetchListVacancyRequests(Object id) =>
      '$vacancies/${_id(id)}/vacancy-requests';
  static String updateVacancy(Object id) => '$vacancies/${_id(id)}/update';
  static String liftUpVacancyById(Object id) =>
      '$vacancies/${_id(id)}/lift-up';
  static String changeVacancyStatusById(Object id) =>
      '$vacancies/${_id(id)}/change-status';
  static String toggleVacancyFavorite(Object id) =>
      '$vacancies/${_id(id)}/favorite';
  static String deleteVacancyById(Object id) => '$vacancies/${_id(id)}';

  /// === Categories ===
  static String get categories => _route('categories');
  static String get popularCategories => _route('categories/popular');

  /// === Services ===
  static String get services => _route('services');
  static String get servicesGeo => '$services/geo';
  static String get myServices => _route('me/services/customer');
  static String get myServiceApplies => _route('me/services/performer');
  static String get serviceFavorite => _route('me/service/favorites');

  static String fetchService(Object id) => '$services/${_id(id)}';
  static String fetchSimilarService(Object id) =>
      '$services/${_id(id)}/$similar';
  static String updateService(Object id) => '$services/${_id(id)}/update';
  static String uploadServiceImages(Object id) => '$services/${_id(id)}/images';
  static String liftUpServiceById(Object id) => '$services/${_id(id)}/lift-up';
  static String deactivateServiceById(Object id) =>
      '$services/${_id(id)}/change-status';
  static String toggleServiceFavorite(Object id) =>
      '$services/${_id(id)}/favorite';
  static String deleteServiceById(Object id) => '$services/${_id(id)}';

  /// === Tasks ===
  static String get tasks => _route('tasks');
  static String get tasksGeo => '$tasks/geo';
  static String get myTasks => _route('me/tasks/customer');
  static String get myTaskApplies => _route('me/tasks/performer');
  static String get taskFavorite => _route('me/task/favorites');

  static String fetchTask(Object id) => '$tasks/${_id(id)}';
  static String fetchSimilarTask(Object id) => '$tasks/${_id(id)}/$similar';
  static String applyTask(Object id) => '$tasks/${_id(id)}/task-requests';
  static String fetchOwnTaskRequest(Object id) =>
      '$tasks/${_id(id)}/task-requests/own';
  static String fetchListTaskRequests(Object id) =>
      '$tasks/${_id(id)}/task-requests';
  static String updateTask(Object id) => '$tasks/${_id(id)}/update';
  static String uploadTaskImages(Object id) => '$tasks/${_id(id)}/images';
  static String liftUpTaskById(Object id) => '$tasks/${_id(id)}/lift-up';
  static String deactivateTaskById(Object id) =>
      '$tasks/${_id(id)}/change-status';
  static String toggleTaskFavorite(Object id) =>
      '$tasks/${_id(id)}/favorite';
  static String deleteTaskById(Object id) => '$tasks/${_id(id)}';

  static String vacancyContact(Object vacancyId) =>
      _route('vacancies/${_id(vacancyId)}/phone');
  static String serviceContact(Object serviceId) =>
      _route('services/${_id(serviceId)}/phone');
  static String taskContact(Object taskId) =>
      _route('tasks/${_id(taskId)}/phone');

  /// === User ===
  static String get me => _route('me');
  static String get meEdit => '$me/edit';
  static String get mePortfolios => '$me/portfolios';
  static String get meVerificationDoc => '$me/verification-doc';
  static String get meLocale => '$me/locale';
  static String get meAvatar => '$me/avatar';
  static String get meDestroyAccount => '$me/destroy-account';
  static String get meLocaleSync => '$me/locale';

  static String userFeedbacks(Object userId) =>
      _route('users/${_id(userId)}/feedbacks');
  static String userFeedbacksCount(Object userId) =>
      _route('users/${_id(userId)}/feedbacks/count');
  static String get feedbacks => _route('feedbacks');

  /// === Cities ===
  static String get cities => _route('cities');

  /// === Messages ===
  static String get messages => _route('messages');
  static String fetchMessage(Object id) => '$messages/${_id(id)}';
  static String listMessages(String type) => '$messages/$type';
  static String get postMessage => messages;
  static String messageRecords(Object messageId) =>
      '$messages/${_id(messageId)}/records';
  static String uploadMessageFile(Object messageId) =>
      '$messages/${_id(messageId)}/upload';
  static String get askQuestion => '$messages/records';
  static String makeMessageRead(Object messageId) =>
      '$messages/${_id(messageId)}/records/make-read';

  /// === Payments / Reports ===
  static String get paymentTransactions => _route('payment-transactions');
  static String get reports => _route('reports');
  static String get contentContactClick => _route('content-contact-click/');

  /// === AI / Search / Misc ===
  static String get chatGpt => _route('chatgpt');
  static String get search => _route('search/');

  /// === Yandex / external ===
  static const String yandexApiKey = 'd5d11899-3666-4363-98c8-ffc2f4c11a1f';
  static const String yandexGeocodeKey =
      '773f30b3-80df-4c93-8f3f-99ff4833ca4b';
  static const String yandexSuggestKey =
      '6773b3db-3070-4fab-a39a-9f8b468106a8';

  static String yandexGeoSuggest({
    required String search,
    required String suggestApiKey,
    required String language,
  }) =>
      'https://suggest-maps.yandex.ru/v1/suggest?apikey=$yandexSuggestKey&text=$search&print_address=1&attrs=uri&lang=$language';

  static String yandexGeocodePositionToAddress({
    required String geocodeApiKey,
    required double lat,
    required double long,
    required String language,
  }) =>
      'https://geocode-maps.yandex.ru/1.x?apikey=$yandexGeocodeKey&geocode=$long,$lat&lang=$language&format=json';

  static String yandexGeocodeAddressToPosition({
    required String geocodeApiKey,
    required String query,
    required String language,
  }) =>
      'https://geocode-maps.yandex.ru/1.x?apikey=$yandexGeocodeKey&geocode=$query&lang=$language&format=json';
}
