import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';

import '../services/storage_service.dart';

class DioInterceptors extends Interceptor {
  final StorageService _storageService;
  final Dio _dio;
  final Random _random = Random();

  DioInterceptors(this._storageService, this._dio);

  static const int _maxNetworkRetryCount = 2;
  static const int _maxUnauthorizedRetryCount = 1;

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
    final requestOptions = err.requestOptions;
    final retryAttempt = _retryAttempt(requestOptions);

    if (err.response?.statusCode == 401 &&
        retryAttempt < _maxUnauthorizedRetryCount) {
      try {
        handler.resolve(
          await _retry(
            requestOptions,
            attempt: retryAttempt + 1,
            markUnauthorizedRetry: true,
          ),
        );
        return;
      } on DioException catch (e) {
        handler.next(e);
        return;
      }
    }

    if (_shouldRetryNetworkError(err) && retryAttempt < _maxNetworkRetryCount) {
      try {
        final nextAttempt = retryAttempt + 1;
        await Future<void>.delayed(_backoffDelay(nextAttempt));
        handler.resolve(await _retry(requestOptions, attempt: nextAttempt));
        return;
      } on DioException catch (e) {
        handler.next(e);
        return;
      }
    }

    handler.next(err);
  }

  int _retryAttempt(RequestOptions requestOptions) =>
      (requestOptions.extra['retry_attempt'] as int?) ?? 0;

  bool _shouldRetryNetworkError(DioException err) {
    if (!_isIdempotentMethod(err.requestOptions.method)) return false;
    if (err.type == DioExceptionType.cancel) return false;

    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.connectionError) {
      return true;
    }

    final statusCode = err.response?.statusCode;
    if (statusCode != null && [502, 503, 504].contains(statusCode)) {
      return true;
    }

    final errorObject = err.error;
    if (errorObject is SocketException || errorObject is HandshakeException) {
      return true;
    }

    return false;
  }

  bool _isIdempotentMethod(String method) {
    const safeMethods = {'GET', 'HEAD', 'OPTIONS'};
    return safeMethods.contains(method.toUpperCase());
  }

  Duration _backoffDelay(int attempt) {
    final baseMs = 300 * (1 << (attempt - 1));
    final jitterMs = _random.nextInt(150);
    return Duration(milliseconds: baseMs + jitterMs);
  }

  Future<Response<dynamic>> _retry(
    RequestOptions requestOptions, {
    required int attempt,
    bool markUnauthorizedRetry = false,
  }) async {
    String? token = await _storageService.fetchToken();
    String? deviceToken = await _storageService.fetchDeviceToken();

    final headers = Map<String, dynamic>.from(requestOptions.headers);
    if (token != null) {
      headers["Authorization"] = "Bearer $token";
    }
    if (deviceToken != null) {
      headers["X-Device-Token"] = deviceToken;
      headers["X-Device-Type"] = Platform.isAndroid ? "android" : "ios";
    }

    final options = Options(
      method: requestOptions.method,
      headers: headers,
      responseType: requestOptions.responseType,
      contentType: requestOptions.contentType,
      sendTimeout: requestOptions.sendTimeout,
      receiveTimeout: requestOptions.receiveTimeout,
      extra: {
        ...requestOptions.extra,
        'retried': markUnauthorizedRetry,
        'retry_attempt': attempt,
      },
    );

    return _dio.requestUri<dynamic>(
      requestOptions.uri,
      data: requestOptions.data,
      options: options,
    );
  }
}
