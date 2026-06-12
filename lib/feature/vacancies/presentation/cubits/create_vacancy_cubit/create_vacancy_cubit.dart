import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/helpers/enum_helpers.dart';
import 'package:top_jobs/core/helpers/formatters.dart';
import 'package:top_jobs/core/router/app_routes.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_toasttifications.dart';
import 'package:top_jobs/feature/vacancies/data/models/vacancy_create_model.dart';
import 'package:top_jobs/feature/vacancies/domain/repository/vacancy_repository.dart';
import 'package:yandex_geocoder/yandex_geocoder.dart';

import '../../../../../core/helpers/image_picker.dart';
import '../../../../../core/helpers/string_helpers.dart';
import '../../../../../models/address.dart';
import '../../../../../models/vacancy.dart';
import '../../../../ads_form/domain/repository/vacancy_form_repository.dart';
import '../../../../ads_form/data/models/response/chatgpt_response.dart';
import '../../../../common/presentation/cubits/category_cubit/category_cubit.dart';
import '../../../../common/presentation/cubits/user_cubit/user_cubit.dart';

part 'create_vacancy_state.dart';

part 'create_vacancy_cubit.freezed.dart';

class CreateVacancyCubit extends Cubit<CreateVacancyState> {
  CreateVacancyCubit(this._vacancyRepository, this._vacancyFormRepository)
    : super(const CreateVacancyState());

  final VacancyRepository _vacancyRepository;
  final VacancyFormRepository _vacancyFormRepository;

  final TextEditingController vacancyNameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController minSalaryController = TextEditingController();
  final TextEditingController maxSalaryController = TextEditingController();
  final TextEditingController skillsController = TextEditingController();
  final TextEditingController generatedDesController = TextEditingController();
  final TextEditingController companyDescriptionController =
      TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();
  final TextEditingController latController = TextEditingController();
  final TextEditingController longController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController phoneNumberController1 = TextEditingController();
  final TextEditingController phoneNumberController2 = TextEditingController();
  final TextEditingController phoneNumberController3 = TextEditingController();

  List<String> categories = const [];

  void updateLocation(GeocodeResponse response) {
    emit(state.copyWith(location: response));
  }

  void changeWithOutResume() {
    emit(state.copyWith(withOutResume: !state.withOutResume));
  }

  void changeTemporary() {
    emit(state.copyWith(temporaryEmployee: !state.temporaryEmployee));
  }

  void validateEnability() {
    if (descriptionController.text.trim().length >= 50) {
      emit(state.copyWith(buttonEnable: true));
    } else {
      emit(state.copyWith(buttonEnable: false));
    }
  }

  Future<void> pickImage() async {
    final files = await ImagePickerHelper().pickMultiImage();
    if (files.length + state.images.length >= 5) {
      showErrorToast(LocaleKeys.imagesMaxFour.tr());
    } else {
      final oldImages = List<File>.from(state.images);
      oldImages.addAll(files);
      emit(state.copyWith(images: oldImages));
    }
  }

  void updateOperatingMode(int index) {
    final oldSet = Set.from(state.operatingMode);
    if (oldSet.contains(index)) {
      oldSet.remove(index);
    } else {
      oldSet.add(index);
    }
    emit(state.copyWith(operatingMode: oldSet));
  }

  void updateCurrency() {
    emit(state.copyWith(uzsCurrency: !state.uzsCurrency));
  }

  void salaryStatus() {
    emit(state.copyWith(salaryInInterview: !state.salaryInInterview));
  }

  void updateEmploymentType(int index) {
    emit(state.copyWith(employmentType: index));
  }

  String _prompt() => descriptionController.text.trim();

  void _applyGeneratedBody(NewChatGptResponse response) {
    final draft = response.result;
    vacancyNameController.text = draft.title ?? vacancyNameController.text;
    if (draft.salaryMin != null) {
      minSalaryController.text = Formatters.moneyFormat('${draft.salaryMin}');
    }
    if (draft.salaryMax != null) {
      maxSalaryController.text = Formatters.moneyFormat('${draft.salaryMax}');
    }

    final context = navigatorKey.currentContext;
    final categoryId = draft.category?.id.toString();
    if (context != null && categoryId != null && categoryId.isNotEmpty) {
      final matchedCategories =
          context
              .read<CategoryCubit>()
              .state
              .categories
              ?.items
              .where((e) => e.id == categoryId)
              .toList();
      if (matchedCategories != null && matchedCategories.isNotEmpty) {
        final category = matchedCategories.first;
        final localeIndex = context.locale.languageCode == 'ru' ? 0 : 1;
        final translation =
            category.translations.length > localeIndex
                ? category.translations[localeIndex]
                : category.translations.first;
        categoryController.text = translation.name ?? '';
        categories = matchedCategories.map((e) => e.id).toList();
      }
    }
  }

  String? _buildWorkTimePayload() {
    final start = startTimeController.text.trim();
    final end = endTimeController.text.trim();

    if (start.isEmpty && end.isEmpty) {
      return null;
    }

    if (start.isEmpty || end.isEmpty) {
      debugPrint(
        '[FIX][vacancy][work-time] incomplete start="$start" end="$end"',
      );
      return null;
    }

    return '$start - $end';
  }

  Future<void> _streamGeneratedDescription(String prompt) async {
    generatedDesController.clear();
    await for (final event in _vacancyFormRepository.generateVacancyDescription(
      prompt: prompt,
    )) {
      event.fold(
        (l) {
          generatedDesController.text = prompt;
          emit(
            state.copyWith(
              generateVacancyDes: RequestStatus.error,
              errorText: l.message,
            ),
          );
          showErrorToast(l.message ?? LocaleKeys.unExpectedError.tr());
          return;
        },
        (r) {
          generatedDesController.text = '${generatedDesController.text}$r';
          generatedDesController.selection = TextSelection.collapsed(
            offset: generatedDesController.text.length,
          );
        },
      );
    }
  }

  Future<void> _generateVacancyBodyInternal(String prompt) async {
    final response = await _vacancyFormRepository.generateVacancyBody(
      prompt: prompt,
    );

    response.fold(
      (l) {
        emit(
          state.copyWith(
            status: RequestStatus.error,
            generateVacancyDes: RequestStatus.error,
            isEnable: true,
            errorText: l.message,
          ),
        );
        showErrorToast(l.message ?? LocaleKeys.unExpectedError.tr());
      },
      (r) {
        _applyGeneratedBody(r);
        emit(
          state.copyWith(
            status: RequestStatus.loaded,
            generateVacancyDes: RequestStatus.loaded,
            isEnable: true,
            vacancy: state.vacancy,
          ),
        );
      },
    );
  }

  Future<void> generateVacancyDesc() async {
    final prompt = _prompt();
    if (prompt.isEmpty) {
      return;
    }

    debugPrint(
      '[DEBUG][vacancy-create][ai-desc] promptLength=${prompt.length}',
    );
    emit(state.copyWith(generateVacancyDes: RequestStatus.loading));
    try {
      await _streamGeneratedDescription(prompt);
      if (state.generateVacancyDes != RequestStatus.error) {
        emit(state.copyWith(generateVacancyDes: RequestStatus.loaded));
      }
    } catch (e) {
      generatedDesController.text = prompt;
      emit(state.copyWith(generateVacancyDes: RequestStatus.error));
      showErrorToast(e.toString());
    }
  }

  Future<void> generateVacancyBody() async {
    final prompt = _prompt();
    if (prompt.isEmpty) {
      showErrorToast(LocaleKeys.unExpectedError.tr());
      return;
    }

    debugPrint(
      '[DEBUG][vacancy-create][ai-body] promptLength=${prompt.length}',
    );
    emit(
      state.copyWith(
        status: RequestStatus.loading,
        generateVacancyDes: RequestStatus.loading,
      ),
    );
    await _generateVacancyBodyInternal(prompt);
  }

  Future<void> generateVacancy() async {
    final prompt = _prompt();
    if (prompt.isEmpty) {
      showErrorToast(LocaleKeys.unExpectedError.tr());
      return;
    }

    emit(
      state.copyWith(
        status: RequestStatus.loading,
        generateVacancyDes: RequestStatus.loading,
      ),
    );
    await _generateVacancyBodyInternal(prompt);
    await generateVacancyDesc();
  }

  Future<void> createVacancy() async {
    emit(state.copyWith(createVacSt: RequestStatus.loading));

    final workTime = _buildWorkTimePayload();
    if (workTime == null) {
      emit(
        state.copyWith(
          createVacSt: RequestStatus.error,
          errorText: LocaleKeys.enterBusinessHour.tr(),
        ),
      );
      showErrorToast(LocaleKeys.enterBusinessHour.tr());
      debugPrint('[FIX][vacancy][create] aborted: work_time is missing');
      return;
    }

    final response = await _vacancyRepository.createVacancy(
      vacancy: VacancyRequest(
        jobModes: [],
        workTime: workTime,
        phoneNumber:
            '+998${phoneNumberController.text.trim().replaceAll(" ", "")}',
        phoneNumber1:
            phoneNumberController1.text.trim().isNotEmpty
                ? '+998${phoneNumberController1.text.trim().replaceAll(" ", "")}'
                : '',
        phoneNumber2:
            phoneNumberController2.text.trim().isNotEmpty
                ? '+998${phoneNumberController2.text.trim().replaceAll(" ", "")}'
                : '',
        phoneNumber3:
            phoneNumberController3.text.trim().isNotEmpty
                ? '+998${phoneNumberController3.text.trim().replaceAll(" ", "")}'
                : '',
        images: state.images,
        title: vacancyNameController.text.trim(),
        city: StringHelpers.extractCity(
          state
                  .location
                  ?.response
                  ?.geoObjectCollection
                  ?.featureMember?[0]
                  .geoObject
                  ?.metaDataProperty
                  ?.geocoderMetaData
                  ?.text ??
              '',
        ),
        description: generatedDesController.text.trim(),
        address: AddressModel(
          addressLine: StringHelpers.extractStreet(
            state
                    .location
                    ?.response
                    ?.geoObjectCollection
                    ?.featureMember?[0]
                    .geoObject
                    ?.metaDataProperty
                    ?.geocoderMetaData
                    ?.text ??
                '',
          ),
          latitude: double.parse(
            '${state.location?.response?.geoObjectCollection?.metaDataProperty?.geocoderResponseMetaData?.point?.latitude}',
          ),
          longitude: double.parse(
            '${state.location?.response?.geoObjectCollection?.metaDataProperty?.geocoderResponseMetaData?.point?.longitude}',
          ),
        ),
        skills: skillsController.text.trim().split(','),
        shortDescription: companyDescriptionController.text.trim(),
        whoCanRespond: state.withOutResume ? [] : ['without full resume'],
        employmentType: employmentType(state.employmentType),
        salaryMin: int.tryParse(
          minSalaryController.text.replaceAll(' ', '').trim(),
        ),
        salaryMax: int.tryParse(
          maxSalaryController.text.replaceAll(' ', '').trim(),
        ),
        categories: categories,
        partialJobOpportunity: state.temporaryEmployee,
      ),
    );

    response.fold(
      (l) {
        emit(
          state.copyWith(
            createVacSt: RequestStatus.error,
            errorText: l.message,
          ),
        );
        // showSuccessToast("Vacancy created successfully");

        showErrorToast(l.message ?? LocaleKeys.unExpectedError.tr());
      },
      (r) {
        navigatorKey.currentContext?.read<UserCubit>().fetchUser();
        emit(state.copyWith(createVacSt: RequestStatus.loaded, vacancy: r));
        showSuccessToast(LocaleKeys.vacancyCreatedSuccessfully.tr());
      },
    );
  }

  Future<void> editVacancy(String vacancyId) async {
    emit(state.copyWith(createVacSt: RequestStatus.loading));

    final workTime = _buildWorkTimePayload();
    if (workTime == null) {
      emit(
        state.copyWith(
          createVacSt: RequestStatus.error,
          errorText: LocaleKeys.enterBusinessHour.tr(),
        ),
      );
      showErrorToast(LocaleKeys.enterBusinessHour.tr());
      debugPrint('[FIX][vacancy][update] aborted: work_time is missing');
      return;
    }

    final response = await _vacancyRepository.editVacancy(
      vacancy: VacancyRequest(
        jobModes: [],
        workTime: workTime,
        phoneNumber:
            '+998${phoneNumberController.text.trim().replaceAll(" ", "")}',
        phoneNumber1:
            phoneNumberController1.text.trim().isNotEmpty
                ? '+998${phoneNumberController1.text.trim().replaceAll(" ", "")}'
                : '',
        phoneNumber2:
            phoneNumberController2.text.trim().isNotEmpty
                ? '+998${phoneNumberController2.text.trim().replaceAll(" ", "")}'
                : '',
        phoneNumber3:
            phoneNumberController3.text.trim().isNotEmpty
                ? '+998${phoneNumberController3.text.trim().replaceAll(" ", "")}'
                : '',
        images: state.images,
        vacancyId: vacancyId,
        title: vacancyNameController.text.trim(),
        city: cityController.text.trim(),
        description: generatedDesController.text.trim(),
        address: AddressModel(
          addressLine: StringHelpers.extractStreet(
            state
                    .location
                    ?.response
                    ?.geoObjectCollection
                    ?.featureMember?[0]
                    .geoObject
                    ?.metaDataProperty
                    ?.geocoderMetaData
                    ?.text ??
                '',
          ),
          latitude: double.parse(
            '${state.location?.response?.geoObjectCollection?.metaDataProperty?.geocoderResponseMetaData?.point?.latitude}',
          ),
          longitude: double.parse(
            '${state.location?.response?.geoObjectCollection?.metaDataProperty?.geocoderResponseMetaData?.point?.longitude}',
          ),
        ),
        skills: [skillsController.text.trim()],
        shortDescription: companyDescriptionController.text.trim(),
        whoCanRespond: [state.withOutResume ? "" : 'without full resume'],
        employmentType: employmentType(state.employmentType),
        salaryMin: int.tryParse(
          minSalaryController.text.replaceAll(" ", '').trim(),
        ),
        salaryMax: int.tryParse(
          maxSalaryController.text.replaceAll(" ", '').trim(),
        ),
        categories: categories,
        partialJobOpportunity: state.temporaryEmployee,
      ),
    );

    response.fold(
      (l) {
        emit(
          state.copyWith(
            createVacSt: RequestStatus.error,
            errorText: l.message,
          ),
        );
        showErrorToast(l.message ?? LocaleKeys.unExpectedError.tr());
      },
      (r) {
        emit(state.copyWith(createVacSt: RequestStatus.loaded, vacancy: r));
        showSuccessToast(LocaleKeys.vacancyHasBeenEditedSuccessfully.tr());
      },
    );
  }

  void initVacancy(Vacancy vacancy) {
    emit(state.copyWith(isEnable: true));
    vacancyNameController.text =
        vacancy.title.resolve(
          navigatorKey.currentContext?.locale.languageCode,
        ) ??
        '';
    cityController.text = vacancy.city ?? '';
    locationController.text = vacancy.address?.addressLine ?? '';
    // latController.text=double.tryParse(vacancy.address.latitude??0);
    //  descriptionController.text=vacancy.description??'';
    generatedDesController.text =
        vacancy.description?.resolve(
          navigatorKey.currentContext?.locale.languageCode,
        ) ??
        '';
    skillsController.text = vacancy.skills!
        .map((e) {
          return e;
        })
        .join('');
    if (vacancy.negotiable ??
        false || vacancy.salaryMin == null && vacancy.salaryMax == null) {
      emit(state.copyWith(salaryInInterview: true));
    } else {
      minSalaryController.text = vacancy.salaryMin?.toInt().toString() ?? '';
      maxSalaryController.text = vacancy.salaryMax?.toInt().toString() ?? '';
    }

    if (vacancy.whoCanRespond!.contains("without full resume")) {
      emit(state.copyWith(withOutResume: false));
    } else {
      emit(state.copyWith(withOutResume: true));
    }

    if ((vacancy.workTime ?? '').isNotEmpty) {
      final parts = vacancy.workTime!.split('-');
      if (parts.isNotEmpty) {
        startTimeController.text = parts.first.trim();
      }
      if (parts.length > 1) {
        endTimeController.text = parts.last.trim();
      }
    }

    emit(
      state.copyWith(
        employmentType: employmentTypeIndex(vacancy.employmentType),
      ),
    );

    categories = vacancy.categories.map((e) => e.id).toList();
    categoryController.text = vacancy.categories
        .map(
          (e) =>
              e
                  .translations[navigatorKey
                              .currentContext
                              ?.locale
                              .languageCode ==
                          'ru'
                      ? 0
                      : 1]
                  .name,
        )
        .join('');
  }
}

String employmentType(int? index) {
  switch (index) {
    case 0:
      return "full employment";
    case 1:
      return "partial employment";
    case 2:
      return "internship";
    case 3:
      return "other";
    default:
      return "other";
  }
}

int employmentTypeIndex(String? type) {
  switch (type) {
    case "full employment":
      return 0;
    case "partial employment":
      return 1;
    case "internship":
      return 2;
    case "other":
      return 3;
    default:
      return 3;
  }
}
