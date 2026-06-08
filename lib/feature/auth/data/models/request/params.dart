class SmsRegistrationParams {
  final String phoneNumber;
  final String code;
  final String firstName;
  final String? lastName;
  final String? middleName;
  final String userType;

  SmsRegistrationParams({
    required this.phoneNumber,
    required this.code,
    required this.firstName,
    this.lastName,
    this.middleName,
    required this.userType,
  });

  SmsRegistrationParams copyWithCode(String code) {
    return SmsRegistrationParams(
      phoneNumber: phoneNumber,
      code: code,
      firstName: firstName,
      lastName: lastName,
      middleName: middleName,
      userType: userType,
    );
  }
}
