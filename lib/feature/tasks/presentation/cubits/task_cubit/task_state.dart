part of 'task_cubit.dart';

@freezed
abstract class TaskState with _$TaskState {
  const factory TaskState({
    @Default(RequestStatus.initial) RequestStatus status,
    @Default(RequestStatus.initial) RequestStatus similarTasSt,
    @Default(null) String? errorText,
    @Default(null) PaginatedTaskListResponse? listTask,
    @Default(null) PaginatedTaskListResponse? listSimilarTask,
    @Default(false) bool isLoadingMore
  }) = _TaskState;
}
