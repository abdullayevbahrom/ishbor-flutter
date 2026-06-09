import 'package:dartz/dartz.dart';
import '../../../../core/network/api_http.dart';

abstract class RealtimeRepository {
  Future<Either<Failure, void>> heartbeat();
  Future<Either<Failure, Map<String, dynamic>>> checkUserStatus(Object userId);
}
