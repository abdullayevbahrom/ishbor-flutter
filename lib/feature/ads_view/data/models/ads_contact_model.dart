class AdsContactModel {
  final String? phoneNumber;
  final String? phoneNumber1;
  final String? phoneNumber2;
  final String? phoneNumber3;
  final String? telegram;

  const AdsContactModel({
    this.phoneNumber,
    this.phoneNumber1,
    this.phoneNumber2,
    this.phoneNumber3,
    this.telegram,
  });

  /// Create from JSON
  factory AdsContactModel.fromJson(Map<String, dynamic> json) {
    return AdsContactModel(
      phoneNumber: json['phone_number'] as String?,
      phoneNumber1: json['phone_number1'] as String?,
      phoneNumber2: json['phone_number2'] as String?,
      phoneNumber3: json['phone_number3'] as String?,
      telegram: json['telegram'] as String?,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() => {
    'phone_number': phoneNumber,
    'phone_number1': phoneNumber1,
    'phone_number2': phoneNumber2,
    'phone_number3': phoneNumber3,
    'telegram': telegram,
  };

  /// Create a copy with selected fields changed
  AdsContactModel copyWith({
    String? phoneNumber,
    String? phoneNumber1,
    String? phoneNumber2,
    String? phoneNumber3,
    String? telegram,
  }) {
    return AdsContactModel(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      phoneNumber1: phoneNumber1 ?? this.phoneNumber1,
      phoneNumber2: phoneNumber2 ?? this.phoneNumber2,
      phoneNumber3: phoneNumber3 ?? this.phoneNumber3,
      telegram: telegram ?? this.telegram,
    );
  }
}
