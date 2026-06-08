import 'package:top_jobs/core/helpers/date_time_parser.dart';

class AuthSuccess {
  final String? accessToken;
  final String? refreshToken;
  final int? expiresIn;
  final DateTime? expiresAt;

  AuthSuccess({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
    required this.expiresAt,
  });

  String? get token => accessToken;

  factory AuthSuccess.fromJson(Map<String, dynamic> json) {
    final payload = json['data'] is Map<String, dynamic>
        ? Map<String, dynamic>.from(json['data'] as Map<String, dynamic>)
        : json;
    final expiresIn = payload['expires_in'] is int
        ? payload['expires_in'] as int
        : int.tryParse('${payload['expires_in'] ?? ''}');
    final expiresAt = parseNullableDateTime(payload['expires_at']) ??
        (expiresIn != null
            ? DateTime.now().add(Duration(seconds: expiresIn))
            : null);
    return AuthSuccess(
      accessToken: (payload['access_token'] ?? payload['token']) as String?,
      refreshToken: payload['refresh_token'] as String?,
      expiresIn: expiresIn,
      expiresAt: expiresAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'expires_in': expiresIn,
      if (expiresAt != null) 'expires_at': expiresAt!.toIso8601String(),
    };
  }

  AuthSuccess copyWith({
    String? accessToken,
    String? refreshToken,
    int? expiresIn,
    DateTime? expiresAt,
  }) {
    return AuthSuccess(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      expiresIn: expiresIn ?? this.expiresIn,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }
}
