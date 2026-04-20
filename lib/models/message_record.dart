
import 'package:equatable/equatable.dart';
import 'package:top_jobs/core/helpers/date_time_parser.dart';
import 'package:top_jobs/models/file.dart';
import 'package:top_jobs/models/user.dart';


class MessageRecord extends Equatable {
  final int? id;
  final User sender;
  final User receiver;
  final bool read;
  final String body;
  final DateTime createdAt;
  final File? file;
  final bool? isDeleted;

  MessageRecord(
      {required this.id,
      required this.sender,
      required this.receiver,
      required this.read,
      required this.body,
      required this.createdAt,
      this.file,
      this.isDeleted});

  @override
  List<Object?> get props => [id, sender, receiver, read, body, createdAt, file];

  static MessageRecord fromMap(Map<String, dynamic> data) {
    return MessageRecord(
      id: data['id'],
      sender: User.fromMap(data['sender']),
      receiver: User.fromMap(data['receiver']),
      read: data['read'],
      body: data['body'],
      createdAt: parseRequiredDateTime(data['created_at']),
      isDeleted: data['is_deleted'],
      file: data['file'] != null ? File.fromMap(data['file']) : null,
    );
  }

  MessageRecord copyWith({
    int? id,
    User? sender,
    User? receiver,
    bool? read,
    String? body,
    DateTime? createdAt,
    File? file,
    bool? isDeleted,
  }) {
    return MessageRecord(
      id: id ?? this.id,
      sender: sender ?? this.sender,
      receiver: receiver ?? this.receiver,
      read: read ?? this.read,
      body: body ?? this.body,
      createdAt: createdAt ?? this.createdAt,
      file: file ?? this.file,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

}
