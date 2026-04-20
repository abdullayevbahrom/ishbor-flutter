import 'package:dartz/dartz.dart';

import '../../../../core/network/api_http.dart';
import '../../../../models/vacancy.dart';
import '../../../services/data/models/service.dart';
import '../../../tasks/data/models/task_model.dart';

abstract class AdsViewRepository{
  Future<Either<Failure, Vacancy>> fetchVacancyById({required int vacancyId});

  Future<Either<Failure, ServiceModel>> fetchServiceById(
      {required int serviceId});

  Future<Either<Failure, TaskModel>> fetchTaskById({required int taskId});
}