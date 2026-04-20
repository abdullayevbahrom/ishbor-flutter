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
}

class CategoryDataSourceImpl extends CategoryDataSource {
  final Dio _dio;

  CategoryDataSourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<Either<Failure, CategoryListResponse>> fetchCategories({
    required QueryParams queryParams,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.categories,
        queryParameters: {
          'page': queryParams.page,
        },
      );
      if (response.statusCode == 200) {
        return Right(CategoryListResponse.fromMap(response.data));
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
