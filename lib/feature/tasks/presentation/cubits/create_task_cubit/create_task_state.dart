part of 'create_task_cubit.dart';

@freezed
abstract class CreateTaskState with _$CreateTaskState {
  const factory CreateTaskState({
    @Default(RequestStatus.initial) RequestStatus status,
    @Default(null) TaskModel? task,
    @Default(null) String? errorText,
    @Default(null) String? paymentMethod,
    @Default([]) List<File> images,
    @Default(false) bool isNegotiable,
    @Default(false) bool isRemote,
    @Default(false) bool isUSD,
    @Default(null) int? categoryId,
    @Default(true) bool isStartDateNow,
    @Default(null) String? startDate,
    @Default(null) String? expireDate,
    @Default(null) GeocodeResponse? location

  }) = _CreateTaskState;
}
