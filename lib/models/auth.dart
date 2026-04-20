import 'package:equatable/equatable.dart';

class Auth extends Equatable {
  final String userId;
  final String email;
  final String firstName;
  final String? lastName;
  final String provider;
  final String? providerId;
  final String? accessToken;

  Auth({
    required this.userId,
    required this.email,
    required this.firstName,
    this.lastName,
    required this.provider,
    this.providerId,
    this.accessToken,
  });

  @override
  List<Object> get props => [
    userId,
    email,
    firstName,
    lastName!,
    provider,
    providerId!,
    accessToken!,
  ];

  static Auth fromMap(Map<String, dynamic> data) {
    return Auth(
      userId: data['user_id'],
      email: data['email'],
      firstName: data['first_name'],
      lastName: data['last_name'],
      provider: data['provider'],
      providerId: data['provider_id'],
      accessToken: data['access_token'],
    );
  }
}
