import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/helpers/enum_helpers.dart';
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

  int categories = 59;

  void updateLocation(GeocodeResponse response) {
    emit(state.copyWith(location: response));
  }

  void changeWithOutResume() {
    emit(state.copyWith(withOutResume: !state.withOutResume));
  }

  void changeTemporary() {
    emit(state.copyWith(temporaryEmployee: !state.temporaryEmployee));
  }

  validateEnability() {
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

  Future<void> generateVacancyDesc() async {
    emit(state.copyWith(generateVacancyDes: RequestStatus.loading));


    // response.fold(
    //   (l) {
    //     generatedDesController.text = descriptionController.text.trim();
    //     emit(state.copyWith(generateVacancyDes: RequestStatus.error));
    //   },
    //   (r) {
    //     generatedDesController.text = r
    //         .replaceAll("*", '')
    //         .replaceAll('---', '');
    //     emit(state.copyWith(generateVacancyDes: RequestStatus.loaded));
    //   },
    // );
  }

  Future<void> generateVacancyBody() async {}

  Future<void> generateVacancy() async {
    Future.wait([generateVacancyBody(), generateVacancyDesc()]);
  }

  Future<void> createVacancy() async {
    emit(state.copyWith(createVacSt: RequestStatus.loading));

    final response = await _vacancyRepository.createVacancy(
      vacancy: VacancyRequest(
        jobModes: [],
        phoneNumber:
            "+998" + phoneNumberController.text.trim().replaceAll(" ", ''),
        phoneNumber1:
            phoneNumberController1.text.trim().isNotEmpty
                ? "+998" +
                    phoneNumberController1.text.trim().replaceAll(" ", '')
                : "",
        phoneNumber2:
            phoneNumberController2.text.trim().isNotEmpty
                ? "+998" +
                    phoneNumberController2.text.trim().replaceAll(" ", '')
                : "",
        phoneNumber3:
            phoneNumberController3.text.trim().isNotEmpty
                ? "+998" +
                    phoneNumberController3.text.trim().replaceAll(" ", '')
                : "",
        images: state.images,
        title: vacancyNameController.text.trim(),
        city: StringHelpers.extractCity(
          "${state.location?.response?.geoObjectCollection?.featureMember?[0].geoObject?.metaDataProperty?.geocoderMetaData?.text}",
        ),
        description: generatedDesController.text.trim(),
        address: AddressModel(
          addressLine: StringHelpers.extractStreet(
            "${state.location?.response?.geoObjectCollection?.featureMember?[0].geoObject?.metaDataProperty?.geocoderMetaData?.text}",
          ),
          latitude: double.parse(
            "${state.location?.response?.geoObjectCollection?.metaDataProperty?.geocoderResponseMetaData?.point?.latitude}",
          ),
          longitude: double.parse(
            "${state.location?.response?.geoObjectCollection?.metaDataProperty?.geocoderResponseMetaData?.point?.longitude}",
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

  Future<void> editVacancy(int vacancyId) async {
    emit(state.copyWith(createVacSt: RequestStatus.loading));

    final response = await _vacancyRepository.editVacancy(
      vacancy: VacancyRequest(
        jobModes: [],
        phoneNumber:
            "+998" + phoneNumberController.text.trim().replaceAll(" ", ''),
        phoneNumber1:
            phoneNumberController1.text.trim().isNotEmpty
                ? "+998" +
                    phoneNumberController1.text.trim().replaceAll(" ", '')
                : "",
        phoneNumber2:
            phoneNumberController2.text.trim().isNotEmpty
                ? "+998" +
                    phoneNumberController2.text.trim().replaceAll(" ", '')
                : "",
        phoneNumber3:
            phoneNumberController3.text.trim().isNotEmpty
                ? "+998" +
                    phoneNumberController3.text.trim().replaceAll(" ", '')
                : "",
        images: state.images,
        vacancyId: vacancyId,
        title: vacancyNameController.text.trim(),
        city: cityController.text.trim(),
        description: generatedDesController.text.trim(),
        address: AddressModel(
          addressLine: StringHelpers.extractStreet(
            "${state.location?.response?.geoObjectCollection?.featureMember?[0].geoObject?.metaDataProperty?.geocoderMetaData?.text}",
          ),
          latitude: double.parse(
            "${state.location?.response?.geoObjectCollection?.metaDataProperty?.geocoderResponseMetaData?.point?.latitude}",
          ),
          longitude: double.parse(
            "${state.location?.response?.geoObjectCollection?.metaDataProperty?.geocoderResponseMetaData?.point?.longitude}",
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
    vacancyNameController.text = vacancy.title;
    cityController.text = vacancy.city ?? '';
    locationController.text = vacancy.address?.addressLine ?? '';
    // latController.text=double.tryParse(vacancy.address.latitude??0);
    //  descriptionController.text=vacancy.description??'';
    generatedDesController.text = vacancy.description ?? '';
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

    emit(
      state.copyWith(
        employmentType: employmentTypeIndex(vacancy.employmentType),
      ),
    );

    categoryController.text = vacancy.categories
        .map((e) {
          categories = e.id;
          return e
              .translations[navigatorKey.currentContext?.locale.languageCode ==
                      'ru'
                  ? 0
                  : 1]
              .name;
        })
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
