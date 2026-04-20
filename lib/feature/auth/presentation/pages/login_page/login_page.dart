import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/theme/app_colors.dart';
import 'package:top_jobs/core/theme/app_svg.dart';
import 'package:top_jobs/core/theme/app_text_styles.dart';

import '../../../../../core/constants/sizes_const.dart';
import '../../../../../core/helpers/app_launcher.dart';
import '../../../../common/presentation/widget/app_button.dart';
import '../../../../common/presentation/widget/app_phone_form_field.dart';
import '../../cubit/auth_cubit/auth_cubit.dart';

class LoginPage extends StatelessWidget {


  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final _phoneNumberController = TextEditingController();

  show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: this, // Your LoginPage widget
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: SizedBox(
              width: 100.sw,
              height: 450.h,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.cFFFFFF,
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(20.r),
                    right: Radius.circular(20.r),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.c000000.withOpacity(.1),
                      offset: const Offset(0, 4),
                      blurRadius: 8.r,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(height: SizesCons.size_11.h),
                    Container(
                      height: 5.h,
                      width: 95.w,
                      decoration: BoxDecoration(
                        color: AppColors.cE0E5EB,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    SizedBox(height: 23.h),
                    Text(
                      LocaleKeys.login.tr(),
                      style: AppTextStyles.size28Bold.copyWith(
                        color: AppColors.c2E3A59,
                      ),
                    ),
                    SizedBox(height: 28.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        LocaleKeys.enterPhoneNumber.tr(),
                        style: AppTextStyles.size15Regular.copyWith(
                          color: AppColors.cB7BFCA,
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    AppPhoneNumberTextFormField(
                      phoneNumber: _phoneNumberController,
                    ),
                    SizedBox(height: 16.h),
                    SizedBox(
                      height: 50.h,
                      child: AppButton(
                        isLoading: state.verifyPhoneSt.isLoading(),
                        textStyle: AppTextStyles.size17Medium.copyWith(
                          color: AppColors.cFFFFFF,
                        ),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          if (_formKey.currentState?.validate() ?? false) {
                            context.read<AuthCubit>().verifyPhoneNumber(
                              phoneNumber:
                                  "+998${_phoneNumberController.text.trim().replaceAll(
                                    " ",
                                    '',
                                  )}",
                            );
                          }
                        },
                        verticalPadding: 15.h,
                        width: 100.sw,
                        text: LocaleKeys.login.tr(),
                        rightIcon: Center(
                          child: Icon(
                            Icons.arrow_forward_rounded,
                            color: AppColors.cFFFFFF,
                            size: 20.r,
                          ).paddingOnly(left: 3.w),
                        ),
                        color: AppColors.cFF9914,
                      ),
                    ),
                    Text(
                      "yoki",
                      style: AppTextStyles.size17Medium.copyWith(
                        color: AppColors.cB7BFCA,
                      ),
                    ).paddingSymmetric(vertical: 8.h),
                    SizedBox(
                      height: 50.h,
                      child: AppButton(
                        isLoading: state.verifyPhoneSt.isLoading(),
                        textStyle: AppTextStyles.size17Medium.copyWith(
                          color: AppColors.cFFFFFF,
                        ),
                        onPressed: () {
                          FocusScope.of(context).unfocus();

                          AppLauncher().launchTelegram(
                            "https://t.me/ishborloginbot?start",
                          );
                        },
                        width: 100.sw,
                        verticalPadding: 12.h,
                        text: "Login with telegram",
                        rightIcon: SvgPicture.asset(
                          AppSvg.icTelegram,
                        ).paddingOnly(left: 10.w),
                        color: AppColors.c039BE5,
                      ),
                    ),
                  ],
                ).paddingSymmetric(horizontal: 20.w),
              ),
            ),
          ),
        );
      },
    );
  }
}



/*
class LoginPage extends StatefulWidget {

  @override
  State<LoginPage> createState() => _LoginPageState();

  show(BuildContext context) {
    showDialog(
      context: context,
      useSafeArea: true,
      barrierDismissible: true,


      builder:
          (context) => Padding(
            padding: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
              top: 120.h,
              bottom: 70.h,
            ),
            child: this,
          ),
    );
  }
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool rememberPassword = false;
  final phoneNumber = TextEditingController(text: '');
  final passwordController = TextEditingController();

  @override
  void dispose() {
    phoneNumber.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status.isLoaded()) {
          context.read<UserCubit>().fetchUser();
          context.pop();
          setState(() {
            rememberPassword = false;
          });
        }
      },
      builder: (context, state) {
        return FadeInUp(
          child: MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: TextScaler.linear(1)),
            child: Material(
              color: AppColors.cFFFFFF,
              borderRadius: BorderRadius.circular(16.r),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            LocaleKeys.login.tr(),
                            style: AppTextStyles.size32Bold.copyWith(
                              color: AppColors.c333333,
                              fontSize: 32.spMin,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              context.pop();
                            },
                            icon: SvgPicture.asset(
                              AppSvg.icCancelGrey,
                              height: 20.r,
                              width: 20.r,
                            ),
                          ),
                        ],
                      ),
                      AppUtils.hSizedBox24,
                      Text(
                        LocaleKeys.phoneNumber.tr(),
                        style: AppTextStyles.size15Medium.copyWith(
                          color: AppColors.c333333,
                        ),
                      ),
                      AppUtils.hSizedBox8,
                      AppPhoneNumberTextFormField(phoneNumber: phoneNumber),
                      AppUtils.hSizedBox16,
                      Text(
                        LocaleKeys.password.tr(),
                        style: AppTextStyles.size15Medium.copyWith(
                          color: AppColors.c333333,
                        ),
                      ),
                      AppUtils.hSizedBox8,
                      AppTextFormField(
                        minLines: 1,
                        maxLines: 1,
                        obscureTextAvailable: true,
                        keyBoardType: TextInputType.visiblePassword,
                        fillColor: AppColors.cFFFFFF,
                        hintText: LocaleKeys.enterPassword.tr(),
                        controller: passwordController,
                        validator: (value) {
                          return ValidatorHelpers.validateField(value: value!);
                        },
                      ),

                      AppUtils.hSizedBox24,
                      Row(
                        children: [
                          WCheckedBoxListTile(
                            value: rememberPassword,
                            title: LocaleKeys.rememberPassword.tr(),
                            onTap: () {
                              setState(() {
                                rememberPassword = !rememberPassword;
                              });
                            },
                          ),
                        ],
                      ),
                      AppUtils.hSizedBox24,
                      InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthCubit>().logIn(
                              rememberPassword: rememberPassword,
                              model: CheckModel(
                                name:
                                    "+998" +
                                    phoneNumber.text.trim().replaceAll(" ", ''),
                                password: passwordController.text.trim(),
                              ),
                            );
                          }
                        },
                        borderRadius: BorderRadius.circular(12.r),
                        child: SizedBox(
                          width: 100.sw,
                          height: 50.h,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: AppColors.cFFFFFF,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: AppColors.cFF9914,
                                width: 1.5.r,
                              ),
                            ),
                            child:
                                state.status.isLoading()
                                    ? Center(
                                      child: CircularProgressIndicator.adaptive(
                                        backgroundColor: AppColors.cFF9914,
                                      ).paddingSymmetric(vertical: 10.h),
                                    )
                                    : Center(
                                      child: Text(
                                        LocaleKeys.login.tr(),
                                        textAlign: TextAlign.center,
                                        style: AppTextStyles.size17Bold.copyWith(
                                          color: AppColors.cFF9914,
                                        ),
                                      ),
                                    ),
                          ),
                        ),
                      ),
                      AppUtils.hSizedBox16,
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          LocaleKeys.loginWithSocialLinks.tr(),
                          textAlign: TextAlign.center,
                          style: AppTextStyles.size15Regular.copyWith(
                            color: AppColors.c888888,
                          ),
                        ),
                      ),
                      AppUtils.hSizedBox16,
                      Row(
                        spacing: 16.w,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // TODO implement them in next versions
                          // InkWell(
                          //   onTap: () {},
                          //   child: SvgPicture.asset(AppSvg.icFacebook),
                          // ),
                          // InkWell(
                          //   onTap: () {
                          //     context.read<AuthCubit>().logInWithGoogle();
                          //   },
                          //   child: SvgPicture.asset(AppSvg.icGoogle),
                          // ),
                          // if (Platform.isIOS)
                          //   InkWell(
                          //     onTap: () {
                          //
                          //     },
                          //     child: SvgPicture.asset(AppSvg.icApple),
                          //   ),
                        ],
                      ),
                      AppUtils.hSizedBox32,
                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {
                            context.pop();
                           // context.push(Routes.register);
                          },
                          child: DecoratedBox(
                            decoration: BoxDecoration(color: AppColors.cF6F7FB),
                            child: Text(
                              LocaleKeys.registration.tr(),
                              style: AppTextStyles.size15Medium.copyWith(
                                color: AppColors.c13A5E3,
                              ),
                            ).paddingSymmetric(
                              vertical: 10.5.h,
                              horizontal: 44.w,
                            ),
                          ),
                        ),
                      ),
                      AppUtils.hSizedBox24,
                      Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: () {
                            context.pop();

                          },
                          child: Text(
                            LocaleKeys.forgotPassword.tr(),
                            style: AppTextStyles.size15Medium.copyWith(
                              color: AppColors.cBDC0C6,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ).paddingAll(24.r),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

*/
