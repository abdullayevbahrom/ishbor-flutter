import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:top_jobs/feature/services/data/models/service.dart';
import 'package:top_jobs/feature/services/domain/repository/service_repository.dart';
import 'package:top_jobs/feature/tasks/data/models/task_model.dart';
import 'package:top_jobs/feature/tasks/domain/repository/task_repository.dart';
import 'package:top_jobs/feature/vacancies/domain/repository/vacancy_repository.dart';
import 'package:top_jobs/models/vacancy.dart';

part 'expanded_view_state.dart';

part 'expanded_view_cubit.freezed.dart';

class ExpandedViewCubit extends Cubit<ExpandedViewState> {
  ExpandedViewCubit(
    VacancyRepository vacancyRepository,
    ServiceRepository serviceRepository,
    TaskRepository taskRepository,
  ) : super(const ExpandedViewState());
}
