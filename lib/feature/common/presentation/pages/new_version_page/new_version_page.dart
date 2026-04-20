import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/helpers/app_launcher.dart';
import 'package:top_jobs/core/theme/app_colors.dart';
import 'package:top_jobs/core/theme/app_text_styles.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_button.dart';

class NewVersionPage extends StatelessWidget {
  const NewVersionPage({super.key, required this.storeLink});

  final String storeLink;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(CupertinoIcons.rocket_fill, color: AppColors.cFF9914, size: 180),
          50.verticalSpace,
          Text(
           LocaleKeys.updateAvailableTitle.tr(),
            style: AppTextStyles.size24Bold.copyWith(color: AppColors.c2E3A59),
          ),
          20.verticalSpace,
          Text(
            LocaleKeys.updateAvailableMessage.tr(),
            textAlign: TextAlign.center,
            style: AppTextStyles.size18Medium.copyWith(
              color: AppColors.c333333,
            ),
          ),
          40.verticalSpace,
          SizedBox(
            height: 50.h,
            child: AppButton(
              width: 100.sw,
              onPressed: () {
                AppLauncher().launchURL(storeLink);
              },
              text: LocaleKeys.updateButton.tr(),
              color: AppColors.c2E3A59,
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: 16.w),
    );
  }
}
