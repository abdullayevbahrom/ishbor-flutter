import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';

import '../exceptions/exception_listener.dart';
import '../../injection_container.dart';

class DioFailure implements Exception {
  final String message;
  final int? statusCode;
  final DioExceptionType type;
  final dynamic data;

  DioFailure({
    required this.message,
    this.statusCode,
    required this.type,
    this.data,
  });

  factory DioFailure.fromDioError(DioException error) {
    final statusCode = error.response?.statusCode;

    sl<ExceptionListener>().invoke(
      stackTrace: error.stackTrace ?? StackTrace.current,
      method: error.requestOptions.method,
      requestUri: error.requestOptions.uri,
      queryString:
          error.requestOptions.queryParameters.isNotEmpty
              ? error.requestOptions.queryParameters.toString()
              : null,
      requestBody: error.requestOptions.data?.toString(),
      response: error.response,
      requestHeaders: error.requestOptions.headers,
      dioException: error,
    );

    if (error.response == null) {
      return DioFailure(
        message: _handleNoResponse(error),
        statusCode: null,
        type: error.type,
        data: null,
      );
    }

    return DioFailure(
      message: _parseErrorMessage(error.response),
      statusCode: statusCode,
      type: error.type,
      data: error.response?.data,
    );
  }

  static String _parseErrorMessage(Response<dynamic>? response) {
    if (response == null) return LocaleKeys.unExpectedError.tr();
    final data = response.data;

    if (data is Map<String, dynamic>) {
      if (data.containsKey("message")) {
        final message = data["message"];
        if (message is String && message.isNotEmpty) {
          return message;
        } else if (message is List && message.isNotEmpty) {
          return message.join(", ");
        }
      }
      if (data.containsKey("error") && data["error"] != null) {
        return data["error"].toString();
      }
      if (data.isNotEmpty) {
        return data.values.first.toString();
      }
    } else if (data is String && data.isNotEmpty) {
      return data;
    } else if (data is List) {
      if (data.contains("Code has been expired")) {
        return LocaleKeys.codeExpired.tr();
      }
      if (data.contains("Invalid code")) {
        return LocaleKeys.invalidCode.tr();
      }
    }

    return _getStatusCodeMessage(response.statusCode, data);
  }

  static String _getStatusCodeMessage(int? statusCode, dynamic responseData) {
    switch (statusCode) {
      case 208:
        return "User already exists. Please try logging in.";
      case 401:
        return LocaleKeys.userNotFound.tr();
      case 403:
        return "Access forbidden.";
      case 404:
        return LocaleKeys.userNotFound.tr();
      case 500:
        return LocaleKeys.unExpectedError.tr();
      default:
        return responseData is String
            ? responseData
            : LocaleKeys.unExpectedError.tr();
    }
  }

  static String _handleNoResponse(DioException error) {
    // 🔍 Batafsil error ma'lumotini ko'rsatish
    String errorDetail = '';

    if (error.error is SocketException) {
      final socketError = error.error as SocketException;
      errorDetail = 'SocketException: ${socketError.message}';
      debugPrint('🔴 Socket Error: ${socketError.message}');
      debugPrint('🔴 OS Error: ${socketError.osError}');
    } else if (error.error is HandshakeException) {
      errorDetail = 'SSL Handshake failed';
      debugPrint('🔴 SSL Handshake Error: ${error.error}');
    } else if (error.error != null) {
      errorDetail = error.error.toString();
      debugPrint('🔴 Other Error: ${error.error}');
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return LocaleKeys.connectionTimeOut.tr();
      case DioExceptionType.sendTimeout:
        return LocaleKeys.sendTimeOut.tr();
      case DioExceptionType.receiveTimeout:
        return LocaleKeys.receiveTimeOut.tr();
      case DioExceptionType.connectionError:
        if (kDebugMode) {
          return 'Connection Error: $errorDetail';
        }
        return LocaleKeys.connectionTimeOut.tr();
      case DioExceptionType.unknown:
        if (kDebugMode) {
          return 'Unknown Error: $errorDetail';
        }
        return LocaleKeys.unExpectedError.tr();
      default:
        return LocaleKeys.unExpectedError.tr();
    }
  }

  @override
  String toString() => message;
}

base class Failure extends Equatable {
  final String? message;

  const Failure({this.message});

  @override
  String toString() {
    return message ?? LocaleKeys.unExpectedError.tr();
  }

  @override
  List<Object?> get props => [message];
}

final class ServerFailure extends Failure {
  const ServerFailure({super.message});

  @override
  String toString() {
    return message ?? LocaleKeys.unExpectedError.tr();
  }
}
