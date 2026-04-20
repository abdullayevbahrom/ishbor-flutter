import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/theme/app_colors.dart';
import 'package:top_jobs/core/theme/app_svg.dart';
import 'package:top_jobs/core/theme/app_text_styles.dart';
import 'package:top_jobs/core/utils/app_utils.dart';
import 'package:top_jobs/feature/auth/presentation/pages/login_page/login_page.dart';
import 'package:top_jobs/feature/common/presentation/cubits/feedback_cubit/feedback_cubit.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_button.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_divider.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_header.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_decorated_box.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_layout.dart';
import 'package:top_jobs/feature/others_profile/presentation/pages/others_profile_page/widget/w_feedback_item.dart';
import 'package:top_jobs/feature/others_profile/presentation/pages/others_profile_page/widget/w_review_modal_button.dart';
import 'package:top_jobs/feature/others_profile/presentation/pages/others_profile_page/widget/w_tab_bar.dart';
import 'package:top_jobs/feature/others_profile/presentation/pages/others_profile_page/widget/w_user_info.dart';

import '../../../../../injection_container.dart';
import '../../../../../models/user.dart';
import '../../../../common/presentation/cubits/user_cubit/user_cubit.dart';

class OthersProfilePage extends StatelessWidget {
  OthersProfilePage({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    final locale = context.locale.languageCode;
    return WLayout(
      child: Scaffold(
        backgroundColor: AppColors.cFFFFFF,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppHeader(isPopAvailable: true),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    WUserInfo(
                      user: user,
                      locale: locale,
                    ).paddingSymmetric(horizontal: 16.w),
                    WReviews(user: user).paddingSymmetric(horizontal: 16.w),
                    WTabBar(userId: user.id),
                    AppUtils.hSizedBox40,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WReviews extends StatelessWidget {
  const WReviews({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<FeedbackCubit>()..fetchFeedBackList(user.id),
      child: BlocBuilder<FeedbackCubit, FeedbackState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppUtils.hSizedBox16,
              WDecoratedBox(
                radius: 16.r,
                bgColor: AppColors.cF7F9FC,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (state.listSt.isLoaded())
                          if ((state.listFeedBack?.items ?? []).isEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  LocaleKeys.noReviewsYet.tr(),
                                  style: AppTextStyles.size22Medium,
                                ),
                                AppUtils.hSizedBox8,
                                Text(
                                  LocaleKeys.haveYouCollaborated.tr(),
                                  style: AppTextStyles.size15Medium,
                                ),
                              ],
                            ),
                        if ((state.listFeedBack?.items ?? []).isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                LocaleKeys.Feedbacks.tr(),
                                style: AppTextStyles.size22Medium,
                              ),
                              AppUtils.hSizedBox8,
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    AppIcons.icLike,
                                    height: 17.r,
                                  ).paddingOnly(left: 4.w),
                                  Text(
                                    "${user.likesCount ?? '0'}",
                                    style: AppTextStyles.size20Medium.copyWith(
                                      color: AppColors.c15CF74,
                                    ),
                                  ).paddingOnly(left: 4.w, right: 16.w),
                                  SvgPicture.asset(
                                    AppIcons.icDislike,
                                    height: 17.r,
                                  ).paddingOnly(left: 4.w),
                                  Text(
                                    "${user.dislikesCount ?? '0'}",
                                    style: AppTextStyles.size20Medium.copyWith(
                                      color: AppColors.cFF0000,
                                    ),
                                  ).paddingOnly(left: 4.w, right: 16.w),
                                  AppDivider(
                                    height: 25.h,
                                    width: 2.7.r,
                                  ).paddingOnly(right: 8.w),
                                  Text(
                                    "${state.listFeedBack?.totalCount}",
                                    style: AppTextStyles.size20Medium.copyWith(
                                      color: AppColors.cC1C1C1,
                                    ),
                                  ).paddingOnly(right: 2.w),
                                  Text(
                                    LocaleKeys.Feedbacks.tr(),
                                    style: AppTextStyles.size20Medium.copyWith(
                                      color: AppColors.cC1C1C1,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                      ],
                    ),
                    AppUtils.hSizedBox16,
                    AppButton(
                      onPressed: () {
                        if (context.read<UserCubit>().state.status.isLoaded()) {
                          BlocProvider.value(
                            value: context.read<FeedbackCubit>(),
                            child: WReviewModalButton(
                              receiverId: user.id,
                              feedbackCubit: context.read<FeedbackCubit>(),
                            ).show(context),
                          );
                        } else {
                          LoginPage().show(context);
                        }
                      },
                      text: LocaleKeys.writeReview.tr(),
                      color: AppColors.cFF9914,
                    ),

                  ],
                ).paddingAll(16.r),
              ),
              AppUtils.hSizedBox16,
              if ((state.listFeedBack?.items ?? []).isNotEmpty)
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.listFeedBack?.items.length??0,
                  separatorBuilder: (context, index) => AppUtils.hSizedBox16,
                  itemBuilder: (context, index) {
                    return FeedBackItem(
                      feedbackModel: state.listFeedBack?.items[index],
                    );
                  },
                ),
            ],
          );
        },
      ),
    );
  }
}
