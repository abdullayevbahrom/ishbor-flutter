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

  Future<Either<Failure, Vacancy>> fetchVacancyById({required int id});

  Future<Either<Failure, List<Vacancy>>> fetchVacanciesGeo({
    required LocationFilterModel queryParams,
  });

  Future<Either<Failure, void>> liftUpVacancyById({required int vacancyId});

  Future<Either<Failure, void>> deactivateVacancyById({
    required VacancyRequest vacancy,
  });

  Future<Either<Failure, void>> deleteVacancyById({required int vacancyId});

  Future<Either<Failure, VacancyPaginationResponse>> fetchUserVacancies({
    required CommonQueryParams queryParams,
  });

  Future<Either<Failure, VacancyPaginationResponse>> fetchAppliedVacancies({
    required CommonQueryParams queryParams,
  });

  Future<Either<Failure, void>> toggleFavorite({required int vacancyId});
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
      final response = await _dio.get(
        ApiConstants.vacancies,
        queryParameters: queryParams.toMap(),
      );
      if (response.statusCode == 200) {
        return Right(VacancyPaginationResponse.fromMap(response.data));
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
      final response = await _dio.get(
        ApiConstants.fetchSimilarVacancy(queryParams.id!),
        queryParameters: {
          "size": queryParams.pageSize,
          "page": queryParams.pageNumber,
        },
      );

      if (response.statusCode == 200) {
        return Right(VacancyPaginationResponse.fromMap(response.data));
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

  @override
  Future<Either<Failure, Vacancy>> createVacancy({
    required VacancyRequest vacancy,
  }) async {
    try {
      FormData data = FormData.fromMap({
        'title': vacancy.title,
        'categories': vacancy.categories,
        'city': vacancy.city,
        'description': vacancy.description,
        'address': {
          if (vacancy.address?.addressLine != null)
            'addressLine': vacancy.address?.addressLine,
          if (vacancy.address?.latitude != null)
            'latitude': vacancy.address?.latitude,
          if (vacancy.address?.longitude != null)
            'longitude': vacancy.address?.longitude,
        },

        'salaryMin': vacancy.salaryMin,
        'salaryMax': vacancy.salaryMax,
        //'skills': vacancy.skills,
        'shortDescription': vacancy.shortDescription,
        //'whoCanRespond': vacancy.whoCanRespond,
        'employmentType': vacancy.employmentType,
        // 'jobModes':  ["flexible"],
        'partialJobOpportunity': vacancy.partialJobOpportunity,
        "phoneNumber": vacancy.phoneNumber,
        if ((vacancy.phoneNumber1 ?? '').isNotEmpty)
          "phoneNumber1": vacancy.phoneNumber1,
        if ((vacancy.phoneNumber2 ?? '').isNotEmpty)
          "phoneNumber2": vacancy.phoneNumber2,
        if ((vacancy.phoneNumber3 ?? '').isNotEmpty)
          "phoneNumber3": vacancy.phoneNumber3,
      });

      if (vacancy.images.isNotEmpty) {
        for (File file in vacancy.images) {
          final String fileName = file.path.split('/').last;
          final String type = file.path.split('.').last;
          data.files.add(
            MapEntry<String, MultipartFile>(
              'uploadedImages[]',
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
      if (response.statusCode == 200) {
        return Right(Vacancy.fromMap(response.data));
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

  @override
  Future<Either<Failure, VacancyPaginationResponse>> fetchAppliedVacancies({
    required CommonQueryParams queryParams,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.myVacancyApplies,
        queryParameters: queryParams.toMap(),
      );
      if (response.statusCode == 200) {
        return Right(VacancyPaginationResponse.fromMap(response.data));
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
      final response = await _dio.get(
        ApiConstants.myVacancies,
        queryParameters: queryParams.toMap(),
      );
      if (response.statusCode == 200) {
        return Right(VacancyPaginationResponse.fromMap(response.data));
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
      if (kDebugMode) {
        debugPrint(e.toString());
      }
      rethrow;
    }
  }

  @override
  Future<Either<Failure, Vacancy>> fetchVacancyById({required int id}) async {
    try {
      final response = await _dio.get('${ApiConstants.vacancies}/$id');
      if (response.statusCode == 200) {
        return Right(Vacancy.fromMap(response.data));
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
      final response = await _dio.get(
        ApiConstants.vacanciesGeo,
        queryParameters: queryParams.toJson(),
      );

      if (response.statusCode == 200) {
        return Right(
          (response.data as List).map((e) => Vacancy.fromMap(e)).toList(),
        );
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
      Map<String, dynamic> data = {
        'title': vacancy.title,
        // 'categories': jsonEncode(vacancy.categories),
        'city': vacancy.city,
        'description': vacancy.description,
        'address': {
          if (vacancy.address?.addressLine != null)
            'addressLine': vacancy.address?.addressLine,
          if (vacancy.address?.latitude != null)
            'latitude': vacancy.address?.latitude,
          if (vacancy.address?.longitude != null)
            'longitude': vacancy.address?.longitude,
        },
        'salaryMin': vacancy.salaryMin ?? 0,
        'salaryMax': vacancy.salaryMax ?? 0,
        'skills': vacancy.skills,
        if (vacancy.shortDescription.isNotEmpty)
          'shortDescription': vacancy.shortDescription,
        'whoCanRespond': vacancy.whoCanRespond,
        'employmentType': vacancy.employmentType,
        if (vacancy.partialJobOpportunity != null)
          'partialJobOpportunity': vacancy.partialJobOpportunity,
        "phoneNumber": vacancy.phoneNumber,
        if ((vacancy.phoneNumber1 ?? '').isNotEmpty)
          "phoneNumber1": vacancy.phoneNumber1,
        if ((vacancy.phoneNumber2 ?? '').isNotEmpty)
          "phoneNumber2": vacancy.phoneNumber2,
        if ((vacancy.phoneNumber3 ?? '').isNotEmpty)
          "phoneNumber3": vacancy.phoneNumber3,
      };
      final response = await _dio.patch(
        ApiConstants.updateVacancy(vacancy.vacancyId!),
        data: data,
      );

      if (response.statusCode == 200) {
        return Right(Vacancy.fromMap(response.data));
      } else {
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
      final response = await _dio.patch(
        ApiConstants.changeVacancyStatusById(vacancy.vacancyId!),
        data: {"status": "deactivated"},
      );

      if (response.statusCode == 200) {
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
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, void>> deleteVacancyById({
    required int vacancyId,
  }) async {
    try {
      final response = await _dio.delete(
        ApiConstants.deleteVacancyById(vacancyId),
      );

      if (response.statusCode == 204) {
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
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, void>> liftUpVacancyById({
    required int vacancyId,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.liftUpVacancyById(vacancyId),
      );

      if (response.statusCode == 204) {
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
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, void>> toggleFavorite({required int vacancyId}) async {
    try {
      final response = await _dio.post(
        ApiConstants.toggleVacancyFavorite(vacancyId),
      );

      if (response.statusCode == 204) {
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
