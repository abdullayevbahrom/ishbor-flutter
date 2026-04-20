import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:toastification/toastification.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/constants/time_delay_cons.dart';
import 'package:top_jobs/core/extentions/color_extension.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/helpers/app_launcher.dart';
import 'package:top_jobs/core/router/app_routes.dart';
import 'package:top_jobs/core/router/route_names.dart';
import 'package:top_jobs/core/theme/app_colors.dart';
import 'package:top_jobs/core/theme/app_lottie.dart';
import 'package:top_jobs/core/theme/app_text_styles.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_button.dart';

import '../../../../core/constants/sizes_const.dart';

showErrorToast(String? message) {
  toastification.show(
    context: navigatorKey.currentContext,
    type: ToastificationType.error,
    style: ToastificationStyle.fillColored,
    title: Text(message ?? LocaleKeys.unExpectedError.tr(), maxLines: 5),
    autoCloseDuration: TimeDelayCons.duration3,
  );
}

showSuccessToast(String message) {
  toastification.show(
    context: navigatorKey.currentContext,
    type: ToastificationType.success,
    style: ToastificationStyle.fillColored,
    title: Text(message, maxLines: 5),
    autoCloseDuration: TimeDelayCons.duration3,
  );
}

showWarningToast(String message) {
  toastification.show(
    context: navigatorKey.currentContext,
    type: ToastificationType.warning,
    style: ToastificationStyle.fillColored,
    title: Text(message, maxLines: 5),
    autoCloseDuration: TimeDelayCons.duration3,
  );
}

showInfoToast(String message) {
  toastification.show(
    alignment: Alignment.bottomCenter,
    context: navigatorKey.currentContext,
    type: ToastificationType.info,
    style: ToastificationStyle.fillColored,
    title: Text(message, maxLines: 5),
    autoCloseDuration: TimeDelayCons.duration3,
  );
}

showErrorDialog({
  String? title,
  required String body,
  required String lottiePath,
}) {
  return showDialog(
    context: navigatorKey.currentContext!,
    barrierDismissible: true,
    builder:
        (context) => PopScope(
          child: AlertDialog(
            elevation: 2,
            backgroundColor: AppColors.cFFFFFF,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(SizesCons.size_30),
            ),
            title: Column(
              children: [
                Lottie.asset(
                  lottiePath,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
                if (title != null) 15.verticalSpace,
                if (title != null)
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.size20Bold.copyWith(
                      color: AppColors.c2E3A59,
                    ),
                  ),
                10.verticalSpace,
                Text(
                  body,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.size15Medium.copyWith(
                    color: AppColors.c333333,
                  ),
                ),

                25.verticalSpace,
                SizedBox(
                  height: 50.h,

                  child: AppButton(
                    width: 100.sw,

                    onPressed: () {
                      navigatorKey.currentContext?.pop();
                    },
                    text: LocaleKeys.back.tr(),
                    textStyle: AppTextStyles.size17Medium.copyWith(
                      color: AppColors.cFFFFFF,
                    ),
                    color: AppColors.c2E3A59,
                  ),
                ),
                12.verticalSpace,
                SizedBox(
                  height: 50.h,
                  child: AppButton(
                    width: 100.sw,
                    onPressed: () {
                      AppLauncher().launchTelegram("@ishboruz_elon");
                    },
                    text: LocaleKeys.askToSupport.tr(),
                    textStyle: AppTextStyles.size17Medium.copyWith(
                      color: AppColors.c2E3A59,
                    ),
                    color: AppColors.c2E3A59.newWithOpacity(.12),
                  ),
                ),
              ],
            ),
          ),
        ),
  );
}

showPaymentErrorDialog() {
  return showModalBottomSheet(
    context: navigatorKey.currentContext!,
    backgroundColor: AppColors.cFFFFFF,
    isDismissible: true,

    builder:
        (context) => Wrap(
          children: [
            SafeArea(
              child: PopScope(
                child: Column(
                  children: [
                    11.verticalSpace,
                    SizedBox(
                      height: 5,
                      width: 95,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppColors.cE0E5EB,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    16.verticalSpace,
                    Lottie.asset(
                      AppLottie.warning,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                      repeat: false,
                    ),
                    // if (title != null) 15.verticalSpace,
                    // if (title != null)
                    //   Text(
                    //     LocaleKeys.noMoney.tr(),
                    //     textAlign: TextAlign.center,
                    //     style: AppTextStyles.size20Bold.copyWith(
                    //       color: AppColors.c2E3A59,
                    //     ),
                    //   ),
                    10.verticalSpace,
                    Text(
                      LocaleKeys.noMoney.tr(),
                      textAlign: TextAlign.center,
                      style: AppTextStyles.size15Medium.copyWith(
                        color: AppColors.c333333,
                      ),
                    ).paddingSymmetric(horizontal: 20),

                    25.verticalSpace,
                    SizedBox(
                      height: 50.h,
                      child: AppButton(
                        width: 100.sw,
                        onPressed: () {
                          navigatorKey.currentContext?.push(Routes.payment);
                        },
                        text: LocaleKeys.fillUpBalance.tr(),
                        textStyle: AppTextStyles.size17Medium.copyWith(
                          color: AppColors.cFFFFFF,
                        ),
                        color: AppColors.c2E3A59,
                      ),
                    ),
                    12.verticalSpace,
                    SizedBox(
                      height: 50.h,
                      child: AppButton(
                        width: 100.sw,
                        onPressed: () {
                          navigatorKey.currentContext?.pop();
                        },
                        text: LocaleKeys.back.tr(),
                        textStyle: AppTextStyles.size17Medium.copyWith(
                          color: AppColors.c2E3A59,
                        ),
                        color: AppColors.c2E3A59.newWithOpacity(.12),
                      ),
                    ),
                    40.verticalSpace,
                  ],
                ).paddingSymmetric(horizontal: 24),
              ),
            ),
          ],
        ),
  );
}

// void showWarningMessage(String message) {
//   showModalFlash<bool>(
//     barrierDismissible: true,
//     useRootNavigator: true,
//     duration: const Duration(seconds: 2),
//     builder: (context, controller) {
//       return FlashBar(
//         elevation: 0,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//             bottomLeft: Radius.circular(16),
//             bottomRight: Radius.circular(16),
//           ),
//         ),
//         forwardAnimationCurve: Curves.easeInCirc,
//         reverseAnimationCurve: Curves.bounceIn,
//         position: FlashPosition.top,
//         icon: const Icon(Icons.error, size: 30, color: Colors.white),
//         controller: controller,
//         backgroundColor: Colors.orange,
//         content: Text(
//           message,
//           style: AppTextStyles.size16Medium.copyWith(color: AppColors.cFFFFFF),
//         ),
//       );
//     },
//     context: navigatorKey.currentContext!,
//   );
// }
