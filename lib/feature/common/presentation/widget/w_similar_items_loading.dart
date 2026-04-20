import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_similar_item.dart';

import '../../../../core/constants/app_locale_keys.dart';

class WSimilarItemsLoading extends StatelessWidget {
  const WSimilarItemsLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Column(
        children: List.generate(
          5,
              (index) => WSimilarItem(
            imageUrl: AppLocaleKeys.imageUrl,
            title: AppLocaleKeys.lorem,
            subTitle: AppLocaleKeys.lorem,
          ),
        ),
      ).paddingOnly(top: 16.h,bottom: 18.h),
    );
  }
}
