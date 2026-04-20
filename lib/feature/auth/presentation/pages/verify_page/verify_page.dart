import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:top_jobs/core/helpers/formatters.dart';
import 'package:top_jobs/core/theme/app_svg.dart';
import 'package:top_jobs/export.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_button.dart';

import '../../cubit/auth_cubit/auth_cubit.dart';
import '../../widgets/w_pin_put.dart';

class Verification extends StatefulWidget {
  final Function(String code) onTap;
  final String phoneNumber;
  final int count;

  show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return this.paddingOnly(
          left: 16.w,
          right: 16.w,
          top: 260.h,
          bottom: 250.h,
        );
      },
    );
  }

  Verification({
    super.key,
    required this.onTap,
    required this.phoneNumber,
    required this.count,
  });

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  final _formKey = GlobalKey<FormState>();

  final codeController = TextEditingController();
  Timer? timer;
  int time = 50;
  bool resetActive = false;

  @override
  void initState() {
    startTimer(time);
    super.initState();
  }

  @override
  void dispose() {
    codeController.clear();
    timer?.cancel();
    super.dispose();
  }

  void restartTimer() {
    setState(() {
      resetActive = false;
      time = 50;
    });
    startTimer(time);
  }

  void startTimer(int count) async {
    timer = Timer.periodic(Duration(seconds: 1), (_timer) {
      if (time > 0) {
        setState(() {
          time -= 1;
        });
      } else {
        _timer.cancel();
        setState(() {
          resetActive = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        return FadeInUp(
          child: Material(
            color: AppColors.cFFFFFF,
            borderRadius: BorderRadius.circular(16.r),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          LocaleKeys.enterVerificationCode.tr(),
                          style: AppTextStyles.size24Bold.copyWith(
                            color: AppColors.c333333,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          context.pop();
                        },
                        icon: SvgPicture.asset(AppSvg.icCancelGrey),
                      ),
                    ],
                  ),
                  AppUtils.hSizedBox24,
                  Text(
                    LocaleKeys.verificationCodeHasBeenSent.tr(),
                    style: AppTextStyles.size15Medium.copyWith(
                      color: AppColors.c888888,
                    ),
                  ),
                  AppUtils.hSizedBox8,
                  Align(
                    alignment: Alignment.center,
                    child: WPinput(
                      length: widget.count,
                      codeController: codeController,
                      onSendRequest: () {
                        widget.onTap(codeController.text.trim());
                      },
                    ),
                  ),
                  AppUtils.hSizedBox16,
                  SizedBox(
                    height: 40.h,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child:
                          resetActive
                              ? TextButton(
                                onPressed: () {
                                  restartTimer();
                                  context.read<AuthCubit>().reSendCodeAgain(
                                    widget.phoneNumber,
                                  );
                                },
                                child: Text(
                                  LocaleKeys.resend.tr(),
                                  style: AppTextStyles.size15Medium.copyWith(
                                    color: AppColors.cFF9914,
                                  ),
                                ),
                              )
                              : Text(
                                Formatters.formatResetTime(time),
                                style: AppTextStyles.size15Medium,
                              ),
                    ),
                  ),
                  AppUtils.hSizedBox16,
                  SizedBox(
                    height: 50.h,
                    child: AppButton(
                      width: 100.sw,
                      radius: 4.r,
                      isAvailable: !resetActive,

                      // isLoading: state.verifyRestoreSt.isLoading(),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          widget.onTap(codeController.text.trim());
                        }
                      },
                      text: LocaleKeys.verify.tr(),
                      color:
                          resetActive
                              ? AppColors.c15CF74.withOpacity(.3)
                              : AppColors.c15CF74,
                      textStyle: AppTextStyles.size17Bold.copyWith(
                        color: AppColors.cFFFFFF,
                      ),
                      shadow:
                          resetActive
                              ? []
                              : [
                                BoxShadow(
                                  color: AppColors.c15CF74.withOpacity(.4),
                                  blurRadius: 15.r,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                    ),
                  ),
                ],
              ).paddingAll(24.r),
            ),
          ),
        );
      },
    );
  }
}

