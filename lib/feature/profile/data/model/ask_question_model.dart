class SendMessageRequest {
  final int receiver;
  final int? service;
  final int? vacancy;
  final int? task;
  final String body;

  SendMessageRequest({
    required this.receiver,
    this.service,
    required this.body,
    this.vacancy,
    this.task,
  });

  Map<String, dynamic> toJson() {
    return {
      'receiver': receiver,
      if (service != null) 'service': service,
      if (vacancy != null) 'vacancy': vacancy,
      if (task != null) 'task': task,
      'body': body,
    };
  }

  factory SendMessageRequest.fromJson(Map<String, dynamic> json) {
    return SendMessageRequest(
      receiver: json['receiver'],
      service: json['service'],
      body: json['body'],
    );
  }
}
