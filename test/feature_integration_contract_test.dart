import 'dart:convert';
import 'dart:collection';
import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:top_jobs/core/constants/app_locale_keys.dart';
import 'package:top_jobs/core/network/dio_interceptor.dart';
import 'package:top_jobs/core/services/storage_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;

  setUpAll(() async {
    tempDir = await Directory.systemTemp.createTemp(
      'feature-contract-test',
    );
    Hive.init(tempDir.path);
    await Hive.openBox(AppLocaleKeys.appName);
  });

  setUp(() async {
    await StorageService.instance.clear();
  });

  tearDown(() async {
    await StorageService.instance.clear();
  });

  tearDownAll(() async {
    if (Hive.isBoxOpen(AppLocaleKeys.appName)) {
      await Hive.box(AppLocaleKeys.appName).close();
    }
    if (await tempDir.exists()) {
      await tempDir.delete(recursive: true);
    }
  });

  test('dio interceptor signs snake_case payloads and query params', () async {
    await StorageService.instance.putToken('access-token');
    await StorageService.instance.putExpireDate(
      DateTime.now().add(const Duration(hours: 1)),
    );
    await StorageService.instance.putDeviceToken('device-token-123');

    final adapter = _ScriptedAdapter([
      _ScriptedResponse(
        method: 'POST',
        path: '/api/v1/profile/update',
        statusCode: 200,
        body: {'data': {'ok': true}},
      ),
    ]);

    final dio = Dio();
    dio.httpClientAdapter = adapter;
    dio.interceptors.add(DioInterceptors(StorageService.instance, dio));

    await dio.post(
      '/api/v1/profile/update',
      data: {
        'fullName': 'John Doe',
        'postalCode': '100000',
      },
      queryParameters: {
        'pageSize': 2,
        'includeArchived': false,
      },
    );

    expect(adapter.requests, hasLength(1));
    final request = adapter.requests.single;

    expect(
      request.data,
      {
        'full_name': 'John Doe',
        'postal_code': '100000',
      },
    );
    expect(
      request.queryParameters,
      {
        'include_archived': false,
        'page_size': 2,
      },
    );
    expect(request.headers['Authorization'], 'Bearer access-token');
    expect(request.headers['X-Device-Token'], 'device-token-123');
    expect(request.headers['X-Device-Type'], isNotEmpty);
    expect(request.headers['X-Timestamp'], isA<String>());
    expect(request.headers['X-Signature'], isA<String>());

    final timestamp = int.parse(request.headers['X-Timestamp'] as String);
    final expectedSignature = Hmac(
      sha256,
      utf8.encode(''),
    ).convert(
      utf8.encode(
        '/api/v1/profile/update|{"full_name":"John Doe","postal_code":"100000"}|$timestamp',
      ),
    ).toString();
    expect(request.headers['X-Signature'], expectedSignature);
  });

  test('dio interceptor refreshes expired tokens before protected requests', () async {
    await StorageService.instance.putToken('stale-access');
    await StorageService.instance.putRefreshToken('refresh-token');
    await StorageService.instance.putExpireDate(
      DateTime.now().subtract(const Duration(minutes: 5)),
    );
    await StorageService.instance.putDeviceToken('device-token-123');

    final adapter = _ScriptedAdapter([
      _ScriptedResponse(
        method: 'POST',
        path: '/api/v1/auth/refresh',
        statusCode: 200,
        body: {
          'data': {
            'access_token': 'fresh-access',
            'refresh_token': 'fresh-refresh',
            'expires_in': 120,
          },
        },
      ),
      _ScriptedResponse(
        method: 'GET',
        path: '/api/v1/me',
        statusCode: 200,
        body: {
          'data': {
            'id': 'me',
          },
        },
      ),
    ]);

    final dio = Dio();
    dio.httpClientAdapter = adapter;
    dio.interceptors.add(DioInterceptors(StorageService.instance, dio));

    final response = await dio.get('/api/v1/me', data: const <String, dynamic>{});

    expect(response.data['data']['id'], 'me');
    expect(adapter.requests, hasLength(2));
    expect(adapter.requests.first.method, 'POST');
    expect(adapter.requests.first.path, '/api/v1/auth/refresh');
    expect(
      adapter.requests.first.data,
      isA<Map>().having((value) => value['refresh_token'], 'refresh_token', 'refresh-token'),
    );
    expect(adapter.requests.last.method, 'GET');
    expect(adapter.requests.last.headers['Authorization'], 'Bearer fresh-access');
    expect(await StorageService.instance.fetchToken(), 'fresh-access');
    expect(await StorageService.instance.fetchRefreshToken(), 'fresh-refresh');
    expect(await StorageService.instance.getExpireDate(), isNotNull);
  });

  test('dio interceptor persists response device token and reuses it', () async {
    await StorageService.instance.putToken('access-token');
    await StorageService.instance.putExpireDate(
      DateTime.now().add(const Duration(hours: 1)),
    );

    final adapter = _ScriptedAdapter([
      _ScriptedResponse(
        method: 'POST',
        path: '/api/v1/auth/request-code',
        statusCode: 200,
        headers: {
          'X-Device-Token': ['response-device-token'],
        },
        body: {'data': {'ok': true}},
      ),
      _ScriptedResponse(
        method: 'POST',
        path: '/api/v1/auth/request-code',
        statusCode: 200,
        body: {'data': {'ok': true}},
      ),
    ]);

    final dio = Dio();
    dio.httpClientAdapter = adapter;
    dio.interceptors.add(DioInterceptors(StorageService.instance, dio));

    await dio.post('/api/v1/auth/request-code', data: const <String, dynamic>{});
    await Future<void>.delayed(Duration.zero);

    expect(await StorageService.instance.fetchDeviceToken(), 'response-device-token');

    await dio.post('/api/v1/auth/request-code', data: const <String, dynamic>{});

    expect(adapter.requests, hasLength(2));
    expect(adapter.requests.last.headers['X-Device-Token'], 'response-device-token');
  });

}

class _RecordedRequest {
  const _RecordedRequest({
    required this.method,
    required this.path,
    required this.queryParameters,
    required this.headers,
    required this.data,
  });

  final String method;
  final String path;
  final Map<String, dynamic> queryParameters;
  final Map<String, dynamic> headers;
  final dynamic data;
}

class _ScriptedResponse {
  const _ScriptedResponse({
    required this.method,
    required this.path,
    required this.statusCode,
    this.body,
    this.headers = const {},
  });

  final String method;
  final String path;
  final int statusCode;
  final dynamic body;
  final Map<String, List<String>> headers;
}

class _ScriptedAdapter implements HttpClientAdapter {
  _ScriptedAdapter(List<_ScriptedResponse> responses)
      : _responses = Queue<_ScriptedResponse>.from(responses);

  final Queue<_ScriptedResponse> _responses;
  final List<_RecordedRequest> requests = <_RecordedRequest>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    final response = _responses.isNotEmpty
        ? _responses.removeFirst()
        : null;
    if (response == null) {
      throw StateError('No scripted response for ${options.method} ${options.path}');
    }

    requests.add(
      _RecordedRequest(
        method: options.method.toUpperCase(),
        path: options.path,
        queryParameters: Map<String, dynamic>.from(options.queryParameters),
        headers: Map<String, dynamic>.from(options.headers),
        data: options.data,
      ),
    );

    expect(options.method.toUpperCase(), response.method.toUpperCase());
    expect(options.path, response.path);

    return ResponseBody.fromString(
      response.body == null ? '' : _encodeBody(response.body),
      response.statusCode,
      headers: {
        'content-type': ['application/json; charset=utf-8'],
        ...response.headers,
      },
    );
  }

  @override
  void close({bool force = false}) {}

  String _encodeBody(dynamic body) {
    if (body is String) {
      return body;
    }
    return jsonEncode(body);
  }
}
