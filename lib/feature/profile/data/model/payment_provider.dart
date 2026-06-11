enum PaymentProvider {
  click('click'),
  payme('payme'),
  uzum('uzum'),
  paynet('paynet'),
  alif('alif'),
  cash('cash');

  const PaymentProvider(this.apiValue);

  final String apiValue;

  static PaymentProvider fromIndex(int index) {
    switch (index) {
      case 0:
        return PaymentProvider.click;
      case 1:
        return PaymentProvider.payme;
      case 2:
        return PaymentProvider.uzum;
      case 3:
        return PaymentProvider.paynet;
      case 4:
        return PaymentProvider.alif;
      case 5:
        return PaymentProvider.cash;
      default:
        return PaymentProvider.click;
    }
  }
}
