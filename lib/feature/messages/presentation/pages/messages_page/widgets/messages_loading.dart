import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_divider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_jobs/core/constants/app_locale_keys.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/helpers/formatters.dart';
import 'package:top_jobs/core/theme/app_colors.dart';
import 'package:top_jobs/core/theme/app_text_styles.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_cached_network_image.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_animated_button_wrapper.dart';


class WMessagesLoading extends StatelessWidget {
  const WMessagesLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) => WMessageLoadingItem(),
        separatorBuilder:
            (context, index) => AppDivider(
              height: 1.h,
              width: 100.sw,
            ).paddingOnly(left: 80.w),
        itemCount: 10,
      ),
    );
  }
}

class WMessageLoadingItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedButtonWrapper(
      onTap: () {},
      child: Ink(
        decoration: BoxDecoration(color: AppColors.cFFFFFF),
        child: Row(
          spacing: 20.w,
          children: [
            AppCachedNetworkImage(height: 50, radius: 26),
            Expanded(
              child: Column(
                spacing: 4.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    spacing: 20.w,
                    children: [
                      Expanded(
                        child: Text(
                          "Eshonqulov Jahongir",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.size17Medium,
                        ),
                      ),
                      Text(
                        Formatters.formatDate(DateTime.now()),
                        style: AppTextStyles.size14Regular.copyWith(
                          color: AppColors.c888888,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: 20.w,
                    children: [
                      Expanded(
                        child: Text(
                          AppLocaleKeys.lorem,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.size15Regular.copyWith(
                            color: AppColors.c888888,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 16.w, vertical: 19.h),
      ),
    );
  }
}
