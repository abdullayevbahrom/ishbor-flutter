import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_styles.dart';

class WReviewMood extends StatelessWidget {
  const WReviewMood({
    super.key,
    required this.svg,
    required this.text,
    required this.onPressed,
    this.isActive,
  });

  final String svg;
  final String text;
  final VoidCallback onPressed;
  final bool? isActive;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12.r),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: isActive ?? false ? AppColors.c2E3A59 : AppColors.cF7F9FC,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          spacing: 12.w,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(svg, height: 20.h),
            Text(
              text,
              style: AppTextStyles.size15Medium.copyWith(
                color:
                isActive ?? false ? AppColors.cFFFFFF : AppColors.c333333,
              ),
            ),
          ],
        ).paddingSymmetric(vertical: 12.h),
      ),
    );
  }
}
