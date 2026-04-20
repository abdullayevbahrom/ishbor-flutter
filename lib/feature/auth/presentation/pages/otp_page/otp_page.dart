import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/constants/time_delay_cons.dart';
import 'package:top_jobs/core/extentions/color_extension.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/helpers/formatters.dart';
import 'package:top_jobs/core/theme/app_text_styles.dart';
import 'package:top_jobs/feature/auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:top_jobs/feature/common/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_button.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/app_utils.dart';
import '../../../../common/presentation/widget/w_check_box_list_tile.dart';
import '../../widgets/w_pin_put.dart';

class OtpPage extends StatefulWidget {
  OtpPage({super.key, required this.phoneNumber, required this.isRegister});

  final String phoneNumber;
  final bool isRegister;

  show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SizedBox(height: isRegister ? 480.h : 600.h, child: this),
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
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final _otpCodeController = TextEditingController();
  bool enableEdit = false;
  final _formKey = GlobalKey<FormState>();

  int seconds = 60;
  Timer? _timer;

  Future<void> startTimer() async {
    _timer = Timer.periodic(TimeDelayCons.duration1, (timer) {
      if (seconds != 0) {
        setState(() {
          seconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void resetTimer() {
    setState(() {
      seconds = 60;
    });
    startTimer();
  }

  @override
  void initState() {
    if (widget.isRegister) {
      setState(() {
        enableEdit = true;
      });
    }
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _formKey.currentState?.dispose();
    _otpCodeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.loginSt.isLoaded()) {
          context.read<UserCubit>().fetchUser();
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Container(
            width: 100.sw,
            decoration: BoxDecoration(
              color: AppColors.cFFFFFF,
              borderRadius: BorderRadius.horizontal(
                right: Radius.circular(20.r),
                left: Radius.circular(20.r),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.c000000.newWithOpacity(.1),
                  blurRadius: 8.r,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 11.h),
                Container(
                  height: 5.h,
                  width: 95.w,
                  decoration: BoxDecoration(
                    color: AppColors.cE0E5EB,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  LocaleKeys.enterSmsCode.tr(),
                  textAlign: TextAlign.center,
                  style: AppTextStyles.size24Bold.copyWith(
                    color: AppColors.c2E3A59,
                  ),
                ),
                SizedBox(height: 13.h),
                RichText(
                  text: TextSpan(
                    text: LocaleKeys.smsSendThisNumber.tr(),
                    children: [
                      TextSpan(
                        text: Formatters.formatUzbekPhoneNumber(
                          widget.phoneNumber,
                        ),
                        style: AppTextStyles.size15Medium,
                      ),
                    ],
                    style: AppTextStyles.size15Medium.copyWith(
                      color: AppColors.c888888,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                WPinput(
                  codeController: _otpCodeController,
                  onSendRequest: () {
                    FocusScope.of(context).unfocus();
                    if (_formKey.currentState?.validate() ?? false) {
                      context.read<AuthCubit>().checkSmsCode(
                        phone: widget.phoneNumber,
                        code: _otpCodeController.text.trim(),
                      );
                    }
                  },
                  length: 6,
                ),
                SizedBox(height: 8.h),
                seconds == 0
                    ? TextButton(
                      onPressed: () {
                        resetTimer();
                        context.read<AuthCubit>().reSendCodeAgain(
                          widget.phoneNumber,
                        );
                      },
                      child: Text(
                        LocaleKeys.resend.tr(),
                        style: AppTextStyles.size15Regular.copyWith(
                          color: AppColors.c2E3A59,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                    : Text(
                      Formatters.formatResetTime(seconds),
                      style: AppTextStyles.size15Regular.copyWith(
                        color: AppColors.c2E3A59,
                      ),
                    ),
                if (!widget.isRegister) SizedBox(height: 14.h),

                if (!widget.isRegister)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: WCheckedBoxListTile(
                      value: enableEdit,
                      title: LocaleKeys.iAgreePersonalData.tr(),
                      textStyle: AppTextStyles.size15Medium,
                      onTap: () {
                        setState(() {
                          enableEdit = !enableEdit;
                        });
                      },
                    ),
                  ),
                if (!widget.isRegister) AppUtils.hSizedBox24,
                if (!widget.isRegister)
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
                    textStyle: AppTextStyles.size17Medium.copyWith(
                        color: AppColors.cFFFFFF
                    ),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (_formKey.currentState?.validate() ?? false) {
                        context.read<AuthCubit>().checkSmsCode(
                          phone: widget.phoneNumber,
                          code: _otpCodeController.text.trim(),
                        );
                      }
                    },
                    isLoading: state.loginSt.isLoading(),
                    isAvailable: enableEdit,
                    width: 100.sw,
                    text:
                        widget.isRegister
                            ? LocaleKeys.login.tr()
                            : LocaleKeys.register.tr(),
                    color:
                        enableEdit && seconds > 0
                            ? AppColors.c15CF74
                            : AppColors.c15CF74.withOpacity(.4),
                    shadow: [
                      BoxShadow(
                        offset: const Offset(0, 4),
                        color: AppColors.c15CF74.withOpacity(.4),
                        blurRadius: 15.r,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
                SizedBox(
                  height: 50.h,
                  child: AppButton(
                    textStyle: AppTextStyles.size17Medium.copyWith(
                      color: AppColors.cFFFFFF
                    ),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      context.pop();
                    },
                    width: 100.sw,
                    text: LocaleKeys.back.tr(),
                    color: AppColors.c2E3A59,
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
