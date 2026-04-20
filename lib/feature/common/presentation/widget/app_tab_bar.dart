import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class AppTabBar extends StatelessWidget {
  const AppTabBar({
    super.key,
    required this.onTap,
    required this.titles,
    this.indicatorColor,
    this.unSelectedTextStyle,
    this.selectedTextStyle,
    this.tabController,
  });

  final Function(int index) onTap;
  final List<Widget> titles;
  final Color? indicatorColor;
  final TextStyle? unSelectedTextStyle;
  final TextStyle? selectedTextStyle;
  final TabController? tabController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: TabBar(
        controller: tabController,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        onTap: onTap,
        physics: const BouncingScrollPhysics(),
        unselectedLabelStyle:
            unSelectedTextStyle ??
            AppTextStyles.size15Bold.copyWith(
              color: AppColors.cBDC0C6,
              fontSize: 14.r,
            ),
        splashFactory: NoSplash.splashFactory,
        dividerColor: AppColors.cBDC0C6,
        dividerHeight: 3.h,
        indicatorColor: indicatorColor ?? AppColors.cFF9914,
        indicatorSize: TabBarIndicatorSize.tab,

        labelStyle:
            selectedTextStyle ??
            AppTextStyles.size15Bold.copyWith(fontSize: 15.r),
        labelPadding: EdgeInsets.only(bottom: 10.h),
        tabs: titles,
      ),
    ).paddingOnly(top: 24.h, bottom: 14.h);
  }
}
