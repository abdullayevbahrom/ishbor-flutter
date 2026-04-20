import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:top_jobs/core/constants/app_locale_keys.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/theme/app_colors.dart';
import 'package:top_jobs/core/theme/app_text_styles.dart';
import 'package:top_jobs/feature/ads_view/presentation/widgets/w_ads_chipbox.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_button.dart';

class WAdsViewLoading extends StatelessWidget {
  const WAdsViewLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        children: [
          24.verticalSpace,
          Row(
            spacing: 15.w,
            children: const [
              Text("6 soat oldin", style: TextStyle(fontSize: 16)),
              Text("Toshkent viloyati"),
            ],
          ),
          12.verticalSpace,
          Text(
            AppLocaleKeys.lorem,
            style: AppTextStyles.size28Bold,
            maxLines: 2,
          ),
          12.verticalSpace,
          const Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            spacing: 8,
            runSpacing: 8,
            children: [
              WChipBoxItem(text: "Full time"),
              WChipBoxItem(text: "Full time Full time"),
              WChipBoxItem(text: "Full time Full time  Full time"),
              WChipBoxItem(text: "Full time"),
            ],
          ),
          17.verticalSpace,
          Text("1 000 000", style: AppTextStyles.size24Bold),
          26.verticalSpace,
          SizedBox(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.r),
                border: Border.all(color: AppColors.cE0E0E0, width: 1.r),
              ),
              child: const Text(
                AppLocaleKeys.lorem +
                    AppLocaleKeys.lorem +
                    AppLocaleKeys.lorem +
                    AppLocaleKeys.lorem,
              ).paddingSymmetric(vertical: 22.h, horizontal: 16.w),
            ),
          ),
          18.verticalSpace,
          Row(
            spacing: 10.w,
            children: [
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: AppButton(
                    onPressed: () {},
                    text: "",
                    color: AppColors.cFFFFFF,
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: AppButton(
                    onPressed: () {},
                    text: "",
                    color: AppColors.cFFFFFF,
                  ),
                ),
              ),
            ],
          ),
          10.verticalSpace,
          SizedBox(
            height: 50,
            child: AppButton(
              width: 100.sw,
              onPressed: () {},
              text: "",
              color: AppColors.cFFFFFF,
            ),
          )

        ],
      ),
    );
  }
}
