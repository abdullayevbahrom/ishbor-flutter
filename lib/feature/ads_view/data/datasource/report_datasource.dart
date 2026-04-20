import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:top_jobs/core/network/api_http.dart';
import 'package:top_jobs/core/constants/api_const.dart';
import 'package:top_jobs/feature/ads_view/data/models/reports_param.dart';

abstract class ReportsDataSource {
  Future<Either<Failure, void>> reportAd({required ReportsParam params});
}

class ReportsDataSourceImpl extends ReportsDataSource {
  final Dio _dio;

  ReportsDataSourceImpl(this._dio);

  @override
  Future<Either<Failure, void>> reportAd({required ReportsParam params}) async {
    try {
      final response = await _dio.post(
        ApiConstants.reports,
        data: params.toJson(),
      );

      if (response.statusCode == 201) {
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
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
