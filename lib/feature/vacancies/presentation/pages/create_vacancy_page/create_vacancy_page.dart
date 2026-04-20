import 'package:animate_do/animate_do.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/helpers/formatters.dart';
import 'package:top_jobs/core/helpers/key_helpers.dart';
import 'package:top_jobs/core/helpers/scrollcontroller_helpers.dart';
import 'package:top_jobs/core/helpers/validators.dart';
import 'package:top_jobs/core/theme/app_text_styles.dart';
import 'package:top_jobs/core/utils/app_utils.dart';
import 'package:top_jobs/feature/common/presentation/cubits/category_cubit/category_cubit.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_decorated_box.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_layout.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_title_with_text_form.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_toasttifications.dart';
import 'package:top_jobs/feature/services/presentation/pages/create_service_page/widget/w_image_picker.dart';
import 'package:top_jobs/feature/services/presentation/pages/create_service_page/widget/w_inquiry_phone_number.dart';
import 'package:top_jobs/feature/vacancies/presentation/cubits/create_vacancy_cubit/create_vacancy_cubit.dart';
import 'package:top_jobs/feature/vacancies/presentation/pages/create_vacancy_page/widget/generate_vacancy.dart';
import 'package:top_jobs/feature/vacancies/presentation/pages/create_vacancy_page/widget/vacancy_employee_type.dart';
import 'package:top_jobs/feature/vacancies/presentation/pages/create_vacancy_page/widget/vacancy_place.dart';
import 'package:top_jobs/feature/vacancies/presentation/pages/create_vacancy_page/widget/vacancy_suggested_salary.dart';
import 'package:top_jobs/feature/vacancies/presentation/pages/create_vacancy_page/widget/vacancy_who_can_respond.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../injection_container.dart';
import '../../../../../models/vacancy.dart';
import '../../../../common/presentation/cubits/user_cubit/user_cubit.dart';
import '../../../../common/presentation/widget/app_header.dart';
import '../../../../common/presentation/widget/footer.dart';
import '../../../../common/presentation/widget/w_basic_info_form.dart';
import '../../../../common/presentation/widget/w_create_and_cancel_buttons.dart';

class CreateVacancyPage extends StatefulWidget {
  CreateVacancyPage({super.key, this.vacancy});

  final Vacancy? vacancy;

  @override
  State<CreateVacancyPage> createState() => _CreateVacancyPageState();
}

class _CreateVacancyPageState extends State<CreateVacancyPage> {
  final cubit = sl<CreateVacancyCubit>();
  final scrollController = ScrollController();
  int currentLength = 0;

  final GlobalKey<FormFieldState> _descFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _titleFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _locationFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _categoryFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _cityFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _minSalaryFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _maxSalaryFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _skillsFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _shortDescFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _employmentTypeFieldKey =
      GlobalKey<FormFieldState>();

  @override
  void initState() {
    if (widget.vacancy != null) {
      cubit.initVacancy(widget.vacancy!);
    }
    cubit.generatedDesController.addListener(descriptionListener);
    super.initState();
  }

  void descriptionListener() {
    final text = cubit.generatedDesController.text;
    if (text.length > 900) {
      final newText = text.substring(0, 900);
      cubit.generatedDesController.value = cubit.generatedDesController.value
          .copyWith(
            text: newText,
            selection: TextSelection.collapsed(offset: newText.length),
          );
    }
  }

  @override
  void dispose() {
    cubit.generatedDesController.removeListener(descriptionListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocConsumer<CreateVacancyCubit, CreateVacancyState>(
        listener: (context, state) {
          if (state.status.isLoaded() || state.status.isError()) {
            setState(() {
              currentLength = cubit.generatedDesController.text.length;

              if (state.category != null) {
                context.read<CategoryCubit>().state.categories?.items.forEach((
                  element,
                ) {
                  if (element.id == state.category) {
                    cubit.categoryController.text =
                        element
                            .translations[context.locale == 'ru' ? 0 : 1]
                            .name ??
                        '';
                    cubit.categories = element.id;
                  }
                });
              }
            });
          }

          if (state.createVacSt.isLoaded()) {
            context.pushReplacement("/vacancy-view?id=${state.vacancy?.id}");
          }
        },
        builder: (context, state) {
          return Form(
            key: vacancyKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: WLayout(
              bottom: false,
              child: Scaffold(
                backgroundColor: AppColors.cFFFFFF,
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppHeader(isPopAvailable: true),
                    Expanded(
                      child: ListView(
                        controller: scrollController,
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              AppUtils.hSizedBox24,
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  LocaleKeys.createVacancy.tr(),
                                  style: AppTextStyles.size28Bold.copyWith(
                                    color: AppColors.c2E3A59,
                                  ),
                                ).paddingOnly(left: 10.w),
                              ),
                              AppUtils.hSizedBox24,
                              !state.isEnable
                                  ? GenerateVacancy(
                                    onChanged: (value) {
                                      cubit.validateEnability();
                                    },
                                    controller: cubit.descriptionController,
                                    isLoading: state.status.isLoading(),
                                    isAvailable: state.buttonEnable,
                                    onTapButton: () {
                                      FocusScope.of(context).unfocus();
                                      cubit.generateVacancy();
                                    },
                                  )
                                  : FadeInUp(
                                    child: Skeletonizer(
                                      enabled: state.status.isLoading(),
                                      child: Stack(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              WBasicInfoForm(
                                                categoryKey: _categoryFieldKey,
                                                titleKey: _titleFieldKey,
                                                basicTitle:
                                                    LocaleKeys.mainInformation
                                                        .tr(),
                                                serviceController:
                                                    cubit.vacancyNameController,
                                                categoriesController:
                                                    cubit.categoryController,
                                                onTapCategories: () {},
                                                onChanged: ({value, valueStr}) {
                                                  setState(() {
                                                    cubit
                                                        .categoryController
                                                        .text = valueStr!;
                                                    cubit.categories = value!;
                                                  });
                                                },
                                              ),
                                              AppUtils.hSizedBox24,

                                              WDecoratedBox(
                                                radius: 16.r,
                                                child: WTitleWithTextForm(
                                                  bgColor: AppColors.cFFFFFF,
                                                  fieldKey: _descFieldKey,
                                                  keyBoardType:
                                                      TextInputType.text,
                                                  textEditingController:
                                                      cubit
                                                          .generatedDesController,
                                                  title:
                                                      LocaleKeys.description
                                                          .tr(),
                                                  hintText:
                                                      LocaleKeys
                                                          .enterVacancyDescription
                                                          .tr(),
                                                  minLines: 7,
                                                  maxLines: 10,
                                                  maxLength: 900,
                                                  formatters: [
                                                    LengthLimitingTextInputFormatter(
                                                      900,
                                                    ),
                                                  ],
                                                  currentLength: currentLength,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      currentLength =
                                                          value.length;
                                                    });
                                                  },
                                                  validator: (value) {
                                                    return ValidatorHelpers.validateField(
                                                      value: value!,
                                                      message:
                                                          LocaleKeys.description
                                                              .tr(),
                                                    );
                                                  },
                                                ).paddingAll(16.r),
                                              ),
                                              AppUtils.hSizedBox24,
                                              BlocProvider.value(
                                                value: cubit,
                                                child: VacancyPlace(
                                                  cityKey: _cityFieldKey,
                                                  locKey: _locationFieldKey,
                                                  vacancyLocationController:
                                                      cubit.locationController,
                                                  cityController:
                                                      cubit.cityController,
                                                  onLocationSelected: (
                                                    address,
                                                  ) {
                                                    cubit.updateLocation(
                                                      address,
                                                    );
                                                  },
                                                ),
                                              ),
                                              AppUtils.hSizedBox24,
                                              VacancySuggestedSalary(
                                                salaryMaxKey:
                                                    _maxSalaryFieldKey,
                                                salaryMinKey:
                                                    _minSalaryFieldKey,
                                                skillsKey: _skillsFieldKey,
                                                maxSalaryController:
                                                    cubit.maxSalaryController,
                                                minSalaryController:
                                                    cubit.minSalaryController,
                                                companyDescriptionController:
                                                    cubit
                                                        .companyDescriptionController,
                                                keySkillsController:
                                                    cubit.skillsController,
                                                salaryInInterview:
                                                    state.salaryInInterview,
                                                currencyValue:
                                                    state.uzsCurrency,
                                                onTapSalary: () {
                                                  cubit.salaryStatus();
                                                },

                                                onPressedSuffixIcon: () {
                                                  cubit.updateCurrency();
                                                },
                                              ),
                                              AppUtils.hSizedBox24,
                                              VacancyWhoCanRespond(
                                                companyDescriptionController:
                                                    cubit
                                                        .companyDescriptionController,
                                                isApplicationAvailable:
                                                    state.withOutResume,
                                                isTemporaryAvailable:
                                                    state.temporaryEmployee,
                                                onTapApplication: () {
                                                  cubit.changeWithOutResume();
                                                },
                                                onTapTemporary: () {
                                                  cubit.changeTemporary();
                                                },
                                              ),
                                              AppUtils.hSizedBox24,
                                              VacancyEmployeeType(
                                                employmentTypeKey:
                                                    _employmentTypeFieldKey,
                                                set: state.employmentType,
                                                onTap: (index) {
                                                  cubit.updateEmploymentType(
                                                    index,
                                                  );
                                                },
                                                endTimeController:
                                                    cubit.endTimeController,
                                                startTimeController:
                                                    cubit.startTimeController,
                                                onTapEndTime: () {
                                                  final now = DateTime.now();
                                                  DatePicker.showTimePicker(
                                                    context,
                                                    onConfirm: (time) {
                                                      cubit
                                                              .endTimeController
                                                              .text =
                                                          Formatters.formatTimeOnly(
                                                            time,
                                                          );
                                                    },
                                                    showSecondsColumn: false,
                                                    currentTime: DateTime(
                                                      now.year,
                                                      now.month,
                                                      now.day,
                                                      18,
                                                      0,
                                                    ),
                                                  );
                                                },

                                                onTapStartTime: () {
                                                  final now = DateTime.now();
                                                  DatePicker.showTimePicker(
                                                    context,
                                                    onConfirm: (time) {
                                                      cubit
                                                              .startTimeController
                                                              .text =
                                                          Formatters.formatTimeOnly(
                                                            time,
                                                          );
                                                    },
                                                    showSecondsColumn: false,
                                                    currentTime: DateTime(
                                                      now.year,
                                                      now.month,
                                                      now.day,
                                                      8,
                                                      0,
                                                    ),
                                                  );
                                                },
                                              ),

                                              24.verticalSpace,
                                              WImagePicker(
                                                onPressed: () {
                                                  cubit.pickImage();
                                                },
                                                images: state.images,
                                              ),
                                              24.verticalSpace,
                                              WInquiryPhoneNumbers(
                                                phoneNumberController:
                                                    cubit.phoneNumberController,
                                                phoneNumberController1:
                                                    cubit
                                                        .phoneNumberController1,
                                                phoneNumberController2:
                                                    cubit
                                                        .phoneNumberController2,
                                                phoneNumberController3:
                                                    cubit
                                                        .phoneNumberController3,
                                              ),
                                              AppUtils.hSizedBox40,
                                              BlocBuilder<UserCubit, UserState>(
                                                builder: (context, userState) {
                                                  return WCreateAndCancelButtons(
                                                    isLoading:
                                                        state.createVacSt
                                                            .isLoading(),
                                                    title:
                                                        LocaleKeys.createVacancy
                                                            .tr(),
                                                    onTapCancel: () {
                                                      context.pop();
                                                    },
                                                    onTapCreate: () {
                                                      if (vacancyKey
                                                              .currentState
                                                              ?.validate() ??
                                                          false) {
                                                        if (widget.vacancy !=
                                                            null) {
                                                          cubit.editVacancy(
                                                            widget.vacancy!.id,
                                                          );
                                                        } else {
                                                          if ((userState
                                                                          .user
                                                                          ?.balance ??
                                                                      0) <=
                                                                  5000 ||
                                                              (userState
                                                                          .user
                                                                          ?.contentCount ??
                                                                      0) <
                                                                  5) {
                                                            cubit
                                                                .createVacancy();
                                                          } else {
                                                            showPaymentErrorDialog();
                                                          }
                                                        }
                                                      } else {
                                                        ScrollControllerHelpers()
                                                            .scrollToFirstError([
                                                              _descFieldKey,
                                                              _titleFieldKey,
                                                              _categoryFieldKey,
                                                              _cityFieldKey,
                                                              _locationFieldKey,
                                                              _minSalaryFieldKey,
                                                              _maxSalaryFieldKey,
                                                              _skillsFieldKey,
                                                              _shortDescFieldKey,
                                                              _employmentTypeFieldKey,
                                                            ]);
                                                      }
                                                    },
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                          // if (state.status.isLoading())showWarningMessage("Warninig")
                                        ],
                                      ),
                                    ),
                                  ),
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
