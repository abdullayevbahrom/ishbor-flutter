import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:top_jobs/core/network/api_http.dart';
import 'package:top_jobs/core/constants/api_const.dart';
import 'package:top_jobs/feature/ads_view/data/models/reports_param.dart';

abstract class ReportsDataSource {
  Future<Either<Failure, void>> reportAd({required ReportsParam params});
}

class ReportsDataSourceImpl extends ReportsDataSource {
  final Dio _dio;

  ReportsDataSourceImpl(this._dio);

  String _reportTargetType(ReportsParam params) {
    if (params.vacancyId != null) {
      return 'vacancy';
    }
    if (params.serviceId != null) {
      return 'service';
    }
    if (params.taskId != null) {
      return 'task';
    }
    if (params.userId != null) {
      return 'user';
    }
    return 'unknown';
  }

  String _reportTargetId(ReportsParam params) {
    return (params.vacancyId ??
                params.serviceId ??
                params.taskId ??
                params.userId)
            ?.toString() ??
        '';
  }

  @override
  Future<Either<Failure, void>> reportAd({required ReportsParam params}) async {
    try {
      if (kDebugMode) {
        debugPrint(
          '[DEBUG][reports][create] action=report targetType=${_reportTargetType(params)} targetId=${_reportTargetId(params)} bodyLength=${params.body.length}',
        );
      }
      final response = await _dio.post(
        ApiConstants.reports,
        data: params.toJson(),
      );

      if (response.statusCode == 202 || response.statusCode == 201) {
        if (kDebugMode) {
          debugPrint(
            '[DEBUG][reports][create] accepted targetType=${_reportTargetType(params)} targetId=${_reportTargetId(params)}',
          );
        }
        return const Right(null);
      } else {
        if (kDebugMode) {
          debugPrint(
            '[WARN][reports][create] unexpected status=${response.statusCode} targetType=${_reportTargetType(params)} targetId=${_reportTargetId(params)}',
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
          '[WARN][reports][create][error] targetType=${_reportTargetType(params)} targetId=${_reportTargetId(params)} message=${failure.message}',
        );
      }
      return Left(Failure(message: failure.message));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
