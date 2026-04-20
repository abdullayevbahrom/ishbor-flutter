import 'package:dartz/dartz.dart';

import 'package:top_jobs/core/network/api_http.dart';
import 'package:top_jobs/feature/profile/data/datasource/favorites_datasource.dart';

import 'package:top_jobs/feature/services/data/models/service.dart';

import 'package:top_jobs/feature/tasks/data/models/task_model.dart';

import 'package:top_jobs/models/vacancy.dart';

import '../../domain/repository/favorites_repository.dart';

class FavoritesRepositoryImpl extends FavoritesRepository {
  final FavoritesDataSource _favoritesDataSource;

  FavoritesRepositoryImpl(this._favoritesDataSource);

  @override
  Future<Either<Failure, List<ServiceModel>>> fetchServiceFavorites() async {
    final response = await _favoritesDataSource.fetchServiceFavorites();

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
  Future<Either<Failure, List<TaskModel>>> fetchTaskFavorites() async {
    final response = await _favoritesDataSource.fetchTaskFavorites();
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
  Future<Either<Failure, List<Vacancy>>> fetchVacancyFavorites() async {
    final response = await _favoritesDataSource.fetchVacancyFavorites();

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
