import 'package:dartz/dartz.dart';

import '../../../../core/network/api_http.dart';

abstract class MyTasksRepository{
  Future<Either<Failure, void>> changeStatusById({
    required int taskId,
    required String status,
  });
}