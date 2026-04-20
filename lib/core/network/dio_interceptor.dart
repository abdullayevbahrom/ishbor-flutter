import 'dart:io';

import 'package:dio/dio.dart';

import '../services/storage_service.dart';

class DioInterceptors extends Interceptor {
  final StorageService _storageService;

  DioInterceptors(this._storageService);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    String? token = await _storageService.fetchToken();
    String? deviceToken = await _storageService.fetchDeviceToken();

    if (deviceToken != null) {
      options.headers.addAll({
        "X-Device-Token": deviceToken,
        "X-Device-Type": Platform.isAndroid ? "android" : "ios",
      });
    }

    if (token != null) {
      options.headers.addAll({"Authorization": "Bearer $token"});
    }
    return super.onRequest(options, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      final hasRetried = err.requestOptions.extra['retried'] == true;
      if (hasRetried) {
        handler.next(err);
        return;
      }

      try {
        handler.resolve(await _retry(err.requestOptions));
        return;
      } on DioException catch (_) {
        handler.next(err);
        return;
      }
    }
    handler.next(err);
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    String? token = await _storageService.fetchToken();
    final headers = Map<String, dynamic>.from(requestOptions.headers);
    if (token != null) {
      headers["Authorization"] = "Bearer $token";
    }

    final retryDio = Dio();
    final options = Options(
      method: requestOptions.method,
      headers: headers,
      responseType: requestOptions.responseType,
      contentType: requestOptions.contentType,
      sendTimeout: requestOptions.sendTimeout,
      receiveTimeout: requestOptions.receiveTimeout,
      extra: {...requestOptions.extra, 'retried': true},
    );

    return retryDio.requestUri<dynamic>(
      requestOptions.uri,
      data: requestOptions.data,
      options: options,
    );
  }
}
