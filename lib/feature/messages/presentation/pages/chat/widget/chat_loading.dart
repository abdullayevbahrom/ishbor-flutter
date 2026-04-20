import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:top_jobs/core/extentions/color_extension.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';

import '../../../../../../core/theme/app_colors.dart';

class WChatLoading extends StatelessWidget {
  const WChatLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: 10,
        separatorBuilder: (context, index) => 20.verticalSpace,
        itemBuilder: (context, index) {
          bool isLeft = index % 2 == 0;
          return DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.r),
              color:
              isLeft
                  ? AppColors.cFFFFFF.newWithOpacity(.5)
                  : AppColors.cFFFFFF,
            ),
            child: Text(
              index % 3 == 1
                  ? '''qweqweqwewqeqweqwe\nwofweqboibqwioeboqwe'''
                  : '''qweqweqwewqeqweqwe\nwofweqboibqwioeboqwe wofweqboibqwioeboqwe''',
            ).paddingSymmetric(horizontal: 12.w, vertical: 8.h),
          ).paddingOnly(right: isLeft ? 100.w : 0, left: isLeft ? 0 : 100.w);
        },
      ),
    );
  }
}
