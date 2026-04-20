import 'package:dartz/dartz.dart';

import '../../../../core/network/api_http.dart';
import '../../data/models/auth_success.dart';
import '../../data/models/check_model.dart';
import '../../data/models/request/params.dart';

abstract class AuthRepository{
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