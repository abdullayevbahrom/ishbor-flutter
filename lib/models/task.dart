import 'dart:core';

import 'package:top_jobs/core/helpers/date_time_parser.dart';
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
    id,
    status,
    title,
    description,
    categories,
    required this.startsAt,
    required this.expiresAt,
    required this.addresses,
    customer,
    phoneNumber,
    performer,
    price,
    viewCount,
    city,
    images,
    shortDescription,
    this.paymentMethods,
    negotiable,
    this.remote = false,
    this.secureDeal,
    this.compensation,
    moderatorNote,
    createdAt
  }) : super(
    id: id,
    price: price,
    status: status,
    title: title,
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
    createdAt: createdAt
  );

  @override
  List<Object?> get props => [id, status, title, description, categories, startsAt, expiresAt, addresses, customer, phoneNumber, performer, price, paymentMethods, negotiable, remote, secureDeal, compensation, moderatorNote];

  static Task fromMap(Map<String, dynamic> data) {
    return Task(
        id: data['id'],
        status: data['status'],
        title: data['title'],
        description: data['description'] ?? '',
        categories: List.from(data['categories']).map((cat) => CategoryModel.fromMap(cat)).toList(),
        startsAt: parseNullableDateTime(data['starts_at']),
        expiresAt: parseNullableDateTime(data['expires_at']),
        addresses: List.from(data['addresses']).map((address) => AddressModel.fromJson(address)).toList(),
        customer: User.fromMap(data['customer']),
        phoneNumber: data['phone_number'],
        performer: data['performer'] != null ? User.fromMap(data['performer']) : null,
        price: data['price'],
        paymentMethods: List.from(data['payment_methods']).isNotEmpty ? List.from(data['payment_methods']) : [],
        negotiable: data['negotiable'],
        remote: data['remote'],
        secureDeal: data['secure_deal'],
        compensation: data['compensation'],
        moderatorNote: data['moderator_note'],
        images: List.from(data['images']).map((img) => AppImage.fromMap(Map.from(img))).toList(),
        createdAt: parseRequiredDateTime(data['created_at']),
        shortDescription: data['short_description'] ?? '',
        city: data['city'],
        viewCount: data['view_count']
    );
  }
}
