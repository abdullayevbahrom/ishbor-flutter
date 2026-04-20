import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class DioFailure implements Exception {
  final String message;
  final int? statusCode;
  final DioExceptionType type;

  DioFailure({required this.message, this.statusCode, required this.type});

  factory DioFailure.fromDioError(DioException error) {
    return DioFailure(
      message: _handleBadResponse(error.response),
      statusCode: error.response?.statusCode,
      type: error.type,
    );
  }

  static String _handleBadResponse(Response<dynamic>? response) {
    if (response == null) return "No response from server";

    try {
      final data = response.data;

      if (data is Map<String, dynamic>) {
        if (data.containsKey("message") && data["message"] != null) {
          return data["message"].toString();
        }
        if (data.containsKey("error") && data["error"] != null) {
          return data["error"].toString();
        }
        if (data.isNotEmpty) {
          return data.values.first.toString();
        }
      } else if (data is String) {
        return data;
      }
    } catch (e) {
      return "Error parsing response";
    }

    switch (response.statusCode) {
      case 208:
        return "User already exists. Please try logging in.";
      case 400:
        return "Bad request. Please check your input.";
      case 401:
        return "Unauthorized. Please check your credentials.";
      case 403:
        return "Access forbidden.";
      case 404:
        return "User not found.";
      case 500:
        return "Internal server error.";
      default:
        return "Unexpected error: ${response.statusCode}";
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
    return message ?? "Unexpected error";
  }

  @override
  List<Object?> get props => [message];
}

final class ServerFailure extends Failure {
  const ServerFailure({super.message});

  @override
  String toString() {
    return message ?? "Unexpected error";
  }
}
