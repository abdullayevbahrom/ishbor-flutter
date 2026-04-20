part of 'chat_cubit.dart';

@freezed
abstract class ChatState with _$ChatState {
  const factory ChatState({
    @Default(null)int? messageId,
    @Default(RequestStatus.initial) RequestStatus messageSt,
    @Default(RequestStatus.initial) RequestStatus fetchSt,
    @Default(RequestStatus.initial) RequestStatus sendSt,
    @Default(null) PaginatedMessageRecordResponse? messageRecords,
    @Default(null) Message? message,
    @Default(null) String? errorText,
    @Default(false) bool needToDownload,
    @Default(false) bool isDownloading,
    @Default(false) bool isLoadingMore,
    @Default(false) bool enableDownIcon,
    @Default([]) List<dynamic> sendingMessages
  }) = _ChatState;
}
