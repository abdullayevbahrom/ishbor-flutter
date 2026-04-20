import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/helpers/formatters.dart';
import 'package:top_jobs/core/router/route_names.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_default_user_avatar.dart';
import 'package:top_jobs/models/user.dart';

import '../../../../../../core/constants/locale_keys.g.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_svg.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../core/utils/app_utils.dart';
import '../../../../../common/presentation/widget/app_cached_network_image.dart';
import '../../../../../common/presentation/widget/app_divider.dart';

class ChatHeader extends StatelessWidget {
  const ChatHeader({super.key, required this.sender});

  final User? sender;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.cFFFFFF,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          5.verticalSpace,
          InkWell(
            onTap: () {
              context.push(Routes.othersProfile, extra: sender);
            },
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                sender?.avatar?.urls['original'] != null
                    ? AppCachedNetworkImage(
                  height: 50.r,
                  radius: 25.sp,
                  imageUrl: sender?.avatar?.urls['original'],
                )
                    : WDefaultUserAvatar(height: 50.r),
                AppUtils.wSizedBox16,
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              sender?.fullName ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.size17Medium,
                            ),
                          ),
                          AppUtils.wSizedBox4,
                          if (sender?.documentVerified ?? false)
                            SvgPicture.asset(
                              AppSvg.icCheckMark,
                              width: 13.r,
                              height: 13.r,
                            ),
                        ],
                      ),
                      Text(
                        LocaleKeys.lastSeenAgo.tr(
                          args: [
                            Formatters.timeAgo(
                              sender?.lastActiveTime ?? DateTime.now(),
                            ),
                          ],
                        ),
                        style: AppTextStyles.size15Regular.copyWith(
                          color: AppColors.c888888,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: PopupMenuButton(
                    color: AppColors.cFFFFFF,
                    offset: Offset(-25, 30),
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    onSelected: (value) {
                      if (value == "profile") {
                        context.push(Routes.othersProfile, extra: sender);
                      }
                    },
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          value: 'profile',
                          child: Text(LocaleKeys.profile.tr()),
                        ),
                        PopupMenuItem(
                          value: 'delete',
                          child: Text(
                            LocaleKeys.deleteChat.tr(),
                            style: TextStyle(color: Color(0xffFF0000)),
                          ),
                        ),
                      ];
                    },
                    child: SizedBox(
                      height: 35.r,
                      width: 35.r,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppColors.cE0E5EB,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Icon(
                          Icons.more_vert,
                          color: AppColors.cBDC0C6,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 16.w, vertical: 14.h),
          ),
          AppDivider(
            width: 100.sw,
            height: 2.h,
            color: AppColors.cE0E5EB,
          ),
        ],
      ),
    ).paddingOnly(bottom: 10.h);
  }
}
