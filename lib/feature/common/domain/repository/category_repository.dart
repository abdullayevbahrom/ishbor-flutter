import 'package:dartz/dartz.dart';
import 'package:top_jobs/core/network/api_http.dart';
import 'package:top_jobs/feature/common/data/models/category.dart';

import '../../../vacancies/data/models/vacancy_query_params.dart';

abstract class CategoryRepository {
  Future<Either<Failure, CategoryListResponse>> fetchCategories({ required QueryParams queryParams});
}
