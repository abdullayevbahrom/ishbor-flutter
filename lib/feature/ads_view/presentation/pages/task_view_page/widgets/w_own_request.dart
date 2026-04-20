import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/theme/app_colors.dart';
import 'package:top_jobs/core/theme/app_text_styles.dart';
import 'package:top_jobs/models/task_request.dart';

import '../../../../../../core/helpers/formatters.dart';
import '../../../../../../core/theme/app_svg.dart';
import '../../../../../common/presentation/widget/w_default_user_avatar.dart';

class WOwnRequest extends StatelessWidget {
  const WOwnRequest({super.key, required this.taskRequest});

  final TaskRequest taskRequest;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.yourRequest.tr(),
          style: AppTextStyles.size22Medium.copyWith(color: AppColors.c2E3A59),
        ),
        16.verticalSpace,
        SizedBox(
          width: 100.sw,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.cF7F9FC,
              borderRadius: BorderRadius.circular(18.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 23.w,
                  children: [
                    WDefaultUserAvatar(height: 82.h),
                    Column(
                      spacing: 3.h,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          taskRequest.performer.fullName ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.size17Medium.copyWith(
                            color: AppColors.c2E3A59,
                          ),
                        ),
                        Text(
                          LocaleKeys.lastSeenAgo.tr(
                            args: [Formatters.timeAgo(taskRequest.createdAt)],
                          ),
                          style: AppTextStyles.size14Regular.copyWith(
                            color: AppColors.cBDC0C6,
                          ),
                        ),
                        Row(
                          spacing: 4.w,
                          children: [
                            SvgPicture.asset(AppIcons.icLike),
                            Text(
                              '${taskRequest.performer.likesCount ?? 0}',
                              style: AppTextStyles.size13Medium.copyWith(
                                color: AppColors.c888888,
                              ),
                            ),
                            2.horizontalSpace,
                            SvgPicture.asset(AppIcons.icDislike),
                            Text(
                              '${taskRequest.performer.dislikesCount}',

                              style: AppTextStyles.size13Medium.copyWith(
                                color: AppColors.c888888,
                              ),
                            ),
                          ],
                        ),
                        2.verticalSpace,
                        Row(
                          spacing: 4.w,
                          children: [
                            SvgPicture.asset(AppSvg.icCalendar),
                            Text(
                              LocaleKeys.respondAgo.tr(
                                namedArgs: {
                                  "duration": Formatters.timeAgo(
                                    taskRequest.createdAt,
                                  ),
                                },
                              ),
                              style: AppTextStyles.size13Regular.copyWith(
                                color: AppColors.c2E3A59,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                15.verticalSpace,
                Text(
                  Formatters.formatSalary(salaryMin: taskRequest.price),
                  style: AppTextStyles.size16Bold.copyWith(
                    color: AppColors.cFF9914,
                  ),
                ),
                Text(
                  taskRequest.message ?? "",
                  style: AppTextStyles.size15Regular.copyWith(
                    color: AppColors.c888888,
                  ),
                ),


              ],
            ).paddingAll(16.r),
          ),
        ),
        16.verticalSpace,

      ],
    ).paddingSymmetric(horizontal: 16.w);
  }
}
