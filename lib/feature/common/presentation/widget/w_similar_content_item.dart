import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_jobs/core/extentions/color_extension.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/feature/ads_view/presentation/widgets/w_ads_chipbox.dart';

import '../../../../core/helpers/formatters.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class WSimilarContentViewItem extends StatelessWidget {
  const WSimilarContentViewItem({
    super.key,
    this.imageUrl,
    this.salaryMin,
    this.salaryMax,
    required this.title,
    this.bgColor,
    required this.category,
    required this.dateTime,
  });

  final String? imageUrl;
  final double? salaryMin;
  final double? salaryMax;
  final String title;
  final Color? bgColor;
  final String category;
  final String dateTime;

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: 120.h,
      width: 100.sw,
      decoration: BoxDecoration(
        color: bgColor ?? AppColors.cFFFFFF,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Row(
        spacing: 18.w,
        children: [
          if (imageUrl != null)
            SizedBox(
              height: 76.h,
              width: 76.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: imageUrl!,
                ),
              ),
            ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.size17Bold.copyWith(
                      color: AppColors.c2E3A59,
                    ),
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  Formatters.formatSalary(
                    salaryMin: salaryMin,
                    salaryMax: salaryMax,
                  ),
                  style: AppTextStyles.size15Bold.copyWith(
                    color: AppColors.cFF9914,
                  ),
                ),
                4.verticalSpace,
                SizedBox(
                  height: 30,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      WChipBoxItem(text: category, isCategory: true),
                      8.horizontalSpace,
                      WChipBoxItem(
                        text: dateTime,
                        bgColor: AppColors.c2E3A59.newWithOpacity(.06),
                      ),
                    ],
                  ),
                )

              ],
            ),
          ),
        ],
      ).paddingAll(12.r),
    );
  }
}
