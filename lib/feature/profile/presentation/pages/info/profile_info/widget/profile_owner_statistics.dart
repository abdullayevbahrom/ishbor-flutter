import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/utils/app_utils.dart';
import 'package:top_jobs/feature/common/presentation/cubits/feedback_cubit/feedback_cubit.dart';

import '../../../../../../../core/constants/locale_keys.g.dart';
import '../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../core/theme/app_svg.dart';
import '../../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../../injection_container.dart';
import '../../../../../../common/presentation/cubits/user_cubit/user_cubit.dart';
import '../../../../../../common/presentation/widget/app_cached_network_image.dart';
import '../../../../../../common/presentation/widget/w_default_user_avatar.dart';

class ProfileOwnerStatistics extends StatefulWidget {
  ProfileOwnerStatistics({super.key});

  @override
  State<ProfileOwnerStatistics> createState() => _ProfileOwnerStatisticsState();
}

class _ProfileOwnerStatisticsState extends State<ProfileOwnerStatistics> {
  final feedBackCubit = sl<FeedbackCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        final user = state.user;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 24.w,
              children: [
                user?.avatar == null
                    ? WDefaultUserAvatar(height: 82.h)
                    :
                    //ToDo if avatar url null we use default avatar
                    AppCachedNetworkImage(
                      height: 82.h,
                      radius: 41.sp,
                      imageUrl: user?.avatar?.urls['original'],
                    ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4.h,
                    children: [
                      Text(
                        "${user?.fullName ?? ""}",
                        style: AppTextStyles.size17Medium,
                      ),
                      Text(
                        "${user?.balance == 0 ? 0 : user?.balance} ${LocaleKeys.sum.tr()}",
                        style: AppTextStyles.size18Bold.copyWith(
                          color: AppColors.cFF9914,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            AppUtils.hSizedBox16,
            // Material(
            //   color: AppColors.cTransparent,
            //   child: InkWell(
            //     onTap: () {
            //       context.push(Routes.payment, extra: user?.balance);
            //     },
            //     child: Ink(
            //       height: 45.h,
            //       width: 100.sw,
            //       decoration: BoxDecoration(
            //         color: AppColors.c15CF74,
            //         borderRadius: BorderRadius.circular(12.r),
            //         boxShadow: [
            //           BoxShadow(
            //             color: AppColors.c15CF74.newWithOpacity(.4),
            //             blurRadius: 15.r,
            //             offset: Offset(0, 4),
            //           ),
            //         ],
            //       ),
            //       child: Row(
            //         mainAxisSize: MainAxisSize.max,
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           SvgPicture.asset(AppSvg.icPayment),
            //           Text(
            //             LocaleKeys.fillUpBalance.tr(),
            //             style: AppTextStyles.size15Medium.copyWith(
            //               color: AppColors.cFFFFFF,
            //             ),
            //           ).paddingSymmetric(vertical: 12.h, horizontal: 16.w),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            AppUtils.hSizedBox16,

            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BlocProvider(
                    create: (context) => feedBackCubit,
                    child: BlocBuilder<FeedbackCubit, FeedbackState>(
                      bloc: feedBackCubit..fetchFeedbacksCount(user?.id ?? 0),
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () {},
                          child: SizedBox(
                            height: 70.h,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: AppColors.cFF9914,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12.r),
                                  bottomLeft: Radius.circular(12.r),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    LocaleKeys.Feedbacks.tr(),
                                    style: AppTextStyles.size13Regular.copyWith(
                                      color: AppColors.cFFFFFF,
                                    ),
                                  ),
                                  Text(
                                    "${state.countFeedback}",
                                    style: AppTextStyles.size22Medium.copyWith(
                                      color: AppColors.cFFFFFF,
                                    ),
                                  ),
                                ],
                              ).paddingSymmetric(horizontal: 15.w),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 70.h,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: AppColors.cF6F7FB),
                      child: Row(
                        spacing: 10.w,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppIcons.icLike,
                            height: 20.r,
                            width: 20.r,
                          ),
                          Text(
                            "${user?.likesCount ?? '0'}",
                            style: AppTextStyles.size17Medium.copyWith(
                              color: AppColors.c888888,
                            ),
                          ),
                        ],
                      ).paddingOnly(left: 16.w),
                    ),
                  ),
                  SizedBox(
                    height: 70.h,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors.cF6F7FB,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12.r),
                          bottomRight: Radius.circular(12.r),
                        ),
                      ),
                      child: Row(
                        spacing: 10.w,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppIcons.icDislike,
                            width: 20.r,
                            height: 20.r,
                          ),
                          Text(
                            "${user?.dislikesCount ?? ''}",
                            style: AppTextStyles.size17Medium.copyWith(
                              color: AppColors.c888888,
                            ),
                          ),
                        ],
                      ).paddingSymmetric(horizontal: 16.w),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ).paddingAll(16.sp);
      },
    );
  }
}
