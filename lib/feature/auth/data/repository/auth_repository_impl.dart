import 'package:dartz/dartz.dart';
import 'package:top_jobs/core/network/api_http.dart';
import 'package:top_jobs/feature/auth/data/datasource/auth_data_source.dart';
import 'package:top_jobs/feature/auth/data/models/auth_success.dart';
import 'package:top_jobs/feature/auth/data/models/check_model.dart';
import 'package:top_jobs/feature/auth/data/models/request/params.dart';
import 'package:top_jobs/feature/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource _authDatasource;

  AuthRepositoryImpl(this._authDatasource);

  @override
  Future<Either<Failure, void>> sendCodeAgain({
    required String phoneNumber,
  }) async {
    final response = await _authDatasource.sendCodeAgain(
      phoneNumber: phoneNumber,
    );
    return response.fold(
      (l) {
        return Left(Failure(message: l.message));
      },
      (r) {
        return Right(r);
      },
    );
  }

  @override
  Future<Either<Failure, bool>> checkPhone({
    required String phoneNumber,
  }) async {
    final response = await _authDatasource.checkPhone(phoneNumber: phoneNumber);
    return response.fold(
      (l) {
        return Left(Failure(message: l.message));
      },
      (r) {
        return Right(r);
      },
    );
  }

  @override
  Future<Either<Failure, AuthSuccess>> checkSmsCode({
    required String phoneNumber,
    required String code,
  }) async {
    final response = await _authDatasource.checkSmsCode(
      phoneNumber: phoneNumber,
      code: code,
    );
    return response.fold(
      (l) {
        return Left(Failure(message: l.message));
      },
      (r) {
        return Right(r);
      },
    );
  }

  @override
  Future<Either<Failure, AuthSuccess>> smsRegistration({
    required SmsRegistrationParams params,
  }) async {
    final response = await _authDatasource.smsRegistration(params: params);
    return response.fold(
      (l) {
        return Left(Failure(message: l.message));
      },
      (r) {
        return Right(r);
      },
    );
  }

  @override
  Future<Either<Failure, AuthSuccess>> checkAuth({
    required CheckModel checkModel,
  }) async {
    final response = await _authDatasource.checkAuth(checkModel: checkModel);

    return response.fold(
      (l) {
        return Left(Failure(message: l.message));
      },
      (r) {
        return Right(r);
      },
    );
  }
}
