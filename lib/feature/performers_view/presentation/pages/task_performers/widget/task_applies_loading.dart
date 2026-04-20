import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:top_jobs/core/extentions/color_extension.dart';

import '../../../../../../core/theme/app_colors.dart';

class WTaskApplyRequestsLoading extends StatelessWidget {
  const WTaskApplyRequestsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder:
            (context, index) => Container(
              height: 190.h,
              width: 100.sw,
              decoration: BoxDecoration(
                color: AppColors.c000000.newWithOpacity(.02),
                borderRadius: BorderRadius.circular(18.r),
              ),
            ),
        separatorBuilder: (context, index) => 8.verticalSpace,
        itemCount: 10,
      ),
    );
  }
}