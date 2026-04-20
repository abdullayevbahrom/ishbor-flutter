part of 'notification_cubit.dart';

@freezed
abstract class NotificationState with _$NotificationState {
  const factory NotificationState({
    @Default(RequestStatus.initial) RequestStatus status,
    @Default(null) NotificationListResponse? listNotification,
    @Default(null) String? errorText,
    @Default(false) bool hasNewNotification
  }) = _NotificationState;
}
