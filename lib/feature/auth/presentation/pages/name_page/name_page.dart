import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:top_jobs/core/extentions/color_extension.dart';
import 'package:top_jobs/core/helpers/validators.dart';
import 'package:top_jobs/core/theme/app_svg.dart';
import 'package:top_jobs/export.dart';
import 'package:top_jobs/feature/auth/data/models/request/params.dart';
import 'package:top_jobs/feature/auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_button.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_text_form_field.dart';

import '../../../../common/presentation/cubits/user_cubit/user_cubit.dart';

class NamePage extends StatelessWidget {
  NamePage({super.key, required this.phoneNumber, required this.userType});

  final String phoneNumber;
  final String userType;

  void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SizedBox(
              height: 300.h,
              child: this,
            ), // Your LoginPage widget
          ),
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: AppColors.cFFFFFF,
      shape: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(20.r),
          left: Radius.circular(20.r),
        ),
      ),
    );
  }

  final _userNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.registerSt.isLoaded()) {
          context.read<UserCubit>().checkUser();
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Container(
            width: 100.sw,
            decoration: BoxDecoration(
              color: AppColors.cFFFFFF,
              boxShadow: [
                BoxShadow(
                  color: AppColors.c000000.newWithOpacity(.1),
                  offset: const Offset(0, 4),
                  blurRadius: 8.r,
                ),
              ],
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(20.r),
                right: Radius.circular(20.r),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 36.h),
                Text(
                  LocaleKeys.whatYourName.tr(),
                  style: AppTextStyles.size28Bold.copyWith(
                    color: AppColors.c2E3A59,
                  ),
                ),
                SizedBox(height: 16.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    LocaleKeys.enterFullName.tr(),
                    style: AppTextStyles.size15Regular.copyWith(
                      color: AppColors.cB7BFCA,
                    ),
                  ),
                ),
                SizedBox(height: 5.h),
                AppTextFormField(
                  keyBoardType: TextInputType.text,
                  hintText: LocaleKeys.fio.tr(),
                  controller: _userNameController,
                  validator: (value) {
                    return ValidatorHelpers.validateField(value: value!);
                  },
                  prefixIcon: SvgPicture.asset(
                    AppSvg.icPerson,
                  ).paddingOnly(left: 18.w, right: 16.w),
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  height: 50.h,
                  child: AppButton(
                    width: 100.sw,
                    textStyle: AppTextStyles.size17Medium.copyWith(
                      color: AppColors.cFFFFFF,
                    ),
                    isLoading: state.registerSt.isLoading(),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (_formKey.currentState?.validate() ?? false) {
                        final data = _userNameController.text.trim().split(' ');
                        context.read<AuthCubit>().registerUser(
                          params: SmsRegistrationParams(
                            userType: userType,
                            phoneNumber: phoneNumber,
                            firstName: data.length >= 2 ? data[1] : data[0],
                            lastName:
                                data.length > 1
                                    ? data[0].isNotEmpty
                                        ? data[0]
                                        : null
                                    : null,
                            middleName:
                                data.length >= 3
                                    ? data[2].isNotEmpty
                                        ? data[2]
                                        : null
                                    : null,
                          ),
                        );
                      }
                    },
                    text: LocaleKeys.next.tr(),
                    rightIcon: Icon(
                      Icons.arrow_forward,
                      color: AppColors.cFFFFFF,
                    ),
                    color: AppColors.cFF9914,
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 16.w),
          ),
        );
      },
    );
  }
}
