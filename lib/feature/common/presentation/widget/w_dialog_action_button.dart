import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class WDialogActionButton extends StatelessWidget {
  const WDialogActionButton({
    super.key,
    required this.onTap,
    required this.title,
    required this.isEnable,
  });

  final VoidCallback onTap;
  final String title;
  final bool isEnable;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(isEnable ? 16.r : 0),
          bottomRight: Radius.circular(!isEnable ? 16.r : 0),
        ),
        child: Center(
          child: Text(
            title,
            style: AppTextStyles.size20Bold.copyWith(
              color: isEnable ? AppColors.cRed : AppColors.cGreen,
            ),
          ).paddingSymmetric(vertical: 15.h),
        ),
      ),
    );
  }
}
