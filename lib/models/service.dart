
import 'package:top_jobs/core/helpers/date_time_parser.dart';
import 'package:top_jobs/models/ad_pricable.dart';
import 'package:top_jobs/models/address.dart';
import 'package:top_jobs/models/user.dart';

import '../feature/common/data/models/category.dart';
import 'image.dart' show AppImage;


class Service extends AdPricable {

  final AddressModel? address;

  Service({
    id,
    status,
    title,
    createdAt,
    description,
    shortDescription,
    customer,
    phoneNumber,
    performer,
    viewCount,
    city,
    moderatorNote,
    categories,
    images,
    price,
    negotiable,
    this.address
  }) : super(
    id: id,
    status: status,
    title: title,
    createdAt: createdAt,
    categories: categories,
    customer: customer,
    phoneNumber: phoneNumber,
    viewCount: viewCount,
    city: city,
    description: description,
    images: images,
    moderatorNote: moderatorNote,
    negotiable: negotiable,
    performer: performer,
    shortDescription: shortDescription,
    price: price
  );

  @override
  List<Object?> get props => [
    id,
    status,
    title,
    createdAt,
    description,
    shortDescription,
    customer,
    phoneNumber,
    performer,
    viewCount,
    city,
    moderatorNote,
    categories,
    images,
    address
  ];

  static Service fromMap(Map<String, dynamic> data) => Service(
      id: data['id'],
      status: data['status'],
      title: data['title'],
      createdAt: parseRequiredDateTime(data['created_at']),
      description: data['description'] ?? '',
      shortDescription: data['short_description'] ?? '',
      customer: User.fromMap(data['customer']),
      phoneNumber: data['phone_number'],
      performer: data['performer'] != null ? User.fromMap(data['performer']) : null,
      viewCount: data['view_count'],
      city: data['city'],
      moderatorNote: data['moderator_note'],
      categories: List.from(data['categories']).map((cat) => CategoryModel.fromMap(cat)).toList(),
      address: data['address'] != null ? AddressModel.fromJson(data['address']) : null,
      images: List.from(data['images']).map((img) => AppImage.fromMap(Map.from(img))).toList(),
      negotiable: data['negotiable'],
      price: data['price']
    );
}
