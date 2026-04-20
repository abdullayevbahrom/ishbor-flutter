import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/feature/ads_view/presentation/widgets/w_send_message_user.dart';
import 'package:top_jobs/feature/others_profile/presentation/pages/others_profile_page/widget/w_decorated_column.dart';
import 'package:top_jobs/feature/others_profile/presentation/pages/others_profile_page/widget/w_icon_row.dart';

import '../../../../../../core/constants/app_locale_keys.dart';
import '../../../../../../core/constants/locale_keys.g.dart';
import '../../../../../../core/helpers/formatters.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_svg.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../core/utils/app_utils.dart';
import '../../../../../../models/user.dart';
import '../../../../../common/presentation/widget/app_button.dart';
import '../../../../../common/presentation/widget/app_cached_network_image.dart';
import '../../../../../common/presentation/widget/w_decorated_box.dart';
import '../../../../../common/presentation/widget/w_default_user_avatar.dart';

class WUserInfo extends StatelessWidget {
  const WUserInfo({super.key, required this.user, required this.locale});

  final User user;
  final String locale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppUtils.hSizedBox24,
        Text(LocaleKeys.personalData.tr(), style: AppTextStyles.size28Bold),
        Text("${user.fullName ?? ''}", style: AppTextStyles.size28Bold),
        AppUtils.hSizedBox24,
        WDecoratedBox(
          radius: 18.r,
          bgColor: AppColors.cFBFBFD,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: 24.w,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  user.avatar?.urls['original'] != null
                      ? AppCachedNetworkImage(
                        height: 82.h,
                        radius: 42.r,
                        imageUrl: user.avatar?.urls['original'],
                      )
                      : WDefaultUserAvatar(height: 82.h),
                  Expanded(
                    child: Column(
                      spacing: 4.h,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          spacing: 4.w,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                "${user.fullName ?? ''}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.size17Medium,
                              ),
                            ),
                            SvgPicture.asset(
                              AppSvg.icCheckMark,
                              height: 25.r,
                              width: 25.r,
                            ),
                          ],
                        ),
                        Text(
                          LocaleKeys.lastSeenAgo.tr(
                            args: [
                              Formatters.timeAgo(
                                user.lastActiveTime ?? DateTime.now(),
                              ),
                            ],
                          ),
                          style: AppTextStyles.size17Medium.copyWith(
                            color: AppColors.cBDC0C6,
                          ),
                        ),
                        Row(
                          spacing: 16.w,
                          children: [
                            IconRow(
                              iconUrl: AppIcons.icLike,
                              count: '${user.likesCount}',
                            ),
                            IconRow(
                              iconUrl: AppIcons.icDislike,
                              count: '${user.dislikesCount}',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              AppUtils.hSizedBox24,
              SizedBox(
                height: 45.h,
                child: AppButton(
                  width: 100.sw,
                  onPressed: () {
                    WSendMessageUser(
                      title: LocaleKeys.askAQuestion.tr(),
                      receiverId: user.id,
                    ).show(context);
                  },
                  radius: 12.r,
                  text: LocaleKeys.write.tr(),
                  color: AppColors.cFF9914,
                ),
              ),
              AppUtils.hSizedBox24,
              Column(
                spacing: 16.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WDecoratedDetailColumn(
                    title: LocaleKeys.birthDate.tr(),
                    description:
                        user.birthDay != null
                            ? "${Formatters.formatDate(user.birthDay!)}"
                            : "-",
                  ),
                  WDecoratedDetailColumn(
                    title: LocaleKeys.categories.tr(),
                    description:
                        (user.categories ?? []).isNotEmpty
                            ? '''${user.categories?.map((e) {
                              return e.translations[locale == AppLocaleKeys.ru ? 0 : 1].name ?? '-';
                            }).join(',')}'''
                            : "-",
                    textColor: AppColors.cFF9914,
                  ),
                  WDecoratedDetailColumn(
                    title: LocaleKeys.gender.tr(),
                    description:
                        user.gender != null
                            ? "${user.gender == 'male' ? LocaleKeys.Male.tr() : LocaleKeys.Female.tr()}"
                            : "-",
                  ),
                  WDecoratedDetailColumn(
                    title: LocaleKeys.city.tr(),
                    description: user.city != null ? "${user.city}" : "-",
                  ),
                  // WDecoratedDetailColumn(
                  //   title: LocaleKeys.phoneNumber.tr(),
                  //   description:
                  //   Formatters.formatUzbekPhoneNumber(
                  //     "${user.phoneNumber}",
                  //   ),
                  // ),
                  WDecoratedDetailColumn(
                    title: LocaleKeys.aboutMe.tr(),
                    description: user.aboutMe != null ? '${user.aboutMe}' : "-",
                  ),

                  Column(
                    spacing: 8.h,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.jobExamples.tr(),
                        style: AppTextStyles.size15Medium.copyWith(
                          color: AppColors.c333333,
                        ),
                      ),
                      SizedBox(
                        height: 70.h,
                        child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              (user.portfolios ?? []).isNotEmpty
                                  ? user.portfolios?.length ?? 0
                                  : 4,
                          separatorBuilder:
                              (context, index) => AppUtils.wSizedBox16,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              height: 70.h,
                              width: 70.h,
                              child:
                                  (user.portfolios ?? []).isNotEmpty
                                      ? AppCachedNetworkImage(
                                        height: 70.h,
                                        width: 70.h,
                                        radius: 8.r,

                                        imageUrl:
                                            user
                                                .portfolios?[index]
                                                .urls['original'],
                                      )
                                      : DecoratedBox(
                                        decoration: BoxDecoration(
                                          color: AppColors.cE0E5EB.withOpacity(
                                            .3,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            8.r,
                                          ),
                                        ),
                                      ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ).paddingAll(16.r),
        ),
      ],
    );
  }
}
