import 'package:dartz/dartz.dart';

import '../../../../core/network/api_http.dart';
import '../../data/models/reports_param.dart';

abstract class ReportsRepository {
  Future<Either<Failure, void>> reportAd({required ReportsParam params});
}
