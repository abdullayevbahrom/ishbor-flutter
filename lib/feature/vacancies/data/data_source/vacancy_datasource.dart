import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:top_jobs/core/constants/api_const.dart';
import 'package:top_jobs/feature/common/data/models/pagination_model.dart';
import 'package:top_jobs/feature/vacancies/data/models/new_vacancy_model.dart';
import 'package:top_jobs/feature/vacancies/data/models/vacancy_create_model.dart';
import 'package:top_jobs/feature/vacancies/data/models/vacancy_query_params.dart';
import 'package:top_jobs/feature/vacancies/data/models/vacancy_response.dart';
import 'package:top_jobs/models/vacancy.dart';

import '../../../../core/network/api_http.dart';
import '../../../common/data/models/common_query_params.dart';
import '../../../common/data/models/map_filter_query.dart';

abstract class VacancyDataSource {
  Future<Either<Failure, VacancyResponse>> generateVacancy({
    required String text,
  });

  Future<Either<Failure, VacancyPaginationResponse>> fetchVacancies({
    required QueryParams queryParams,
  });

  Future<Either<Failure, PaginationResponse<NewVacancyModel>>>
  fetchNewVacancies({required QueryParams queryParams});

  Future<Either<Failure, VacancyPaginationResponse>> fetchSimilarVacancies({
    required CommonQueryParams queryParams,
  });

  Future<Either<Failure, Vacancy>> createVacancy({
    required VacancyRequest vacancy,
  });

  Future<Either<Failure, Vacancy>> editVacancy({
    required VacancyRequest vacancy,
  });

  Future<Either<Failure, Vacancy>> fetchVacancyById({required String id});

  Future<Either<Failure, List<Vacancy>>> fetchVacanciesGeo({
    required LocationFilterModel queryParams,
  });

  Future<Either<Failure, void>> liftUpVacancyById({required dynamic vacancyId});

  Future<Either<Failure, void>> deactivateVacancyById({
    required VacancyRequest vacancy,
  });

  Future<Either<Failure, void>> deleteVacancyById({required dynamic vacancyId});

  Future<Either<Failure, VacancyPaginationResponse>> fetchUserVacancies({
    required CommonQueryParams queryParams,
  });

  Future<Either<Failure, VacancyPaginationResponse>> fetchAppliedVacancies({
    required CommonQueryParams queryParams,
  });

  Future<Either<Failure, void>> toggleFavorite({required dynamic vacancyId});

  Future<Either<Failure, void>> deleteVacancyImageById({
    required dynamic vacancyId,
    required dynamic imageId,
  });
}

class VacancyDataSourceImpl extends VacancyDataSource {
  final Dio _dio;

  VacancyDataSourceImpl(Dio dio) : _dio = dio;

  @override
  Future<Either<Failure, VacancyResponse>> generateVacancy({
    required String text,
  }) async {
    final prompt = Uri.encodeComponent(text);
    try {
      final response = await _dio.get(
        ApiConstants.chatGpt,
        queryParameters: {"prompt": prompt.characters.take(900)},
        options: Options(),
      );

      if (response.statusCode == 200) {
        if (response.data['ok']) {
          return Right(VacancyResponse.fromJson(response.data));
        } else {
          return Left(Failure(message: response.data['result']));
        }
      } else {
        if (response.data is Map<String, dynamic>) {
          return Left(Failure(message: response.data['message']));
        } else {
          return Left(Failure(message: response.data.toString()));
        }
      }
    } on DioException catch (e) {
      final failure = DioFailure.fromDioError(e);
      return Left(Failure(message: failure.message));
    } on Exception catch (e) {
      if (kDebugMode) {
        debugPrint(e.toString());
      }
      rethrow;
    }
  }

  @override
  Future<Either<Failure, VacancyPaginationResponse>> fetchVacancies({
    required QueryParams queryParams,
  }) async {
    try {
      debugPrint(
        '[VACANCY][list] GET ${ApiConstants.vacancies} query=${queryParams.toMap()}',
      );
      final response = await _dio.get(
        ApiConstants.vacancies,
        queryParameters: queryParams.toMap(),
      );
      if (response.statusCode == 200) {
        debugPrint('[VACANCY][list] loaded status=${response.statusCode}');
        return Right(VacancyPaginationResponse.fromMap(response.data));
      } else {
        debugPrint(
          '[VACANCY][list][warn] status=${response.statusCode} payload=${response.data}',
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
      if (kDebugMode) {
        debugPrint(e.toString());
      }
      rethrow;
    }
  }

  @override
  Future<Either<Failure, VacancyPaginationResponse>> fetchSimilarVacancies({
    required CommonQueryParams queryParams,
  }) async {
    try {
      debugPrint(
        '[VACANCY][similar] GET ${ApiConstants.fetchSimilarVacancy(queryParams.id!)} query=${queryParams.toMap()}',
      );
      final response = await _dio.get(
        ApiConstants.fetchSimilarVacancy(queryParams.id!),
        queryParameters: {
          "size": queryParams.pageSize,
          "page": queryParams.pageNumber,
        },
      );

      if (response.statusCode == 200) {
        debugPrint('[VACANCY][similar] loaded status=${response.statusCode}');
        return Right(VacancyPaginationResponse.fromMap(response.data));
      } else {
        debugPrint(
          '[VACANCY][similar][warn] status=${response.statusCode} payload=${response.data}',
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

  @override
  Future<Either<Failure, Vacancy>> createVacancy({
    required VacancyRequest vacancy,
  }) async {
    try {
      debugPrint(
        '[VACANCY][create] POST ${ApiConstants.vacancies} categories=${vacancy.categories} city=${vacancy.city}',
      );
      final payload = Map<String, dynamic>.from(vacancy.toJson());
      final images = List<File>.from(vacancy.images);
      final data = FormData.fromMap(payload);

      if (images.isNotEmpty) {
        for (File file in images) {
          final String fileName = file.path.split('/').last;
          final String type = file.path.split('.').last;
          data.files.add(
            MapEntry<String, MultipartFile>(
              'uploadedImages',
              MultipartFile.fromBytes(
                file.readAsBytesSync(),
                filename: fileName,
                contentType: DioMediaType("image", type),
              ),
            ),
          );
        }
      }

      final response = await _dio.post(ApiConstants.vacancies, data: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('[VACANCY][create] success status=${response.statusCode}');
        return Right(Vacancy.fromMap(response.data));
      } else {
        debugPrint(
          '[VACANCY][create][warn] status=${response.statusCode} payload=${response.data}',
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

  @override
  Future<Either<Failure, VacancyPaginationResponse>> fetchAppliedVacancies({
    required CommonQueryParams queryParams,
  }) async {
    try {
      debugPrint(
        '[VACANCY][applies] GET ${ApiConstants.myVacancyApplies} query=${queryParams.toMap()}',
      );
      final response = await _dio.get(
        ApiConstants.myVacancyApplies,
        queryParameters: queryParams.toMap(),
      );
      if (response.statusCode == 200) {
        debugPrint('[VACANCY][applies] loaded status=${response.statusCode}');
        return Right(VacancyPaginationResponse.fromMap(response.data));
      } else {
        debugPrint(
          '[VACANCY][applies][warn] status=${response.statusCode} payload=${response.data}',
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
      if (kDebugMode) {
        debugPrint(e.toString());
      }
      rethrow;
    }
  }

  @override
  Future<Either<Failure, VacancyPaginationResponse>> fetchUserVacancies({
    required CommonQueryParams queryParams,
  }) async {
    try {
      debugPrint(
        '[VACANCY][mine] GET ${ApiConstants.myVacancies} query=${queryParams.toMap()}',
      );
      final response = await _dio.get(
        ApiConstants.myVacancies,
        queryParameters: queryParams.toMap(),
      );
      if (response.statusCode == 200) {
        debugPrint('[VACANCY][mine] loaded status=${response.statusCode}');
        return Right(VacancyPaginationResponse.fromMap(response.data));
      } else {
        debugPrint(
          '[VACANCY][mine][warn] status=${response.statusCode} payload=${response.data}',
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
      if (kDebugMode) {
        debugPrint(e.toString());
      }
      rethrow;
    }
  }

  @override
  Future<Either<Failure, Vacancy>> fetchVacancyById({
    required String id,
  }) async {
    try {
      debugPrint('[VACANCY][read] GET ${ApiConstants.fetchVacancy(id)}');
      final response = await _dio.get(ApiConstants.fetchVacancy(id));
      if (response.statusCode == 200) {
        debugPrint('[VACANCY][read] loaded status=${response.statusCode}');
        return Right(Vacancy.fromMap(response.data));
      } else {
        debugPrint(
          '[VACANCY][read][warn] status=${response.statusCode} payload=${response.data}',
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
      if (kDebugMode) {
        debugPrint(e.toString());
      }
      rethrow;
    }
  }

  @override
  Future<Either<Failure, List<Vacancy>>> fetchVacanciesGeo({
    required LocationFilterModel queryParams,
  }) async {
    try {
      debugPrint(
        '[VACANCY][geo] GET ${ApiConstants.vacanciesGeo} query=${queryParams.toJson()}',
      );
      final response = await _dio.get(
        ApiConstants.vacanciesGeo,
        queryParameters: queryParams.toJson(),
      );

      if (response.statusCode == 200) {
        debugPrint('[VACANCY][geo] loaded status=${response.statusCode}');
        final payload = response.data;
        final items =
            payload is List
                ? payload
                : payload is Map<String, dynamic>
                ? (payload['items'] as List? ??
                    (payload['data'] is Map<String, dynamic>
                        ? payload['data']['items'] as List?
                        : null) ??
                    const [])
                : const [];
        return Right(
          items
              .map((e) => Vacancy.fromMap(Map<String, dynamic>.from(e)))
              .toList(),
        );
      } else {
        debugPrint(
          '[VACANCY][geo][warn] status=${response.statusCode} payload=${response.data}',
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
      if (kDebugMode) {
        debugPrint(e.toString());
      }
      rethrow;
    }
  }

  @override
  Future<Either<Failure, Vacancy>> editVacancy({
    required VacancyRequest vacancy,
  }) async {
    try {
      debugPrint(
        '[VACANCY][update] PATCH ${ApiConstants.updateVacancy(vacancy.vacancyId!)} id=${vacancy.vacancyId}',
      );
      final data = FormData.fromMap(vacancy.toJson());
      final response = await _dio.patch(
        ApiConstants.updateVacancy(vacancy.vacancyId!),
        data: data,
      );

      if (response.statusCode == 200) {
        debugPrint('[VACANCY][update] success status=${response.statusCode}');
        return Right(Vacancy.fromMap(response.data));
      } else {
        debugPrint(
          '[VACANCY][update][warn] status=${response.statusCode} payload=${response.data}',
        );
        //     response.data,
        // "stractree",
        // response.requestOptions.uri,
        // response.requestOptions.method,
        // "userIp",
        // response.requestOptions.queryParameters,
        // response.requestOptions.data,

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
      if (kDebugMode) {
        debugPrint(e.toString());
      }
      rethrow;
    }
  }

  @override
  Future<Either<Failure, void>> deactivateVacancyById({
    required VacancyRequest vacancy,
  }) async {
    try {
      debugPrint(
        '[VACANCY][status] PATCH ${ApiConstants.changeVacancyStatusById(vacancy.vacancyId!)} id=${vacancy.vacancyId} status=deactivated',
      );
      final response = await _dio.patch(
        ApiConstants.changeVacancyStatusById(vacancy.vacancyId!),
        data: {"status": "deactivated"},
      );

      if (response.statusCode == 200) {
        debugPrint('[VACANCY][status] success status=${response.statusCode}');
        return const Right(null);
      } else {
        debugPrint(
          '[VACANCY][status][warn] status=${response.statusCode} payload=${response.data}',
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

  @override
  Future<Either<Failure, void>> deleteVacancyById({
    required dynamic vacancyId,
  }) async {
    try {
      debugPrint(
        '[VACANCY][delete] DELETE ${ApiConstants.deleteVacancyById(vacancyId)}',
      );
      final response = await _dio.delete(
        ApiConstants.deleteVacancyById(vacancyId),
      );

      if (response.statusCode == 204) {
        debugPrint('[VACANCY][delete] success status=${response.statusCode}');
        return const Right(null);
      } else {
        debugPrint(
          '[VACANCY][delete][warn] status=${response.statusCode} payload=${response.data}',
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

  @override
  Future<Either<Failure, void>> liftUpVacancyById({
    required dynamic vacancyId,
  }) async {
    try {
      debugPrint(
        '[VACANCY][lift-up] POST ${ApiConstants.liftUpVacancyById(vacancyId)}',
      );
      final response = await _dio.post(
        ApiConstants.liftUpVacancyById(vacancyId),
      );

      if (response.statusCode == 204) {
        debugPrint('[VACANCY][lift-up] success status=${response.statusCode}');
        return const Right(null);
      } else {
        debugPrint(
          '[VACANCY][lift-up][warn] status=${response.statusCode} payload=${response.data}',
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

  @override
  Future<Either<Failure, void>> toggleFavorite({
    required dynamic vacancyId,
  }) async {
    try {
      debugPrint(
        '[VACANCY][favorite] POST ${ApiConstants.toggleVacancyFavorite(vacancyId)}',
      );
      final response = await _dio.post(
        ApiConstants.toggleVacancyFavorite(vacancyId),
      );

      if (response.statusCode == 204) {
        debugPrint('[VACANCY][favorite] success status=${response.statusCode}');
        return const Right(null);
      } else {
        debugPrint(
          '[VACANCY][favorite][warn] status=${response.statusCode} payload=${response.data}',
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

  @override
  Future<Either<Failure, void>> deleteVacancyImageById({
    required dynamic vacancyId,
    required dynamic imageId,
  }) async {
    try {
      debugPrint(
        '[FIX][VACANCY][image-delete] DELETE ${ApiConstants.deleteVacancyImage(vacancyId)} image=$imageId',
      );
      final response = await _dio.delete(
        ApiConstants.deleteVacancyImage(vacancyId),
        data: {'image': imageId.toString()},
      );

      if (response.statusCode == 204 || response.statusCode == 200) {
        debugPrint(
          '[FIX][VACANCY][image-delete] success status=${response.statusCode}',
        );
        return const Right(null);
      } else {
        debugPrint(
          '[FIX][VACANCY][image-delete][warn] status=${response.statusCode} payload=${response.data}',
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

  @override
  Future<Either<Failure, PaginationResponse<NewVacancyModel>>>
  fetchNewVacancies({required QueryParams queryParams}) async {
    try {
      final response = await _dio.get(
        'vacancies-new',
        queryParameters: queryParams.toMap(),
      );

      final result = PaginationResponse<NewVacancyModel>.fromJson(
        response.data,
        (json) => NewVacancyModel.fromJson(json),
      );
      return Right(result);
    } on DioException catch (e) {
      final failure = DioFailure.fromDioError(e);
      return Left(Failure(message: failure.message));
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
