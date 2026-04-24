import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:top_jobs/core/network/api_http.dart';
import 'package:top_jobs/core/constants/api_const.dart';
import 'package:top_jobs/feature/auth/data/models/auth_success.dart';

import '../models/check_model.dart';
import '../models/request/params.dart';

abstract class AuthDatasource {
  Future<Either<Failure, AuthSuccess>> checkAuth({
    required CheckModel checkModel,
  });

  Future<Either<Failure, void>> sendCodeAgain({required String phoneNumber});

  Future<Either<Failure, bool>> checkPhone({required String phoneNumber});

  Future<Either<Failure, AuthSuccess>> checkSmsCode({
    required String phoneNumber,
    required String code,
  });

  Future<Either<Failure, AuthSuccess>> smsRegistration({
    required SmsRegistrationParams params,
  });
}

class AuthDataSourceImpl extends AuthDatasource {
  final Dio _dio;

  AuthDataSourceImpl(this._dio);

  @override
  Future<Either<Failure, void>> sendCodeAgain({
    required String phoneNumber,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.sendCodeAgain,
        data: {'phoneNumber': phoneNumber},
      );
      if (response.statusCode == 204 || response.statusCode == 200) {
        return const Right(null);
      } else {
        if (response.data is Map<String, dynamic>) {
          final data = response.data as Map<String, dynamic>;
          final fallback = data.values.isNotEmpty
              ? data.values.first.toString()
              : 'Unknown error';
          return Left(
            Failure(
              message:
                  data['message'] ??
                  data['error'] ??
                  data['phoneNumber'] ??
                  fallback,
            ),
          );
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
  Future<Either<Failure, bool>> checkPhone({
    required String phoneNumber,
  }) async {
    try {
      final response = await _dio.post(
        "security/check-phone",
        data: {"phoneNumber": phoneNumber},
      );
      if (response.statusCode == 200) {
        return Right(response.data['exists']);
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
  Future<Either<Failure, AuthSuccess>> checkSmsCode({
    required String phoneNumber,
    required String code,
  }) async {
    try {
      final response = await _dio.post(
        "security/verify-sms-login",
        data: {"phoneNumber": phoneNumber, "code": code},
      );
      if (response.statusCode == 200) {
        return Right(AuthSuccess.fromJson(response.data));
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
  Future<Either<Failure, AuthSuccess>> smsRegistration({
    required SmsRegistrationParams params,
  }) async {
    try {
      final response = await _dio.post(
        "security/sms-registration",
        data: {
          "phoneNumber": params.phoneNumber,
          "firstName": params.firstName,
          "type": params.userType,
          //"password": params.password,
          if ((params.lastName ?? '').isNotEmpty) "lastName": params.lastName,
          if ((params.middleName ?? '').isNotEmpty)
            "middleName": params.middleName,
        },
      );
      if (response.statusCode == 200) {
        return Right(AuthSuccess.fromJson(response.data));
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
  Future<Either<Failure, AuthSuccess>> checkAuth({
    required CheckModel checkModel,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.loginCheck,
        options: Options(contentType: Headers.formUrlEncodedContentType),
        data: {"_username": checkModel.name, "_password": checkModel.password},
      );

      if (response.statusCode == 200) {
        return Right(AuthSuccess.fromJson(response.data));
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
