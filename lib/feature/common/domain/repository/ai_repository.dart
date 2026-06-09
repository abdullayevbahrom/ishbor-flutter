import 'package:dartz/dartz.dart';
import '../../../../core/network/api_http.dart';

abstract class AiRepository {
  Future<Either<Failure, Map<String, dynamic>>> analyzeAdDraft({required String prompt});
  Stream<String> streamDescription({required String prompt});
}
