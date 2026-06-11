import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:top_jobs/core/network/api_http.dart';
import 'package:top_jobs/core/constants/api_const.dart';
import 'package:top_jobs/feature/common/data/models/category.dart';
import 'package:top_jobs/models/tag.dart';
import 'package:top_jobs/models/third_party_ad.dart';

abstract class CatalogDataSource {
  Future<Either<Failure, CategoryListResponse>> fetchPopularCategories({
    String? city,
    int? size,
  });

  Future<Either<Failure, CategoryModel>> fetchCategoryById({
    required Object id,
  });

  Future<Either<Failure, List<TagModel>>> fetchTags({int? page, int? size});

  Future<Either<Failure, TagModel>> fetchTagById({required Object id});

  Future<Either<Failure, List<ThirdPartyAd>>> fetchBanners({
    int? page,
    int? size,
  });
}

class CatalogDataSourceImpl extends CatalogDataSource {
  final Dio _dio;

  CatalogDataSourceImpl(this._dio);

  @override
  Future<Either<Failure, CategoryListResponse>> fetchPopularCategories({
    String? city,
    int? size,
  }) async {
    try {
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
      final response = await _dio.get(ApiConstants.fetchCategory(id));
      if (response.statusCode == 200) {
        return Right(
          CategoryModel.fromMap(response.data['data'] ?? response.data),
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

  @override
  Future<Either<Failure, List<TagModel>>> fetchTags({
    int? page,
    int? size,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.tags,
        queryParameters: {
          if (page != null) 'page': page,
          if (size != null) 'size': size,
        },
      );
      if (response.statusCode == 200) {
        final List items =
            response.data['items'] ?? response.data['data'] ?? [];
        return Right(
          items
              .map((e) => TagModel.fromMap(Map<String, dynamic>.from(e)))
              .toList(),
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

  @override
  Future<Either<Failure, TagModel>> fetchTagById({required Object id}) async {
    try {
      final response = await _dio.get(ApiConstants.fetchTag(id));
      if (response.statusCode == 200) {
        return Right(
          TagModel.fromMap(
            Map<String, dynamic>.from(response.data['data'] ?? response.data),
          ),
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

  @override
  Future<Either<Failure, List<ThirdPartyAd>>> fetchBanners({
    int? page,
    int? size,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.thirdPartyAds,
        queryParameters: {
          if (page != null) 'page': page,
          if (size != null) 'size': size,
        },
      );
      if (response.statusCode == 200) {
        final List items =
            response.data['items'] ?? response.data['data'] ?? [];
        return Right(
          items
              .map((e) => ThirdPartyAd.fromMap(Map<String, dynamic>.from(e)))
              .toList(),
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
