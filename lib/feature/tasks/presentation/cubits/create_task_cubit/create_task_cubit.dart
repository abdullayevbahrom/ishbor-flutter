import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:top_jobs/core/helpers/enum_helpers.dart';
import 'package:top_jobs/core/helpers/formatters.dart';
import 'package:top_jobs/core/helpers/image_picker.dart';
import 'package:top_jobs/core/router/app_routes.dart';
import 'package:top_jobs/feature/common/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_toasttifications.dart';
import 'package:top_jobs/feature/tasks/data/models/task_request_model.dart';
import 'package:top_jobs/feature/tasks/domain/repository/task_repository.dart';
import 'package:yandex_geocoder/yandex_geocoder.dart';

import '../../../../../core/helpers/string_helpers.dart';
import '../../../../../export.dart';
import '../../../data/models/task_model.dart';

part 'create_task_state.dart';

part 'create_task_cubit.freezed.dart';

class CreateTaskCubit extends Cubit<CreateTaskState> {
  CreateTaskCubit(this._taskRepository) : super(const CreateTaskState());
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController minSalaryController = TextEditingController();
  final TextEditingController maxSalaryController = TextEditingController();
  final TextEditingController taskLocationController = TextEditingController();
  final TextEditingController taskDescriptionController =
      TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController latController = TextEditingController();
  final TextEditingController longController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController phoneNumberController1 = TextEditingController();
  final TextEditingController phoneNumberController2 = TextEditingController();
  final TextEditingController phoneNumberController3 = TextEditingController();

  final TaskRepository _taskRepository;

  void updateLocation(GeocodeResponse response) {
    emit(state.copyWith(location: response));
  }

  void updateDate({String? startDate, String? endDate}) {
    emit(
      state.copyWith(
        startDate: startDate ?? state.startDate,
        expireDate: endDate ?? state.expireDate,
      ),
    );
  }

  void updateStartDate() {
    emit(state.copyWith(isStartDateNow: !state.isStartDateNow));
  }

  void updateCategory({required String valueStr, required int valueInt}) {
    categoryController.text = valueStr;
    emit(state.copyWith(categoryId: valueInt));
  }

  void updateCurrency({bool? isUZS}) {
    emit(state.copyWith(isUSD: isUZS ?? !state.isUSD));
  }

  void updateNegotiable() {
    emit(state.copyWith(isNegotiable: !state.isNegotiable));
  }

  void updateRemoteWork() {
    emit(state.copyWith(isRemote: !state.isRemote));
  }

  void updatePaymentMethod(String method) {
    if (state.paymentMethod == method) {
      emit(state.copyWith(paymentMethod: null));
    } else {
      emit(state.copyWith(paymentMethod: method));
    }
  }

  void updateAddress(Map<String, dynamic>? address) {
    taskLocationController.text = Formatters.cleanAndReverseAddress(
      address?['display_name'] ?? '',
    );
    latController.text = address?['lat'] ?? '';
    longController.text = address?['long'] ?? "";
  }

  Future<void> pickImages() async {
    final files = await ImagePickerHelper().pickMultiImage();
    if (files.length + state.images.length >= 5) {
      showErrorToast("Images count must be 4 at max");
    } else {
      final oldImages = List<File>.from(state.images);
      oldImages.addAll(files);
      emit(state.copyWith(images: oldImages));
    }
  }

  Future<void> createTask() async {
    emit(state.copyWith(status: RequestStatus.loading));

    final response = await _taskRepository.createTask(
      taskRequest: TaskRequestModel(
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
        paymentMethod: state.paymentMethod ?? '',
        title: taskNameController.text.trim(),
        categoryIds: [state.categoryId ?? 0],
        description: taskDescriptionController.text.trim(),
        price:
            !state.isNegotiable
                ? minSalaryController.text.replaceAll(" ", '').trim()
                : "0",
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
        exprTime: state.expireDate!,
        startTime:
            state.isStartDateNow
                ? DateFormat('yyyy/MM/dd HH:mm').format(DateTime.now())
                : state.startDate!,
      ),
    );

    response.fold(
      (l) {
        emit(state.copyWith(status: RequestStatus.error, errorText: l.message));
        showErrorToast(l.message ?? LocaleKeys.somethingWentWrong.tr());
      },
      (r) {
        navigatorKey.currentContext?.read<UserCubit>().fetchUser();
        emit(state.copyWith(status: RequestStatus.loaded, task: r));
        showSuccessToast(LocaleKeys.taskEditedSuccessfully.tr());
      },
    );
  }

  Future<void> editTask({required int taskId}) async {
    emit(state.copyWith(status: RequestStatus.loading));

    final response = await _taskRepository.editTask(
      task: TaskRequestModel(
        taskId: taskId,
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
        paymentMethod: state.paymentMethod ?? '',
        title: taskNameController.text.trim(),
        categoryIds: [state.categoryId ?? 0],
        description: taskDescriptionController.text.trim(),
        price:
            !state.isNegotiable
                ? minSalaryController.text.replaceAll(" ", '').trim()
                : "0",
        addressLine:
            taskLocationController.text.trim().isNotEmpty
                ? taskLocationController.text.trim()
                : null,
        latitude:
            latController.text.isNotEmpty
                ? double.parse(latController.text.trim())
                : null,
        longitude:
            longController.text.isNotEmpty
                ? double.parse(longController.text.trim())
                : null,
        negotiable: state.isNegotiable,
        uploadedImages: state.images,
        city: cityController.text.trim(),
        exprTime: state.expireDate!,
        startTime:
            state.isStartDateNow
                ? DateFormat('yyyy/MM/dd HH:mm').format(DateTime.now())
                : state.startDate!,
      ),
    );

    response.fold(
      (l) {
        emit(state.copyWith(status: RequestStatus.error, errorText: l.message));
        showErrorToast(l.message ?? LocaleKeys.somethingWentWrong.tr());
      },
      (r) {
        emit(state.copyWith(status: RequestStatus.loaded, task: r));
        showSuccessToast(LocaleKeys.taskCreatedSuccessfully.tr());
      },
    );
  }

  void initTask({required TaskModel task}) {
    taskNameController.text = task.title;
    taskDescriptionController.text = task.description ?? "";
    minSalaryController.text =
        task.negotiable ?? false ? "" : "${task.price?.toInt() ?? ''}";
    cityController.text = task.city ?? '';
    endDateController.text = Formatters.formatExpireDate(
      task.expiresAt ?? DateTime.now(),
    );
    startDateController.text = Formatters.formatExpireDate(
      task.startsAt ?? DateTime.now(),
    );
    taskLocationController.text =
        task.addresses.first.addressLine != null
            ? "${task.addresses.first.addressLine ?? ''}"
            : "";
    latController.text =
        task.addresses.first.latitude != null
            ? "${task.addresses.first.latitude ?? ''}"
            : "";
    longController.text =
        task.addresses.first.longitude != null
            ? "${task.addresses.first.longitude ?? ''}"
            : "";
    categoryController.text = task.categories
        .map((e) {
          emit(state.copyWith(categoryId: e.id));
          return e
              .translations[navigatorKey.currentContext?.locale.languageCode ==
                      'ru'
                  ? 0
                  : 1]
              .name;
        })
        .join('');
    emit(
      state.copyWith(
        paymentMethod: task.paymentMethods.map((e) => e).join(''),
        isNegotiable: task.negotiable,
        images: [],
        expireDate: task.expiresAt!.toString(),
        startDate: task.startsAt!.toString(),
        isStartDateNow: false,
      ),
    );
  }
}
