import 'package:dartz/dartz.dart';
import 'package:top_jobs/core/network/api_http.dart';
import 'package:top_jobs/feature/common/data/datasource/cities_datasource.dart';
import 'package:top_jobs/feature/common/data/models/cities_list.dart';
import 'package:top_jobs/feature/common/domain/repository/cities_repository.dart';

class CitiesRepositoryImpl extends CitiesRepository {
  final CitiesDataSource _citiesDataSource;

  CitiesRepositoryImpl(this._citiesDataSource);

  @override
  Future<Either<Failure, CitiesList>> fetchCities() async {
    final response = await _citiesDataSource.fetchCities();

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
