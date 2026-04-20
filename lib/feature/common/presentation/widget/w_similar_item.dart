import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/app_utils.dart';
import 'app_cached_network_image.dart';

class WSimilarItem extends StatelessWidget {
  const WSimilarItem(
      {super.key, this.imageUrl, required this.title, required this.subTitle});

  final String? imageUrl;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.cMainBg,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.cEDEDED),
      ),
      child: Row(
        children: [
          imageUrl == null
              ? AppUtils.kSizedBoxShrink
              : AppCachedNetworkImage(
            height: 63.h,
            radius: 6.r,
            imageUrl: imageUrl,
          ).paddingOnly(right: 24.w),
          Expanded(
            child: Column(
              spacing: 8.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.size17Medium,
                ),
                Text(
                  subTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.size15Regular.copyWith(
                    color: AppColors.c888888,
                  ),
                ),
              ],
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: 16.w, vertical: 8.h),
    );
  }
}
