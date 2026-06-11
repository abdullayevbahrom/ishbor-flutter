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

  void _log429(DioException error) {
    if (error.response?.statusCode == 429) {
      debugPrint('[WARN][search] rate limit hit status=429');
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> globalSearch({
    required String query,
    String? type,
    int? limit,
  }) async {
    try {
      debugPrint(
        '[DEBUG][search] queryLength=${query.trim().length} type=${type ?? ''} limit=${limit ?? ''}',
      );
      final response = await _dio.get(
        ApiConstants.search,
        queryParameters: {
          'q': query,
          if (type != null) 'type': type,
          if (limit != null) 'limit': limit,
        },
      );
      if (response.statusCode == 200) {
        final raw = response.data;
        final payload =
            raw is Map<String, dynamic>
                ? Map<String, dynamic>.from(raw['data'] ?? raw)
                : <String, dynamic>{};
        debugPrint('[DEBUG][search] resultKeys=${payload.keys.toList()}');
        return Right(payload);
      } else {
        return Left(Failure(message: _extractMessage(response.data)));
      }
    } on DioException catch (e) {
      _log429(e);
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
