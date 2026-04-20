import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/helpers/app_launcher.dart';
import 'package:top_jobs/core/theme/app_colors.dart';
import 'package:top_jobs/core/theme/app_text_styles.dart';
import 'package:top_jobs/core/utils/app_utils.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_button.dart';

import '../../../../core/theme/app_svg.dart';

class BottomMenu extends StatelessWidget {
  const BottomMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // SvgPicture.asset(AppSvg.icQuestions),
          // AppUtils.hSizedBox30,
          // Text(
          //   LocaleKeys.frequentlyAskedQuestion.tr(),
          //   style: AppTextStyles.size18Medium,
          // ),
          // Text(
          //   LocaleKeys.getAnswerForQuestions.tr(),
          //   textAlign: TextAlign.center,
          //   style: AppTextStyles.size15Regular.copyWith(
          //     color: AppColors.c888888,
          //   ),
          // ).paddingOnly(top: 8.h, bottom: 16.h),
          // AppButton(
          //   onPressed: () {},
          //   text: LocaleKeys.viewQuestions.tr(),
          //   color: AppColors.cFAFAFA,
          //   textStyle: AppTextStyles.size17Medium,
          // ),
          // AppUtils.hSizedBox32,
          // SvgPicture.asset(AppSvg.icNews),
          // AppUtils.hSizedBox30,
          // Text(LocaleKeys.latestNews.tr(), style: AppTextStyles.size18Medium),
          // RichText(
          //   textAlign: TextAlign.center,
          //   text: TextSpan(
          //     style: AppTextStyles.size15Regular.copyWith(
          //       color: AppColors.c888888,
          //     ),
          //     children: [
          //       if (context.locale.languageCode == 'uz')
          //         TextSpan(
          //           text: " ISH BOR ",
          //           style: AppTextStyles.size15Regular.copyWith(
          //             color: AppColors.cFF9914,
          //           ),
          //         ),
          //       TextSpan(
          //         text: tr('findLatestNewsAndUpdates'),
          //
          //         style: AppTextStyles.size15Regular.copyWith(
          //           color: AppColors.c888888,
          //         ),
          //       ),
          //       if (context.locale.languageCode == 'ru')
          //         TextSpan(
          //           text: "ISH BOR ",
          //           style: AppTextStyles.size15Regular.copyWith(
          //             color: AppColors.cFF9914,
          //           ),
          //         ),
          //     ],
          //   ),
          // ).paddingOnly(top: 8.h, bottom: 16.h),
          // AppButton(
          //   onPressed: () {},
          //   text: LocaleKeys.readNews.tr(),
          //   color: AppColors.cFAFAFA,
          //   textStyle: AppTextStyles.size17Medium,
          // ),
          // AppUtils.hSizedBox32,
          SvgPicture.asset(AppSvg.icSupport),
          AppUtils.hSizedBox30,
          Text(LocaleKeys.helpCenter.tr(), style: AppTextStyles.size18Medium),
          Text(
            LocaleKeys.didNotFindAnswersToQuestions.tr(),
            textAlign: TextAlign.center,
            style: AppTextStyles.size15Regular.copyWith(
              color: AppColors.c888888,
            ),
          ).paddingOnly(top: 8.h, bottom: 16.h),
          AppButton(
            onPressed: () {
              AppLauncher().launchTelegram("ishboruz_elon",);
            },
            text: LocaleKeys.contactSupport.tr(),
            color: AppColors.cF7F9FC,
            textStyle: AppTextStyles.size17Medium,
          ),
        ],
      ),
    );
  }
}
