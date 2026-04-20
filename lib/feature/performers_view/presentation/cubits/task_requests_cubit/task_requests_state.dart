part of 'task_requests_cubit.dart';

@freezed
abstract class TaskRequestsState with _$TaskRequestsState {
  const factory TaskRequestsState({
    @Default(RequestStatus.initial) RequestStatus status,
    @Default(RequestStatus.initial) RequestStatus choosePerformerSt,
    @Default(RequestStatus.initial) RequestStatus cancelPerformerSt,
    @Default(RequestStatus.initial) RequestStatus finishTaskSt,
    @Default(null) PaginatedTaskRequestList? listTaskRequest,
    @Default(null) TaskModel? task,
    @Default(null) TaskRequest? taskRequest
  }) = _TaskRequestsState;
}
