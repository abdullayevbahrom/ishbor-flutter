

class PaymentTransaction {
  final int id;
  final String status;
  final double amount;
  final String provider;
  final String? errorCode;
  final String? errorMessage;

  PaymentTransaction({
    required this.id,
    required this.status,
    required this.amount,
    required this.provider,
    this.errorCode,
    this.errorMessage,
  });

  static PaymentTransaction fromMap(Map<String, dynamic> data) {
    return PaymentTransaction(
      id: data['id'],
      status: data['status'],
      amount: data['amount'],
      provider: data['provider'],
      errorCode: data['error_code'] ?? null,
      errorMessage: data['error_message'] ?? null,
    );
  }
}
