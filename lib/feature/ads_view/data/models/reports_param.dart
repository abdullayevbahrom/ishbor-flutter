class ReportsParam {
  final String? userId;
  final dynamic taskId;
  final dynamic serviceId;
  final dynamic vacancyId;
  final String body;

  ReportsParam({
    this.userId,
    this.taskId,
    this.serviceId,
    this.vacancyId,
    required this.body,
  });

  Map<String, dynamic> toJson() {
    return {
      if (userId != null) "user": userId,
      if (vacancyId != null) "vacancy": vacancyId,
      if (serviceId != null) "service": serviceId,
      if (taskId != null) "task": taskId,
      "body": body,
    };
  }
}
