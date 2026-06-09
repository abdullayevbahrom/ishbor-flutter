import 'package:dartz/dartz.dart';
import '../../../../core/network/api_http.dart';
import '../../../../models/tag.dart';
import '../../../../models/third_party_ad.dart';

abstract class CatalogRepository {
  Future<Either<Failure, List<TagModel>>> fetchTags({
    int? page,
    int? size,
  });

  Future<Either<Failure, TagModel>> fetchTagById({required Object id});

  Future<Either<Failure, List<ThirdPartyAd>>> fetchBanners({
    int? page,
    int? size,
  });
}
