
import 'package:equatable/equatable.dart';
import 'package:top_jobs/core/helpers/date_time_parser.dart';
import 'package:top_jobs/models/user.dart';
import 'package:top_jobs/models/vacancy.dart';

import '../feature/services/data/models/service.dart';
import '../feature/tasks/data/models/task_model.dart';
import 'message_record.dart';


class Message extends Equatable {
  final int id;
  final User sender;
  final User receiver;
  final Vacancy? vacancy;
  final ServiceModel? service;
  final TaskModel? task;
  final DateTime? createdAt;
  final MessageRecord? lastRecord;
  final bool? hasNewRecord;

  Message(
      {required this.id,
      required this.sender,
      required this.receiver,
      this.vacancy,
      this.service,
      this.task,
      this.createdAt,
      this.lastRecord,
      this.hasNewRecord});

  @override
  List<Object?> get props =>
      [id, sender, receiver, task, createdAt, lastRecord];

  static Message fromMap(Map<String, dynamic> data) {
    return Message(
        id: data['id'],
        sender: User.fromMap(data['sender']),
        receiver: User.fromMap(data['receiver']),
        vacancy:
            data['vacancy'] != null ? Vacancy.fromMap(data['vacancy']) : null,
        service:
            data['service'] != null ? ServiceModel.fromMap(data['service']) : null,
        task: data['task'] != null ? TaskModel.fromJson(data['task']) : null,
        createdAt: parseNullableDateTime(data['created_at']),
        lastRecord: data['last_record'] != null
            ? MessageRecord.fromMap(data['last_record'])
            : null,
        hasNewRecord: data['has_new_record']);
  }

  Message copyWith({
    int? id,
    User? sender,
    User? receiver,
    Vacancy? vacancy,
    ServiceModel? service,
    TaskModel? task,
    DateTime? createdAt,
    MessageRecord? lastRecord,
    bool? hasNewRecord,
  }) {
    return Message(
      id: id ?? this.id,
      sender: sender ?? this.sender,
      receiver: receiver ?? this.receiver,
      vacancy: vacancy ?? this.vacancy,
      service: service ?? this.service,
      task: task ?? this.task,
      createdAt: createdAt ?? this.createdAt,
      lastRecord: lastRecord ?? this.lastRecord,
      hasNewRecord: hasNewRecord ?? this.hasNewRecord,
    );
  }

}
