import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:top_jobs/core/constants/api_const.dart';
import 'package:top_jobs/core/network/api_http.dart';
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

  Future<Either<Failure, AuthSuccess>> refresh({
    required String refreshToken,
  });

  Future<Either<Failure, void>> logout({required String refreshToken});
}

class AuthDataSourceImpl extends AuthDatasource {
  AuthDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<Either<Failure, void>> sendCodeAgain({
    required String phoneNumber,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.authRequestCode,
        data: {'phone_number': phoneNumber},
      );

      if (response.statusCode == 200) {
        return const Right(null);
      }

      return Left(Failure(message: _messageFromResponse(response.data)));
    } on DioException catch (e) {
      final failure = DioFailure.fromDioError(e);
      return Left(Failure(message: failure.message));
    } catch (e) {
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
        ApiConstants.authRequestCode,
        data: {'phone_number': phoneNumber},
      );

      if (response.statusCode == 200) {
        final payload = _payload(response.data);
        return Right(payload['exists'] == true);
      }

      return Left(Failure(message: _messageFromResponse(response.data)));
    } on DioException catch (e) {
      final failure = DioFailure.fromDioError(e);
      return Left(Failure(message: failure.message));
    } catch (e) {
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
        ApiConstants.authVerifyCode,
        data: {'phone_number': phoneNumber, 'code': code},
      );

      if (response.statusCode == 200) {
        return Right(AuthSuccess.fromJson(_payload(response.data)));
      }

      return Left(Failure(message: _messageFromResponse(response.data)));
    } on DioException catch (e) {
      final failure = DioFailure.fromDioError(e);
      return Left(Failure(message: failure.message));
    } catch (e) {
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
        ApiConstants.authRegister,
        data: {
          'phone_number': params.phoneNumber,
          'code': params.code,
          'type': params.userType,
          'first_name': params.firstName,
          if ((params.lastName ?? '').isNotEmpty) 'last_name': params.lastName,
          if ((params.middleName ?? '').isNotEmpty)
            'middle_name': params.middleName,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(AuthSuccess.fromJson(_payload(response.data)));
      }

      return Left(Failure(message: _messageFromResponse(response.data)));
    } on DioException catch (e) {
      final failure = DioFailure.fromDioError(e);
      return Left(Failure(message: failure.message));
    } catch (e) {
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
        ApiConstants.authVerifyCode,
        data: {
          'phone_number': checkModel.name,
          'code': checkModel.password,
        },
      );

      if (response.statusCode == 200) {
        return Right(AuthSuccess.fromJson(_payload(response.data)));
      }

      return Left(Failure(message: _messageFromResponse(response.data)));
    } on DioException catch (e) {
      final failure = DioFailure.fromDioError(e);
      return Left(Failure(message: failure.message));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, AuthSuccess>> refresh({
    required String refreshToken,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.authRefresh,
        data: {'refresh_token': refreshToken},
        options: Options(extra: {'skip_authorization': true}),
      );

      if (response.statusCode == 200) {
        return Right(AuthSuccess.fromJson(_payload(response.data)));
      }

      return Left(Failure(message: _messageFromResponse(response.data)));
    } on DioException catch (e) {
      final failure = DioFailure.fromDioError(e);
      return Left(Failure(message: failure.message));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, void>> logout({required String refreshToken}) async {
    try {
      final response = await _dio.post(
        ApiConstants.authLogout,
        data: {'refresh_token': refreshToken},
        options: Options(extra: {'skip_authorization': true}),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return const Right(null);
      }

      return Left(Failure(message: _messageFromResponse(response.data)));
    } on DioException catch (e) {
      final failure = DioFailure.fromDioError(e);
      return Left(Failure(message: failure.message));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Map<String, dynamic> _payload(dynamic responseData) {
    if (responseData is Map<String, dynamic>) {
      final data = responseData['data'];
      if (data is Map<String, dynamic>) {
        return Map<String, dynamic>.from(data);
      }
      return Map<String, dynamic>.from(responseData);
    }

    return <String, dynamic>{};
  }

  String _messageFromResponse(dynamic responseData) {
    if (responseData is Map<String, dynamic>) {
      final firstValue = responseData.values.isNotEmpty ? responseData.values.first : 'Unknown error';
      return (
        responseData['message'] ??
        responseData['error'] ??
        firstValue
      ).toString();
    }

    return responseData?.toString() ?? 'Unknown error';
  }
}
