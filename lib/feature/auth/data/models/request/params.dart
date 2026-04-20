class SmsRegistrationParams {
  final String phoneNumber;
  final String firstName;
  final String? lastName;
  final String? middleName;
  final String userType;

  SmsRegistrationParams({
    required this.phoneNumber,
    required this.firstName,
    this.lastName,
    this.middleName,
    required this.userType,
  });
}
