class FeedbackRequestModel {
  final String? message;
  final int? receiver;
  final bool? like;
  final bool? dislike;
  final int? task;
  final int? vacancy;
  final int? service;

  FeedbackRequestModel({
    this.message,
    this.receiver,
    this.like,
    this.dislike,
    this.task,
    this.vacancy,
    this.service,
  });

  factory FeedbackRequestModel.fromJson(Map<String, dynamic> json) {
    return FeedbackRequestModel(
      message: json['message'] as String?,
      receiver: json['receiver'] as int?,
      like: json['like'] as bool?,
      dislike: json['dislike'] as bool?,
      task: json['task'] as int?,
      vacancy: json['vacancy'] as int?,
      service: json['service'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (message != null) 'message': message,
      if (receiver != null) 'receiver': receiver,
      if (like != null) 'like': like,
      if (dislike != null) 'dislike': dislike,
      if (task != null) 'task': task,
      if (vacancy != null) 'vacancy': vacancy,
      if (service != null) 'service': service,
    };
  }
}
