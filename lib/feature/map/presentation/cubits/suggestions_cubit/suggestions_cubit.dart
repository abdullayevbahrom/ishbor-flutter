import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:top_jobs/core/helpers/enum_helpers.dart';
import 'package:top_jobs/feature/map/domain/repository/yandex_repository.dart';

import '../../../../../core/router/app_routes.dart';

part 'suggestions_state.dart';

part 'suggestions_cubit.freezed.dart';

class SuggestionsCubit extends Cubit<SuggestionsState> {
  SuggestionsCubit(this._yandexRepository) : super(const SuggestionsState());
  final YandexRepository _yandexRepository;
  final TextEditingController searchController = TextEditingController();
  void clearController() {
    searchController.clear();
    emit(state.copyWith(suggestions: []));
  }

  Future<void> fetchSuggestions() async {
    emit(state.copyWith(status: RequestStatus.loading));
    final response = await _yandexRepository.fetchSuggestionsByQuery(
      search: searchController.text.trim(),
      language:
          navigatorKey.currentContext?.locale.languageCode == 'ru'
              ? "ru_RU"
              : "uz_UZ",
    );

    response.fold(
      (l) {
        emit(state.copyWith(status: RequestStatus.error));
      },
      (r) {
        emit(state.copyWith(status: RequestStatus.loaded, suggestions: r));
      },
    );
  }
}
