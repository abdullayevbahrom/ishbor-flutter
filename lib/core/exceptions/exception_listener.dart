import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_jobs/core/router/app_routes.dart';
import 'package:top_jobs/feature/common/presentation/cubits/user_cubit/user_cubit.dart';

class ExceptionListener {
  final bool isDebug;
  final List<String> chatIds;
  final String? botToken;

  ExceptionListener({
    required this.isDebug,
    this.chatIds = const [],
    this.botToken,
  });

  void invoke({
    required StackTrace stackTrace,
    required Uri requestUri,
    required String method,
    String? requestBody,
    String? queryString,
    Response? response,
    Map<String, dynamic>? requestHeaders,
    DioException? dioException, // 👈 Qo'shildi
  }) {
   // if (isDebug) return;
    if (botToken == null || botToken!.isEmpty) return;

    _send(
      stackTrace: stackTrace,
      requestUri: requestUri,
      method: method,
      requestBody: requestBody,
      queryString: queryString,
      response: response,
      requestHeaders: requestHeaders,
      dioException: dioException, // 👈 Qo'shildi
    );
  }

  Future<void> _send({
    required StackTrace stackTrace,
    required Uri requestUri,
    required String method,
    String? requestBody,
    String? queryString,
    Response? response,
    Map<String, dynamic>? requestHeaders,
    DioException? dioException, // 👈 Qo'shildi
  }) async {
    final dio = Dio();

    try {
      final ipResponse = await dio.get('https://api.ipify.org');

      final userCubit = navigatorKey.currentContext?.read<UserCubit>();
      final userPhone =
          userCubit?.state.status.isLoaded() == true
              ? userCubit!.state.user?.phoneNumber
              : 'Guest';

      final text = _buildMessage(
        stackTrace: stackTrace,
        requestUri: requestUri,
        method: method,
        ip: ipResponse.data,
        userPhone: userPhone ?? 'GUEST',
        requestBody: requestBody,
        queryString: queryString,
        response: response,
        requestHeaders: requestHeaders,
        dioException: dioException, // 👈 Qo'shildi
      );

      for (final chatId in chatIds) {
        await dio.post(
          'https://api.telegram.org/bot$botToken/sendMessage',
          data: {'chat_id': chatId, 'text': text, 'parse_mode': 'HTML'},
        );
      }
    } catch (e) {
      debugPrint('⚠️ ExceptionListener xatolik: $e');
    }
  }

  String _buildMessage({
    required StackTrace stackTrace,
    required Uri requestUri,
    required String method,
    required String ip,
    required String userPhone,
    String? requestBody,
    String? queryString,
    Response? response,
    Map<String, dynamic>? requestHeaders,
    DioException? dioException, // 👈 Qo'shildi
  }) {
    final shortStack = stackTrace.toString().split('\n').take(3).join('\n');

    return '''
<b>🚨 MOBILE API RESPONSE</b>

<b>👤 User</b> 📞 $userPhone
 
<b>🌐 Request</b>
$method ${requestUri.toString()}

<b>📦 Query</b>
${queryString ?? '—'}

<b>📤 Request Headers</b>
<pre>${_formatHeaders(requestHeaders)}</pre>

<b>📦 Body</b>
${requestBody ?? '—'}

<b>📥 Response</b>
${_formatResponse(response, dioException)}

<b>🧾 cURL</b>
<pre>${_generateCurl(method: method, uri: requestUri, headers: requestHeaders, body: requestBody)}</pre>

<b>📡 Network</b>
IP: $ip
''';
  }

  String _formatResponse(Response? response, DioException? dioException) {
    if (response == null) {
      // 🔍 Batafsil xatolik ma'lumoti
      final errorDetails = _getDetailedErrorInfo(dioException);

      return '''
❌ <b>NO RESPONSE FROM SERVER</b>

<b>Error Type:</b> ${dioException?.type.name ?? 'unknown'}

<b>Error Message:</b>
${dioException?.message ?? 'No message'}

<b>Detailed Error:</b>
$errorDetails
''';
    }

    return '''
Status: ${response.statusCode}

Headers:
${_formatHeaders(response.headers.map)}

Body:
<pre>${_truncate(response.data?.toString() ?? '—')}</pre>
''';
  }

  String _getDetailedErrorInfo(DioException? error) {
    if (error == null) return '—';

    final buffer = StringBuffer();

    // Exception type
    buffer.writeln('Type: ${error.type.name}');

    // Error object
    if (error.error != null) {
      final errorObj = error.error!;
      buffer.writeln('\nError Object Type: ${errorObj.runtimeType}');

      // SocketException - network xatoliklari
      if (errorObj is SocketException) {
        buffer.writeln('Reason: ${errorObj.message}');
        if (errorObj.osError != null) {
          buffer.writeln(
            'OS Error: ${errorObj.osError!.message} (Code: ${errorObj.osError!.errorCode})',
          );
        }
        buffer.writeln('Address: ${errorObj.address?.host ?? 'unknown'}');
        buffer.writeln('Port: ${errorObj.port ?? 'unknown'}');
      }
      // HandshakeException - SSL xatoliklari
      else if (errorObj is HandshakeException) {
        buffer.writeln('SSL Handshake Error: ${errorObj.message}');
      }
      // HttpException
      else if (errorObj is HttpException) {
        buffer.writeln('HTTP Error: ${errorObj.message}');
        buffer.writeln('URI: ${errorObj.uri}');
      }
      // Boshqa xatoliklar
      else {
        buffer.writeln('Details: ${errorObj.toString()}');
      }
    }

    // DioException message
    if (error.message != null && error.message!.isNotEmpty) {
      buffer.writeln('\nDio Message: ${error.message}');
    }

    return buffer.toString();
  }

  String _formatHeaders(Map<String, dynamic>? headers) {
    if (headers == null || headers.isEmpty) return '—';

    final safe = Map<String, dynamic>.from(headers);

    const hiddenKeys = [
      'authorization',
      'Authorization',
      'token',
      'access-token',
      'refresh-token',
    ];

    for (final key in hiddenKeys) {
      if (safe.containsKey(key)) {
        safe[key] = '***HIDDEN***';
      }
    }

    return safe.entries.map((e) => '${e.key}: ${e.value}').join('\n');
  }

  String _generateCurl({
    required String method,
    required Uri uri,
    Map<String, dynamic>? headers,
    String? body,
  }) {
    final buffer = StringBuffer();

    buffer.write('curl -X $method "${uri.toString()}"');

    headers?.forEach((key, value) {
      if (key.toLowerCase() == 'authorization') {
        buffer.write(' \\\n  -H "$key: ***HIDDEN***"');
      } else {
        buffer.write(' \\\n  -H "$key: $value"');
      }
    });

    if (body != null && body.isNotEmpty) {
      buffer.write(' \\\n  -d \'$body\'');
    }

    return buffer.toString();
  }

  String _truncate(String text, {int max = 1500}) {
    if (text.length <= max) return text;
    return '${text.substring(0, max)}...\n(TRUNCATED)';
  }

  String _formatError(Object error) {
    if (error is DioException) {
      return '''
DioException (${error.response?.statusCode})
${error.message}
''';
    }

    if (error is FlutterError) {
      return error.message;
    }

    return error.toString();
  }
}
