import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:top_jobs/core/extentions/color_extension.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/theme/app_png.dart';
import 'package:top_jobs/core/utils/app_utils.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_decorated_box.dart';

import '../../../../core/constants/app_locale_keys.dart';
import '../../../../core/constants/locale_keys.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class WLoading extends StatelessWidget {
  const WLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,

      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 10,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return LoadingItem();
        },
      ),
    );
  }
}

class LoadingItem extends StatelessWidget {
  const LoadingItem({super.key});

  @override
  Widget build(BuildContext context) {
    return WDecoratedBoxWithShadow(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Amaya Soft',
                style: AppTextStyles.size13Regular.copyWith(
                  color: AppColors.c888888,
                ),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Status',
                      style: AppTextStyles.size10Regular.copyWith(
                        color: AppColors.cRed,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 5.w,
                      children: [
                        Text(
                          'qwe',
                          style: AppTextStyles.size13Regular.copyWith(
                            color: AppColors.c888888,
                          ),
                        ),
                        Text(
                          '12',
                          style: AppTextStyles.size13Regular.copyWith(
                            color: AppColors.c888888,
                          ),
                        ),
                      ],
                    ).paddingOnly(left: 10.w),
                  ],
                ).paddingOnly(left: 4.w),
              ),
            ],
          ),
          AppUtils.hSizedBox24,
          Row(
            spacing: 24.w,
            children: [
              Container(
                height: 70.r,
                width: 70.r,
                decoration: BoxDecoration(
                  color: AppColors.cGrey.newWithOpacity(.5),
                  borderRadius: BorderRadius.circular(18.r),
                  image: DecorationImage(
                    image: AssetImage(AppPng.map),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                spacing: 10.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Flutter dev',
                    softWrap: true,
                    style: AppTextStyles.size20Bold,
                  ),
                  Text(
                    "3- 6 mln so'm",
                    style: AppTextStyles.size18Bold.copyWith(
                      color: AppColors.cFF9914,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            AppLocaleKeys.lorem,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.size15Regular.copyWith(
              color: AppColors.c888888,
            ),
          ).paddingOnly(top: 8.h),
          Text(
            LocaleKeys.tashkent.tr(),
            style: AppTextStyles.size13Regular.copyWith(
              color: AppColors.c888888,
            ),
          ).paddingOnly(top: 16.h),
        ],
      ),
    ).paddingSymmetric(horizontal: 16.w, vertical: 10.h);
  }
}
