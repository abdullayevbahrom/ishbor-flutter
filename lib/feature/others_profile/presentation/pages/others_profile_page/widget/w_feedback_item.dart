import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_decorated_box.dart';
import 'package:top_jobs/models/feedback.dart';
import '../../../../../../core/helpers/formatters.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_svg.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../core/utils/app_utils.dart';
import '../../../../../common/presentation/widget/app_cached_network_image.dart';

class FeedBackItem extends StatelessWidget {
  const FeedBackItem({super.key, required this.feedbackModel});

  final FeedbackModel? feedbackModel;

  @override
  Widget build(BuildContext context) {
    return WDecoratedBox(
      radius: 16.r,
      bgColor: AppColors.cF7F9FC,
      child: Column(
        spacing: 16.h,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppCachedNetworkImage(height: 60.h, radius: 30.h),
              AppUtils.wSizedBox20,
              Column(
                spacing: 4.h,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${feedbackModel?.sender.fullName ?? ''}",
                    style: AppTextStyles.size17Medium,
                  ),
                  Text(
                    Formatters.timeAgo(DateTime.now()),
                    style: AppTextStyles.size15Regular.copyWith(
                      color: AppColors.cBDC0C6,
                    ),
                  ),
                ],
              ),
              AppUtils.wSizedBox8,
              if (feedbackModel?.like ?? false)
                SvgPicture.asset(AppIcons.icLike, height: 17.r),
              if (feedbackModel?.dislike ?? false)
                SvgPicture.asset(AppIcons.icDislike, height: 17.r),
            ],
          ),
          Text(
            "${feedbackModel?.message ?? ''}",
            style: AppTextStyles.size15Regular,
          ),
        ],
      ).paddingAll(18.r),
    );
  }
}
