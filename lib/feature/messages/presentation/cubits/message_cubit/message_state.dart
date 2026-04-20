part of 'message_cubit.dart';

@freezed
abstract class MessageState with _$MessageState {
  const factory MessageState({
    @Default(RequestStatus.initial) RequestStatus status,
    @Default(false) bool isLoading,
    @Default(null) PaginatedChatMessageResponse? messages,
    @Default(false) bool hasUnreadMessage
  }) = _MessageState;
}
