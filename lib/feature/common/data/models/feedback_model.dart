class FeedbackRequestModel {
  final String? message;
  final String? receiverType;
  final String? receiverId;
  final bool? like;
  final bool? dislike;

  FeedbackRequestModel({
    this.message,
    this.receiverType,
    this.receiverId,
    this.like,
    this.dislike,
  });

  factory FeedbackRequestModel.fromJson(Map<String, dynamic> json) {
    return FeedbackRequestModel(
      message: json['message'] as String?,
      receiverType: json['receiver_type']?.toString(),
      receiverId: json['receiver_id']?.toString(),
      like: json['like'] as bool?,
      dislike: json['dislike'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (message != null) 'message': message,
      if (receiverType != null) 'receiver_type': receiverType,
      if (receiverId != null) 'receiver_id': receiverId,
      if (like != null) 'like': like,
      if (dislike != null) 'dislike': dislike,
    };
  }
}
