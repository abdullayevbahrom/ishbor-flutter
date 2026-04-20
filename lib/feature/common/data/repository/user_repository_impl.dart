import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:top_jobs/core/network/api_http.dart';
import 'package:top_jobs/feature/common/data/datasource/user_data_source.dart';
import 'package:top_jobs/feature/common/data/models/user_update_request.dart';
import 'package:top_jobs/feature/common/domain/repository/user_repository.dart';
import 'package:top_jobs/models/user.dart';

class UserRepositoryImpl extends UserRepository {
  final UserDataSource _dataSource;

  UserRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, User>> fetchUser() async {
    final response = await _dataSource.fetchUser();

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
  Future<Either<Failure, User>> editUser({
    required UserProfileUpdateRequest userProfile,
  }) async {
    final response = await _dataSource.editUser(userProfile: userProfile);
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
  Future<Either<Failure, User>> uploadPortfolios({
    required List<File> portfolios,
  }) async {
    final response = await _dataSource.uploadPortfolios(portfolios: portfolios);
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
  Future<Either<Failure, User>> uploadVerificationDoc({
    required File file,
  }) async {
    final response = await _dataSource.uploadVerificationDoc(file: file);
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
  Future<Either<Failure, void>> updateLocale({required String locale}) async {
    final response = await _dataSource.updateLocale(locale: locale);
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
  Future<Either<Failure, User>> uploadAvatar({required File file}) async {
    final response = await _dataSource.uploadAvatar(file: file);
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
