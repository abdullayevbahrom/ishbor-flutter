import 'package:dartz/dartz.dart';
import 'package:top_jobs/core/network/api_http.dart';
import 'package:top_jobs/feature/common/data/datasource/catalog_datasource.dart';
import 'package:top_jobs/feature/common/domain/repository/catalog_repository.dart';
import 'package:top_jobs/models/tag.dart';
import 'package:top_jobs/models/third_party_ad.dart';

class CatalogRepositoryImpl extends CatalogRepository {
  final CatalogDataSource _catalogDataSource;

  CatalogRepositoryImpl(this._catalogDataSource);

  @override
  Future<Either<Failure, List<TagModel>>> fetchTags({
    int? page,
    int? size,
  }) {
    return _catalogDataSource.fetchTags(page: page, size: size);
  }

  @override
  Future<Either<Failure, TagModel>> fetchTagById({required Object id}) {
    return _catalogDataSource.fetchTagById(id: id);
  }

  @override
  Future<Either<Failure, List<ThirdPartyAd>>> fetchBanners({
    int? page,
    int? size,
  }) {
    return _catalogDataSource.fetchBanners(page: page, size: size);
  }
}
