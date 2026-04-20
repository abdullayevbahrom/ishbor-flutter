import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';

import '../../../../core/constants/locale_keys.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'app_button.dart';

class WCreateAndCancelButtons extends StatelessWidget {
  const WCreateAndCancelButtons({
    super.key,
    required this.onTapCreate,
    required this.onTapCancel,
    required this.title,
    required this.isLoading,
  });

  final VoidCallback onTapCreate;
  final VoidCallback onTapCancel;
  final String title;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 24.h,
      children: [
        AppButton(
          radius: 12.r,
          isLoading: isLoading,
          onPressed: onTapCreate,
          text: title,
          color: AppColors.cFF9914,
          textStyle: AppTextStyles.size18Bold.copyWith(
            color: AppColors.cFFFFFF,
          ),
        ),
        InkWell(
          onTap: onTapCancel,
          borderRadius: BorderRadius.circular(12.r),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.cE0E5EB, width: 2.r),
            ),
            child: Text(
              LocaleKeys.cancel.tr(),
              style: AppTextStyles.size18Bold.copyWith(
                color: AppColors.cBDC0C6,
              ),
            ).paddingSymmetric(horizontal: 32.w, vertical: 12.h),
          ),
        ),
      ],
    );
  }
}
