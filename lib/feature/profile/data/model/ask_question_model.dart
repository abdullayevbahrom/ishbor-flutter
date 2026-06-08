class SendMessageRequest {
  final String receiverId;
  final String adType;
  final String adId;
  final String body;
  final String? messageId;

  SendMessageRequest({
    required this.receiverId,
    required this.adType,
    required this.adId,
    required this.body,
    this.messageId,
  });

  Map<String, dynamic> toJson() {
    return {
      'receiver_id': receiverId,
      'ad_type': adType,
      'ad_id': adId,
      'body': body,
      if (messageId != null && messageId!.isNotEmpty) 'message_id': messageId,
    };
  }

  factory SendMessageRequest.fromJson(Map<String, dynamic> json) {
    return SendMessageRequest(
      receiverId: json['receiver_id']?.toString() ?? '',
      adType: json['ad_type']?.toString() ?? '',
      adId: json['ad_id']?.toString() ?? '',
      body: json['body']?.toString() ?? '',
      messageId: json['message_id']?.toString(),
    );
  }
}
