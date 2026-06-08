import 'package:equatable/equatable.dart';
import 'package:top_jobs/core/helpers/date_time_parser.dart';

class FeedbackModel extends Equatable {
  final String id;
  final String receiverType;
  final String receiverId;
  final String? senderId;
  final DateTime? createdAt;
  final bool? like;
  final bool? dislike;
  final String? message;
  final Map<String, dynamic>? metaData;
  final String? status;
  final String? senderName;
  final String? senderAvatarUrl;

  const FeedbackModel({
    required this.id,
    required this.receiverType,
    required this.receiverId,
    this.senderId,
    this.createdAt,
    this.like,
    this.dislike,
    this.message,
    this.metaData,
    this.status,
    this.senderName,
    this.senderAvatarUrl,
  });

  @override
  List<Object?> get props => [
    id,
    receiverType,
    receiverId,
    senderId,
    createdAt,
    like,
    dislike,
    message,
    metaData,
    status,
    senderName,
    senderAvatarUrl,
  ];

  static FeedbackModel fromMap(Map<String, dynamic> data) {
    final sender = data['sender'];
    final senderMap =
        sender is Map<String, dynamic> ? sender : <String, dynamic>{};
    final rawMetaData = data['meta_data'];

    return FeedbackModel(
      id: data['id']?.toString() ?? '',
      receiverType: data['receiver_type']?.toString() ?? '',
      receiverId: data['receiver_id']?.toString() ?? '',
      senderId: data['sender_id']?.toString(),
      createdAt: parseNullableDateTime(data['created_at']),
      like: data['like'] as bool?,
      dislike: data['dislike'] as bool?,
      message: data['message']?.toString(),
      metaData:
          rawMetaData is Map<String, dynamic>
              ? Map<String, dynamic>.from(rawMetaData)
              : null,
      status: data['status']?.toString(),
      senderName: senderMap['full_name']?.toString(),
      senderAvatarUrl: _senderAvatarUrl(senderMap['avatar']),
    );
  }

  static String? _senderAvatarUrl(dynamic avatar) {
    if (avatar is String && avatar.isNotEmpty) {
      return avatar;
    }
    if (avatar is Map<String, dynamic>) {
      final url = avatar['url'] ?? avatar['original'];
      if (url != null && url.toString().isNotEmpty) {
        return url.toString();
      }
      final urls = avatar['urls'];
      if (urls is Map<String, dynamic>) {
        final original = urls['original'];
        if (original != null && original.toString().isNotEmpty) {
          return original.toString();
        }
      }
    }
    return null;
  }

  FeedbackModel copyWith({
    String? id,
    String? receiverType,
    String? receiverId,
    String? senderId,
    DateTime? createdAt,
    bool? like,
    bool? dislike,
    String? message,
    Map<String, dynamic>? metaData,
    String? status,
    String? senderName,
    String? senderAvatarUrl,
  }) {
    return FeedbackModel(
      id: id ?? this.id,
      receiverType: receiverType ?? this.receiverType,
      receiverId: receiverId ?? this.receiverId,
      senderId: senderId ?? this.senderId,
      createdAt: createdAt ?? this.createdAt,
      like: like ?? this.like,
      dislike: dislike ?? this.dislike,
      message: message ?? this.message,
      metaData: metaData ?? this.metaData,
      status: status ?? this.status,
      senderName: senderName ?? this.senderName,
      senderAvatarUrl: senderAvatarUrl ?? this.senderAvatarUrl,
    );
  }
}
