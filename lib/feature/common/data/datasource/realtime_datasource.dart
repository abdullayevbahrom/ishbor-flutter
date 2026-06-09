import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:top_jobs/core/network/api_http.dart';
import 'package:top_jobs/core/constants/api_const.dart';

abstract class RealtimeDataSource {
  Future<Either<Failure, void>> heartbeat();
  Future<Either<Failure, Map<String, dynamic>>> checkUserStatus(Object userId);
}

class RealtimeDataSourceImpl extends RealtimeDataSource {
  final Dio _dio;

  RealtimeDataSourceImpl(this._dio);

  @override
  Future<Either<Failure, void>> heartbeat() async {
    try {
      final response = await _dio.post(ApiConstants.heartbeat);
      if (response.statusCode == 204 || response.statusCode == 200) {
        return const Right(null);
      } else {
        return Left(Failure(message: _extractMessage(response.data)));
      }
    } on DioException catch (e) {
      return Left(Failure(message: DioFailure.fromDioError(e).message));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> checkUserStatus(Object userId) async {
    try {
      final response = await _dio.get(ApiConstants.userStatus(userId));
      if (response.statusCode == 200) {
        return Right(Map<String, dynamic>.from(response.data['data'] ?? response.data));
      } else {
        return Left(Failure(message: _extractMessage(response.data)));
      }
    } on DioException catch (e) {
      return Left(Failure(message: DioFailure.fromDioError(e).message));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  String _extractMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data['message']?.toString() ?? data.toString();
    }
    return data?.toString() ?? 'Unknown error';
  }
}
