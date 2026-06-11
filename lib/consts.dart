const String _defaultApiBaseUrl = 'https://api.ishbor.uz';
const String apiBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: _defaultApiBaseUrl,
);

const String websocketUrl = String.fromEnvironment('WS_URL', defaultValue: '');

const String mercureUrlOverride = String.fromEnvironment(
  'MERCURE_URL',
  defaultValue: '',
);

const String mercurePublicUrl = String.fromEnvironment(
  'MERCURE_PUBLIC_URL',
  defaultValue: '',
);

const String apiSignatureSecret = String.fromEnvironment(
  'API_SIGNATURE_SECRET',
  defaultValue: '',
);

const String appEnvironment = String.fromEnvironment(
  'APP_ENV',
  defaultValue: 'prod',
);

const bool isProd = bool.fromEnvironment('dart.vm.product');

const String baseUrl = apiBaseUrl;

String _deriveMercureUrl(String apiUrl) {
  try {
    final url = Uri.parse(apiUrl);
    final mercureHost = url.host.startsWith('api.')
        ? url.host.replaceFirst('api.', 'ws.')
        : url.host;
    return url.replace(
      host: mercureHost,
      path: '/.well-known/mercure',
    ).toString();
  } catch (_) {
    return '$apiUrl/.well-known/mercure';
  }
}

String get mercureUrl {
  if (mercurePublicUrl.isNotEmpty) {
    return mercurePublicUrl;
  }
  if (mercureUrlOverride.isNotEmpty) {
    return mercureUrlOverride;
  }
  if (websocketUrl.isNotEmpty) {
    return websocketUrl;
  }
  return _deriveMercureUrl(apiBaseUrl);
}

String get mercureEndpointUrl => mercureUrl;

String get wsUrl => mercureUrl;

const Map<String, String> paymentIcons = {
  'cash': 'assets/img/p_cash.jpg',
  'click': 'assets/img/p_click.jpg',
  'payme': 'assets/img/p_payme.jpg',
  'humo': 'assets/img/p_humo.jpg',
};

const String mapTemplateUrl =
    'https://api.mapbox.com/styles/v1/aqvavin/ckatv9mok26w01ipsq1gcfygq/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYXF2YXZpbiIsImEiOiJja2F0dWV0bjYxMnp5MndxZnpkOGFlazg2In0.395FAQrHko_tPkQ_NQx1xw';
