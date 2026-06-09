import 'ad.dart';

abstract class AdPricable extends Ad {
  final double? price;

  AdPricable({
    required super.id,
    required super.status,
    required super.title,
    required super.createdAt,
    super.description,
    super.shortDescription,
    required super.customer,
    super.phoneNumber,
    super.performer,
    super.viewCount,
    super.city,
    super.moderatorNote,
    required super.categories,
    super.images,
    super.negotiable,
    super.isFavorite,
    super.hasUserRequest,
    this.price,
  });
}
