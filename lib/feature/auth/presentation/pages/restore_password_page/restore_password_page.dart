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
import 'package:top_jobs/feature/common/presentation/widget/app_phone_form_field.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_text_form_field.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_layout.dart';

import '../../../../common/presentation/widget/app_header.dart';
import '../../cubit/auth_cubit/auth_cubit.dart';

class RestorePassword extends StatefulWidget {
  @override
  _RestorePasswordState createState() => _RestorePasswordState();
}

class _RestorePasswordState extends State<RestorePassword> {
  final _formKey = GlobalKey<FormState>();

  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final verificationCodeController = TextEditingController();

  @override
  void dispose() {
    phoneNumberController.dispose();
    passwordController.dispose();
    verificationCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: WLayout(
            child: Scaffold(
              backgroundColor: AppColors.cFFFFFF,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppHeader(isPopAvailable: true),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppUtils.hSizedBox40,
                      Text(
                        LocaleKeys.passwordRecovery.tr(),
                        style: AppTextStyles.size28Bold,
                      ),
                      AppUtils.hSizedBox16,
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppColors.cFBFBFD,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LocaleKeys.phoneNumber.tr(),
                              style: AppTextStyles.size15Medium.copyWith(
                                color: AppColors.c333333,
                              ),
                            ),
                            AppUtils.hSizedBox8,
                            AppPhoneNumberTextFormField(
                              phoneNumber: phoneNumberController,
                            ),
                            AppUtils.hSizedBox24,
                            Text(
                              LocaleKeys.newPassword.tr(),
                              style: AppTextStyles.size15Medium.copyWith(
                                color: AppColors.c333333,
                              ),
                            ),
                            AppUtils.hSizedBox8,
                            AppTextFormField(
                              maxLines: 1,
                              minLines: 1,
                              fillColor: AppColors.cFFFFFF,
                              hintText: LocaleKeys.enterPassword.tr(),
                              controller: passwordController,
                              obscureTextAvailable: true,
                              validator:
                                  (value) => ValidatorHelpers.validateField(
                                    value: value ?? '',
                                  ),
                            ),
                            AppUtils.hSizedBox30,
                            SizedBox(
                              height: 55.h,
                              child: AppButton(
                                radius: 8.r,
                                width: 100.sw,
                               // isLoading: state.restoreSt.isLoading(),
                                onPressed: () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    // context.read<AuthCubit>().restorePassword(
                                    //   restorePassword: RestorePasswordModel(
                                    //     password:
                                    //         "+998" +
                                    //         passwordController.text
                                    //             .trim()
                                    //             .replaceAll(" ", ''),
                                    //     phoneNumber:
                                    //         phoneNumberController.text.trim(),
                                    //   ),
                                    // );
                                  }
                                },
                                text: LocaleKeys.send.tr(),
                                color: AppColors.cFF9914,
                                textStyle: AppTextStyles.size17Bold.copyWith(
                                  color: AppColors.cFFFFFF,
                                ),
                              ),
                            ),
                          ],
                        ).paddingAll(24.r),
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 16.w),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
