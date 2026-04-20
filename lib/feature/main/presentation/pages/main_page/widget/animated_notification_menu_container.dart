import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:top_jobs/core/extentions/color_extension.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_refresh_indicator.dart';
import '../../../../../../core/constants/locale_keys.g.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../core/utils/app_utils.dart';
import '../../../../../common/presentation/cubits/notification_cubit/notification_cubit.dart';
import '../../../../../common/presentation/widget/app_divider.dart';
import 'animated_menu_container.dart';
import 'notifications_dialog_widget.dart';

class WAnimatedNotificationMenuContainer extends StatelessWidget {
  const WAnimatedNotificationMenuContainer({super.key, required this.open});

  final bool open;
  static const _dur = Duration(milliseconds: 300);
  static const _curve = Curves.easeInOut;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 50,
      bottom: 110,
      child: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          final notifications = state.listNotification?.items ?? [];
          return AnimatedMenuContainer(
            open: open,
            duration: _dur,
            curve: _curve,
            child: Wrap(
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width/5*3.9,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.cFEFEFE,
                      borderRadius: BorderRadius.circular(18.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.c000000.newWithOpacity(.05),
                          blurRadius: 40.r,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        color: AppColors.cMainBg,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.c000000.newWithOpacity(.05),
                            blurRadius: 40.r,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 16.h,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              LocaleKeys.notifications.tr(),
                              style: AppTextStyles.size18Bold,
                            ),
                            AppUtils.hSizedBox4,
                            AppDivider(
                              height: 1.h,
                              width: 100.sw,
                              color: AppColors.cE0E5EB,
                            ),
                            AppUtils.hSizedBox16,
                            if (state.status.isError())
                              Center(child: Text(state.errorText.toString()))
                            else if (state.status.isLoading())
                              Skeletonizer(
                                enabled: true,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics:
                                  const NeverScrollableScrollPhysics(),
                                  itemCount: 15,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      height: 30.h,
                                      width: 100.sw,
                                      color: AppColors.cFF9914,
                                    ).paddingOnly(bottom: 8.h);
                                  },
                                ), // example skeleton height
                              )
                            else if (notifications.isEmpty)
                              Center(
                                child: Text(LocaleKeys.noNotifications.tr()),
                              )
                            else
                              WRefreshIndicator(
                                onRefresh: () async {
                                  context
                                      .read<NotificationCubit>()
                                      .fetchNotifications();
                                },
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxHeight:
                                        MediaQuery.sizeOf(context).height * 0.6,
                                  ),

                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    itemCount: notifications.length,
                                    itemBuilder: (context, index) {
                                      return NotificationItem(
                                        makeRead: () {
                                          context
                                              .read<NotificationCubit>()
                                              .makeNotificationRead(index);
                                        },
                                        notification: notifications[index],
                                      ).paddingOnly(bottom: 8.h);
                                    },
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
