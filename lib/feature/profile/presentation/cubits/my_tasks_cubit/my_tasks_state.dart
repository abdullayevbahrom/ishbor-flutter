part of 'my_tasks_cubit.dart';

@freezed
abstract class MyTasksState with _$MyTasksState {
  const factory MyTasksState({
    @Default(RequestStatus.initial) RequestStatus myTaskSt,
    @Default(RequestStatus.initial) RequestStatus myTaskAppliesSt,
    @Default(RequestStatus.initial) RequestStatus liftUpTaskSt,
    @Default(RequestStatus.initial) RequestStatus deactivateTaskSt,
    @Default(RequestStatus.initial) RequestStatus deleteTaskSt,
    @Default(false) bool isLoadingMore1,
    @Default(false) bool isLoadingMore2,
    @Default(null) PaginatedTaskListResponse? myTasks,
    @Default(null)  PaginatedTaskResponse? myTaskApplies,
    @Default(null) String? errorText,
  }) = _MyTasksState;
}
