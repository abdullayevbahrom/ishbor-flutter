import 'package:equatable/equatable.dart';
import 'package:top_jobs/models/file.dart';
import 'package:top_jobs/models/image.dart';

import 'api_model_utils.dart';
import '../feature/common/data/models/category.dart';

class User extends Equatable {
  final String id;
  final int? contentCount;
  final int? contentLimit;
  final int? chatGptLimit;
  final String? phoneNumber;
  final String? email;
  final String? fullName;
  final String? firstName;
  final String? lastName;
  final String? middleName;
  final DateTime? birthDay;
  final AppImage? avatar;
  final List<CategoryModel>? categories;
  final List<AppImage>? portfolios;
  final List<AppImage>? uploadedPortfolios;
  final String? city;
  final String? gender;
  final String? locale;
  final String? timezone;
  final int likesCount;
  final int dislikesCount;
  final bool? configured;
  final bool phoneNumberVerified;
  final bool? verified;
  final bool? documentVerified;
  final bool? active;
  final double? balance;
  final bool? online;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? lastActiveTime;
  final DateTime? logoutTime;
  final String? aboutMe;
  final File? verificationDoc;

  User({
    required this.id,
    required this.phoneNumber,
    this.contentLimit,
    this.contentCount,
    this.chatGptLimit,
    this.email,
    this.fullName,
    this.firstName,
    this.lastName,
    this.middleName,
    this.birthDay,
    this.avatar,
    this.categories,
    this.portfolios,
    this.uploadedPortfolios,
    this.city,
    this.gender,
    this.locale,
    this.timezone,
    required this.likesCount,
    required this.dislikesCount,
    this.configured,
    required this.phoneNumberVerified,
    this.verified,
    this.documentVerified,
    this.active,
    this.balance,
    this.online,
    this.createdAt,
    this.updatedAt,
    this.lastActiveTime,
    this.logoutTime,
    this.aboutMe,
    this.verificationDoc,
  });

  @override
  List<Object?> get props => [
    id,
    phoneNumber,
    email,
    fullName,
    firstName,
    lastName,
    middleName,
    birthDay,
    avatar,
    categories,
    portfolios,
    uploadedPortfolios,
    city,
    gender,
    locale,
    timezone,
    likesCount,
    dislikesCount,
    configured,
    phoneNumberVerified,
    verified,
    documentVerified,
    active,
    balance,
    online,
    createdAt,
    updatedAt,
    lastActiveTime,
    logoutTime,
    aboutMe,
    verificationDoc,
    contentCount,
    contentLimit,
  ];

  static User fromMap(dynamic source) {
    final data = unwrapData(source);

    return User(
      id: stringValue(data['id']) ?? '',
      contentCount: intValue(data['content_count']),
      contentLimit: intValue(data['content_limit']),
      chatGptLimit: intValue(data['chat_gpt_limit']),
      phoneNumber: stringValue(data['phone_number'] ?? data['phoneNumber']),
      email: stringValue(data['email']),
      fullName: stringValue(data['full_name'] ?? data['fullName']),
      firstName: stringValue(data['first_name'] ?? data['firstName']),
      lastName: stringValue(data['last_name'] ?? data['lastName']),
      middleName: stringValue(data['middle_name'] ?? data['middleName']),
      birthDay: dateTimeValue(data['birth_day']),
      avatar: data['avatar'] != null ? AppImage.fromJson(data['avatar']) : null,
      categories: mappedList(data['categories'], CategoryModel.fromMap),
      portfolios: mappedList(data['portfolios'], AppImage.fromJson),
      uploadedPortfolios: mappedList(
        data['uploaded_portfolios'],
        AppImage.fromJson,
      ),
      city: stringValue(data['city']),
      gender: stringValue(data['gender']),
      locale: stringValue(data['locale']),
      timezone: stringValue(data['timezone']),
      likesCount: intValue(data['likes_count']) ?? 0,
      dislikesCount: intValue(data['dislikes_count']) ?? 0,
      configured: boolValue(data['configured']),
      phoneNumberVerified: boolValue(data['phone_verified']) ?? false,
      verified: boolValue(data['verified']),
      documentVerified: boolValue(data['document_verified']),
      active: boolValue(data['active']),
      balance: doubleValue(data['balance']),
      online: boolValue(data['online']),
      createdAt: dateTimeValue(data['created_at']),
      updatedAt: dateTimeValue(data['updated_at']),
      lastActiveTime: dateTimeValue(data['last_active_time']),
      logoutTime: dateTimeValue(data['logout_time']),
      aboutMe: stringValue(data['about_me']),
      verificationDoc:
          data['verification_doc'] != null
              ? File.fromJson(data['verification_doc'])
              : null,
    );
  }
}
