import 'package:dartz/dartz.dart';

import '../../../../core/exceptions/failure.dart';

abstract class MyServiceRepository{
  Future<Either<Failure, void>> changeStatusById({
    required int serviceId,
    required String status,
  });
}