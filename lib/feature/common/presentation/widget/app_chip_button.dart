import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class AppChipButton extends StatelessWidget {
  AppChipButton({
    super.key,
    required this.label,
    this.isActive,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;
  final bool? isActive;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Chip(
        labelPadding: EdgeInsets.symmetric(vertical: 5.sp, horizontal: 12.sp),
        side: BorderSide(
          color: isActive ?? false ? AppColors.cFF9914 : AppColors.cE0E5EB,
          width: isActive ?? false ? 2.sp : 1.sp,
        ),
        backgroundColor: AppColors.cMainBg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        color: WidgetStatePropertyAll(AppColors.cMainBg),
        label: Text(label, style: AppTextStyles.size14Medium),
      ),
    );
  }
}
