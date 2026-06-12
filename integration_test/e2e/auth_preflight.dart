import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:top_jobs/core/constants/api_const.dart';
import 'package:top_jobs/feature/auth/data/models/auth_success.dart';

import 'e2e_config.dart';

final class AuthPreflightResult {
  const AuthPreflightResult({
    required this.mode,
    required this.accessToken,
    required this.refreshToken,
    required this.userId,
    required this.deviceToken,
    required this.expiresAt,
  });

  final String mode;
  final String accessToken;
  final String? refreshToken;
  final String? userId;
  final String? deviceToken;
  final DateTime? expiresAt;

  bool get hasRefreshToken => (refreshToken ?? '').trim().isNotEmpty;

  AuthPreflightResult copyWith({
    String? mode,
    String? accessToken,
    String? refreshToken,
    String? userId,
    String? deviceToken,
    DateTime? expiresAt,
  }) {
    return AuthPreflightResult(
      mode: mode ?? this.mode,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      userId: userId ?? this.userId,
      deviceToken: deviceToken ?? this.deviceToken,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }
}

final class AuthPreflight {
  AuthPreflight(this._config) {
    _dio = Dio(
      BaseOptions(
        baseUrl: _config.apiBaseUrl,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
      ),
    );
  }

  final E2EConfig _config;
  late final Dio _dio;

  Future<AuthPreflightResult> run() async {
    final missing = _config.validate();
    if (missing.isNotEmpty) {
      throw StateError('Missing E2E env: ${missing.join(', ')}');
    }

    debugPrint(
      '[INFO][E2E][auth-preflight] start mode=${_config.authMode} phone=${_maskPhone(_config.testPhone)} runId=${_config.runId}',
    );

    if (_config.hasAccessToken) {
      final validated = await _validateToken(_config.accessToken);
      debugPrint(
        '[INFO][E2E][auth-preflight] mode=token status=ok userId=${validated.userId ?? "<unknown>"}',
      );
      return validated;
    }

    final requested = await _requestCode(_config.testPhone);
    final verified = await _verifyCode(
      phoneNumber: _config.testPhone,
      code: _config.testOtp,
    );

    final refreshed =
        verified.hasRefreshToken
            ? await _refreshToken(verified.refreshToken!, verified.deviceToken)
            : verified;
    final validated = await _validateToken(refreshed.accessToken);
    final result = validated.copyWith(
      mode: 'otp',
      refreshToken: refreshed.refreshToken,
      deviceToken: refreshed.deviceToken ?? requested.deviceToken,
      expiresAt: refreshed.expiresAt ?? validated.expiresAt,
    );

    debugPrint(
      '[INFO][E2E][auth-preflight] mode=otp status=ok userId=${result.userId ?? "<unknown>"}',
    );
    return result;
  }

  Future<AuthPreflightResult> _requestCode(String phoneNumber) async {
    final payload = {'phone_number': phoneNumber};
    final response = await _dio.post(
      ApiConstants.authRequestCode,
      data: payload,
      options: _signedOptions(ApiConstants.authRequestCode, payload),
    );

    final deviceToken = _deviceTokenFromResponse(response);
    return AuthPreflightResult(
      mode: 'otp',
      accessToken: '',
      refreshToken: null,
      userId: null,
      deviceToken: deviceToken,
      expiresAt: null,
    );
  }

  Future<AuthPreflightResult> _verifyCode({
    required String phoneNumber,
    required String code,
  }) async {
    final payload = {'phone_number': phoneNumber, 'code': code};
    final response = await _dio.post(
      ApiConstants.authVerifyCode,
      data: payload,
      options: _signedOptions(ApiConstants.authVerifyCode, payload),
    );

    final auth = AuthSuccess.fromJson(_payload(response.data));
    final accessToken = auth.accessToken ?? '';
    if (accessToken.isEmpty) {
      throw StateError('Auth verify response missing access token.');
    }

    return AuthPreflightResult(
      mode: 'otp',
      accessToken: accessToken,
      refreshToken: auth.refreshToken,
      userId: null,
      deviceToken: _deviceTokenFromResponse(response),
      expiresAt: auth.expiresAt,
    );
  }

  Future<AuthPreflightResult> _refreshToken(
    String refreshToken,
    String? deviceToken,
  ) async {
    final payload = {'refresh_token': refreshToken};
    final response = await _dio.post(
      ApiConstants.authRefresh,
      data: payload,
      options: _signedOptions(
        ApiConstants.authRefresh,
        payload,
        skipAuthorization: true,
      ),
    );

    final auth = AuthSuccess.fromJson(_payload(response.data));
    final accessToken = auth.accessToken ?? '';
    if (accessToken.isEmpty) {
      throw StateError('Auth refresh response missing access token.');
    }

    return AuthPreflightResult(
      mode: 'otp',
      accessToken: accessToken,
      refreshToken: auth.refreshToken ?? refreshToken,
      userId: null,
      deviceToken: _deviceTokenFromResponse(response) ?? deviceToken,
      expiresAt: auth.expiresAt,
    );
  }

  Future<AuthPreflightResult> _validateToken(String token) async {
    final response = await _dio.get(
      ApiConstants.me,
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
        extra: {'skip_signature': true, 'skip_token_refresh': true},
      ),
    );

    final payload = _payload(response.data);
    final userId =
        (payload['id'] ?? payload['user_id'] ?? payload['userId'])?.toString();

    return AuthPreflightResult(
      mode: 'token',
      accessToken: token,
      refreshToken: null,
      userId: userId,
      deviceToken: _deviceTokenFromResponse(response),
      expiresAt: null,
    );
  }

  Options _signedOptions(
    String path,
    Map<String, dynamic> body, {
    bool skipAuthorization = false,
  }) {
    final timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final rawBody = jsonEncode(body);
    return Options(
      extra: {
        if (skipAuthorization) 'skip_authorization': true,
        'skip_token_refresh': true,
      },
      headers: {
        'X-Timestamp': timestamp.toString(),
        'X-Signature': _signature(
          path: path,
          rawBody: rawBody,
          timestamp: timestamp,
        ),
      },
    );
  }

  String _signature({
    required String path,
    required String rawBody,
    required int timestamp,
  }) {
    final payload = '$path|$rawBody|$timestamp';
    final key = utf8.encode(_config.apiSignatureSecret);
    final bytes = utf8.encode(payload);
    return Hmac(sha256, key).convert(bytes).toString();
  }

  Map<String, dynamic> _payload(dynamic responseData) {
    if (responseData is Map<String, dynamic>) {
      final data = responseData['data'];
      if (data is Map<String, dynamic>) {
        return Map<String, dynamic>.from(data);
      }
      return Map<String, dynamic>.from(responseData);
    }

    return <String, dynamic>{};
  }

  String? _deviceTokenFromResponse(Response<dynamic> response) {
    return response.headers.value('X-Device-Token') ??
        response.headers.value('x-device-token');
  }

  String _maskPhone(String phone) {
    final trimmed = phone.trim();
    if (trimmed.length <= 4) {
      return '****';
    }
    return '***${trimmed.substring(trimmed.length - 4)}';
  }
}
