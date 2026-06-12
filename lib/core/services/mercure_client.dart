import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:top_jobs/core/constants/api_const.dart';
import 'package:top_jobs/core/services/storage_service.dart';

class MercureClient {
  static const int _maxAttempts = 3;
  static const Duration _baseBackoff = Duration(milliseconds: 300);

  static Future<MercureSubscription?> initChat(String messageId) async {
    return _connectWithFallback(
      label: 'messages',
      topics: ['chats/$messageId/messages'],
    );
  }

  Future<MercureSubscription?> initUserStatus({
    FutureOr<void> Function(dynamic)? onMessages,
    FutureOr<void> Function(Object error)? onError,
  }) async {
    final userId = await _currentUserId();
    if (userId == null || userId.isEmpty) {
      debugPrint(
        '[WARN][mercure] statuses subscription skipped: no user id available',
      );
      return null;
    }

    return _connectWithFallback(
      label: 'statuses',
      topics: ['users/status/$userId'],
      onMessages: onMessages,
      onError: onError,
    );
  }

  static Future<MercureSubscription?> initNotificationsSource(
    String userId,
  ) async {
    if (userId.isEmpty) {
      debugPrint(
        '[WARN][mercure] notifications subscription skipped: no user id provided',
      );
      return null;
    }

    return _connectWithFallback(
      label: 'notifications',
      topics: ['users/$userId/notifications'],
    );
  }

  static Future<MercureSubscription?> initStatusCheckSource(
    String userId,
  ) async {
    if (userId.isEmpty) {
      debugPrint(
        '[WARN][mercure] status-check subscription skipped: no user id provided',
      );
      return null;
    }

    return _connectWithFallback(
      label: 'status-check',
      topics: ['users/status/check/$userId'],
    );
  }

  static Future<MercureSubscription?> _connectWithFallback({
    required String label,
    required List<String> topics,
    FutureOr<void> Function(dynamic)? onMessages,
    FutureOr<void> Function(Object error)? onError,
  }) async {
    final normalizedTopics = topics.where((topic) => topic.isNotEmpty).toList();
    if (normalizedTopics.isEmpty) {
      debugPrint('[WARN][mercure] source skipped: no topics provided');
      return null;
    }

    final headers = await _mercureHeaders();
    final baseUri = _buildMercureUri(normalizedTopics);

    final attempts = <_MercureAttempt>[
      _MercureAttempt(uri: baseUri, headers: headers, tag: 'mercure'),
    ];

    for (final attempt in attempts) {
      final subscription = await _tryConnect(
        label: label,
        attempt: attempt,
        onMessages: onMessages,
        onError: onError,
      );
      if (subscription != null) {
        return subscription;
      }
    }

    debugPrint(
      '[WARN][mercure] $label source unavailable after retries; falling back to HTTP',
    );
    return null;
  }

  static Future<MercureSubscription?> _tryConnect({
    required String label,
    required _MercureAttempt attempt,
    FutureOr<void> Function(dynamic)? onMessages,
    FutureOr<void> Function(Object error)? onError,
  }) async {
    Object? lastError;

    for (var i = 0; i < _maxAttempts; i++) {
      HttpClient? client;
      StreamSubscription<String>? streamSubscription;
      final controller = StreamController<String>();

      try {
        debugPrint(
          '[DEBUG][mercure] connecting label=$label attempt=${i + 1} mode=${attempt.tag} uri=${attempt.uri}',
        );

        client = HttpClient();
        final request = await client.getUrl(attempt.uri);

        request.headers.set(HttpHeaders.acceptHeader, 'text/event-stream');
        request.headers.set(HttpHeaders.cacheControlHeader, 'no-cache');
        request.headers.set(HttpHeaders.connectionHeader, 'keep-alive');
        attempt.headers.forEach(request.headers.set);

        final response = await request.close();
        if (response.statusCode != HttpStatus.ok) {
          throw HttpException(
            'Mercure returned unexpected status ${response.statusCode}',
            uri: attempt.uri,
          );
        }

        final parser = _MercureEventParser();
        streamSubscription = response
            .transform(utf8.decoder)
            .transform(const LineSplitter())
            .listen(
              (line) {
                final event = parser.addLine(line);
                if (event != null) {
                  if (!controller.isClosed) {
                    controller.add(event);
                  }
                  if (onMessages != null) {
                    final result = onMessages(event);
                    if (result is Future<void>) {
                      unawaited(result);
                    }
                  }
                }
              },
              onError: (error) {
                debugPrint(
                  '[WARN][mercure] stream error label=$label mode=${attempt.tag}: $error',
                );
                final failure =
                    error is Object ? error : StateError(error.toString());
                if (onError != null) {
                  final result = onError(failure);
                  if (result is Future<void>) {
                    unawaited(result);
                  }
                }
                if (!controller.isClosed) {
                  controller.addError(failure);
                }
              },
              onDone: () {
                final finalEvent = parser.close();
                if (finalEvent != null && !controller.isClosed) {
                  controller.add(finalEvent);
                }
                debugPrint(
                  '[DEBUG][mercure] stream closed label=$label mode=${attempt.tag}',
                );
                if (onError != null) {
                  final result = onError(
                    StateError('$label mercure stream closed'),
                  );
                  if (result is Future<void>) {
                    unawaited(result);
                  }
                }
                if (!controller.isClosed) {
                  controller.close();
                }
                client?.close(force: true);
              },
              cancelOnError: false,
            );

        debugPrint(
          '[DEBUG][mercure] connected label=$label mode=${attempt.tag}',
        );
        return MercureSubscription(
          client: client,
          controller: controller,
          streamSubscription: streamSubscription,
          label: label,
          mode: attempt.tag,
        );
      } catch (error) {
        lastError = error;
        await streamSubscription?.cancel();
        if (!controller.isClosed) {
          await controller.close();
        }
        client?.close(force: true);

        final delay = _baseBackoff * (1 << i);
        debugPrint(
          '[WARN][mercure] connect failed label=$label mode=${attempt.tag} attempt=${i + 1}: $error; retrying in ${delay.inMilliseconds}ms',
        );
        await Future<void>.delayed(delay);
      }
    }

    if (lastError != null && onError != null) {
      onError(lastError);
    }
    return null;
  }

  static Future<Map<String, String>> _mercureHeaders() async {
    final storage = StorageService.instance;
    final token = await storage.fetchToken();
    final deviceToken = await storage.fetchDeviceToken();

    final headers = <String, String>{};
    if (token != null && token.isNotEmpty) {
      headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
    }
    if (deviceToken != null && deviceToken.isNotEmpty) {
      headers['X-Device-Token'] = deviceToken;
    }

    return headers;
  }

  static Uri _buildMercureUri(List<String> topics) {
    final base = Uri.parse(ApiConstants.mercureUrl);
    final merged = <String, dynamic>{...base.queryParameters, 'topic': topics};
    return base.replace(queryParameters: merged);
  }

  static Future<String?> _currentUserId() async {
    final storage = StorageService.instance;
    final stored = await storage.fetchUserId();
    if (stored != null && stored.isNotEmpty) {
      return stored;
    }
    return null;
  }
}

class MercureSubscription {
  MercureSubscription({
    required this.client,
    required this.controller,
    required this.streamSubscription,
    required this.label,
    required this.mode,
  });

  final HttpClient client;
  final StreamController<String> controller;
  final StreamSubscription<String> streamSubscription;
  final String label;
  final String mode;

  Stream<String> get stream => controller.stream;

  Future<void> close() async {
    await streamSubscription.cancel();
    if (!controller.isClosed) {
      await controller.close();
    }
    client.close(force: true);
  }
}

class _MercureAttempt {
  const _MercureAttempt({
    required this.uri,
    required this.headers,
    required this.tag,
  });

  final Uri uri;
  final Map<String, String> headers;
  final String tag;
}

class _MercureEventParser {
  final StringBuffer _data = StringBuffer();

  String? addLine(String line) {
    if (line.isEmpty) {
      return _flush();
    }

    if (line.startsWith('data:')) {
      final value = line.substring(5).trimLeft();
      if (_data.isNotEmpty) {
        _data.write('\n');
      }
      _data.write(value);
    }

    return null;
  }

  String? close() {
    return _flush();
  }

  String? _flush() {
    if (_data.isEmpty) {
      return null;
    }
    final event = _data.toString();
    _data.clear();
    return event;
  }
}
