import 'package:dartz/dartz.dart';

import '../../../../core/exceptions/failure.dart';
import '../../data/models/ads_contact_model.dart';

abstract class AdsContactRepository{
  Future<Either<Failure, AdsContactModel>> fetchVacancyContact({
    required dynamic vacancyId,
  });

  Future<Either<Failure, AdsContactModel>> fetchServiceContact({
    required dynamic serviceId,
  });

  Future<Either<Failure, AdsContactModel>> fetchTaskContact({
    required dynamic taskId,
  });
}