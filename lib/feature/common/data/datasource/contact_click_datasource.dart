import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:top_jobs/core/constants/api_const.dart';
import 'package:top_jobs/core/network/api_http.dart';

import '../models/contact_click_params.dart';

abstract class ContactClickDatasource {
  Future<Either<Failure, void>> addContactClick({
    required ContactClickParams contactClickParams,
  });
}

class ContactClickDataSourceImpl extends ContactClickDatasource {
  final Dio _dio;

  ContactClickDataSourceImpl(this._dio);

  String _maskContact(String contact) {
    if (contact.isEmpty) {
      return '';
    }

    final trimmed = contact.trim();
    if (trimmed.length <= 4) {
      return '****';
    }

    final visiblePrefix = trimmed.substring(0, 2);
    final visibleSuffix = trimmed.substring(trimmed.length - 2);
    return '$visiblePrefix***$visibleSuffix';
  }

  @override
  Future<Either<Failure, void>> addContactClick({
    required ContactClickParams contactClickParams,
  }) async {
    try {
      if (kDebugMode) {
        debugPrint(
          '[DEBUG][contact-click][create] action=contact_click type=${contactClickParams.type} id=${contactClickParams.id} contact=${_maskContact(contactClickParams.contact)}',
        );
      }
      final response = await _dio.post(
        ApiConstants.contentContactClick,
        data: contactClickParams.toJson(),
      );

      if (response.statusCode == 202 || response.statusCode == 204) {
        if (kDebugMode) {
          debugPrint(
            '[DEBUG][contact-click][create] accepted type=${contactClickParams.type} id=${contactClickParams.id}',
          );
        }
        return const Right(null);
      } else {
        if (kDebugMode) {
          debugPrint(
            '[WARN][contact-click][create] unexpected status=${response.statusCode} type=${contactClickParams.type} id=${contactClickParams.id}',
          );
        }
        if (response.data is Map<String, dynamic>) {
          return Left(Failure(message: response.data['message']));
        } else {
          return Left(Failure(message: response.data));
        }
      }
    } on DioException catch (e) {
      final failure = DioFailure.fromDioError(e);
      if (kDebugMode) {
        debugPrint(
          '[WARN][contact-click][create][error] type=${contactClickParams.type} id=${contactClickParams.id} message=${failure.message}',
        );
      }
      return Left(Failure(message: failure.message));
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
