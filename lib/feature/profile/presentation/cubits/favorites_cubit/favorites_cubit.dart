import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:top_jobs/core/helpers/enum_helpers.dart';
import 'package:top_jobs/feature/profile/domain/repository/favorites_repository.dart';
import 'package:top_jobs/feature/services/data/models/service.dart';
import 'package:top_jobs/feature/services/domain/repository/service_repository.dart';
import 'package:top_jobs/feature/tasks/data/models/task_model.dart';
import 'package:top_jobs/feature/tasks/domain/repository/task_repository.dart';
import 'package:top_jobs/feature/vacancies/domain/repository/vacancy_repository.dart';
import 'package:top_jobs/models/vacancy.dart';

part 'favorites_state.dart';

part 'favorites_cubit.freezed.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit(
    this._favoritesRepository,
    this._vacancyRepository,
    this._serviceRepository,
    this._taskRepository,
  ) : super(const FavoritesState());

  final FavoritesRepository _favoritesRepository;
  final VacancyRepository _vacancyRepository;
  final ServiceRepository _serviceRepository;
  final TaskRepository _taskRepository;

  Future<void> fetchVacancyFavorites() async {
    emit(state.copyWith(vacancyStatus: RequestStatus.loading));

    final response = await _favoritesRepository.fetchVacancyFavorites();

    response.fold(
      (l) {
        emit(state.copyWith(vacancyStatus: RequestStatus.error));
      },
      (r) {
        emit(
          state.copyWith(vacancyStatus: RequestStatus.loaded, listVacancy: r),
        );
      },
    );
  }

  Future<void> fetchServiceFavorites() async {
    emit(state.copyWith(serviceStatus: RequestStatus.loading));

    final response = await _favoritesRepository.fetchServiceFavorites();
    response.fold(
      (l) {
        emit(state.copyWith(serviceStatus: RequestStatus.error));
      },
      (r) {
        emit(
          state.copyWith(serviceStatus: RequestStatus.loaded, listService: r),
        );
      },
    );
  }

  Future<void> fetchTaskFavorites() async {
    emit(state.copyWith(taskStatus: RequestStatus.loading));
    final response = await _favoritesRepository.fetchTaskFavorites();

    response.fold(
      (l) {
        emit(state.copyWith(taskStatus: RequestStatus.error));
      },
      (r) {
        emit(state.copyWith(taskStatus: RequestStatus.loaded, listTAsk: r));
      },
    );
  }

  Future<void> toggleVacancy(int index) async {
    final oldVacancy = state.listVacancy[index];

    final newVacancies = List<Vacancy>.from(state.listVacancy)..removeAt(index);
    emit(state.copyWith(listVacancy: newVacancies));

    final response = await _vacancyRepository.toggleFavorite(
      vacancyId: oldVacancy.id,
    );
    response.fold((l) {}, (r) {});
  }

  Future<void> toggleService(int index) async {
    final oldService = state.listService[index];

    final newService = List<ServiceModel>.from(state.listService)
      ..removeAt(index);

    emit(state.copyWith(listService: newService));

    final response = await _serviceRepository.toggleServiceById(
      serviceId: oldService.id,
    );
    response.fold((l) {}, (r) {});
  }

  Future<void> toggleTask(int index) async {
    final oldTask = state.listTAsk[index];

    final newTasks = List<TaskModel>.from(state.listTAsk)..removeAt(index);
    emit(state.copyWith(listTAsk: newTasks));

    final response = await _taskRepository.toggleTaskById(taskId: oldTask.id);
    response.fold((l) {}, (r) {});
  }
}
