import 'package:equatable/equatable.dart';
import 'package:top_jobs/core/helpers/date_time_parser.dart';
import 'package:top_jobs/models/file.dart';
import 'package:top_jobs/models/user.dart';

class MessageRecord extends Equatable {
  final String? id;
  final String? messageId;
  final String senderId;
  final User sender;
  final String? receiverId;
  final User? receiver;
  final bool read;
  final String body;
  final DateTime createdAt;
  final File? file;
  final bool? isDeleted;

  MessageRecord({
    required this.id,
    required this.messageId,
    required this.senderId,
    required this.sender,
    required this.receiverId,
    required this.receiver,
    required this.read,
    required this.body,
    required this.createdAt,
    this.file,
    this.isDeleted,
  });

  @override
  List<Object?> get props => [
    id,
    messageId,
    senderId,
    sender,
    receiverId,
    receiver,
    read,
    body,
    createdAt,
    file,
  ];

  static MessageRecord fromMap(Map<String, dynamic> data) {
    final createdAt = parseRequiredDateTime(data['created_at']);
    final senderId =
        data['sender_id']?.toString() ??
        data['sender']?['id']?.toString() ??
        '';
    final receiverId =
        data['receiver_id']?.toString() ?? data['receiver']?['id']?.toString();

    return MessageRecord(
      id: data['id']?.toString(),
      messageId: data['message_id']?.toString(),
      senderId: senderId,
      sender: _messageRecordUserFromMap(data['sender'], fallbackId: senderId),
      receiverId: receiverId,
      receiver: _messageRecordUserFromMap(
        data['receiver'],
        fallbackId: receiverId,
      ),
      read: data['read'] == true,
      body: data['body']?.toString() ?? '',
      createdAt: createdAt,
      isDeleted: data['is_deleted'],
      file: _messageFileFromSource(data['file'], createdAt: createdAt),
    );
  }

  MessageRecord copyWith({
    String? id,
    String? messageId,
    String? senderId,
    User? sender,
    String? receiverId,
    User? receiver,
    bool? read,
    String? body,
    DateTime? createdAt,
    File? file,
    bool? isDeleted,
  }) {
    return MessageRecord(
      id: id ?? this.id,
      messageId: messageId ?? this.messageId,
      senderId: senderId ?? this.senderId,
      sender: sender ?? this.sender,
      receiverId: receiverId ?? this.receiverId,
      receiver: receiver ?? this.receiver,
      read: read ?? this.read,
      body: body ?? this.body,
      createdAt: createdAt ?? this.createdAt,
      file: file ?? this.file,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}

User _messageRecordUserFromMap(dynamic source, {String? fallbackId}) {
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

File? _messageFileFromSource(dynamic source, {required DateTime createdAt}) {
  if (source == null) {
    return null;
  }

  if (source is Map<String, dynamic>) {
    return File.fromMap(source);
  }

  if (source is Map) {
    return File.fromMap(
      Map<String, dynamic>.fromEntries(
        source.entries.map(
          (entry) => MapEntry(entry.key.toString(), entry.value),
        ),
      ),
    );
  }

  final url = source.toString();
  if (url.isEmpty) {
    return null;
  }

  final fileName =
      Uri.parse(url).pathSegments.isEmpty
          ? url.split('/').last
          : Uri.parse(url).pathSegments.last;
  final dotIndex = fileName.lastIndexOf('.');
  final originalName =
      dotIndex > 0 ? fileName.substring(0, dotIndex) : fileName;
  final extension = dotIndex > 0 ? fileName.substring(dotIndex + 1) : '';

  return File(
    id: 0,
    url: url,
    createdAt: createdAt,
    originalName: originalName,
    extension: extension,
    mimeType: '',
  );
}
