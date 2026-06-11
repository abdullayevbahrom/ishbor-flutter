import 'dart:core';

import 'package:top_jobs/core/helpers/date_time_parser.dart';
import 'package:top_jobs/models/ad_customer.dart';
import 'package:top_jobs/models/api_model_utils.dart';
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

  static Task fromMap(dynamic source) {
    final payload = unwrapData(source);
    return Task(
      id: stringValue(payload['id']) ?? '',
      status: stringValue(payload['status']) ?? '',
      title: LocalizedText.fromJson(payload['title']),
      description:
          payload['description'] != null
              ? LocalizedText.fromJson(payload['description'])
              : null,
      shortDescription:
          payload['short_description'] != null
              ? LocalizedText.fromJson(payload['short_description'])
              : null,
      categories: mappedList(payload['categories'], CategoryModel.fromMap),
      startsAt: parseNullableDateTime(payload['starts_at']),
      expiresAt: parseNullableDateTime(payload['expires_at']),
      addresses: mappedList(payload['addresses'], AddressModel.fromJson),
      customer: AdCustomer.fromJson(
        payload['customer'] ?? payload['user'] ?? payload['owner'],
      ),
      phoneNumber: stringValue(payload['phone_number']),
      performer:
          payload['performer'] != null ? User.fromMap(payload['performer']) : null,
      price: doubleValue(payload['price']),
      viewCount: intValue(payload['view_count']),
      city: stringValue(payload['city']),
      images: mappedList(payload['images'], AppImage.fromJson),
      paymentMethods: stringList(payload['payment_methods']),
      negotiable: boolValue(payload['negotiable']) ?? false,
      remote: boolValue(payload['remote']) ?? false,
      secureDeal: boolValue(payload['secure_deal']) ?? false,
      compensation: boolValue(payload['compensation']) ?? false,
      moderatorNote: stringValue(payload['moderator_note']),
      createdAt: parseRequiredDateTime(payload['created_at']),
      isFavorite: boolValue(payload['is_favorite']),
      hasUserRequest: boolValue(payload['has_user_request']),
    );
  }
}
