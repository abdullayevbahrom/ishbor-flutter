import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:top_jobs/core/network/api_http.dart';
import 'package:top_jobs/core/constants/api_const.dart';

abstract class SearchDataSource {
  Future<Either<Failure, Map<String, dynamic>>> globalSearch({
    required String query,
    String? type,
    int? limit,
  });
}

class SearchDataSourceImpl extends SearchDataSource {
  final Dio _dio;

  SearchDataSourceImpl(this._dio);

  @override
  Future<Either<Failure, Map<String, dynamic>>> globalSearch({
    required String query,
    String? type,
    int? limit,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.search,
        queryParameters: {
          'q': query,
          if (type != null) 'type': type,
          if (limit != null) 'limit': limit,
        },
      );
      if (response.statusCode == 200) {
        return Right(
          Map<String, dynamic>.from(response.data['data'] ?? response.data),
        );
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
