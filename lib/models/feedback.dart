
import 'package:equatable/equatable.dart';
import 'package:top_jobs/core/helpers/date_time_parser.dart';
import 'package:top_jobs/models/service.dart';
import 'package:top_jobs/models/task.dart';
import 'package:top_jobs/models/user.dart';
import 'package:top_jobs/models/vacancy.dart';


class FeedbackModel extends Equatable {
  final int id;
  final User sender;
  final User receiver;
  final Task? task;
  final Vacancy? vacancy;
  final Service? service;
  final DateTime? createdAt;
  final bool? like;
  final bool? dislike;
  final String? message;

  FeedbackModel({
    required this.id,
    required this.sender,
    required this.receiver,
    this.task,
    this.vacancy,
    this.service,
     this.createdAt,
    this.like,
    this.dislike,
    this.message
  });

  @override
  List<Object?> get props => [
    id,
    sender,
    receiver,
    task,
    vacancy,
    service,
    createdAt,
    like,
    dislike,
    message
  ];

  static FeedbackModel fromMap(Map<String, dynamic> data) {
    return FeedbackModel(
      id: data['id'],
      sender: User.fromMap(data['sender']),
      receiver: User.fromMap(data['receiver']),
      task: data['task'] != null ? Task.fromMap(data['task']) : null,
      vacancy: data['vacancy'] != null ? Vacancy.fromMap(data['vacancy']) : null,
      service: data['service'] != null ? Service.fromMap(data['service']) : null,
      createdAt: parseNullableDateTime(data['created_at']),
      like: data['like'] != null ? data['like'] : null,
      dislike: data['dislike'] != null ? data['dislike'] : null,
      message: data['message'] != null ? data['message'] : null,
    );
  }

  FeedbackModel copyWith({
    int? id,
    User? sender,
    User? receiver,
    Task? task,
    Vacancy? vacancy,
    Service? service,
    DateTime? createdAt,
    bool? like,
    bool? dislike,
    String? message,
  }) {
    return FeedbackModel(
      id: id ?? this.id,
      sender: sender ?? this.sender,
      receiver: receiver ?? this.receiver,
      task: task ?? this.task,
      vacancy: vacancy ?? this.vacancy,
      service: service ?? this.service,
      createdAt: createdAt ?? this.createdAt,
      like: like ?? this.like,
      dislike: dislike ?? this.dislike,
      message: message ?? this.message,
    );
  }

}
