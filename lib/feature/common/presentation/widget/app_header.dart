import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/theme/app_colors.dart';
import 'package:top_jobs/core/theme/app_svg.dart';
import 'package:top_jobs/core/theme/app_png.dart';
import 'package:top_jobs/core/utils/app_utils.dart';
import 'package:top_jobs/feature/common/presentation/cubits/user_cubit/user_cubit.dart';

import '../../../../core/router/route_names.dart';
import '../../../main/presentation/pages/main_page/main_page.dart';
import '../cubits/notification_cubit/notification_cubit.dart';

class AppHeader extends StatelessWidget {
  final bool? isPopAvailable;
  final Widget? popUpMenu;

  const AppHeader({super.key, this.isPopAvailable, this.popUpMenu});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        return DecoratedBox(
          decoration: BoxDecoration(color: AppColors.cFFFFFF),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 3.h),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: InkWell(
                    onTap: () {
                      context.go(Routes.main);
                    },
                    child: Center(
                      child: Image.asset(
                        AppPng.imgLogo,
                        height: 60.h,
                        width: 60.h,
                      ).paddingOnly(bottom: 5.h),
                    ),
                  ),
                ),
                isPopAvailable ?? false
                    ? Positioned(
                      top: 0,
                      bottom: 0,
                      child: IconButton(
                        onPressed: () {
                          if (context.canPop()) {
                            context.pop();
                          } else {
                            context.go(Routes.main);
                          }
                        },
                        icon: SizedBox(
                          height: 30,
                          width: 30,
                          child: SvgPicture.asset(
                            AppSvg.icBack,
                            fit: BoxFit.none,
                          ),
                        ),
                      ),
                    )
                    : AppUtils.kSizedBoxShrink,

                if (popUpMenu != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(height: 50.h, child: popUpMenu),
                      ),
                    ],
                  ),

                if (popUpMenu == null)
                  Align(
                    alignment: Alignment.centerRight,
                    child:
                        context.read<UserCubit>().state.status.isLoaded()
                            ? IconButton(
                              onPressed: () {
                                WNotificationsList().show(context);

                                // NotificationsDialogWidget().show(context);
                              },
                              icon: Badge(
                                isLabelVisible: state.hasNewNotification,
                                child: SvgPicture.asset(
                                  AppSvg.icBell,
                                  height: 27,
                                ).paddingAll(2.r),
                              ),
                            )
                            : SizedBox(height: 60.h, width: 20),
                  ),
              ],
            ).paddingSymmetric(horizontal: 8.w),
          ),
        );
      },
    );
  }
}
