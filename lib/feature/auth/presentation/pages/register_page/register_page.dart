import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/helpers/validators.dart';
import 'package:top_jobs/core/theme/app_colors.dart';
import 'package:top_jobs/core/theme/app_text_styles.dart';
import 'package:top_jobs/core/utils/app_utils.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_button.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_header.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_phone_form_field.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_text_form_field.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_check_box_list_tile.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_layout.dart';

import '../../cubit/auth_cubit/auth_cubit.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _registerKey = GlobalKey();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatController = TextEditingController();
  bool isChecked = false;

  @override
  void dispose() {
    phoneController.dispose();
    nameController.dispose();
    passwordController.dispose();
    repeatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Form(
          key: _registerKey,
          child: WLayout(
            child: Scaffold(
              backgroundColor: AppColors.cFFFFFF,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppHeader(isPopAvailable: true),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(bottom: 170.h),
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      scrollDirection: Axis.vertical,
                      children: [
                        AppUtils.hSizedBox40,
                        Text(
                          LocaleKeys.registration.tr(),
                          style: AppTextStyles.size28Bold.copyWith(
                            color: AppColors.c2E3A59,
                          ),
                        ).paddingSymmetric(horizontal: 16.w),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: AppColors.cFBFBFD,
                            borderRadius: BorderRadius.circular(16.r),
                            boxShadow: [
                              // BoxShadow(
                              //   color: AppColors.c000000.withOpacity(.12),
                              //   offset: Offset(0,4),
                              //   blurRadius: 15.r
                              // )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                LocaleKeys.verifyPhone.tr(),
                                style: AppTextStyles.size15Medium.copyWith(
                                  color: AppColors.c333333,
                                ),
                              ),
                              AppUtils.hSizedBox8,
                              AppPhoneNumberTextFormField(phoneNumber: phoneController),
                              AppUtils.hSizedBox16,
                              Text(
                                LocaleKeys.name.tr(),
                                style: AppTextStyles.size15Medium.copyWith(
                                  color: AppColors.c333333,
                                ),
                              ),
                              AppUtils.hSizedBox8,
                              AppTextFormField(
                                fillColor: AppColors.cFFFFFF,
                                hintText: LocaleKeys.name.tr(),
                                controller: nameController,
                                keyBoardType: TextInputType.text,
                                validator:
                                    (value) => ValidatorHelpers.validateField(
                                      value: value!,
                                    ),
                              ),
                              // AppUtils.hSizedBox16,
                              // Text(
                              //   LocaleKeys.email.tr(),
                              //   style: AppTextStyles.size15Medium.copyWith(
                              //     color: AppColors.c333333,
                              //   ),
                              // ),
                              // AppUtils.hSizedBox8,
                              // AppTextFormField(
                              //   fillColor: AppColors.cFFFFFF,
                              //   hintText: LocaleKeys.email.tr(),
                              //   controller: emailController,
                              //   keyBoardType: TextInputType.emailAddress,
                              //   validator:
                              //       (value) => ValidatorHelpers.validateField(
                              //         value: value!,
                              //       ),
                              // ),
                              AppUtils.hSizedBox16,
                              Text(
                                LocaleKeys.password.tr(),
                                style: AppTextStyles.size15Medium.copyWith(
                                  color: AppColors.c333333,
                                ),
                              ),
                              AppUtils.hSizedBox8,
                              AppTextFormField(
                                maxLines: 1,
                                obscureTextAvailable: true,
                                fillColor: AppColors.cFFFFFF,
                                hintText: LocaleKeys.password.tr(),
                                controller: passwordController,
                                keyBoardType: TextInputType.visiblePassword,

                                validator:
                                    (value) => ValidatorHelpers.passwordChecker(
                                      value: value!,
                                    ),
                              ),
                              AppUtils.hSizedBox16,
                              Text(
                                LocaleKeys.repeatPassword.tr(),
                                style: AppTextStyles.size15Medium.copyWith(
                                  color: AppColors.c333333,
                                ),
                              ),
                              AppUtils.hSizedBox8,
                              AppTextFormField(
                                maxLines: 1,
                                obscureTextAvailable: true,
                                fillColor: AppColors.cFFFFFF,
                                hintText: LocaleKeys.repeatPassword.tr(),
                                controller: repeatController,
                                keyBoardType: TextInputType.visiblePassword,
                                validator:
                                    (value) =>
                                        ValidatorHelpers.validatePasswords(
                                          value1: value!,
                                          value2:
                                              passwordController.text.trim(),
                                        ),
                              ),
                            ],
                          ).paddingAll(24.r),
                        ).paddingSymmetric(horizontal: 16.w, vertical: 16.h),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: AppColors.cFBFBFD,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              WCheckedBoxListTile(
                                value: isChecked,
                                title: LocaleKeys.iAgreePersonalData.tr(),
                                textStyle: AppTextStyles.size15Medium,
                                onTap: () {
                                  setState(() {
                                    isChecked = !isChecked;
                                  });
                                },
                              ),
                              AppUtils.hSizedBox24,
                              Text(
                                LocaleKeys.byClickingRegister.tr(),
                                style: AppTextStyles.size13Regular.copyWith(
                                  color: AppColors.c8A8A8A,
                                ),
                              ),
                              AppUtils.hSizedBox16,
                              SizedBox(
                                height: 50.h,
                                child: AppButton(
                                  onPressed: () {
                                    if (isChecked) {
                                      if (_registerKey.currentState?.validate() ??
                                          false) {
                                        // context.read<AuthCubit>().register(registerModel: RegisterModel(
                                        //   phoneNumber: "+998"+phoneController.text.trim().replaceAll(" ", ""),
                                        //   password: passwordController.text.trim(),
                                        //   firstName: nameController.text.trim(),
                                        // ));
                                      }
                                    }
                                  },
                                  isLoading: state.registerSt.isLoading(),
                                  width: 100.sw,
                                  radius: 4.r,
                                  textStyle: AppTextStyles.size17Bold.copyWith(
                                    color: AppColors.cFFFFFF,
                                  ),
                                  text: LocaleKeys.register.tr(),
                                  color:
                                      isChecked
                                          ? AppColors.cFF9914
                                          : AppColors.cFF9914.withOpacity(.3),
                                ),
                              ),
                            ],
                          ).paddingAll(24.r),
                        ).paddingSymmetric(horizontal: 16.w),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
