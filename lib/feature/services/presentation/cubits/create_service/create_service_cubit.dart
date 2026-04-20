import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/helpers/enum_helpers.dart';
import 'package:top_jobs/core/helpers/formatters.dart';
import 'package:top_jobs/core/helpers/image_picker.dart';
import 'package:top_jobs/core/helpers/string_helpers.dart';
import 'package:top_jobs/core/router/app_routes.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_toasttifications.dart';
import 'package:top_jobs/feature/services/data/models/service_request_model.dart';
import 'package:top_jobs/feature/services/domain/repository/service_repository.dart';
import 'package:yandex_geocoder/yandex_geocoder.dart';

import '../../../../common/presentation/cubits/user_cubit/user_cubit.dart';
import '../../../data/models/service.dart';

part 'create_service_state.dart';

part 'create_service_cubit.freezed.dart';

class CreateServiceCubit extends Cubit<CreateServiceState> {
  CreateServiceCubit(this._serviceRepository)
    : super(const CreateServiceState());
  final TextEditingController serviceNameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController minSalaryController = TextEditingController();
  final TextEditingController maxSalaryController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController serviceLocationController =
      TextEditingController();
  final TextEditingController serviceDescriptionController =
      TextEditingController();
  final TextEditingController latController = TextEditingController();
  final TextEditingController longController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController phoneNumberController1 = TextEditingController();
  final TextEditingController phoneNumberController2 = TextEditingController();
  final TextEditingController phoneNumberController3 = TextEditingController();

  final ServiceRepository _serviceRepository;

  void updateLocation(GeocodeResponse response) {
    emit(state.copyWith(location: response));
  }

  void updateLatLong({double? lat, double? long}) {
    latController.text = lat.toString();
    longController.text = long.toString();
  }

  void updateCurrency({bool? isUZS}) {
    emit(state.copyWith(isUZS: isUZS ?? !state.isUZS));
  }

  void updateCategory({int? categoryId, String? categoryName}) {
    categoryController.text = categoryName ?? '';
    emit(state.copyWith(category: categoryId ?? 0));
  }

  void updateCheckBox() {
    emit(state.copyWith(isNegotiable: !state.isNegotiable));
  }

  void addImages(List<File> images) {
    final oldImages = List<File>.from(state.images ?? []);
    oldImages.addAll(images);
    emit(state.copyWith(images: oldImages));
  }

  void updateAddress(Map<String, dynamic>? address) {
    serviceLocationController.text = Formatters.cleanAndReverseAddress(
      address?['display_name'] ?? '',
    );
    latController.text = address?['lat'] ?? '';
    longController.text = address?['long'] ?? "";
  }

  void removeImage(int index) {
    final images = List<File>.from(state.images ?? []);
    images.removeAt(index);
    emit(state.copyWith(images: images));
  }

  Future<void> pickImages() async {
    final files = await ImagePickerHelper().pickMultiImage();
    if (files.length + state.images.length >= 5) {
      showErrorToast(LocaleKeys.imagesMaxFour.tr());
    } else {
      final oldImages = List<File>.from(state.images);
      oldImages.addAll(files);
      emit(state.copyWith(images: oldImages));
    }
  }

  Future<void> createService() async {
    emit(state.copyWith(status: RequestStatus.loading));
    final response = await _serviceRepository.createService(
      service: ServiceCreateRequest(
        phoneNumber: "+998" + phoneNumberController.text.trim(),
        phoneNumber1:
            phoneNumberController1.text.trim().isNotEmpty
                ? "+998" + phoneNumberController1.text.trim()
                : "",
        phoneNumber2:
            phoneNumberController2.text.trim().isNotEmpty
                ? "+998" + phoneNumberController2.text.trim()
                : "",
        phoneNumber3:
            phoneNumberController3.text.trim().isNotEmpty
                ? "+998" + phoneNumberController3.text.trim()
                : "",
        title: serviceNameController.text.trim(),
        categoryIds: [state.category],
        description: serviceDescriptionController.text.trim(),
        price:
            !state.isNegotiable
                ? minSalaryController.text.trim().replaceAll(" ", '')
                : '0',
        addressLine:
            state.location != null
                ? StringHelpers.extractStreet(
                  "${state.location?.response?.geoObjectCollection?.featureMember?[0].geoObject?.metaDataProperty?.geocoderMetaData?.text}",
                )
                : null,

        latitude:
            state.location != null
                ? double.parse(
                  "${state.location?.response?.geoObjectCollection?.metaDataProperty?.geocoderResponseMetaData?.point?.latitude}",
                )
                : null,
        longitude:
            state.location != null
                ? double.parse(
                  "${state.location?.response?.geoObjectCollection?.metaDataProperty?.geocoderResponseMetaData?.point?.longitude}",
                )
                : null,
        negotiable: state.isNegotiable,
        uploadedImages: state.images,
        city:
            state.location != null
                ? StringHelpers.extractCity(
                  "${state.location?.response?.geoObjectCollection?.featureMember?[0].geoObject?.metaDataProperty?.geocoderMetaData?.text}",
                )
                : "",
      ),
    );

    response.fold(
      (l) {
        emit(state.copyWith(status: RequestStatus.error, errorText: l.message));
        showErrorToast(l.message ?? LocaleKeys.unExpectedError.tr());
      },
      (r) {
        navigatorKey.currentContext?.read<UserCubit>().fetchUser();
        emit(state.copyWith(status: RequestStatus.loaded, service: r));
        showSuccessToast(LocaleKeys.serviceCreatedSuccessfully.tr());
      },
    );
  }

  Future<void> editService(int serviceId) async {
    emit(state.copyWith(status: RequestStatus.loading));
    final response = await _serviceRepository.editService(
      service: ServiceCreateRequest(
        serviceId: serviceId,
        phoneNumber: "+998" + phoneNumberController.text.trim().replaceAll(" ",''),
        phoneNumber1:
        phoneNumberController1.text.trim().isNotEmpty
            ? "+998" + phoneNumberController1.text.trim().replaceAll(" ",'')
            : "",
        phoneNumber2:
        phoneNumberController2.text.trim().isNotEmpty
            ? "+998" + phoneNumberController2.text.trim().replaceAll(" ",'')
            : "",
        phoneNumber3:
        phoneNumberController3.text.trim().isNotEmpty
            ? "+998" + phoneNumberController3.text.trim().replaceAll(" ",'')
            : "",
        title: serviceNameController.text.trim(),
        categoryIds: [state.category],
        description: serviceDescriptionController.text.trim(),
        price:
            !state.isNegotiable
                ? minSalaryController.text.trim().replaceAll(" ", '')
                : '0',
        addressLine:
            state.location != null
                ? StringHelpers.extractStreet(
                  "${state.location?.response?.geoObjectCollection?.featureMember?[0].geoObject?.metaDataProperty?.geocoderMetaData?.text}",
                )
                : null,

        latitude:
            state.location != null
                ? double.parse(
                  "${state.location?.response?.geoObjectCollection?.metaDataProperty?.geocoderResponseMetaData?.point?.latitude}",
                )
                : null,
        longitude:
            state.location != null
                ? double.parse(
                  "${state.location?.response?.geoObjectCollection?.metaDataProperty?.geocoderResponseMetaData?.point?.longitude}",
                )
                : null,
        negotiable: state.isNegotiable,
        uploadedImages: state.images,
        city: StringHelpers.extractCity(
          "${state.location?.response?.geoObjectCollection?.featureMember?[0].geoObject?.metaDataProperty?.geocoderMetaData?.text}",
        ),
      ),
    );

    response.fold(
      (l) {
        emit(state.copyWith(status: RequestStatus.error, errorText: l.message));
        showErrorToast(l.message ?? LocaleKeys.unExpectedError.tr());
      },
      (r) {
        emit(state.copyWith(status: RequestStatus.loaded, service: r));
        showSuccessToast(LocaleKeys.serviceHasBeenEditedSuccessfully.tr());
      },
    );
  }

  void initService(ServiceModel service) {
    serviceNameController.text = service.title;
    serviceDescriptionController.text = service.description ?? "";
    minSalaryController.text = (service.price?.toInt() ?? 0).toString();
    cityController.text = service.city ?? "";
    serviceLocationController.text = service.address?.addressLine ?? '';
    latController.text = "${service.address?.latitude ?? ""}";
    longController.text = "${service.address?.longitude ?? ""}";
    categoryController.text = service.categories
        .map((e) {
          emit(
            state.copyWith(category: e.id, isNegotiable: state.isNegotiable),
          );
          return e
              .translations[navigatorKey.currentContext!.locale.languageCode ==
                      'ru'
                  ? 0
                  : 1]
              .name;
        })
        .join('');
  }
}
