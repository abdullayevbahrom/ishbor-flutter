import 'package:top_jobs/core/helpers/date_time_parser.dart';

class AuthSuccess {
  final String? token;
  final DateTime? expiresAt;

  AuthSuccess({required this.token, required this.expiresAt});

  factory AuthSuccess.fromJson(Map<String, dynamic> json) {
    return AuthSuccess(
      token: json['token'] as String?,
      expiresAt: parseNullableDateTime(json['expires_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      if (expiresAt != null) 'expires_at': expiresAt!.toIso8601String(),
    };
  }

  AuthSuccess copyWith({String? token, DateTime? expiresAt}) {
    return AuthSuccess(
      token: token ?? this.token,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }
}
