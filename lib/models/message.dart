import 'package:equatable/equatable.dart';
import 'package:top_jobs/core/helpers/date_time_parser.dart';
import 'package:top_jobs/models/user.dart';
import 'package:top_jobs/models/vacancy.dart';

import '../feature/services/data/models/service.dart';
import '../feature/tasks/data/models/task_model.dart';
import 'message_record.dart';

class Message extends Equatable {
  final String id;
  final String senderId;
  final User? sender;
  final String? receiverId;
  final User? receiver;
  final String? adType;
  final String? adId;
  final Vacancy? vacancy;
  final ServiceModel? service;
  final TaskModel? task;
  final DateTime? createdAt;
  final MessageRecord? lastRecord;
  final bool? hasNewRecord;

  Message({
    required this.id,
    required this.senderId,
    required this.sender,
    required this.receiverId,
    required this.receiver,
    this.adType,
    this.adId,
    this.vacancy,
    this.service,
    this.task,
    this.createdAt,
    this.lastRecord,
    this.hasNewRecord,
  });

  @override
  List<Object?> get props => [
    id,
    senderId,
    sender,
    receiverId,
    receiver,
    adType,
    adId,
    task,
    createdAt,
    lastRecord,
  ];

  static Message fromMap(Map<String, dynamic> data) {
    final senderId =
        data['sender_id']?.toString() ??
        data['sender']?['id']?.toString() ??
        '';
    final receiverId =
        data['receiver_id']?.toString() ?? data['receiver']?['id']?.toString();

    return Message(
      id: data['id']?.toString() ?? '',
      senderId: senderId,
      sender: _messageUserFromMap(data['sender'], fallbackId: senderId),
      receiverId: receiverId,
      receiver: _messageUserFromMap(data['receiver'], fallbackId: receiverId),
      adType: data['ad_type']?.toString(),
      adId: data['ad_id']?.toString(),
      vacancy:
          data['vacancy'] != null ? Vacancy.fromMap(data['vacancy']) : null,
      service:
          data['service'] != null
              ? ServiceModel.fromMap(data['service'])
              : null,
      task: data['task'] != null ? TaskModel.fromJson(data['task']) : null,
      createdAt: parseNullableDateTime(data['created_at']),
      lastRecord:
          data['last_record'] != null
              ? MessageRecord.fromMap(data['last_record'])
              : null,
      hasNewRecord: data['has_new_record'],
    );
  }

  Message copyWith({
    String? id,
    String? senderId,
    User? sender,
    String? receiverId,
    User? receiver,
    String? adType,
    String? adId,
    Vacancy? vacancy,
    ServiceModel? service,
    TaskModel? task,
    DateTime? createdAt,
    MessageRecord? lastRecord,
    bool? hasNewRecord,
  }) {
    return Message(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      sender: sender ?? this.sender,
      receiverId: receiverId ?? this.receiverId,
      receiver: receiver ?? this.receiver,
      adType: adType ?? this.adType,
      adId: adId ?? this.adId,
      vacancy: vacancy ?? this.vacancy,
      service: service ?? this.service,
      task: task ?? this.task,
      createdAt: createdAt ?? this.createdAt,
      lastRecord: lastRecord ?? this.lastRecord,
      hasNewRecord: hasNewRecord ?? this.hasNewRecord,
    );
  }
}

User? _messageUserFromMap(dynamic source, {String? fallbackId}) {
  if (source == null && (fallbackId == null || fallbackId.isEmpty)) {
    return null;
  }

  final data =
      source is Map<String, dynamic>
          ? Map<String, dynamic>.from(source)
          : source is Map
          ? Map<String, dynamic>.fromEntries(
            source.entries.map(
              (entry) => MapEntry(entry.key.toString(), entry.value),
            ),
          )
          : <String, dynamic>{};

  if ((data['id'] == null || data['id'].toString().isEmpty) &&
      fallbackId != null &&
      fallbackId.isNotEmpty) {
    data['id'] = fallbackId;
  }

  final avatar = data['avatar'];
  if (avatar is String && avatar.isNotEmpty) {
    data['avatar'] = {'url': avatar};
  }

  data.putIfAbsent('likes_count', () => 0);
  data.putIfAbsent('dislikes_count', () => 0);
  data.putIfAbsent('phone_verified', () => false);

  if ((data['full_name'] == null || data['full_name'].toString().isEmpty) &&
      fallbackId != null &&
      fallbackId.isNotEmpty) {
    data['full_name'] = fallbackId;
  }

  return User.fromMap(data);
}
