import 'package:dartz/dartz.dart';

import '../../../../core/network/api_http.dart';

abstract class MyVacanciesRepository{
  Future<Either<Failure, void>> changeVacancyStatus({
    required String status,
    required int vacancyId,
  });
}