import 'package:equatable/equatable.dart';
import 'package:top_jobs/models/file.dart';
import 'package:top_jobs/models/image.dart';

import '../feature/common/data/models/category.dart';

class User extends Equatable {
  final int id;
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
    contentLimit
  ];

  static User fromMap(Map<String, dynamic> data) => User(
    id: data['id'],
    contentCount: data['content_count'],
    contentLimit: data['content_limit'],
    chatGptLimit: data['chat_gpt_limit'],
    phoneNumber: data['phone_number'],
    email: data['email'],
    fullName: data['full_name'],
    firstName: data['first_name'],
    lastName: data['last_name'],
    middleName: data['middle_name'],
    birthDay:
        data['birth_day'] != null ? DateTime.tryParse(data['birth_day']) : null,
    avatar:
        data['avatar'] != null && data['avatar']['urls'] != null
            ? AppImage.fromMap(Map.from(data['avatar']))
            : null,
    categories:
        List.from(
          data['categories'],
        ).map((cat) => CategoryModel.fromMap(cat)).toList(),
    portfolios:
        List.from(
          data['portfolios'],
        ).map((img) => AppImage.fromMap(Map.from(img))).toList(),
    uploadedPortfolios:
        List.from(
          data['uploaded_portfolios'],
        ).map((img) => AppImage.fromMap(Map.from(img))).toList(),
    city: data['city'],
    gender: data['gender'],
    locale: data['locale'],
    timezone: data['timezone'],
    likesCount: data['likes_count'],
    dislikesCount: data['dislikes_count'],
    configured: data['configured'],
    phoneNumberVerified: data['phone_verified'],
    verified: data['verified'],
    documentVerified: data['document_verified'],
    active: data['active'],
    balance:
        (data['balance'] is int)
            ? (data['balance'] as int).toDouble()
            : data['balance'],
    online: data['online'],
    createdAt:
        data['created_at'] != null
            ? DateTime.tryParse(data['created_at'])
            : null,
    updatedAt:
        data['updated_at'] != null
            ? DateTime.tryParse(data['updated_at'])
            : null,
    lastActiveTime:
        data['last_active_time'] != null
            ? DateTime.tryParse(data['last_active_time'])
            : null,
    logoutTime:
        data['logout_time'] != null
            ? DateTime.tryParse(data['logout_time'])
            : null,
    aboutMe: data['about_me'],
    verificationDoc:
        data['verification_doc'] != null &&
                data['verification_doc']['url'] != null
            ? File.fromMap(Map.from(data['verification_doc']))
            : null,
  );
}
