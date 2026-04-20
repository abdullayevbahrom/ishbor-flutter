import 'package:equatable/equatable.dart';
import 'package:top_jobs/models/image.dart';
import 'package:top_jobs/models/user.dart';

import '../feature/common/data/models/category.dart';

abstract class Ad extends Equatable {
  final int id;
  final String status;
  final String title;
  final DateTime createdAt;
  final String? description;
  final String? shortDescription;
  final User customer;
  final String? phoneNumber;
  final User? performer;
  final int? viewCount;
  final String? city;
  final String? moderatorNote;
  final List<CategoryModel> categories;
  final bool? negotiable;
  final List<AppImage>? images;
  final String? titleUz;
  final String? titleRu;
  final String? descriptionUz;
  final String? descriptionRu;
  final String? shortDescriptionUz;
  final String? shortDescriptionRu;

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
    required this.viewCount,
    this.city,
    this.moderatorNote,
    required this.categories,
    this.negotiable,
    this.images,
    this.titleUz,
    this.titleRu,
    this.descriptionUz,
    this.descriptionRu,
    this.shortDescriptionUz,
    this.shortDescriptionRu,
  });
}
