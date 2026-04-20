part of 'notification_details_cubit.dart';

@freezed
abstract class NotificationDetailsState with _$NotificationDetailsState {
  const factory NotificationDetailsState({
    @Default(RequestStatus.initial) RequestStatus status,
    @Default(null) String? errorText,
    @Default(null) Vacancy? vacancy,
    @Default(null) ServiceModel? service,
    @Default(null) TaskModel? task,
    @Default(null) Message? message,
}) = _NotificationDetailsState;
}
