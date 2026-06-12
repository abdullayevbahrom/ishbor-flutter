import 'dart:io';

final class E2EConfig {
  const E2EConfig({
    required this.apiBaseUrl,
    required this.mercurePublicUrl,
    required this.apiSignatureSecret,
    required this.testPhone,
    required this.testOtp,
    required this.accessToken,
    required this.cleanup,
    required this.allowProd,
    required this.runId,
  });

  factory E2EConfig.fromEnvironment([Map<String, String>? environment]) {
    final env = environment ?? Platform.environment;
    return E2EConfig(
      apiBaseUrl: env['E2E_API_BASE_URL'] ?? '',
      mercurePublicUrl: env['E2E_MERCURE_PUBLIC_URL'] ?? '',
      apiSignatureSecret: env['E2E_API_SIGNATURE_SECRET'] ?? '',
      testPhone: env['E2E_TEST_PHONE'] ?? '',
      testOtp: env['E2E_TEST_OTP'] ?? '',
      accessToken: env['E2E_ACCESS_TOKEN'] ?? '',
      cleanup: _parseBool(env['E2E_CLEANUP'], fallback: true),
      allowProd: _parseBool(env['E2E_ALLOW_PROD'], fallback: false),
      runId:
          env['E2E_RUN_ID']?.trim().isNotEmpty == true
              ? env['E2E_RUN_ID']!.trim()
              : _defaultRunId(),
    );
  }

  final String apiBaseUrl;
  final String mercurePublicUrl;
  final String apiSignatureSecret;
  final String testPhone;
  final String testOtp;
  final String accessToken;
  final bool cleanup;
  final bool allowProd;
  final String runId;

  bool get hasAccessToken => accessToken.trim().isNotEmpty;
  bool get hasOtp => testPhone.trim().isNotEmpty && testOtp.trim().isNotEmpty;

  String get authMode => hasAccessToken ? 'token' : 'otp';

  List<String> validate() {
    final missing = <String>[];

    if (apiBaseUrl.trim().isEmpty) missing.add('E2E_API_BASE_URL');
    if (mercurePublicUrl.trim().isEmpty) missing.add('E2E_MERCURE_PUBLIC_URL');
    if (apiSignatureSecret.trim().isEmpty) {
      missing.add('E2E_API_SIGNATURE_SECRET');
    }

    if (!hasAccessToken && !hasOtp) {
      missing.add('E2E_ACCESS_TOKEN|E2E_TEST_PHONE+E2E_TEST_OTP');
    }

    if (_isProductionApi(apiBaseUrl) && !allowProd) {
      missing.add('E2E_ALLOW_PROD=1');
    }

    return missing;
  }

  String describeForLog() {
    return 'env=e2e baseUrl=$apiBaseUrl mercure=$mercurePublicUrl authMode=$authMode cleanup=$cleanup runId=$runId';
  }

  static bool _parseBool(String? value, {required bool fallback}) {
    final normalized = value?.trim().toLowerCase();
    if (normalized == null || normalized.isEmpty) {
      return fallback;
    }
    return normalized == '1' ||
        normalized == 'true' ||
        normalized == 'yes' ||
        normalized == 'on';
  }

  static bool _isProductionApi(String value) {
    return value.trim() == 'https://api.ishbor.uz';
  }

  static String _defaultRunId() {
    final now = DateTime.now().toUtc();
    return [
      now.year.toString().padLeft(4, '0'),
      now.month.toString().padLeft(2, '0'),
      now.day.toString().padLeft(2, '0'),
      'T',
      now.hour.toString().padLeft(2, '0'),
      now.minute.toString().padLeft(2, '0'),
      now.second.toString().padLeft(2, '0'),
      'Z',
    ].join();
  }
}
