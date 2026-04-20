library topjobconsts;

const bool isProd = bool.fromEnvironment('dart.vm.product');

const String baseUrl = bool.fromEnvironment('dart.vm.product')
  ? 'https://api.topjob.uz'
  : 'https://api.topjob.uz';

const String wsUrl = bool.fromEnvironment('dart.vm.product')
  ? 'wss://ws.topjob.uz'
  : 'wss://ws.topjob.uz';

const Map<String, String> paymentIcons = {
  'cash': 'assets/img/p_cash.jpg',
  'click': 'assets/img/p_click.jpg',
  'payme': 'assets/img/p_payme.jpg',
  'humo': 'assets/img/p_humo.jpg',
};

const String mapTemplateUrl = 'https://api.mapbox.com/styles/v1/aqvavin/ckatv9mok26w01ipsq1gcfygq/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYXF2YXZpbiIsImEiOiJja2F0dWV0bjYxMnp5MndxZnpkOGFlazg2In0.395FAQrHko_tPkQ_NQx1xw';
