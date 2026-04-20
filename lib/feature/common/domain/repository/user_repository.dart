import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:top_jobs/core/network/api_http.dart';
import 'package:top_jobs/models/user.dart';

import '../../data/models/user_update_request.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> fetchUser();

  Future<Either<Failure, User>> editUser({
    required UserProfileUpdateRequest userProfile,
  });

  Future<Either<Failure, User>> uploadPortfolios({required List<File> portfolios});

  Future<Either<Failure, User>> uploadVerificationDoc({required File file});
  Future<Either<Failure, void>> updateLocale({required String locale});
  Future<Either<Failure, User>> uploadAvatar({required File file});

}
