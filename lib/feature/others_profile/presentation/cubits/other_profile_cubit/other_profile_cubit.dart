import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:top_jobs/core/helpers/enum_helpers.dart';
import 'package:top_jobs/feature/services/domain/repository/service_repository.dart';
import 'package:top_jobs/feature/tasks/domain/repository/task_repository.dart';
import 'package:top_jobs/feature/vacancies/data/models/vacancy_query_params.dart';
import 'package:top_jobs/feature/vacancies/domain/repository/vacancy_repository.dart';
import 'package:top_jobs/models/vacancy.dart';

import '../../../../services/data/models/service.dart';
import '../../../../tasks/data/models/task_model.dart';

part 'other_profile_state.dart';

part 'other_profile_cubit.freezed.dart';

class OtherProfileCubit extends Cubit<OtherProfileState> {
  OtherProfileCubit(
    this._vacancyRepository,
    this._serviceRepository,
    this._taskRepository,
  ) : super(const OtherProfileState());
  final VacancyRepository _vacancyRepository;
  final ServiceRepository _serviceRepository;
  final TaskRepository _taskRepository;

  int pageNumber = 1;
  int pageSize = 10;
  QueryParams _filters = QueryParams.empty();

  QueryParams get filters => _filters;

  void resetFilter() {
    _filters = QueryParams.empty();
  }
/// shu yerda xato bor
  void updateIndex({required int index,required int userId}) {
    emit(state.copyWith(index: index));
    switch (index) {
      case 0:
        if (!state.vacancy.isLoaded()) fetchVacancy(userId);
        break;
      case 1:
        if (!state.service.isLoaded()) fetchServices(userId);
        break;
      case 2:
        if (!state.task.isLoaded()) fetchTasks(userId);
        break;
    }
  }

  Future<void> fetchVacancy(int userId) async {
    emit(state.copyWith(vacancy: RequestStatus.loading, userId: userId));
    final response = await _vacancyRepository.fetchVacancies(
      queryParams: QueryParams(
        size: pageSize,
        page: pageNumber,
        customer: state.userId,
      ),
    );

    response.fold(
      (l) {
        emit(
          state.copyWith(vacancy: RequestStatus.error, vacancyError: l.message),
        );
      },
      (r) {
        emit(state.copyWith(vacancy: RequestStatus.loaded, listVacancy: r));
      },
    );
  }

  Future<void> fetchServices(int userId) async {
    emit(state.copyWith(service: RequestStatus.loading, userId: userId));
    final response = await _serviceRepository.fetchServices(
      queryParams: QueryParams(
        page: pageNumber,
        size: pageSize,
        customer: state.userId,
      ),
    );

    response.fold(
      (l) {
        emit(
          state.copyWith(service: RequestStatus.error, serviceError: l.message),
        );
      },
      (r) {
        emit(state.copyWith(service: RequestStatus.loaded, listService: r));
      },
    );
  }

  Future<void> fetchTasks(int userId) async {
    emit(state.copyWith(task: RequestStatus.loading, userId: userId));
    final response = await _taskRepository.fetchTasks(
      queryParams: QueryParams(
        page: pageNumber,
        size: pageSize,
        customer: state.userId,
      ),
    );

    response.fold(
      (l) {
        emit(state.copyWith(task: RequestStatus.error, taskError: l.message));
      },
      (r) {
        emit(state.copyWith(task: RequestStatus.loaded, listTask: r));
      },
    );
  }
}
