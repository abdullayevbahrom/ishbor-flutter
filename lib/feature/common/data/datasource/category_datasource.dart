import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:top_jobs/core/network/api_http.dart';
import 'package:top_jobs/core/constants/api_const.dart';
import 'package:top_jobs/feature/common/data/models/category.dart';

import '../../../vacancies/data/models/vacancy_query_params.dart';

abstract class CategoryDataSource {
  Future<Either<Failure, CategoryListResponse>> fetchCategories({
    required QueryParams queryParams,
  });

  Future<Either<Failure, CategoryListResponse>> fetchPopularCategories({
    String? city,
    int? size,
  });

  Future<Either<Failure, CategoryModel>> fetchCategoryById({
    required Object id,
  });
}

class CategoryDataSourceImpl extends CategoryDataSource {
  final Dio _dio;

  CategoryDataSourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<Either<Failure, CategoryListResponse>> fetchCategories({
    required QueryParams queryParams,
  }) async {
    try {
      debugPrint(
        '[DEBUG][catalog] fetch categories query=${queryParams.toMap()}',
      );
      final response = await _dio.get(
        ApiConstants.categories,
        queryParameters: queryParams
            .toMap()
            .entries
            .where((entry) => entry.value != null)
            .fold<Map<String, dynamic>>({}, (acc, entry) {
              acc[entry.key] = entry.value;
              return acc;
            }),
      );
      if (response.statusCode == 200) {
        return Right(CategoryListResponse.fromMap(response.data));
      } else {
        debugPrint(
          '[WARN][catalog] fetch categories failed status=${response.statusCode}',
        );
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
  Future<Either<Failure, CategoryListResponse>> fetchPopularCategories({
    String? city,
    int? size,
  }) async {
    try {
      debugPrint(
        '[DEBUG][catalog] fetch popular categories city=${city ?? ''} size=${size ?? ''}',
      );
      final response = await _dio.get(
        ApiConstants.popularCategories,
        queryParameters: {
          if (city != null) 'city': city,
          if (size != null) 'size': size,
        },
      );
      if (response.statusCode == 200) {
        return Right(CategoryListResponse.fromMap(response.data));
      } else {
        debugPrint(
          '[WARN][catalog] fetch popular categories failed status=${response.statusCode}',
        );
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
  Future<Either<Failure, CategoryModel>> fetchCategoryById({
    required Object id,
  }) async {
    try {
      debugPrint('[DEBUG][catalog] fetch category id=${id.toString()}');
      final response = await _dio.get(ApiConstants.fetchCategory(id));
      if (response.statusCode == 200) {
        return Right(
          CategoryModel.fromMap(response.data['data'] ?? response.data),
        );
      } else {
        debugPrint(
          '[WARN][catalog] fetch category failed status=${response.statusCode} id=${id.toString()}',
        );
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
