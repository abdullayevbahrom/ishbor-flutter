import 'package:equatable/equatable.dart';
import 'package:top_jobs/models/ad_customer.dart';
import 'package:top_jobs/models/image.dart';
import 'package:top_jobs/models/localized_text.dart';
import 'package:top_jobs/models/user.dart';

import '../feature/common/data/models/category.dart';

abstract class Ad extends Equatable {
  final String id;
  final String status;
  final LocalizedText title;
  final DateTime createdAt;
  final LocalizedText? description;
  final LocalizedText? shortDescription;
  final AdCustomer customer;
  final String? phoneNumber;
  final User? performer;
  final int? viewCount;
  final String? city;
  final String? moderatorNote;
  final List<CategoryModel> categories;
  final bool? negotiable;
  final List<AppImage>? images;
  final bool? isFavorite;
  final bool? hasUserRequest;

  const Ad({
    required this.id,
    required this.status,
    required this.title,
    required this.createdAt,
    this.description,
    this.shortDescription,
    required this.customer,
    this.phoneNumber,
    this.performer,
    this.viewCount,
    this.city,
    this.moderatorNote,
    required this.categories,
    this.negotiable,
    this.images,
    this.isFavorite,
    this.hasUserRequest,
  });

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
        negotiable,
        images,
        isFavorite,
        hasUserRequest,
      ];
}
