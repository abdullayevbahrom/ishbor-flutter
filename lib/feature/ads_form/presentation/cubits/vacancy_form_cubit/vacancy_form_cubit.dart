import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/helpers/enum_helpers.dart';
import 'package:top_jobs/core/router/app_routes.dart';
import 'package:top_jobs/core/router/route_names.dart';
import 'package:top_jobs/core/services/storage_service.dart';
import 'package:top_jobs/feature/ads_form/data/models/request/vacancy_params.dart';
import 'package:top_jobs/feature/ads_form/domain/repository/vacancy_form_repository.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_toasttifications.dart';

import '../../../../../core/exceptions/failure.dart';
import '../../../../../models/vacancy.dart';
import '../../../data/models/response/chatgpt_response.dart';
import '../../pages/vacancy_form_page/widgets/vacancy_form_listener.dart';

part 'vacancy_form_state.dart';

part 'vacancy_form_cubit.freezed.dart';

class VacancyFormCubit extends Cubit<VacancyFormState> {
  final VacancyFormRepository _formRepository;
  final StorageService _storageService;

  VacancyFormCubit(this._formRepository, this._storageService, Object? _)
    : super(const VacancyFormState());
  StreamSubscription<Either<Failure, String>>? _sub;

  void continuePublishingAd() {
    navigatorKey.currentContext?.pushReplacement(Routes.vacancyForm);
    emit(state.copyWith(continueUnpublishedAds: true, enableForm: true));
  }

  void initChatGptStatus() {
    emit(state.copyWith(gptDesSt: RequestStatus.initial));
  }

  Future<void> generateVacancyBody(String prompt) async {
    emit(state.copyWith(gptSt: RequestStatus.loading, enableForm: true));

    final response = await _formRepository.generateVacancyBody(prompt: prompt);

    response.fold(
      (l) {
        emit(state.copyWith(gptSt: RequestStatus.error));
      },
      (r) {
        emit(state.copyWith(gptSt: RequestStatus.loaded, vacancyBody: r));
      },
    );
  }

  Future<void> generateVacancyDesc(String prompt) async {
    emit(state.copyWith(gptDesSt: RequestStatus.loading));

    final response = await _formRepository.generateVacancyDesc(prompt: prompt);
    response.fold(
      (l) {
        emit(state.copyWith(gptDesSt: RequestStatus.error));
      },
      (r) {
        emit(state.copyWith(gptDesSt: RequestStatus.loaded, vacancyDesc: r));
      },
    );
  }

  Future<void> createVacancy(VacancyParams vacancyParams) async {
    emit(state.copyWith(formSt: RequestStatus.loading));
    final response = await _formRepository.createVacancy(
      vacancyParams: vacancyParams,
    );

    response.fold(
      (l) {
        emit(state.copyWith(formSt: RequestStatus.error));
        showErrorToast(l.message);
        saveVacancyParamsStorage(vacancyParams);
      },
      (r) {
        emit(state.copyWith(formSt: RequestStatus.loaded, vacancy: r));
        showSuccessToast(LocaleKeys.vacancyCreatedSuccessfully.tr());
        saveVacancyParamsStorage(null);
      },
    );
  }

  Future<void> saveVacancyParamsStorage(VacancyParams? vacancyParams) async {
    await _storageService.putVacancyParams(vacancyParams);
  }

  Future<void> getVacancyParamsFromStorage() async {
    final params = await _storageService.getVacancyParams();
    if (params == null) {
      emit(state.copyWith(hasUnpublishedAds: false));
    } else {
      emit(state.copyWith(hasUnpublishedAds: true, params: params));
      WVacancyDraftBottomSheet(
        onTappedContinue: () {
          navigatorKey.currentContext?.pop();
          continuePublishingAd();
        },
      ).show(navigatorKey.currentContext!);
    }
  }

  void generateVacancyDescription(String prompt) {
    emit(state.copyWith(gptDesSt: RequestStatus.loading, vacancyDesc: ''));
    _sub = _formRepository.generateVacancyDescription(prompt: prompt).listen((
      event,
    ) {
      event.fold(
        (l) {
          emit(state.copyWith(gptDesSt: RequestStatus.error));
        },
        (r) {
          emit(
            state.copyWith(
              gptDesSt: RequestStatus.loaded,
              vacancyDesc: (state.vacancyDesc ?? '') + r,
            ),
          );
        },
      );
    });
  }
}
