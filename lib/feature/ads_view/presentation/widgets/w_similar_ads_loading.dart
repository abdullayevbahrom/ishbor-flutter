import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/constants/app_locale_keys.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../common/presentation/widget/w_similar_content_item.dart';

class WSimilarAdsLoading extends StatelessWidget {
  const WSimilarAdsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: 10,
        scrollDirection: Axis.vertical,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => 8.verticalSpace,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {},
            child: WSimilarContentViewItem(
              category: 'lorem',
              dateTime:"time",
              title: AppLocaleKeys.lorem,
              salaryMin: 1000,
              imageUrl: AppLocaleKeys.imageUrl,
              bgColor: AppColors.cF7F9FC,
            ),
          );
        },
      ),
    );
  }
}
