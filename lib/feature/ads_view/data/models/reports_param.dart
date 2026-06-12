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

  String get receiverType {
    if (vacancyId != null) {
      return 'vacancy';
    }
    if (serviceId != null) {
      return 'service';
    }
    if (taskId != null) {
      return 'task';
    }
    return 'user';
  }

  String get receiverId {
    return (vacancyId ?? serviceId ?? taskId ?? userId)?.toString() ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'receiver_type': receiverType,
      'receiver_id': receiverId,
      'body': body,
    };
  }
}
