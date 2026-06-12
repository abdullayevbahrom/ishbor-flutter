import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:top_jobs/core/constants/api_const.dart';
import 'package:top_jobs/core/network/api_http.dart';
import 'package:top_jobs/feature/performers_view/data/models/paginated_vacancy_requests.dart';
import 'package:top_jobs/models/vacancy_request.dart';

abstract class VacancyRequestDataSource {
  Future<Either<Failure, VacancyRequest>> applyRequestVacancy({
    required Object vacancyId,
    required String message,
  });

  Future<Either<Failure, VacancyRequest>> ownRequestsVacancy({
    required Object vacancyId,
  });

  Future<Either<Failure, PaginatedVacancyRequestList>> listRequestsByVacancy({
    required Object vacancyId,
    int? page,
    int? size,
    String? status,
  });

  Future<Either<Failure, PaginatedVacancyRequestList>> listAllRequests({
    int? page,
    int? size,
    String? status,
  });

  Future<Either<Failure, VacancyRequest>> getRequestDetail({
    required Object requestId,
  });

  Future<Either<Failure, VacancyRequest>> changeStatus({
    required Object requestId,
    required String status,
  });

  Future<Either<Failure, void>> deleteRequest({required Object requestId});
}

class VacancyRequestDataSourceImpl extends VacancyRequestDataSource {
  final Dio _dio;

  VacancyRequestDataSourceImpl(this._dio);

  @override
  Future<Either<Failure, VacancyRequest>> applyRequestVacancy({
    required Object vacancyId,
    required String message,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.applyVacancy(vacancyId),
        data: {"message": message},
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return Right(
          VacancyRequest.fromMap(response.data['data'] ?? response.data),
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
  Future<Either<Failure, VacancyRequest>> ownRequestsVacancy({
    required Object vacancyId,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.fetchOwnVacancyRequest(vacancyId),
      );
      if (response.statusCode == 200) {
        if (response.data['data'] == null) {
          return Left(Failure(message: "Not found"));
        }
        return Right(VacancyRequest.fromMap(response.data['data']));
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
  Future<Either<Failure, PaginatedVacancyRequestList>> listRequestsByVacancy({
    required Object vacancyId,
    int? page,
    int? size,
    String? status,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.fetchListVacancyRequests(vacancyId),
        queryParameters: {
          if (page != null) 'page': page,
          if (size != null) 'size': size,
          if (status != null) 'status': status,
        },
      );
      if (response.statusCode == 200) {
        return Right(PaginatedVacancyRequestList.fromMap(response.data));
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
  Future<Either<Failure, PaginatedVacancyRequestList>> listAllRequests({
    int? page,
    int? size,
    String? status,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.vacancyRequests,
        queryParameters: {
          if (page != null) 'page': page,
          if (size != null) 'size': size,
          if (status != null) 'status': status,
        },
      );
      if (response.statusCode == 200) {
        return Right(PaginatedVacancyRequestList.fromMap(response.data));
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
  Future<Either<Failure, VacancyRequest>> getRequestDetail({
    required Object requestId,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.fetchVacancyRequest(requestId),
      );
      if (response.statusCode == 200) {
        return Right(
          VacancyRequest.fromMap(response.data['data'] ?? response.data),
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
  Future<Either<Failure, VacancyRequest>> changeStatus({
    required Object requestId,
    required String status,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.changeVacancyRequestStatus(requestId),
        data: {'status': status},
      );
      if (response.statusCode == 200) {
        return Right(
          VacancyRequest.fromMap(response.data['data'] ?? response.data),
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
  Future<Either<Failure, void>> deleteRequest({
    required Object requestId,
  }) async {
    try {
      final response = await _dio.delete(
        ApiConstants.deleteVacancyRequest(requestId),
      );
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

  String _extractMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data['message']?.toString() ?? data.toString();
    }
    return data?.toString() ?? 'Unknown error';
  }
}
