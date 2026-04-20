class ReportsParam {
  final int? userId;
  final int? taskId;
  final int? serviceId;
  final int? vacancyId;
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
