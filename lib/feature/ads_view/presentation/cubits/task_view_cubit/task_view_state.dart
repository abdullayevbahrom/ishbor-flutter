part of 'task_view_cubit.dart';

@freezed
abstract class TaskViewState with _$TaskViewState {
  const factory TaskViewState({
    @Default(RequestStatus.initial) RequestStatus status,
    @Default(RequestStatus.initial) RequestStatus similarTasksSt,
    @Default(RequestStatus.initial) RequestStatus requestTasksSt,
    @Default(RequestStatus.initial) RequestStatus ownTaskRequestSt,
    @Default(false) bool isLoadingMore,
    @Default(null) TaskModel? task,
    @Default(null)  PaginatedTaskListResponse? listTasks,
    @Default(null) TaskRequest? myRequest,
    @Default(null) int? taskId
  }) = _TaskViewState;
}
