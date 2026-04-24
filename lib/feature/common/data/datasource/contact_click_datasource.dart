import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
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

  @override
  Future<Either<Failure, void>> addContactClick({
    required ContactClickParams contactClickParams,
  }) async {
    try {
      final response = await _dio.post("/contact-click",
      data: contactClickParams.toJson()
      );

      if (response.statusCode == 204 || response.statusCode == 200) {
        return const Right(null);
      } else {
        if (response.data is Map<String, dynamic>) {
          return Left(Failure(message: response.data['message']));
        } else {
          return Left(Failure(message: response.data));
        }
      }
    } on DioException catch (e) {
      final failure = DioFailure.fromDioError(e);
      return Left(Failure(message: failure.message));
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
