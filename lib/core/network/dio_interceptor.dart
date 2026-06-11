import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../consts.dart';
import '../constants/api_const.dart';
import 'snake_case_mapper.dart';
import '../services/storage_service.dart';

class DioInterceptors extends Interceptor {
  DioInterceptors(this._storageService, this._dio);

  final StorageService _storageService;
  final Dio _dio;
  final Random _random = Random();
  Future<void>? _refreshInFlight;

  static const int _maxNetworkRetryCount = 2;
  static const int _maxUnauthorizedRetryCount = 1;
  static const Duration _refreshSkew = Duration(minutes: 1);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      await _prepareRequest(options);
      handler.next(options);
    } catch (error, stackTrace) {
      if (kDebugMode) {
        debugPrint('[DIO][request][error] ${options.method} ${options.uri}');
        debugPrint('$error');
      }
      handler.reject(
        DioException(
          requestOptions: options,
          error: error,
          stackTrace: stackTrace,
          type: DioExceptionType.unknown,
          message: error.toString(),
        ),
      );
    }
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    _persistDeviceTokenFromResponse(response);
    handler.next(response);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final requestOptions = err.requestOptions;
    final retryAttempt = _retryAttempt(requestOptions);

    if (_shouldRefreshOnUnauthorized(err) &&
        retryAttempt < _maxUnauthorizedRetryCount) {
      try {
        await _refreshTokens(force: true);
        handler.resolve(
          await _retry(requestOptions, attempt: retryAttempt + 1),
        );
        return;
      } on DioException catch (e) {
        await _storageService.clearAuth();
        handler.next(e);
        return;
      } catch (error) {
        await _storageService.clearAuth();
        handler.next(
          DioException(
            requestOptions: requestOptions,
            type: DioExceptionType.unknown,
            message: error.toString(),
            error: error,
          ),
        );
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

  Future<void> _prepareRequest(RequestOptions options) async {
    if (_shouldBypassInterceptors(options)) {
      return;
    }

    _normalizeRequest(options);

    final headers = Map<String, dynamic>.from(options.headers);
    headers['Accept'] ??= 'application/json';
    headers['X-Device-Type'] ??= Platform.isAndroid ? 'android' : 'ios';

    final deviceToken = await _ensureDeviceToken();
    if (deviceToken != null && deviceToken.isNotEmpty) {
      headers['X-Device-Token'] = deviceToken;
    } else if (_shouldAttachAuthorization(options)) {
      throw StateError(
        '[DIO][device-token] unable to bootstrap token for '
        '${options.method} ${options.uri.path}',
      );
    }

    final shouldAttachAuthorization = _shouldAttachAuthorization(options);
    if (shouldAttachAuthorization &&
        await _storageService.hasFreshToken(skew: _refreshSkew)) {
      final token = await _storageService.fetchToken();
      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }
    } else if (shouldAttachAuthorization) {
      await _refreshTokens();
      final token = await _storageService.fetchToken();
      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }
    }

    final timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final rawBody = _canonicalRequestBody(options.data);
    headers['X-Timestamp'] = timestamp.toString();

    if (_shouldSignRequest(options)) {
      headers['X-Signature'] = _buildSignature(
        path: options.uri.path,
        rawBody: rawBody,
        timestamp: timestamp,
      );
    }

    options.headers
      ..clear()
      ..addAll(headers);

    if (kDebugMode) {
      debugPrint(
        '[DIO][request] ${options.method} ${options.uri.path}'
        ' ts=$timestamp bodyHash=${sha256.convert(utf8.encode(rawBody)).toString().substring(0, 8)}'
        ' auth=${headers.containsKey("Authorization")}'
        ' device=${headers.containsKey("X-Device-Token")}',
      );
    }
  }

  void _normalizeRequest(RequestOptions options) {
    options.queryParameters = SnakeCaseMapper.normalizeQuery(
      options.queryParameters,
    );

    if (options.data is FormData) {
      return;
    }

    options.data = SnakeCaseMapper.normalizeBody(options.data);
  }

  String _canonicalRequestBody(dynamic data) {
    if (data == null) {
      return '';
    }

    if (data is FormData) {
      return '';
    }

    if (data is String) {
      return data;
    }

    if (data is Map || data is List) {
      return jsonEncode(data);
    }

    return jsonEncode(data);
  }

  bool _shouldBypassInterceptors(RequestOptions options) {
    if (options.extra['skip_signature'] == true) {
      return true;
    }

    if (!options.uri.isAbsolute) {
      return false;
    }

    final apiHost = Uri.parse(apiBaseUrl).host;
    return options.uri.host != apiHost;
  }

  bool _shouldAttachAuthorization(RequestOptions options) {
    if (options.extra['skip_authorization'] == true) {
      return false;
    }

    return !options.uri.path.startsWith('/api/v1/auth/');
  }

  bool _shouldSignRequest(RequestOptions options) {
    if (options.extra['skip_signature'] == true) {
      return false;
    }

    if (!options.uri.isAbsolute) {
      return true;
    }

    final apiHost = Uri.parse(apiBaseUrl).host;
    return options.uri.host == apiHost;
  }

  Future<String?> _ensureDeviceToken() async {
    final stored = await _storageService.fetchDeviceToken();
    if (stored != null && stored.isNotEmpty) {
      return stored;
    }

    try {
      final token = await _fetchFirebaseDeviceToken();
      if (token != null && token.isNotEmpty) {
        await _storageService.putDeviceToken(token);
        if (kDebugMode) {
          debugPrint('[FIX][DIO][device-token] bootstrapped from Firebase');
        }
      }
      return token;
    } catch (error) {
      if (kDebugMode) {
        debugPrint('[FIX][DIO][device-token] failed to bootstrap: $error');
      }
      return null;
    }
  }

  void _persistDeviceTokenFromResponse(Response<dynamic> response) {
    final deviceToken =
        response.headers.value('X-Device-Token') ??
        response.headers.value('x-device-token');

    if (deviceToken == null || deviceToken.isEmpty) {
      return;
    }

    if (kDebugMode) {
      debugPrint(
        '[FIX][DIO][device-token] persisted from response for '
        '${response.requestOptions.method} ${response.requestOptions.uri.path}',
      );
    }

    unawaited(_storageService.putDeviceToken(deviceToken));
  }

  Future<String?> _fetchFirebaseDeviceToken() async {
    try {
      return await FirebaseMessaging.instance.getToken();
    } catch (_) {
      return null;
    }
  }

  String _buildSignature({
    required String path,
    required String rawBody,
    required int timestamp,
  }) {
    final payload = '$path|$rawBody|$timestamp';
    final secret = apiSignatureSecret;
    if (secret.isEmpty && kDebugMode) {
      debugPrint('[DIO][signature] API_SIGNATURE_SECRET is empty');
    }

    final key = utf8.encode(secret);
    final bytes = utf8.encode(payload);
    final hmacSha256 = Hmac(sha256, key);
    return hmacSha256.convert(bytes).toString();
  }

  bool _shouldRefreshOnUnauthorized(DioException err) {
    if (err.response?.statusCode != 401) {
      return false;
    }

    final path = err.requestOptions.uri.path;
    if (path.startsWith('/api/v1/auth/')) {
      return false;
    }

    return true;
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
  }) async {
    await _prepareRequest(requestOptions);
    final retryOptions = Options(
      method: requestOptions.method,
      headers: Map<String, dynamic>.from(requestOptions.headers),
      responseType: requestOptions.responseType,
      contentType: requestOptions.contentType,
      sendTimeout: requestOptions.sendTimeout,
      receiveTimeout: requestOptions.receiveTimeout,
      extra: {...requestOptions.extra, 'retry_attempt': attempt},
    );

    return _dio.requestUri<dynamic>(
      requestOptions.uri,
      data: requestOptions.data,
      options: retryOptions,
    );
  }

  Future<void> _refreshTokens({bool force = false}) async {
    final refreshToken = await _storageService.fetchRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      return;
    }

    if (!force && await _storageService.hasFreshToken(skew: _refreshSkew)) {
      return;
    }

    if (_refreshInFlight != null) {
      return _refreshInFlight!;
    }

    final completer = Completer<void>();
    _refreshInFlight = completer.future;

    try {
      final response = await _dio.post(
        ApiConstants.authRefresh,
        data: {'refresh_token': refreshToken},
        options: Options(
          extra: {
            'skip_authorization': true,
            'skip_signature': false,
            'skip_token_refresh': true,
          },
        ),
      );

      final payload =
          response.data is Map<String, dynamic>
              ? (response.data['data'] is Map<String, dynamic>
                  ? Map<String, dynamic>.from(response.data['data'])
                  : Map<String, dynamic>.from(response.data))
              : <String, dynamic>{};

      final accessToken = payload['access_token'] as String?;
      final newRefreshToken =
          payload['refresh_token'] as String? ?? refreshToken;
      final expiresIn =
          payload['expires_in'] is int
              ? payload['expires_in'] as int
              : int.tryParse('${payload['expires_in'] ?? ''}');

      if (accessToken == null || accessToken.isEmpty) {
        throw StateError('Refresh response missing access_token.');
      }

      await _storageService.putToken(accessToken);
      await _storageService.putRefreshToken(newRefreshToken);
      await _storageService.putExpireDate(
        expiresIn != null
            ? DateTime.now().add(Duration(seconds: expiresIn))
            : null,
      );

      if (kDebugMode) {
        debugPrint(
          '[DIO][refresh] success expiresIn=${expiresIn ?? 'unknown'}',
        );
      }

      completer.complete();
    } catch (error, stackTrace) {
      completer.completeError(error, stackTrace);
      if (error is DioException) {
        rethrow;
      }
      throw DioException(
        requestOptions: RequestOptions(path: ApiConstants.authRefresh),
        type: DioExceptionType.unknown,
        message: error.toString(),
        error: error,
      );
    } finally {
      _refreshInFlight = null;
    }
  }
}
