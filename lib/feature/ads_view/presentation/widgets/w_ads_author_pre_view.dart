import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/router/app_routes.dart';
import 'package:top_jobs/feature/common/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_default_user_avatar.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_svg.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../models/user.dart';
import '../../../common/presentation/widget/app_button.dart';
import '../../../common/presentation/widget/app_cached_network_image.dart';

class WAdsAuthorPreView extends StatelessWidget {
  const WAdsAuthorPreView({
    super.key,
    required this.onPressedAuthorAds,
    this.imageUrl,
    required this.name,
    required this.city,
    required this.countLike,
    required this.countDislike,
    required this.actionName,
    this.isVerified,
  });

  final VoidCallback onPressedAuthorAds;
  final String? imageUrl;
  final String name;
  final String city;
  final String countLike;
  final String countDislike;
  final String actionName;
  final bool? isVerified;

  User? get currentUser =>
      navigatorKey.currentContext?.read<UserCubit>().state.user;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onPressedAuthorAds,
          borderRadius: BorderRadius.circular(12.r),
          radius: 0,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.cF7F9FC,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              spacing: 24.w,
              children: [
                imageUrl == null
                    ? WDefaultUserAvatar(height: 80.h)
                    : AppCachedNetworkImage(
                      height: 80.h,
                      radius: 40.sp,
                      imageUrl: imageUrl,
                    ),
                Expanded(
                  child: Column(
                    spacing: 8.h,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        spacing: 4.w,
                        children: [
                          Flexible(
                            child: Text(
                              name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.size22Medium.copyWith(
                                fontSize: 22.sp,
                              ),
                            ),
                          ),
                          if (isVerified ?? false)
                            SvgPicture.asset(
                              AppSvg.icCheckMark,
                              height: 20.h,
                              width: 20.w,
                              fit: BoxFit.cover,
                            ),
                        ],
                      ),
                      if (city.isNotEmpty )
                        Text(
                          city,
                          style: AppTextStyles.size14Regular.copyWith(
                            color: AppColors.c888888,
                          ),
                        ),
                      Row(
                        spacing: 4.w,
                        children: [
                          SvgPicture.asset(
                            AppIcons.icLike,
                            height: 13.h,
                            width: 13.w,
                          ),
                          Text(
                            countLike,
                            style: AppTextStyles.size13Medium.copyWith(
                              color: AppColors.c888888,
                            ),
                          ),
                          SvgPicture.asset(
                            AppIcons.icDislike,
                            height: 13.h,
                            width: 13.w,
                          ),
                          Text(
                            countDislike,
                            style: AppTextStyles.size13Medium.copyWith(
                              color: AppColors.c888888,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ).paddingAll(16.sp),
          ),
        ).paddingOnly(top: 24.h, bottom: 8.h),
        SizedBox(
          width: 100.sw,
          child: AppButton(
            onPressed: onPressedAuthorAds,
            radius: 12.r,
            text: actionName,
            color: AppColors.cF7F9FC,
            textStyle: AppTextStyles.size15Medium,
          ),
        ),
      ],
    ).paddingSymmetric(horizontal: 16.w);
  }
}
