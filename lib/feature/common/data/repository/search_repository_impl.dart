import 'package:dartz/dartz.dart';
import 'package:top_jobs/core/network/api_http.dart';
import 'package:top_jobs/feature/common/data/datasource/search_datasource.dart';
import 'package:top_jobs/feature/common/domain/repository/search_repository.dart';

class SearchRepositoryImpl extends SearchRepository {
  final SearchDataSource _searchDataSource;

  SearchRepositoryImpl(this._searchDataSource);

  @override
  Future<Either<Failure, Map<String, dynamic>>> globalSearch({
    required String query,
    String? type,
    int? limit,
  }) {
    return _searchDataSource.globalSearch(query: query, type: type, limit: limit);
  }
}
