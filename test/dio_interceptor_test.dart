import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:top_jobs/core/constants/app_locale_keys.dart';
import 'package:top_jobs/core/network/dio_interceptor.dart';
import 'package:top_jobs/core/services/storage_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('dio-interceptor-test');
    Hive.init(tempDir.path);
    await Hive.openBox(AppLocaleKeys.appName);
    await StorageService.instance.putDeviceToken(null);
  });

  tearDown(() async {
    await Hive.box(AppLocaleKeys.appName).clear();
    await Hive.box(AppLocaleKeys.appName).close();
    if (await tempDir.exists()) {
      await tempDir.delete(recursive: true);
    }
  });

  test('persists x-device-token from response headers', () async {
    final dio = Dio();
    final interceptor = DioInterceptors(StorageService.instance, dio);
    final requestOptions = RequestOptions(path: '/api/v1/me');
    final response = Response<dynamic>(
      requestOptions: requestOptions,
      headers: Headers.fromMap({
        'X-Device-Token': ['response-device-token'],
      }),
    );

    interceptor.onResponse(response, _ResponseHandler());
    await Future<void>.delayed(Duration.zero);

    expect(
      await StorageService.instance.fetchDeviceToken(),
      'response-device-token',
    );
  });
}

class _ResponseHandler extends ResponseInterceptorHandler {
  @override
  void next(Response response) {}

  @override
  void resolve(Response response) {}
}
