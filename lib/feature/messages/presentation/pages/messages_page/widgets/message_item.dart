import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/helpers/formatters.dart';
import 'package:top_jobs/core/theme/app_colors.dart';
import 'package:top_jobs/core/theme/app_text_styles.dart';
import 'package:top_jobs/feature/common/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_cached_network_image.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_default_user_avatar.dart';
import 'package:top_jobs/models/message.dart';


class WMessageItem extends StatelessWidget {
  const WMessageItem({super.key, required this.message, required this.onTap});

  final Message? message;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final me = context.read<UserCubit>().state.user;
    final user = (me?.id != message?.sender.id ? message?.sender : message?.receiver);
    return InkWell(
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(color: AppColors.cFFFFFF),
        child: Row(
          spacing: 20.w,
          children: [
            if (user?.avatar?.urls['original'] != null)
              AppCachedNetworkImage(
                height: 50,
                radius: 26,
                imageUrl: user?.avatar?.urls['original'],
              )
            else
              WDefaultUserAvatar(height: 50),
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
                          user?.fullName ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.size17Medium,
                        ),
                      ),
                      Text(
                        Formatters.formatDate(
                          message?.lastRecord?.createdAt ?? DateTime.now(),
                        ),
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
                          Formatters.formatLastRecord(message!.lastRecord!),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.size15Regular.copyWith(
                            color: AppColors.c888888,
                          ),
                        ),
                      ),
                      if (message?.hasNewRecord ?? false)
                        Badge(
                          textStyle: AppTextStyles.size14Regular.copyWith(
                            color: AppColors.cFFFFFF,
                          ),
                          backgroundColor: AppColors.c2196F3,
                          label: Text(
                            "1",
                          ).paddingSymmetric(horizontal: 5.w, vertical: 4.h),
                          // child: Text("2").paddingAll(5.r),
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
