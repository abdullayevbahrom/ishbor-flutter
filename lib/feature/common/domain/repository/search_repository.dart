import 'package:dartz/dartz.dart';
import '../../../../core/network/api_http.dart';

abstract class SearchRepository {
  Future<Either<Failure, Map<String, dynamic>>> globalSearch({
    required String query,
    String? type,
    int? limit,
  });
}
