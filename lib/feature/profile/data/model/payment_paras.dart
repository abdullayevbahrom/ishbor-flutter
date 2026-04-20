class PaymentParams {
  final String provider;
  final String amount;

  const PaymentParams({required this.provider, required this.amount});

  Map<String, dynamic> toJson() {
    return {"provider": provider, "amount": amount};
  }
}
