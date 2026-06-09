import 'dart:core';

import 'package:top_jobs/core/helpers/date_time_parser.dart';
import 'package:top_jobs/models/ad_customer.dart';
import 'package:top_jobs/models/localized_text.dart';
import 'package:top_jobs/models/user.dart';

import '../feature/common/data/models/category.dart';
import 'ad_pricable.dart';
import 'address.dart';
import 'image.dart';

class Task extends AdPricable {
  final DateTime? startsAt;
  final DateTime? expiresAt;
  final List<AddressModel> addresses;
  final List<String>? paymentMethods;
  final bool remote;
  final bool? secureDeal;
  final bool? compensation;

  Task({
    required super.id,
    required super.status,
    required super.title,
    super.description,
    super.shortDescription,
    required super.categories,
    required this.startsAt,
    required this.expiresAt,
    required this.addresses,
    required super.customer,
    super.phoneNumber,
    super.performer,
    super.price,
    super.viewCount,
    super.city,
    super.images,
    this.paymentMethods,
    super.negotiable,
    this.remote = false,
    this.secureDeal,
    this.compensation,
    super.moderatorNote,
    required super.createdAt,
    super.isFavorite,
    super.hasUserRequest,
  });

  @override
  List<Object?> get props => [
        ...super.props,
        startsAt,
        expiresAt,
        addresses,
        paymentMethods,
        remote,
        secureDeal,
        compensation,
      ];

  static Task fromMap(Map<String, dynamic> data) {
    return Task(
      id: data['id']?.toString() ?? '',
      status: data['status']?.toString() ?? '',
      title: LocalizedText.fromJson(data['title']),
      description: data['description'] != null ? LocalizedText.fromJson(data['description']) : null,
      shortDescription: data['short_description'] != null ? LocalizedText.fromJson(data['short_description']) : null,
      categories: (data['categories'] as List?)?.map((cat) => CategoryModel.fromMap(cat)).toList() ?? [],
      startsAt: parseNullableDateTime(data['starts_at']),
      expiresAt: parseNullableDateTime(data['expires_at']),
      addresses: (data['addresses'] as List?)?.map((address) => AddressModel.fromJson(address)).toList() ?? [],
      customer: AdCustomer.fromJson(data['customer'] ?? data['user'] ?? data['owner']),
      phoneNumber: data['phone_number']?.toString(),
      performer: data['performer'] != null ? User.fromMap(data['performer']) : null,
      price: (data['price'] as num?)?.toDouble(),
      viewCount: data['view_count'] is num ? (data['view_count'] as num).toInt() : null,
      city: data['city']?.toString(),
      images: (data['images'] as List?)?.map((img) => AppImage.fromMap(Map.from(img))).toList() ?? [],
      paymentMethods: (data['payment_methods'] as List?)?.map((e) => e.toString()).toList(),
      negotiable: data['negotiable'] == true,
      remote: data['remote'] == true,
      secureDeal: data['secure_deal'] == true,
      compensation: data['compensation'] == true,
      moderatorNote: data['moderator_note']?.toString(),
      createdAt: parseRequiredDateTime(data['created_at']),
      isFavorite: data['is_favorite'] == true,
      hasUserRequest: data['has_user_request'] == true,
    );
  }
}
