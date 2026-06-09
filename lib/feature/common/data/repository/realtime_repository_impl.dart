import 'package:dartz/dartz.dart';
import 'package:top_jobs/core/network/api_http.dart';
import 'package:top_jobs/feature/common/data/datasource/realtime_datasource.dart';
import 'package:top_jobs/feature/common/domain/repository/realtime_repository.dart';

class RealtimeRepositoryImpl extends RealtimeRepository {
  final RealtimeDataSource _realtimeDataSource;

  RealtimeRepositoryImpl(this._realtimeDataSource);

  @override
  Future<Either<Failure, void>> heartbeat() {
    return _realtimeDataSource.heartbeat();
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> checkUserStatus(Object userId) {
    return _realtimeDataSource.checkUserStatus(userId);
  }
}
