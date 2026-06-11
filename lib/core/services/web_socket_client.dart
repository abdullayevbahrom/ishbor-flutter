import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:top_jobs/core/constants/api_const.dart';
import 'package:top_jobs/core/services/storage_service.dart';
import 'package:web_socket_channel/io.dart';

import '../../injection_container.dart';

class WebsocketClient {
  static const int _maxAttempts = 3;
  static const Duration _baseBackoff = Duration(milliseconds: 300);

  static Future<IOWebSocketChannel?> initChat(Object messageId) async {
    final path = '/messages/$messageId';
    return _connectWithFallback(
      label: 'messages',
      path: path,
    );
  }

  Future<IOWebSocketChannel?> initUserStatus({
    FutureOr<void> Function(dynamic)? onMessages,
    FutureOr<void> Function(Object error)? onError,
  }) async {
    return _connectWithFallback(
      label: 'statuses',
      path: '/users/statuses',
      onMessages: onMessages,
      onError: onError,
    );
  }

  static Future<IOWebSocketChannel?> _connectWithFallback({
    required String label,
    required String path,
    FutureOr<void> Function(dynamic)? onMessages,
    FutureOr<void> Function(Object error)? onError,
  }) async {
    final headers = await _socketHeaders();
    final baseUri = Uri.parse('${ApiConstants.wsUrl}$path');

    final attempts = <_SocketAttempt>[
      _SocketAttempt(
        uri: baseUri,
        headers: headers,
        tag: 'header-auth',
      ),
      _SocketAttempt(
        uri: baseUri.replace(
          queryParameters: {
            ...baseUri.queryParameters,
            if (headers['Authorization'] != null)
              'token': (headers['Authorization'] as String).replaceFirst(
                'Bearer ',
                '',
              ),
          },
        ),
        headers: const {},
        tag: 'query-token',
      ),
    ];

    for (final attempt in attempts) {
      final channel = await _tryConnect(
        label: label,
        attempt: attempt,
        onMessages: onMessages,
        onError: onError,
      );
      if (channel != null) {
        return channel;
      }
    }

    debugPrint(
      '[WARN][socket] $label socket unavailable after retries; falling back to HTTP',
    );
    return null;
  }

  static Future<IOWebSocketChannel?> _tryConnect({
    required String label,
    required _SocketAttempt attempt,
    FutureOr<void> Function(dynamic)? onMessages,
    FutureOr<void> Function(Object error)? onError,
  }) async {
    Object? lastError;

    for (var i = 0; i < _maxAttempts; i++) {
      try {
        debugPrint(
          '[DEBUG][socket] connecting label=$label attempt=${i + 1} mode=${attempt.tag} uri=${attempt.uri.path}',
        );
        final channel = IOWebSocketChannel.connect(
          attempt.uri,
          headers: attempt.headers,
        );

        channel.stream.listen(
          (event) async {
            if (onMessages != null) {
              await onMessages(event);
            }
          },
          onError: (error) {
            debugPrint(
              '[WARN][socket] stream error label=$label mode=${attempt.tag}: $error',
            );
            if (onError != null) {
              onError(error is Object ? error : StateError(error.toString()));
            }
          },
          onDone: () {
            debugPrint(
              '[DEBUG][socket] stream closed label=$label mode=${attempt.tag}',
            );
            if (onError != null) {
              onError(StateError('$label socket closed'));
            }
          },
          cancelOnError: false,
        );

        debugPrint(
          '[DEBUG][socket] connected label=$label mode=${attempt.tag}',
        );
        return channel;
      } catch (error) {
        lastError = error;
        final delay = _baseBackoff * (1 << i);
        debugPrint(
          '[WARN][socket] connect failed label=$label mode=${attempt.tag} attempt=${i + 1}: $error; retrying in ${delay.inMilliseconds}ms',
        );
        await Future<void>.delayed(delay);
      }
    }

    if (lastError != null && onError != null) {
      onError(lastError);
    }
    return null;
  }

  static Future<Map<String, String>> _socketHeaders() async {
    final storage = sl<StorageService>();
    final token = await storage.fetchToken();
    final deviceToken = await storage.fetchDeviceToken();

    final headers = <String, String>{};
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }
    if (deviceToken != null && deviceToken.isNotEmpty) {
      headers['X-Device-Token'] = deviceToken;
    }

    return headers;
  }
}

class _SocketAttempt {
  const _SocketAttempt({
    required this.uri,
    required this.headers,
    required this.tag,
  });

  final Uri uri;
  final Map<String, String> headers;
  final String tag;
}
