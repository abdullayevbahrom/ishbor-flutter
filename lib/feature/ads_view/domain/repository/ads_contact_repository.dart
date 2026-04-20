import 'package:dartz/dartz.dart';

import '../../../../core/exceptions/failure.dart';
import '../../data/models/ads_contact_model.dart';

abstract class AdsContactRepository{
  Future<Either<Failure, AdsContactModel>> fetchVacancyContact({
    required int vacancyId,
  });

  Future<Either<Failure, AdsContactModel>> fetchServiceContact({
    required int serviceId,
  });

  Future<Either<Failure, AdsContactModel>> fetchTaskContact({
    required int taskId,
  });
}