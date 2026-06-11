import 'package:top_jobs/core/helpers/date_time_parser.dart';
import 'package:top_jobs/models/ad_customer.dart';
import 'package:top_jobs/models/ad_pricable.dart';
import 'package:top_jobs/models/address.dart';
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

  static Service fromMap(Map<String, dynamic> data) => Service(
    id: data['id']?.toString() ?? '',
    status: data['status']?.toString() ?? '',
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
    phoneNumber: data['phone_number']?.toString(),
    performer:
        data['performer'] != null ? User.fromMap(data['performer']) : null,
    viewCount:
        data['view_count'] is num ? (data['view_count'] as num).toInt() : null,
    city: data['city']?.toString(),
    moderatorNote: data['moderator_note']?.toString(),
    categories:
        (data['categories'] as List?)
            ?.map((cat) => CategoryModel.fromMap(cat))
            .toList() ??
        [],
    address:
        data['address'] != null ? AddressModel.fromJson(data['address']) : null,
    images:
        (data['images'] as List?)
            ?.map((img) => AppImage.fromMap(Map.from(img)))
            .toList() ??
        [],
    negotiable: data['negotiable'] == true,
    price: (data['price'] as num?)?.toDouble(),
    isFavorite: data['is_favorite'] == true,
    hasUserRequest: data['has_user_request'] == true,
  );
}
