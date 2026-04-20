import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_svg_icon.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_svg.dart';
import '../../../../core/theme/app_text_styles.dart';

class WCountSeeCountClick extends StatelessWidget {
  const WCountSeeCountClick({super.key, this.countSee, this.countContactClick});

  final int? countSee;
  final int? countContactClick;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5.w,
      children: [
        WSvgIcon(svgUrl: AppSvg.icCountSee),
        Text(
          "${countSee ?? 0}",
          style: AppTextStyles.size17Medium.copyWith(color: AppColors.c2E3A59),
        ),
        SizedBox(width: 8.w),
        SizedBox(
          height: 20.r,
          width: 20.r,
          child: SvgPicture.asset(AppSvg.icPhone).paddingAll(2.r),
        ),
        Text(
          "${countContactClick ?? 0}",
          style: AppTextStyles.size17Medium.copyWith(color: AppColors.c2E3A59),
        ),
      ],
    );
  }
}
