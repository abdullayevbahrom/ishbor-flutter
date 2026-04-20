import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/extentions/color_extension.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/helpers/app_launcher.dart';
import 'package:top_jobs/core/theme/app_colors.dart';
import 'package:top_jobs/core/theme/app_svg.dart';
import 'package:top_jobs/core/theme/app_text_styles.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_button.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_layout.dart';

class WErrorPage extends StatelessWidget {
  const WErrorPage({super.key, required this.onPressedReTry});

  final VoidCallback onPressedReTry;

  @override
  Widget build(BuildContext context) {
    return WLayout(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.r),
                color: AppColors.cFF3A44.newWithOpacity(.3),
              ),
              child: SvgPicture.asset(AppSvg.icWifiOff).paddingAll(25.r),
            ),
            28.verticalSpace,
            Text(
              LocaleKeys.smthGotWrong.tr(),
              textAlign: TextAlign.center,
              style: AppTextStyles.size16Medium.copyWith(
                color: AppColors.c2E3A59,
              ),
            ),
            8.verticalSpace,
            Text(
              LocaleKeys.tryAgainOrCheckInternet.tr(),
              textAlign: TextAlign.center,
              style: AppTextStyles.size16Regular.copyWith(
                color: AppColors.c2E3A59.newWithOpacity(.74),
              ),
            ),
            25.verticalSpace,
            AppButton(
              onPressed: onPressedReTry,
              width: 100.sw,
              verticalPadding: 12.h,
              text: LocaleKeys.tryAgain.tr(),
              textStyle: AppTextStyles.size17Medium.copyWith(
                color: AppColors.cFFFFFF,
              ),
              color: AppColors.c2E3A59,
            ), 
            9.verticalSpace,
            AppButton(
              onPressed: () {
                AppLauncher().launchTelegram("@ishboruz_elon");
              },
              width: 100.sw,
              verticalPadding: 12.h,
              textStyle: AppTextStyles.size17Medium.copyWith(
                color: AppColors.c2E3A59,
              ),
              text: LocaleKeys.askToSupport.tr(),
              color: AppColors.c2E3A59.newWithOpacity(.12),
            ),
          ],
        ).paddingSymmetric(horizontal: 16.w),
      ),
    );
  }
}
