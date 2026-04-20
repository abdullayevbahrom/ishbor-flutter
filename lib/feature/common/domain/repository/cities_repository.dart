import 'package:dartz/dartz.dart';

import '../../../../core/network/api_http.dart';
import '../../data/models/cities_list.dart';

abstract class CitiesRepository{
  Future<Either<Failure, CitiesList>> fetchCities();

}