sealed class ApiConstants {
  ApiConstants._();

  static const bool _isProd = bool.fromEnvironment('dart.vm.product');

  /// === BASE URL endpoints ===
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue:
        _isProd
            ? 'https://api.ishbor.uz/'
            : 'http://host.docker.internal:8080/',
  );

  ///  Websocket url
  static const String wsUrl = String.fromEnvironment(
    'WS_BASE_URL',
    defaultValue:
        _isProd ? 'wss://ws.ishbor.uz' : 'ws://host.docker.internal:8081',
  );

  /// Optional host header for local Docker API routing.
  static const String apiHostHeader = String.fromEnvironment(
    'API_HOST_HEADER',
    defaultValue: _isProd ? '' : 'test.api.ishbor.uz',
  );

  /// === OPEN STREET endpoints ===
  static const String reverseLocation =
      "https://nominatim.openstreetmap.org/reverse";
  static const String searchLocation =
      "https://nominatim.openstreetmap.org/search";

  /// === ChatGPT endpoints ===
  static const String chatGpt = "chatgpt";

  /// === Common endpoints ===
  static const String similar = 'similar';

  /// === Notifications endpoints ===
  static const String notifications = 'notifications';

  static String makeReadNotification(int id) => "$notifications/$id/make-read";

  ///  === VACANCIES endpoints ===
  static const String vacancies = 'vacancies';
  static const String vacanciesGeo = '$vacancies/geo';
  static const String myVacancies = 'me/vacancies/customer';
  static const String myVacancyApplies = 'me/vacancies/performer';
  static const String vacancyFavorite = "me/vacancy/favorites";

  static String fetchVacancy(int id) => '$vacancies/$id';

  static String fetchSimilarVacancy(int id) => '$vacancies/$id/$similar';

  static String applyVacancy(int id) => '$vacancies/$id/vacancy-requests';

  static String fetchOwnVacancyRequest(int id) =>
      '$vacancies/$id/vacancy-requests/own';

  static String fetchListVacancyRequests(int id) =>
      '$vacancies/$id/vacancy-requests';

  static String updateVacancy(int id) => '$vacancies/$id/update';

  static String liftUpVacancyById(int id) => '$vacancies/$id/lift-up';

  static String changeVacancyStatusById(int id) =>
      '$vacancies/$id/change-status';

  static String toggleVacancyFavorite(int id) => "$vacancies/$id/favorite";

  static String deleteVacancyById(int id) => '$vacancies/$id';

  /// === CATEGORIES endpoints ===
  static const String categories = "categories";

  /// === SERVICES endpoints ===
  static const String services = 'services';
  static const String servicesGeo = '$services/geo';
  static const String myServices = 'me/services/customer';
  static const String myServiceApplies = 'me/services/performer';
  static const String serviceFavorite = "me/service/favorites";

  static String fetchService(int id) => '$services/$id';

  static String fetchSimilarService(int id) => '$services/$id/$similar';

  static String updateService(int id) => '$services/$id/update';

  static String uploadServiceImages(int id) => '$services/$id/images';

  static String liftUpServiceById(int id) => '$services/$id/lift-up';

  static String deactivateServiceById(int id) => '$services/$id/change-status';

  static String toggleServiceFavorite(int id) => "$services/$id/favorite";

  static String deleteServiceById(int id) => '$services/$id';

  /// === TASKS endpoints ===
  static const String tasks = 'tasks';
  static const String tasksGeo = '$tasks/geo';
  static const String myTasks = 'me/tasks/customer';
  static const String myTaskApplies = 'me/tasks/performer';
  static const String taskFavorite = "me/task/favorites";

  static String fetchTask(int id) => '$tasks/$id';

  static String fetchSimilarTask(int id) => '$tasks/$id/$similar';

  static String applyTask(int id) => '$tasks/$id/task-requests';

  static String fetchOwnTaskRequest(int id) => '$tasks/$id/task-requests/own';

  static String fetchListTaskRequests(int id) => '$tasks/$id/task-requests';

  static String updateTask(int id) => '$tasks/$id/update';

  static String uploadTaskImages(int id) => '$tasks/$id/images';

  static String liftUpTaskById(int id) => '$tasks/$id/lift-up';

  static String deactivateTaskById(int id) => '$tasks/$id/change-status';

  static String toggleTaskFavorite(int id) => "$tasks/$id/favorite";

  static String deleteTaskById(int id) => '$tasks/$id';

  static String vacancyContact(int vacancyId) => "vacancies/$vacancyId/phone";

  static String serviceContact(int serviceId) => "services/$serviceId/phone";

  static String taskContact(int taskId) => "tasks/$taskId/phone";

  /// === AUTH endpoints ===
  static const String loginCheck = 'security/login_check';
  static const String register = 'security/registration';
  static const String verifyPhone = 'security/verify-phone';
  static const String forgotPassword = 'security/forgot-password';
  static const String forgotPasswordVerify = 'security/forgot-password/verify';
  static const String sendCodeAgain = 'security/verify-phone/send-again';

  /// ==== USER endpoints ====
  static const String me = 'me';
  static const String meEdit = '$me/edit';
  static const String mePortfolios = '$me/portfolios';
  static const String meVerificationDoc = '$me/verification-doc';
  static const String meLocale = "$me/locale";
  static const String meAvatar = "$me/avatar";

  /// ==== FEEDBACK endpoints ====
  static String userFeedbacks(int userId) => 'users/$userId/feedbacks';

  static String userFeedbacksCount(int userId) =>
      'users/$userId/feedbacks/count';
  static const String feedbacks = "feedbacks";

  /// ==== CITIES endpoints ====
  static const String cities = "cities";

  /// ==== MESSAGES endpoints ====
  static const String messages = 'messages';

  static String fetchMessage(int id) => '$messages/$id';

  static String listMessages(String type) => '$messages/$type';

  static String postMessage() => messages;

  static String messageRecords(int messageId) => '$messages/$messageId/records';

  static String uploadMessageFile(int messageId) =>
      '$messages/$messageId/upload';
  static String askQuestion = "$messages/records";

  static String makeMessageRead(int messageId) =>
      "$messages/$messageId/records/make-read";

  static const String paymentTransactions = "/payment-transactions";
  static const String reports = '/reports';

  static const String yandexApiKey = "d5d11899-3666-4363-98c8-ffc2f4c11a1f";
  static const String yandexGeocodeKey = "773f30b3-80df-4c93-8f3f-99ff4833ca4b";
  static const String yandexSuggestKey = "6773b3db-3070-4fab-a39a-9f8b468106a8";

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
