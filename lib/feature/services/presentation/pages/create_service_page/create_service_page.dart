import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/helpers/key_helpers.dart';
import 'package:top_jobs/core/helpers/scrollcontroller_helpers.dart';
import 'package:top_jobs/core/helpers/validators.dart';
import 'package:top_jobs/core/theme/app_colors.dart';
import 'package:top_jobs/core/utils/app_utils.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_header.dart';
import 'package:top_jobs/feature/common/presentation/widget/footer.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_basic_info_form.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_layout.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_title_with_text_form.dart';
import 'package:top_jobs/feature/services/data/models/service.dart';
import 'package:top_jobs/feature/services/presentation/pages/create_service_page/widget/suggested_salary.dart';
import 'package:top_jobs/feature/services/presentation/pages/create_service_page/widget/w_image_picker.dart';
import 'package:top_jobs/feature/services/presentation/pages/create_service_page/widget/w_inquiry_phone_number.dart';

import '../../../../../injection_container.dart';
import '../../../../common/presentation/cubits/user_cubit/user_cubit.dart';
import '../../../../common/presentation/widget/w_create_and_cancel_buttons.dart';
import '../../../../common/presentation/widget/w_toasttifications.dart';
import '../../cubits/create_service/create_service_cubit.dart';

class CreateServicePage extends StatefulWidget {
  final ServiceModel? service;

  const CreateServicePage({super.key, this.service});

  @override
  State<CreateServicePage> createState() => _CreateServicePageState();
}

class _CreateServicePageState extends State<CreateServicePage> {
  final cubit = sl<CreateServiceCubit>();
  int currentLength = 0;

  final GlobalKey<FormFieldState> _titleFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _categoryFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _salaryFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _cityFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _locationFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _descFieldKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    if (widget.service != null) cubit.initService(widget.service!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocConsumer<CreateServiceCubit, CreateServiceState>(
        listener: (context, state) {
          if (state.status.isLoaded()) {
            context.pushReplacement("/service-view?id=${state.service?.id}");
          }
        },
        builder: (context, state) {
          return Form(
            key: serviceKey,
            child: WLayout(
              child: Scaffold(
                backgroundColor: AppColors.cFFFFFF,
                body: Column(
                  children: [
                    AppHeader(isPopAvailable: true),
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        children: [
                          Column(
                            children: [
                              WBasicInfoForm(
                                titleKey: _titleFieldKey,
                                categoryKey: _categoryFieldKey,
                                serviceController: cubit.serviceNameController,
                                categoriesController: cubit.categoryController,
                                onTapCategories: () {},
                                onChanged: ({value, valueStr}) {
                                  cubit.updateCategory(
                                    categoryId: value,
                                    categoryName: valueStr,
                                  );
                                },
                                basicTitle: LocaleKeys.mainInformation.tr(),
                                title: LocaleKeys.createService.tr(),
                              ),
                              AppUtils.hSizedBox24,
                              SuggestedSalary(
                                cityKey: _cityFieldKey,
                                locationKey: _locationFieldKey,
                                salaryKey: _salaryFieldKey,
                                minSalaryController: cubit.minSalaryController,
                                maxSalaryController: cubit.maxSalaryController,
                                cityController: cubit.cityController,
                                location: state.location,
                                locationController:
                                    cubit.serviceLocationController,
                                onChangedCurrency: (value) {
                                  if ((int.tryParse(value!) ?? 0) >= 50000) {
                                    cubit.updateCurrency(isUZS: true);
                                  } else {
                                    cubit.updateCurrency(isUZS: false);
                                  }
                                },
                                onTapCheckBox: () {
                                  cubit.updateCheckBox();
                                },
                                checkBoxValue: state.isNegotiable,
                                currencyValue: state.isUZS,
                                onTapCurrency: () {
                                  cubit.updateCurrency();
                                },
                                onSelectedLocation: (address) {
                                  cubit.updateLocation(address);
                                },
                              ),
                              AppUtils.hSizedBox40,
                              WTitleWithTextForm(
                                bgColor: AppColors.cFFFFFF,
                                fieldKey: _descFieldKey,
                                keyBoardType: TextInputType.text,
                                textEditingController:
                                    cubit.serviceDescriptionController,
                                onChanged: (value) {
                                  setState(() {
                                    currentLength = value.length;
                                  });
                                },
                                currentLength: currentLength,
                                title: LocaleKeys.description.tr(),
                                hintText:
                                    LocaleKeys.enterServiceDescription.tr(),
                                validator: (value) {
                                  return ValidatorHelpers.validateField(
                                    value: value!,
                                    message:
                                        LocaleKeys.enterServiceDescription.tr(),
                                  );
                                },
                                minLines: 6,
                                maxLines: 10,
                                maxLength: 900,
                              ),
                              AppUtils.hSizedBox24,
                              WImagePicker(
                                images: state.images,
                                onPressed: () {
                                  cubit.pickImages();
                                },
                              ),
                              AppUtils.hSizedBox24,
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
                                  return WCreateAndCancelButtons(
                                    title: LocaleKeys.createService.tr(),
                                    onTapCancel: () {},
                                    onTapCreate: () {
                                      if (serviceKey.currentState?.validate() ??
                                          false) {
                                        if (widget.service != null) {
                                          cubit.editService(widget.service!.id);
                                        } else {
                                          if ((userState.user?.balance ?? 0) >=
                                                  5000 ||
                                              (userState.user?.contentCount ??
                                                      0) <
                                                  (userState
                                                          .user
                                                          ?.contentLimit ??
                                                      0)) {
                                            cubit.createService();
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
                                              _locationFieldKey,
                                              _descFieldKey,
                                            ]);
                                      }
                                    },
                                    isLoading: state.status.isLoading(),
                                  );
                                },
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
