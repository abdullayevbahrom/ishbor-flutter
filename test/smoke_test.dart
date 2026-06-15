import 'package:flutter_test/flutter_test.dart';
import 'package:top_jobs/core/constants/api_const.dart';
import 'package:top_jobs/core/constants/easy_locale.dart';
import 'package:top_jobs/feature/auth/data/models/auth_success.dart';

void main() {
  test('api constants expose versioned endpoints', () {
    expect(ApiConstants.authRequestCode, '/api/v1/auth/request-code');
    expect(ApiConstants.authVerifyCode, '/api/v1/auth/verify-code');
    expect(ApiConstants.authRefresh, '/api/v1/auth/refresh');
    expect(ApiConstants.vacanciesNew, '/api/v1/vacancies-new');
  });

  test('supported locales are available', () {
    expect(EasyLocale.all, hasLength(2));
    expect(EasyLocale.all.first.languageCode, 'ru');
    expect(EasyLocale.all.last.languageCode, 'uz');
  });

  test('auth success parses access and refresh tokens', () {
    final result = AuthSuccess.fromJson({
      'data': {
        'access_token': 'access-token',
        'refresh_token': 'refresh-token',
        'expires_in': 60,
      },
    });

    expect(result.token, 'access-token');
    expect(result.refreshToken, 'refresh-token');
    expect(result.expiresIn, 60);
    expect(result.expiresAt, isNotNull);
  });
}
