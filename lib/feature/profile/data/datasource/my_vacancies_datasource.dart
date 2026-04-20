import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:top_jobs/core/network/api_http.dart';

import '../../../../core/constants/api_const.dart';

abstract class MyVacanciesDataSource {
  Future<Either<Failure, void>> changeVacancyStatus({
    required String status,
    required int vacancyId,
  });
}

class MyVacanciesDataSourceImpl implements MyVacanciesDataSource {
  final Dio _dio;

  MyVacanciesDataSourceImpl(this._dio);

  @override
  Future<Either<Failure, void>> changeVacancyStatus({
    required String status,
    required int vacancyId,
  }) async {
    try {
      final response = await _dio.patch(
        ApiConstants.changeVacancyStatusById(vacancyId),
        data: {"status": status},
      );

      if (response.statusCode == 200) {
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
