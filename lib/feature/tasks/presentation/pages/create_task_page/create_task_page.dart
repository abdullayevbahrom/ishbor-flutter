import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/helpers/key_helpers.dart';
import 'package:top_jobs/core/helpers/scrollcontroller_helpers.dart';
import 'package:top_jobs/core/helpers/validators.dart';
import 'package:top_jobs/core/theme/app_colors.dart';
import 'package:top_jobs/core/theme/app_text_styles.dart';
import 'package:top_jobs/core/utils/app_utils.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_header.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_text_form_field.dart';
import 'package:top_jobs/feature/common/presentation/widget/footer.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_basic_info_form.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_check_box_list_tile.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_create_and_cancel_buttons.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_decorated_box.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_layout.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_radio_list_tile.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_title_with_text_form.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_toasttifications.dart';
import 'package:top_jobs/feature/services/presentation/pages/create_service_page/widget/suggested_salary.dart';
import 'package:top_jobs/feature/services/presentation/pages/create_service_page/widget/w_image_picker.dart';
import 'package:top_jobs/feature/services/presentation/pages/create_service_page/widget/w_inquiry_phone_number.dart';
import 'package:top_jobs/feature/tasks/data/models/task_model.dart';

import '../../../../../injection_container.dart' show sl;
import '../../../../common/presentation/cubits/user_cubit/user_cubit.dart';
import '../../cubits/create_task_cubit/create_task_cubit.dart';

class CreateTaskPage extends StatefulWidget {
  CreateTaskPage({super.key, this.task});

  final TaskModel? task;

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final cubit = sl<CreateTaskCubit>();
  int currentLength = 0;
  List<String> paymentMethods = [
    LocaleKeys.cash.tr(),
    LocaleKeys.transferToCard.tr(),
    LocaleKeys.onlinePayment.tr(),
  ];

  List<String> paymentMethodsValue = ['cash', 'card', 'online'];
  final GlobalKey<FormFieldState> _titleFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _categoryFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _salaryFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _cityFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _locFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _descFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _startTimeFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _endTimeFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _paymentTypeFieldKey =
      GlobalKey<FormFieldState>();

  @override
  void initState() {
    if (widget.task != null) cubit.initTask(task: widget.task!);
    cubit.taskDescriptionController.addListener(() {
      final text = cubit.taskDescriptionController.text;
      if (text.length > 900) {
        final newText = text.substring(0, 900);
        cubit.taskDescriptionController.value = cubit
            .taskDescriptionController
            .value
            .copyWith(
              text: newText,
              selection: TextSelection.collapsed(offset: newText.length),
            );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocConsumer<CreateTaskCubit, CreateTaskState>(
        listener: (context, state) {
          if (state.status.isLoaded()) {
            context.pushReplacement("/task-view?id=${state.task?.id}");
          }
        },
        builder: (context, state) {
          return Form(
            key: taskKey,
            child: WLayout(
              child: Scaffold(
                backgroundColor: AppColors.cFFFFFF,
                body: Column(
                  children: [
                    AppHeader(isPopAvailable: true),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              WBasicInfoForm(
                                titleKey: _titleFieldKey,
                                categoryKey: _categoryFieldKey,
                                serviceController: cubit.taskNameController,
                                categoriesController: cubit.categoryController,
                                onTapCategories: () {},
                                onChanged: ({value, valueStr}) {
                                  cubit.updateCategory(
                                    valueStr: valueStr ?? "",
                                    valueInt: value ?? 0,
                                  );
                                },
                                basicTitle: LocaleKeys.mainInformation.tr(),
                                title: LocaleKeys.createTask.tr(),
                              ),
                              AppUtils.hSizedBox24,
                              SuggestedSalary(
                                salaryKey: _salaryFieldKey,
                                locationKey: _locFieldKey,
                                cityKey: _cityFieldKey,
                                maxSalaryController: cubit.maxSalaryController,
                                minSalaryController: cubit.minSalaryController,
                                cityController: cubit.cityController,
                                locationController:
                                    cubit.taskLocationController,
                                location: state.location,

                                onChangedCurrency: (value) {
                                  if ((int.tryParse(value!) ?? 0) >= 50000) {
                                    cubit.updateCurrency(isUZS: true);
                                  } else {
                                    cubit.updateCurrency(isUZS: false);
                                  }
                                },
                                onTapCheckBox: () {
                                  cubit.updateNegotiable();
                                },
                                currencyValue: state.isUSD,
                                onTapCurrency: () {
                                  cubit.updateCurrency();
                                },
                                onSelectedLocation: (address) {
                                  cubit.updateLocation(address);
                                },
                                checkBoxValue: state.isNegotiable,
                              ),
                              AppUtils.hSizedBox24,
                              WTitleWithTextForm(
                                bgColor: AppColors.cFFFFFF,
                                fieldKey: _descFieldKey,
                                keyBoardType: TextInputType.text,
                                maxLines: 10,
                                minLines: 6,
                                maxLength: 900,
                                formatters: [
                                  LengthLimitingTextInputFormatter(900),
                                ],
                                currentLength: currentLength,
                                textEditingController:
                                    cubit.taskDescriptionController,
                                title: LocaleKeys.taskDescription.tr(),
                                hintText: LocaleKeys.enterTaskDescription.tr(),
                                onChanged: (value) {
                                  setState(() {
                                    currentLength = value.length;
                                  });
                                },
                                validator: (value) {
                                  return ValidatorHelpers.validateField(
                                    value: value!,
                                  );
                                },
                              ),
                              AppUtils.hSizedBox40,
                              WDecoratedBox(
                                radius: 16.r,
                                bgColor: AppColors.cFBFBFD,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      LocaleKeys.completeTaskTill.tr(),
                                      style: AppTextStyles.size22Bold.copyWith(
                                        color: AppColors.c2E3A59,
                                      ),
                                    ),
                                    AppUtils.hSizedBox24,
                                    Text(
                                      LocaleKeys.startDate.tr(),
                                      style: AppTextStyles.size15Medium
                                          .copyWith(color: AppColors.c333333),
                                    ),
                                    AppUtils.hSizedBox8,
                                    WCheckedBoxListTile(
                                      value: state.isStartDateNow,
                                      title: LocaleKeys.now.tr(),

                                      onTap: () {
                                        cubit.updateStartDate();
                                      },
                                    ),
                                    AppUtils.hSizedBox8,
                                    if (!state.isStartDateNow)
                                      AppTextFormField(
                                        fieldKey: _startTimeFieldKey,
                                        fillColor: AppColors.cFFFFFF,
                                        hintText: LocaleKeys.enterDate.tr(),
                                        controller: cubit.startDateController,
                                        keyBoardType: TextInputType.none,
                                        validator: (value) {
                                          return ValidatorHelpers.validateField(
                                            value: value!,
                                          );
                                        },
                                        onTap: () {
                                          DatePicker.showDatePicker(
                                            context,
                                            locale:
                                                context.locale.languageCode ==
                                                        "ru"
                                                    ? LocaleType.ru
                                                    : LocaleType.en,
                                            currentTime: DateTime.now(),

                                            minTime: DateTime.now(),
                                            maxTime: DateTime(2030),
                                            onConfirm: (time) {
                                              cubit.updateDate(
                                                startDate: DateFormat(
                                                  'yyyy/MM/dd HH:mm',
                                                ).format(time),
                                              );
                                              cubit
                                                  .startDateController
                                                  .text = DateFormat(
                                                'yyyy/MM/dd',
                                              ).format(time);
                                            },
                                          );
                                        },
                                      ),

                                    AppUtils.hSizedBox16,
                                    WTitleWithTextForm(
                                      fieldKey: _endTimeFieldKey,
                                      keyBoardType: TextInputType.none,
                                      textEditingController:
                                          cubit.endDateController,
                                      formatters: [],
                                      title: LocaleKeys.endDate.tr(),
                                      hintText: LocaleKeys.enterDate.tr(),
                                      onTap: () {
                                        DatePicker.showDatePicker(
                                          context,
                                          locale:
                                              context.locale.languageCode ==
                                                      "ru"
                                                  ? LocaleType.ru
                                                  : LocaleType.en,
                                          currentTime: DateTime.now().add(
                                            Duration(days: 1),
                                          ),

                                          minTime:
                                              DateTime.now()
                                                ..add(Duration(days: 1)),
                                          maxTime: DateTime(2030),
                                          onConfirm: (time) {
                                            cubit.updateDate(
                                              endDate: DateFormat(
                                                'yyyy/MM/dd HH:mm',
                                              ).format(time),
                                            );
                                            cubit
                                                .endDateController
                                                .text = DateFormat(
                                              'yyyy/MM/dd',
                                            ).format(time);
                                          },
                                        );
                                      },
                                      validator: (value) {
                                        return ValidatorHelpers.validateField(
                                          value: value!,
                                          message: LocaleKeys.endDate.tr(),
                                        );
                                      },
                                    ),
                                  ],
                                ).paddingAll(16.r),
                              ),
                              AppUtils.hSizedBox16,
                              WCheckedBoxListTile(
                                value: state.isRemote,
                                title: LocaleKeys.youCanWorkRemote.tr(),
                                onTap: () {
                                  cubit.updateRemoteWork();
                                },
                              ),
                              AppUtils.hSizedBox24,
                              WDecoratedBox(
                                radius: 16.r,
                                bgColor: AppColors.cFBFBFD,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      LocaleKeys.paymentMethods.tr(),
                                      style: AppTextStyles.size20Bold.copyWith(
                                        color: AppColors.c2E3A59,
                                      ),
                                    ),
                                    FormField(
                                      key: _paymentTypeFieldKey,
                                      validator: (value) {
                                        if (cubit.state.paymentMethod == null) {
                                          return LocaleKeys.selectPaymentType
                                              .tr();
                                        }
                                        return null;
                                      },

                                      builder:
                                          (formState) => Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ...List.generate(
                                                paymentMethods.length,
                                                (index) {
                                                  return WRadioListTile(
                                                    title:
                                                        paymentMethods[index],
                                                    onTap: () {
                                                      cubit.updatePaymentMethod(
                                                        paymentMethodsValue[index],
                                                      );
                                                      formState.didChange(
                                                        paymentMethodsValue[index],
                                                      );
                                                    },
                                                    value:
                                                        cubit
                                                            .state
                                                            .paymentMethod ==
                                                        paymentMethodsValue[index],
                                                  );
                                                },
                                              ),

                                              if (formState.hasError)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        top: 4.0,
                                                        left: 8,
                                                      ),
                                                  child: Text(
                                                    formState.errorText ?? '',
                                                    style: AppTextStyles
                                                        .size13Medium
                                                        .copyWith(
                                                          color: AppColors.cRed,
                                                        ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                    ),
                                  ],
                                ).paddingAll(16.r),
                              ),
                              AppUtils.hSizedBox24,

                              WImagePicker(
                                onPressed: () {
                                  cubit.pickImages();
                                },
                                images: state.images,
                              ),
                              24.verticalSpace,
                              WInquiryPhoneNumbers(
                                phoneNumberController:
                                    cubit.phoneNumberController,
                                phoneNumberController1:
                                    cubit.phoneNumberController1,
                                phoneNumberController2:
                                    cubit.phoneNumberController2,
                                phoneNumberController3:
                                    cubit.phoneNumberController3,
                              ),
                              24.verticalSpace,
                              BlocBuilder<UserCubit, UserState>(
                                builder: (context, userState) {
                                  return Align(
                                    alignment: Alignment.center,
                                    child: WCreateAndCancelButtons(
                                      onTapCreate: () {
                                        if (taskKey.currentState?.validate() ??
                                            false) {
                                          if (widget.task != null) {
                                            cubit.editTask(
                                              taskId: widget.task!.id,
                                            );
                                          } else {
                                            if ((userState.user?.balance ?? 0) >= 5000 ||
                                                (userState.user?.contentCount ?? 0) <
                                                    (userState.user?.contentLimit ?? 0)) {
                                              cubit.createTask();
                                            } else {
                                              showPaymentErrorDialog();
                                            }
                                          }
                                        } else {
                                          ScrollControllerHelpers()
                                              .scrollToFirstError([
                                                _titleFieldKey,
                                                _categoryFieldKey,
                                                _salaryFieldKey,
                                                _cityFieldKey,
                                                _locFieldKey,
                                                _descFieldKey,
                                                _startTimeFieldKey,
                                                _endTimeFieldKey,
                                                _paymentTypeFieldKey,
                                              ]);
                                        }
                                      },
                                      onTapCancel: () {
                                        context.pop();
                                      },
                                      title: LocaleKeys.createTask.tr(),
                                      isLoading: state.status.isLoading(),
                                    ),
                                  );
                                },
                              ),
                              AppUtils.hSizedBox24,
                            ],
                          ).paddingSymmetric(horizontal: 16.w),

                          Footer(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
