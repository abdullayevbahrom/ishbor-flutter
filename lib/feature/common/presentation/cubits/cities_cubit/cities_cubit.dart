import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:top_jobs/feature/common/domain/repository/cities_repository.dart';

import '../../../../../core/helpers/enum_helpers.dart';
import '../../../data/models/cities_list.dart';

part 'cities_state.dart';

part 'cities_cubit.freezed.dart';

class CitiesCubit extends Cubit<CitiesState> {
  CitiesCubit(this._citiesRepository) : super(const CitiesState());

  final CitiesRepository _citiesRepository;

  Future<void> fetchCities() async {
    emit(state.copyWith(status: RequestStatus.loading));

    final response = await _citiesRepository.fetchCities();

    response.fold(
      (l) {
        emit(state.copyWith(status: RequestStatus.error, errorText: l.message));
      },
      (r) {
        emit(state.copyWith(status: RequestStatus.loaded, listCities: r));
      },
    );
  }
}
