import 'package:dartz/dartz.dart';

import '../../../../core/network/api_http.dart';
import '../../../../models/vacancy.dart';
import '../../../services/data/models/service.dart';
import '../../../tasks/data/models/task_model.dart';

abstract class FavoritesRepository {
  Future<Either<Failure, List<Vacancy>>> fetchVacancyFavorites();

  Future<Either<Failure, List<ServiceModel>>> fetchServiceFavorites();

  Future<Either<Failure, List<TaskModel>>> fetchTaskFavorites();
}
