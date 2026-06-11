import 'package:top_jobs/core/helpers/date_time_parser.dart';
import 'package:top_jobs/models/ad_customer.dart';
import 'package:top_jobs/models/ad_pricable.dart';
import 'package:top_jobs/models/address.dart';
import 'package:top_jobs/models/api_model_utils.dart';
import 'package:top_jobs/models/localized_text.dart';
import 'package:top_jobs/models/user.dart';

import '../feature/common/data/models/category.dart';
import 'image.dart' show AppImage;

class Service extends AdPricable {
  final AddressModel? address;

  Service({
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
    super.price,
    super.negotiable,
    super.isFavorite,
    super.hasUserRequest,
    this.address,
  });

  @override
  List<Object?> get props => [...super.props, address];

  static Service fromMap(dynamic source) {
    final data = unwrapData(source);

    return Service(
      id: stringValue(data['id']) ?? '',
      status: stringValue(data['status']) ?? '',
      title: LocalizedText.fromJson(data['title']),
      createdAt: parseRequiredDateTime(data['created_at']),
      description:
        data['description'] != null
            ? LocalizedText.fromJson(data['description'])
            : null,
    shortDescription:
        data['short_description'] != null
            ? LocalizedText.fromJson(data['short_description'])
            : null,
    customer: AdCustomer.fromJson(
      data['customer'] ?? data['user'] ?? data['owner'],
    ),
    phoneNumber: stringValue(data['phone_number']),
    performer:
        data['performer'] != null ? User.fromMap(data['performer']) : null,
    viewCount: intValue(data['view_count']),
    city: stringValue(data['city']),
    moderatorNote: stringValue(data['moderator_note']),
    categories: mappedList(data['categories'], CategoryModel.fromMap),
    address:
        data['address'] != null ? AddressModel.fromJson(data['address']) : null,
    images: mappedList(data['images'], AppImage.fromJson),
    negotiable: boolValue(data['negotiable']) ?? false,
    price: doubleValue(data['price']),
    isFavorite: boolValue(data['is_favorite']),
    hasUserRequest: boolValue(data['has_user_request']),
    );
  }
}
