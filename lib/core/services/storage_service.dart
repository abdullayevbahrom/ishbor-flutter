import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:top_jobs/feature/ads_form/data/models/request/vacancy_params.dart';
import '../constants/app_locale_keys.dart';
class StorageService {
  static final StorageService instance = StorageService._();

  StorageService._();

  final Box _box = Hive.box(AppLocaleKeys.appName);

  Future<void> putToken(String? token) async {
    await _box.put(_StorageKeys.token, token);
  }

  Future<String?> fetchToken() async {
    return await _box.get(_StorageKeys.token, defaultValue: null);
  }

  Future<void> putUserId(int userId) async {
    await _box.put(_StorageKeys.userId, userId);
  }

  Future<int?> fetchUserId() async {
    return await _box.get(_StorageKeys.userId, defaultValue: null);
  }

  Future<void> putExpireDate(DateTime? time) async {
    await _box.put(_StorageKeys.tokenExpireDate, time);
  }

  Future<DateTime?> getExpireDate() async {
    return _box.get(_StorageKeys.tokenExpireDate, defaultValue: null);
  }

  Future<void> putDeviceToken(String? deviceToken) async {
    await _box.put(_StorageKeys.deviceToken, deviceToken);
  }

  Future<String?> fetchDeviceToken() async {
    return await _box.get(_StorageKeys.deviceToken, defaultValue: null);
  }

  Future<void> putPassword(String? password) async {
    await _box.put(_StorageKeys.password, password);
  }

  Future<void> putSearchQuery(String query) async {
    final oldQueries = List.from(await fetchSearchQuery());
    final newQueries = oldQueries..insert(0, query);
    if (newQueries.length > 5) {
      final newSortedQueries = newQueries.sublist(0, 4);
      await _box.put(_StorageKeys.searchQuery, newSortedQueries);
    } else {
      await _box.put(_StorageKeys.searchQuery, newQueries);
    }
  }

  Future<VacancyParams?> getVacancyParams() async {
    final vacancyParams = await _box.get(_StorageKeys.vacancyParams);
    if (vacancyParams == null) return null;
    return VacancyParams.fromJson(jsonDecode(vacancyParams));
  }

  Future<void> putVacancyParams(VacancyParams? vacancyParams) async {
    await _box.put(
      _StorageKeys.vacancyParams,
      vacancyParams != null ? jsonEncode(vacancyParams.toJson()) : null,
    );
  }

  Future<List<String>> fetchSearchQuery() async {
    final list = _box.get(_StorageKeys.searchQuery, defaultValue: []);
    return List<String>.from(list.whereType<String>());
  }

  Future<String?> fetchPassword() async {
    return await _box.get(_StorageKeys.password, defaultValue: null);
  }

  Future<void> putPendingKey(String? value) async {
    await _box.put(_StorageKeys.pendingNavigationKey, value);
  }

  Future<String?> getPendingKey() async {
    return await _box.get(
      _StorageKeys.pendingNavigationKey,
      defaultValue: null,
    );
  }

  Future<void> clear() async {
    await _box.clear();
  }

  Future<void> putCountOfPhoneReq() async {
    final countOfReq = await getCountOfPhoneReq();
    await _box.put(_StorageKeys.countOfPhoneReq, countOfReq + 1);
  }

  Future<int> getCountOfPhoneReq() async {
    return await _box.get(_StorageKeys.countOfPhoneReq, defaultValue: 0);
  }
}

class _StorageKeys {
  static const String token = "token";
  static const String tokenExpireDate = "tokenExpireDate";
  static const String password = "password";
  static const String searchQuery = "searchQuery";
  static const String deviceToken = "deviceToken";
  static const String vacancyParams = "vacancyParams";
  static const String pendingNavigationKey = "pendingNavigationKey";
  static const String userId = "userId";
  static const String countOfPhoneReq = "countPhoneNumberReq";
}
