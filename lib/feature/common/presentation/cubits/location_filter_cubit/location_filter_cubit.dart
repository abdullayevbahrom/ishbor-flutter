import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:top_jobs/core/helpers/enum_helpers.dart';
import 'package:top_jobs/core/router/app_routes.dart';
import 'package:top_jobs/core/router/route_names.dart';
import 'package:top_jobs/feature/common/data/models/map_filter_query.dart';
import 'package:top_jobs/feature/services/domain/repository/service_repository.dart';
import 'package:top_jobs/feature/tasks/data/models/task_model.dart';
import 'package:top_jobs/feature/tasks/domain/repository/task_repository.dart';
import 'package:top_jobs/feature/vacancies/domain/repository/vacancy_repository.dart';

import '../../../../../models/vacancy.dart';
import '../../../../services/data/models/service.dart';

part 'location_filter_state.dart';

part 'location_filter_cubit.freezed.dart';

class LocationFilterCubit extends Cubit<LocationFilterState> {
  LocationFilterCubit(
    this._vacancyRepository,
    this._serviceRepository,
    this._taskRepository,
  ) : super(const LocationFilterState());

  final VacancyRepository _vacancyRepository;
  final ServiceRepository _serviceRepository;
  final TaskRepository _taskRepository;

  Future<void> fetchVacanciesGeo(LocationFilterModel queryParams) async {
    emit(state.copyWith(status: RequestStatus.loading));
    final response = await _vacancyRepository.fetchVacanciesGeo(
      queryParams: queryParams,
    );

    response.fold(
      (l) {
        emit(state.copyWith(status: RequestStatus.error, errorText: l.message));
      },
      (r) {
        emit(state.copyWith(status: RequestStatus.loaded, listVacancy: r));
        navigatorKey.currentContext!.push(Routes.map, extra: {"vacancy": r});
      },
    );
  }

  Future<void> fetchServiceGeo(LocationFilterModel queryParams) async {
    emit(state.copyWith(status: RequestStatus.loading));
    final response = await _serviceRepository.fetchServiceGeo(
      query: queryParams,
    );

    response.fold(
      (l) {
        emit(state.copyWith(status: RequestStatus.error, errorText: l.message));
      },
      (r) {
        emit(state.copyWith(status: RequestStatus.loaded, listService: r));
        navigatorKey.currentContext!.push(Routes.map, extra: {"service": r});
      },
    );
  }

  Future<void> fetchTaskGeo(LocationFilterModel queryParams) async {
    emit(state.copyWith(status: RequestStatus.loading));
    final response = await _taskRepository.fetchTaskGeo(query: queryParams);

    response.fold(
      (l) {
        emit(state.copyWith(status: RequestStatus.error, errorText: l.message));
      },
      (r) {
        emit(state.copyWith(status: RequestStatus.loaded, listTask: r));
        navigatorKey.currentContext!.push(Routes.map, extra: {"task": r});
      },
    );
  }
}
