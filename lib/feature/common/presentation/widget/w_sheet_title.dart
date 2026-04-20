import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_svg.dart';
import '../../../../core/theme/app_text_styles.dart';

class WSheetTitle extends StatelessWidget {
  const WSheetTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyles.size24Bold.copyWith(color: AppColors.c2E3A59),
        ),
        IconButton(
          onPressed: () {
            context.pop();
          },
          icon: SvgPicture.asset(AppSvg.icCancel, height: 18.r),
        ),
      ],
    ).paddingSymmetric(horizontal: 16.w);
  }
}
