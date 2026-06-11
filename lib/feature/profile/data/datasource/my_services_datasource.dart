import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:top_jobs/core/network/api_http.dart';

import '../../../../core/constants/api_const.dart';

abstract class MyServicesDataSource {
  Future<Either<Failure, void>> changeStatusById({
    required dynamic serviceId,
    required String status,
  });
}

class MyServicesDataSourceImpl implements MyServicesDataSource {
  final Dio _dio;

  MyServicesDataSourceImpl(this._dio);

  @override
  Future<Either<Failure, void>> changeStatusById({
    required dynamic serviceId,
    required String status,
  }) async {
    try {
      debugPrint(
        '[SERVICE][status] PATCH ${ApiConstants.deactivateServiceById(serviceId)} status=$status',
      );
      final response = await _dio.patch(
        ApiConstants.deactivateServiceById(serviceId),
        data: {"status": status},
      );
      if (response.statusCode == 200 || response.statusCode == 204) {
        debugPrint('[SERVICE][status] success status=${response.statusCode}');
        return const Right(null);
      } else {
        debugPrint(
          '[SERVICE][status][warn] status=${response.statusCode} payload=${response.data}',
        );
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
