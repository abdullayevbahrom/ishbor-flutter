import 'dart:io';

final class E2EConfig {
  const E2EConfig({
    required this.apiBaseUrl,
    required this.deviceApiBaseUrl,
    required this.mercurePublicUrl,
    required this.apiSignatureSecret,
    required this.appVersion,
    required this.appDir,
    required this.screenshotsRoot,
    required this.testPhone,
    required this.testOtp,
    required this.accessToken,
    required this.cleanup,
    required this.allowProd,
    required this.runId,
  });

  factory E2EConfig.fromEnvironment([Map<String, String>? environment]) {
    final env = environment ?? Platform.environment;
    const apiBaseUrlDefine = String.fromEnvironment('E2E_API_BASE_URL');
    const deviceApiBaseUrlDefine = String.fromEnvironment(
      'E2E_DEVICE_API_BASE_URL',
    );
    const mercurePublicUrlDefine = String.fromEnvironment(
      'E2E_MERCURE_PUBLIC_URL',
    );
    const apiSignatureSecretDefine = String.fromEnvironment(
      'E2E_API_SIGNATURE_SECRET',
    );
    const appVersionDefine = String.fromEnvironment('E2E_APP_VERSION');
    const appDirDefine = String.fromEnvironment('E2E_APP_DIR');
    const screenshotsRootDefine = String.fromEnvironment('E2E_SCREENSHOTS_ROOT');
    const testPhoneDefine = String.fromEnvironment('E2E_TEST_PHONE');
    const testOtpDefine = String.fromEnvironment('E2E_TEST_OTP');
    const accessTokenDefine = String.fromEnvironment('E2E_ACCESS_TOKEN');
    const cleanupDefine = String.fromEnvironment('E2E_CLEANUP');
    const allowProdDefine = String.fromEnvironment('E2E_ALLOW_PROD');
    const runIdDefine = String.fromEnvironment('E2E_RUN_ID');

    String envOrDefine(String envName, String defineValue, {String fallback = ''}) {
      final envValue = env[envName]?.trim();
      if (envValue != null && envValue.isNotEmpty) {
        return envValue;
      }

      final define = defineValue.trim();
      if (define.isNotEmpty) {
        return define;
      }

      return fallback;
    }

    return E2EConfig(
      apiBaseUrl: envOrDefine(
        'E2E_API_BASE_URL',
        apiBaseUrlDefine,
      ),
      deviceApiBaseUrl: envOrDefine(
        'E2E_DEVICE_API_BASE_URL',
        deviceApiBaseUrlDefine,
        fallback: envOrDefine('E2E_API_BASE_URL', apiBaseUrlDefine),
      ),
      mercurePublicUrl: envOrDefine(
        'E2E_MERCURE_PUBLIC_URL',
        mercurePublicUrlDefine,
      ),
      apiSignatureSecret: envOrDefine(
        'E2E_API_SIGNATURE_SECRET',
        apiSignatureSecretDefine,
      ),
      appVersion: envOrDefine(
        'E2E_APP_VERSION',
        appVersionDefine,
        fallback: 'unknown',
      ),
      appDir: envOrDefine(
        'E2E_APP_DIR',
        appDirDefine,
        fallback: '/workspace/flutter',
      ),
      screenshotsRoot: envOrDefine(
        'E2E_SCREENSHOTS_ROOT',
        screenshotsRootDefine,
        fallback: 'var/screnshots',
      ),
      testPhone: envOrDefine('E2E_TEST_PHONE', testPhoneDefine),
      testOtp: envOrDefine('E2E_TEST_OTP', testOtpDefine),
      accessToken: envOrDefine('E2E_ACCESS_TOKEN', accessTokenDefine),
      cleanup: _parseBool(
        env['E2E_CLEANUP'] ?? cleanupDefine,
        fallback: true,
      ),
      allowProd: _parseBool(
        env['E2E_ALLOW_PROD'] ?? allowProdDefine,
        fallback: false,
      ),
      runId: envOrDefine('E2E_RUN_ID', runIdDefine, fallback: _defaultRunId()),
    );
  }

  final String apiBaseUrl;
  final String deviceApiBaseUrl;
  final String mercurePublicUrl;
  final String apiSignatureSecret;
  final String appVersion;
  final String appDir;
  final String screenshotsRoot;
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
    return 'env=e2e baseUrl=$apiBaseUrl mercure=$mercurePublicUrl version=$appVersion authMode=$authMode cleanup=$cleanup runId=$runId';
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
