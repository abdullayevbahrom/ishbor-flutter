import 'dart:async';
import 'dart:convert';
import 'dart:collection';
import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:top_jobs/core/constants/api_const.dart';
import 'package:top_jobs/core/constants/app_locale_keys.dart';
import 'package:top_jobs/core/network/dio_interceptor.dart';
import 'package:top_jobs/core/services/mercure_client.dart';
import 'package:top_jobs/core/services/storage_service.dart';
import 'package:top_jobs/feature/common/data/datasource/realtime_datasource.dart';
import 'package:top_jobs/feature/profile/data/datasource/payment_datasource.dart';
import '../integration_test/e2e/test_data.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;

  setUpAll(() async {
    tempDir = await Directory.systemTemp.createTemp('feature-contract-test');
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
        body: {
          'data': {'ok': true},
        },
      ),
    ]);

    final dio = Dio();
    dio.httpClientAdapter = adapter;
    dio.interceptors.add(DioInterceptors(StorageService.instance, dio));

    await dio.post(
      '/api/v1/profile/update',
      data: {'fullName': 'John Doe', 'postalCode': '100000'},
      queryParameters: {'pageSize': 2, 'includeArchived': false},
    );

    expect(adapter.requests, hasLength(1));
    final request = adapter.requests.single;

    expect(request.data, {'full_name': 'John Doe', 'postal_code': '100000'});
    expect(request.queryParameters, {
      'include_archived': false,
      'page_size': 2,
    });
    expect(request.headers['Authorization'], 'Bearer access-token');
    expect(request.headers['X-Device-Token'], 'device-token-123');
    expect(request.headers['X-Device-Type'], isNotEmpty);
    expect(request.headers['X-Timestamp'], isA<String>());
    expect(request.headers['X-Signature'], isA<String>());

    final timestamp = int.parse(request.headers['X-Timestamp'] as String);
    final expectedSignature =
        Hmac(sha256, utf8.encode(''))
            .convert(
              utf8.encode(
                '/api/v1/profile/update|{"full_name":"John Doe","postal_code":"100000"}|$timestamp',
              ),
            )
            .toString();
    expect(request.headers['X-Signature'], expectedSignature);
  });

  test(
    'dio interceptor refreshes expired tokens before protected requests',
    () async {
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
            'data': {'id': 'me'},
          },
        ),
      ]);

      final dio = Dio();
      dio.httpClientAdapter = adapter;
      dio.interceptors.add(DioInterceptors(StorageService.instance, dio));

      final response = await dio.get(
        '/api/v1/me',
        data: const <String, dynamic>{},
      );

      expect(response.data['data']['id'], 'me');
      expect(adapter.requests, hasLength(2));
      expect(adapter.requests.first.method, 'POST');
      expect(adapter.requests.first.path, '/api/v1/auth/refresh');
      expect(
        adapter.requests.first.data,
        isA<Map>().having(
          (value) => value['refresh_token'],
          'refresh_token',
          'refresh-token',
        ),
      );
      expect(adapter.requests.last.method, 'GET');
      expect(
        adapter.requests.last.headers['Authorization'],
        'Bearer fresh-access',
      );
      expect(await StorageService.instance.fetchToken(), 'fresh-access');
      expect(
        await StorageService.instance.fetchRefreshToken(),
        'fresh-refresh',
      );
      expect(await StorageService.instance.getExpireDate(), isNotNull);
    },
  );

  test(
    'dio interceptor persists response device token and reuses it',
    () async {
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
          body: {
            'data': {'ok': true},
          },
        ),
        _ScriptedResponse(
          method: 'POST',
          path: '/api/v1/auth/request-code',
          statusCode: 200,
          body: {
            'data': {'ok': true},
          },
        ),
      ]);

      final dio = Dio();
      dio.httpClientAdapter = adapter;
      dio.interceptors.add(DioInterceptors(StorageService.instance, dio));

      await dio.post(
        '/api/v1/auth/request-code',
        data: const <String, dynamic>{},
      );
      await Future<void>.delayed(Duration.zero);

      expect(
        await StorageService.instance.fetchDeviceToken(),
        'response-device-token',
      );

      await dio.post(
        '/api/v1/auth/request-code',
        data: const <String, dynamic>{},
      );

      expect(adapter.requests, hasLength(2));
      expect(
        adapter.requests.last.headers['X-Device-Token'],
        'response-device-token',
      );
    },
  );

  test('dio interceptor emits e2e trace events for responses', () async {
    await StorageService.instance.putToken('access-token');
    await StorageService.instance.putExpireDate(
      DateTime.now().add(const Duration(hours: 1)),
    );
    await StorageService.instance.putDeviceToken('device-token-123');

    final traces = <DioE2ETrace>[];
    DioInterceptors.e2eObserver = traces.add;

    addTearDown(() {
      DioInterceptors.e2eObserver = null;
    });

    final adapter = _ScriptedAdapter([
      _ScriptedResponse(
        method: 'GET',
        path: '/api/v1/me',
        statusCode: 200,
        body: {
          'data': {'id': 'me'},
        },
      ),
    ]);

    final dio = Dio();
    dio.httpClientAdapter = adapter;
    dio.interceptors.add(DioInterceptors(StorageService.instance, dio));

    await dio.get('/api/v1/me');

    expect(traces, isNotEmpty);
    final trace = traces.singleWhere(
      (item) => item.phase == 'response',
      orElse: () => throw StateError('missing response trace'),
    );
    expect(trace.method, 'GET');
    expect(trace.path, '/api/v1/me');
    expect(trace.statusCode, 200);
    expect(trace.durationMs, greaterThanOrEqualTo(0));
  });

  test(
    'mercure client subscribes to realtime topic with stored headers',
    () async {
      await StorageService.instance.putToken('socket-access');
      await StorageService.instance.putDeviceToken('socket-device');
      await StorageService.instance.putUserId('user-42');

      final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      final requestReceived = Completer<void>();
      late HttpRequest capturedRequest;

      server.listen((HttpRequest request) async {
        if (!requestReceived.isCompleted) {
          capturedRequest = request;
          requestReceived.complete();
        }

        request.response.statusCode = HttpStatus.ok;
        request.response.headers.contentType = ContentType(
          'text',
          'event-stream',
          charset: 'utf-8',
        );
        request.response.write('event: user.status.online.v1\n');
        request.response.write(
          'data: {"user_id":"user-42","status":"online"}\n\n',
        );
        await request.response.close();
      });

      final overrides = _RedirectingHttpOverrides(
        Uri.parse('http://127.0.0.1:${server.port}'),
      );

      try {
        await HttpOverrides.runZoned(() async {
          final channel = await MercureClient().initUserStatus();
          expect(channel, isNotNull);

          final firstMessage = await channel!.stream.first.timeout(
            const Duration(seconds: 5),
          );
          final parsedMessage =
              jsonDecode(firstMessage) as Map<String, dynamic>;
          expect(parsedMessage['user_id'], 'user-42');
          expect(parsedMessage['status'], 'online');

          await requestReceived.future.timeout(const Duration(seconds: 5));
          expect(capturedRequest.uri.path, '/.well-known/mercure');
          expect(capturedRequest.uri.queryParametersAll['topic'], [
            'users/status/user-42',
          ]);
          expect(
            capturedRequest.headers.value(HttpHeaders.authorizationHeader),
            'Bearer socket-access',
          );
          expect(
            capturedRequest.headers.value(HttpHeaders.acceptHeader),
            'text/event-stream',
          );
          expect(
            capturedRequest.headers.value('x-device-token'),
            'socket-device',
          );

          await channel.close();
        }, createHttpClient: overrides.createHttpClient);
      } finally {
        await overrides.dispose();
        await server.close(force: true);
      }
    },
  );

  test(
    'mercure client subscribes to status-check topic with stored headers',
    () async {
      await StorageService.instance.putToken('socket-access');
      await StorageService.instance.putDeviceToken('socket-device');
      await StorageService.instance.putUserId('user-42');

      final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      final requestReceived = Completer<void>();
      late HttpRequest capturedRequest;

      server.listen((HttpRequest request) async {
        if (!requestReceived.isCompleted) {
          capturedRequest = request;
          requestReceived.complete();
        }

        request.response.statusCode = HttpStatus.ok;
        request.response.headers.contentType = ContentType(
          'text',
          'event-stream',
          charset: 'utf-8',
        );
        request.response.write('data: {"user_id":"user-42","online":true}\n\n');
        await request.response.close();
      });

      final overrides = _RedirectingHttpOverrides(
        Uri.parse('http://127.0.0.1:${server.port}'),
      );

      try {
        await HttpOverrides.runZoned(() async {
          final channel = await MercureClient.initStatusCheckSource('user-42');
          expect(channel, isNotNull);

          final firstMessage = await channel!.stream.first.timeout(
            const Duration(seconds: 5),
          );
          final parsedMessage =
              jsonDecode(firstMessage) as Map<String, dynamic>;
          expect(parsedMessage['user_id'], 'user-42');
          expect(parsedMessage['online'], isTrue);

          await requestReceived.future.timeout(const Duration(seconds: 5));
          expect(capturedRequest.uri.path, '/.well-known/mercure');
          expect(capturedRequest.uri.queryParametersAll['topic'], [
            'users/status/check/user-42',
          ]);
          expect(
            capturedRequest.headers.value(HttpHeaders.authorizationHeader),
            'Bearer socket-access',
          );
          expect(
            capturedRequest.headers.value(HttpHeaders.acceptHeader),
            'text/event-stream',
          );
          expect(
            capturedRequest.headers.value('x-device-token'),
            'socket-device',
          );

          await channel.close();
        }, createHttpClient: overrides.createHttpClient);
      } finally {
        await overrides.dispose();
        await server.close(force: true);
      }
    },
  );

  test(
    'realtime datasource returns success and surfaces backend errors',
    () async {
      final dio = Dio();
      final adapter = _ScriptedAdapter([
        _ScriptedResponse(
          method: 'POST',
          path: ApiConstants.heartbeat,
          statusCode: 204,
        ),
        _ScriptedResponse(
          method: 'GET',
          path: ApiConstants.userStatus('user-42'),
          statusCode: 422,
          body: {'message': 'User status unavailable'},
        ),
      ]);
      dio.httpClientAdapter = adapter;

      final dataSource = RealtimeDataSourceImpl(dio);

      final heartbeatResult = await dataSource.heartbeat();
      heartbeatResult.fold(
        (_) => fail('Expected heartbeat() to succeed'),
        (_) {},
      );

      final statusResult = await dataSource.checkUserStatus('user-42');
      statusResult.fold(
        (failure) => expect(failure.message, 'User status unavailable'),
        (_) => fail('Expected checkUserStatus() to fail'),
      );

      expect(adapter.requests, hasLength(2));
      expect(adapter.requests.first.path, ApiConstants.heartbeat);
      expect(adapter.requests.last.path, ApiConstants.userStatus('user-42'));
    },
  );

  test('payment datasource parses happy path and provider failures', () async {
    final dio = Dio();
    final adapter = _ScriptedAdapter([
      _ScriptedResponse(
        method: 'POST',
        path: ApiConstants.paymentTransactions,
        statusCode: 201,
        body: {
          'data': {
            'id': 'txn-1',
            'payment_url': 'https://pay.example/txn-1',
            'status': 'pending',
          },
        },
      ),
      _ScriptedResponse(
        method: 'POST',
        path: ApiConstants.payByProvider('vacancy', 42, '1000', 'payme'),
        statusCode: 422,
        body: {'message': 'Provider rejected payment'},
      ),
    ]);
    dio.httpClientAdapter = adapter;

    final dataSource = PaymentDataSourceImpl(dio);

    final createResult = await dataSource.createTopUp(
      amount: 1000,
      provider: 'payme',
    );
    createResult.fold(
      (failure) => fail('Expected createTopUp() to succeed: $failure'),
      (payload) {
        expect(payload['id'], 'txn-1');
        expect(payload['payment_url'], 'https://pay.example/txn-1');
      },
    );

    final providerResult = await dataSource.payByProvider(
      content: 'vacancy',
      contentId: 42,
      top: '1000',
      provider: 'payme',
    );
    providerResult.fold(
      (failure) => expect(failure.message, 'Provider rejected payment'),
      (_) => fail('Expected payByProvider() to fail'),
    );

    expect(adapter.requests, hasLength(2));
    expect(adapter.requests.first.path, ApiConstants.paymentTransactions);
    expect(adapter.requests.first.data, {'amount': 1000, 'provider': 'payme'});
    expect(
      adapter.requests.last.path,
      ApiConstants.payByProvider('vacancy', 42, '1000', 'payme'),
    );
  });

  test('e2e test data tags run ids and classifies cleanup failures', () async {
    final testData = E2ETestData(runId: 'run-123');
    final cleanupLog = <String>[];

    final tagged = testData.tagPayload(
      {'title': 'Demo'},
      type: 'vacancy',
      id: '123',
    );

    expect(tagged['e2e_run_id'], 'run-123');
    expect(tagged['e2e_type'], 'vacancy');
    expect(tagged['e2e_id'], '123');

    testData.registerCreated(
      type: 'vacancy',
      id: '123',
      impact: E2ECleanupImpact.warning,
      cleanup: () async {
        cleanupLog.add('vacancy');
      },
    );
    testData.registerCreated(
      type: 'message',
      id: '456',
      impact: E2ECleanupImpact.error,
      cleanup: () async {
        throw StateError('cleanup failed');
      },
    );

    final summary = await testData.cleanup();

    expect(cleanupLog, ['vacancy']);
    expect(summary.cleaned, 1);
    expect(summary.warningFailures, 0);
    expect(summary.errorFailures, 1);
    expect(summary.status, 'error');
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
    final response = _responses.isNotEmpty ? _responses.removeFirst() : null;
    if (response == null) {
      throw StateError(
        'No scripted response for ${options.method} ${options.path}',
      );
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

class _RedirectingHttpOverrides extends HttpOverrides {
  _RedirectingHttpOverrides(this.delegateUri);

  final Uri delegateUri;
  final List<_RedirectingHttpClient> _clients = <_RedirectingHttpClient>[];

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final delegate = super.createHttpClient(context);
    final client = _RedirectingHttpClient(delegateUri, delegate);
    _clients.add(client);
    return client;
  }

  Future<void> dispose() async {
    for (final client in _clients) {
      client.close(force: true);
    }
    _clients.clear();
  }
}

class _RedirectingHttpClient implements HttpClient {
  _RedirectingHttpClient(this.delegateUri, this.delegate);

  final Uri delegateUri;
  final HttpClient delegate;

  @override
  Future<HttpClientRequest> openUrl(String method, Uri url) async {
    final rewritten = delegateUri.replace(
      path: url.path,
      query: url.query,
      fragment: url.fragment,
    );
    return delegate.openUrl(method, rewritten);
  }

  @override
  Future<HttpClientRequest> getUrl(Uri url) {
    return openUrl('GET', url);
  }

  @override
  void close({bool force = false}) {
    delegate.close(force: force);
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
