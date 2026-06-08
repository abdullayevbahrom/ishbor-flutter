import 'package:dartz/dartz.dart';

import '../../../../core/network/api_http.dart';

abstract class MyTasksRepository{
  Future<Either<Failure, void>> changeStatusById({
    required dynamic taskId,
    required String status,
  });
}