import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/theme/app_colors.dart';

import '../../../../../../core/theme/app_text_styles.dart';

class CreateActionForm extends StatelessWidget {
  const CreateActionForm({
    super.key,
    required this.onTap,
    required this.imageUrl,
    required this.title,
    required this.index,
  });

  final VoidCallback onTap;
  final String imageUrl;
  final String title;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.cTransparent,
      child: InkWell(
        onTap: onTap,
        borderRadius:
            index % 3 == 1
                ? BorderRadius.only(
                  topLeft: Radius.circular(18.r),
                  topRight: Radius.circular(18.r),
                )
                : index % 3 == 0
                ? BorderRadius.only(
                  bottomRight: Radius.circular(18.r),
                  bottomLeft: Radius.circular(18.r),
                )
                : BorderRadius.zero,
        child: Ink(
          color: AppColors.cFEFEFE,
          child: Row(
            spacing: 10.w,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(imageUrl, height: 30.h),
              Text(
                title,
                style: AppTextStyles.size17Medium.copyWith(
                  color: AppColors.c2E3A59,
                ),
              ),
            ],
          ),
        ).paddingOnly(
          left: 19.w,
          top: index % 3 == 1 ? 16.h : 12.h,
          bottom: index % 3 == 0 ? 16.h : 12.h,
          right: 30
        ),
      ),
    );
  }
}
