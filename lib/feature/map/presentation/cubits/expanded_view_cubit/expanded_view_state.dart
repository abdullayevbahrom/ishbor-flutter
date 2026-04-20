part of 'expanded_view_cubit.dart';

@freezed
abstract class ExpandedViewState with _$ExpandedViewState {
  const factory ExpandedViewState({
    @Default([]) List<Vacancy> vacancyList,
    @Default([]) List<ServiceModel> serviceList,
    @Default([]) List<TaskModel> taskList,
  }) = _ExpandedViewState;
}
