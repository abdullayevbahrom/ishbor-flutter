import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_styles.dart' show AppTextStyles;

class WDecoratedDetailColumn extends StatelessWidget {
  const WDecoratedDetailColumn({
    super.key,
    required this.title,
    required this.description,
    this.textColor,
  });

  final String title;
  final String description;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.size15Medium.copyWith(color: AppColors.c333333),
        ),
        SizedBox(
          width: 100.sw,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.cF6F7FB,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              description,
              style: AppTextStyles.size15Medium.copyWith(
                color: textColor ?? AppColors.c333333,
              ),
            ).paddingSymmetric(vertical: 10.h, horizontal: 16.w),
          ),
        ),
      ],
    );
  }
}
