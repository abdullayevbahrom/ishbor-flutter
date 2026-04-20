import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_styles.dart';

class IconRow extends StatelessWidget {
  const IconRow({super.key, required this.iconUrl, required this.count});

  final String iconUrl;
  final String count;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 4.w,
      children: [
        SvgPicture.asset(iconUrl, height: 18.r, width: 18.r),
        Text(
          count,
          style: AppTextStyles.size17Medium.copyWith(color: AppColors.c888888),
        ),
      ],
    );
  }
}
