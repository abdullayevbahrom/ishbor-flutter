import 'package:dartz/dartz.dart';
import 'package:top_jobs/core/network/api_http.dart';
import 'package:top_jobs/feature/common/data/datasource/category_datasource.dart';
import 'package:top_jobs/feature/common/data/models/category.dart';
import 'package:top_jobs/feature/common/domain/repository/category_repository.dart';

import '../../../vacancies/data/models/vacancy_query_params.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  final CategoryDataSource _categoryDataSource;

  CategoryRepositoryImpl(this._categoryDataSource);

  @override
  Future<Either<Failure, CategoryListResponse>> fetchCategories({
    required QueryParams queryParams,
  }) {
    return _categoryDataSource.fetchCategories(queryParams: queryParams);
  }

  @override
  Future<Either<Failure, CategoryListResponse>> fetchPopularCategories({
    String? city,
    int? size,
  }) {
    return _categoryDataSource.fetchPopularCategories(city: city, size: size);
  }

  @override
  Future<Either<Failure, CategoryModel>> fetchCategoryById({
    required Object id,
  }) {
    return _categoryDataSource.fetchCategoryById(id: id);
  }
}
