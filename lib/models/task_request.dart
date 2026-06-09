import 'package:top_jobs/core/helpers/date_time_parser.dart';
import 'package:top_jobs/models/user.dart';

import '../feature/tasks/data/models/task_model.dart';
import 'ad_request.dart';

class TaskRequest extends AdRequest {
  final TaskModel? task;
  final double price;

  TaskRequest({
    required super.id,
    required this.task,
    required super.performer,
    required super.status,
    required this.price,
    super.message,
    required super.createdAt,
  });

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
      id: data['id']?.toString() ?? '',
      task: data['task'] != null ? TaskModel.fromJson(data['task']) : null,
      performer: User.fromMap(data['performer']),
      price: (data['price'] as num?)?.toDouble() ?? 0.0,
      status: data['status']?.toString() ?? '',
      message: data['message']?.toString(),
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
