import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:top_jobs/core/network/api_http.dart';
import 'package:top_jobs/core/constants/api_const.dart';
import 'package:top_jobs/core/network/api_response.dart';
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

  @override
  Future<Either<Failure, List<TagModel>>> fetchTags({
    int? page,
    int? size,
  }) async {
    try {
      debugPrint(
        '[DEBUG][catalog] fetch tags page=${page ?? ''} size=${size ?? ''}',
      );
      final response = await _dio.get(
        ApiConstants.tags,
        queryParameters: {
          if (page != null) 'page': page,
          if (size != null) 'size': size,
        },
      );
      if (response.statusCode == 200) {
        final parsed = ApiListResponse.fromJson(
          response.data,
          TagModel.fromMap,
        );
        return Right(parsed.items);
      } else {
        debugPrint(
          '[WARN][catalog] fetch tags failed status=${response.statusCode}',
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
  Future<Either<Failure, TagModel>> fetchTagById({required Object id}) async {
    try {
      debugPrint('[DEBUG][catalog] fetch tag id=${id.toString()}');
      final response = await _dio.get(ApiConstants.fetchTag(id));
      if (response.statusCode == 200) {
        return Right(
          TagModel.fromMap(
            Map<String, dynamic>.from(response.data['data'] ?? response.data),
          ),
        );
      } else {
        debugPrint(
          '[WARN][catalog] fetch tag failed status=${response.statusCode} id=${id.toString()}',
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
  Future<Either<Failure, List<ThirdPartyAd>>> fetchBanners({
    int? page,
    int? size,
  }) async {
    try {
      debugPrint(
        '[DEBUG][catalog] fetch banners page=${page ?? ''} size=${size ?? ''}',
      );
      final response = await _dio.get(
        ApiConstants.thirdPartyAds,
        queryParameters: {
          if (page != null) 'page': page,
          if (size != null) 'size': size,
        },
      );
      if (response.statusCode == 200) {
        final parsed = ApiListResponse.fromJson(
          response.data,
          ThirdPartyAd.fromMap,
        );
        return Right(parsed.items);
      } else {
        debugPrint(
          '[WARN][catalog] fetch banners failed status=${response.statusCode}',
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
