import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_styles.dart';

class WCategoryRow extends StatelessWidget {
  const WCategoryRow({
    super.key,
    required this.title,
    required this.isEnable,
    required this.onTap,
  });

  final String title;
  final bool isEnable;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyles.size18Medium.copyWith(
              color: AppColors.c333333,
            ),
          ),
           Badge(
            isLabelVisible: isEnable,
                backgroundColor: AppColors.cFF9914,
                child: Icon(
                  Icons.keyboard_arrow_right_rounded,
                  color: AppColors.cC1C1C1,
                  size: 24.h,
                ),
              )
        ],
      ).paddingSymmetric(horizontal: 40.w, vertical: 16.h),
    );
  }
}
