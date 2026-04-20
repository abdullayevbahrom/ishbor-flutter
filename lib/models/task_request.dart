import 'package:top_jobs/core/helpers/date_time_parser.dart';
import 'package:top_jobs/models/user.dart';

import '../feature/tasks/data/models/task_model.dart';
import 'ad_request.dart';

class TaskRequest extends AdRequest {
  final TaskModel? task;
  final double price;

  TaskRequest({
    required id,
    required this.task,
    required performer,
    required status,
    required this.price,
    message,
    required createdAt,
  }) : super(
         id: id,
         performer: performer,
         status: status,
         createdAt: createdAt,
         message: message,
       );

  @override
  List<Object?> get props => [
    id,
    task,
    performer,
    status,
    price,
    message,
    createdAt,
  ];

  static TaskRequest fromMap(Map<String, dynamic> data) {
    return TaskRequest(
      id: data['id'],
      task: data['task'] != null ? TaskModel.fromJson(data['task']) : null,
      performer: User.fromMap(data['performer']),
      price: data['price'],
      status: data['status'],
      message: data['message'] != null ? data['message'] : null,
      createdAt: parseRequiredDateTime(data['created_at']),
    );
  }

  TaskRequest copyWith({
    String? id,
    TaskModel? task,
    User? performer,
    String? status,
    double? price,
    String? message,
    DateTime? createdAt,
  }) {
    return TaskRequest(
      id: id ?? this.id,
      task: task ?? this.task,
      performer: performer ?? this.performer,
      status: status ?? this.status,
      price: price ?? this.price,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
