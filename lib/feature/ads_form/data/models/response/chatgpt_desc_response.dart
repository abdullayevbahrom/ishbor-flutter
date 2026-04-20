class ChatGptDescResponse {
  final bool ok;
  final String result;

  const ChatGptDescResponse({required this.ok, required this.result});

  factory ChatGptDescResponse.fromJson(Map<String, dynamic> json) {
    return ChatGptDescResponse(
      ok: json['ok'] == true,
      result: json['result']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'ok': ok, 'result': result};
  }

  ChatGptDescResponse copyWith({bool? ok, String? result}) {
    return ChatGptDescResponse(
      ok: ok ?? this.ok,
      result: result ?? this.result,
    );
  }

  @override
  String toString() =>
      'VacancyResponse(ok: $ok, result length: ${result.length})';
}
