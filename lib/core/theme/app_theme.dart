import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_jobs/core/theme/app_colors.dart';

import 'app_text_styles.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData.light().copyWith(
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.cFFFFFF,
      foregroundColor: AppColors.cF6F7FB,
      surfaceTintColor: Colors.transparent,
    ),
    scaffoldBackgroundColor: AppColors.cFFFFFF,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 2,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      backgroundColor: AppColors.cF6F7FB,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.cFF9914,
      unselectedItemColor: AppColors.c888888,
      selectedLabelStyle: AppTextStyles.size14Medium.copyWith(
        color: AppColors.cFF9914,
        fontFamily: "fontNorms",
      ),
      unselectedLabelStyle: AppTextStyles.size14Medium.copyWith(
        color: AppColors.c888888,
        fontFamily: "fontNorms",
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.cMainBg,
      hintStyle: AppTextStyles.size15Medium.copyWith(color: AppColors.c888888),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      errorStyle: AppTextStyles.size12Medium.copyWith(color: AppColors.cRed),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.sp),
        borderSide: BorderSide(color: AppColors.cRed, width: 1.5.r),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.sp),
        borderSide: BorderSide(color: AppColors.cFF9914, width: 1.5.r),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.sp),
        borderSide: BorderSide(color: AppColors.cEDEDED, width: 1.5.r),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.sp),
        borderSide: BorderSide(color: AppColors.cRed, width: 1.5.r),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.sp),
        borderSide: BorderSide(color: AppColors.cEDEDED, width: 1.5.r),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.sp),
        borderSide: BorderSide(color: AppColors.cEDEDED, width: 1.5.r),
      ),
    ),
  );
}
