import 'package:dartz/dartz.dart';
import 'package:top_jobs/core/network/api_http.dart';
import 'package:top_jobs/feature/ads_view/data/datasource/report_datasource.dart';
import 'package:top_jobs/feature/ads_view/data/models/reports_param.dart';
import 'package:top_jobs/feature/ads_view/domain/repository/reports_repository.dart';

class ReportsRepositoryImpl implements ReportsRepository {
  final ReportsDataSource _reportsDataSource;

  ReportsRepositoryImpl(this._reportsDataSource);

  @override
  Future<Either<Failure, void>> reportAd({
    required ReportsParam params,
  }) async {
    final response= await _reportsDataSource.reportAd(params: params);

    return response.fold((l) {
      return Left(Failure(message: l.message));
    }, (r) {
      return Right(r);
    },);
  }
}
