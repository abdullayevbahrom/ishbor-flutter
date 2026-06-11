import 'package:dartz/dartz.dart';
import 'package:top_jobs/core/network/api_http.dart';
import 'package:top_jobs/feature/common/data/datasource/ai_datasource.dart';
import 'package:top_jobs/feature/common/domain/repository/ai_repository.dart';

class AiRepositoryImpl extends AiRepository {
  final AiDataSource _aiDataSource;

  AiRepositoryImpl(this._aiDataSource);

  @override
  Future<Either<Failure, Map<String, dynamic>>> analyzeAdDraft({
    required String prompt,
  }) {
    return _aiDataSource.analyzeAdDraft(prompt: prompt);
  }

  @override
  Stream<String> streamDescription({required String prompt}) {
    return _aiDataSource.streamDescription(prompt: prompt);
  }
}
