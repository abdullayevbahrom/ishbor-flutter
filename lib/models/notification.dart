import 'package:equatable/equatable.dart';
import 'package:top_jobs/models/user.dart';

class Notification extends Equatable {

  final int id;
  final String type;
  final String operation;
  final String operationId;
  final User receiver;
  final bool read;
  final String title;
  final String body;

  Notification({
    required this.id,
    required this.type,
    required this.operation,
    required this.operationId,
    required this.receiver,
    required this.read,
    required this.title,
    required this.body
  });

  @override
  List<Object> get props => [id, type, operation, operationId, receiver, read, title, body];

  static Notification fromMap(Map<String, dynamic> data) {
    return Notification(
      id: data['id'],
      type: data['type'],
      operation: data['operation'],
      operationId: data['operation_id'].toString(),
      receiver: User.fromMap(data['receiver']),
      title: data['title'],
      body: data['body'],
      read: data['read'],
    );
  }
}
