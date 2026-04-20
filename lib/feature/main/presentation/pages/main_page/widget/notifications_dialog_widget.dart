import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:top_jobs/core/constants/time_delay_cons.dart';
import 'package:top_jobs/core/extentions/color_extension.dart';
import 'package:top_jobs/core/helpers/formatters.dart';
import 'package:top_jobs/core/router/route_names.dart';
import 'package:top_jobs/feature/common/data/models/notifications.dart';

import '../../../../../../export.dart';
import '../../../../../common/presentation/cubits/notification_cubit/notification_cubit.dart';
import '../../../../../common/presentation/widget/app_divider.dart';

class NotificationsDialogWidget extends StatelessWidget {
  const NotificationsDialogWidget({super.key});

  void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      barrierColor: AppColors.cTransparent,
      useRootNavigator: true,
      builder:
          (context) => Align(
            alignment: Alignment.center,
            child: Material(
              color: AppColors.cFFFFFF,
              child: Stack(
                children: [
                  Wrap(children: [this]),
                ],
              ),
            ).paddingSymmetric(horizontal: 50.w, vertical: 16.h),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        final notifications = state.listNotification?.items ?? [];

        return FadeInRight(
          duration: TimeDelayCons.durationMill200,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              color: AppColors.cMainBg,
              boxShadow: [
                BoxShadow(
                  color: AppColors.c000000.newWithOpacity(.5),
                  blurRadius: 40.r,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
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
                      child: const SizedBox(
                        height: 150,
                      ), // example skeleton height
                    )
                  else if (notifications.isEmpty)
                    Center(child: Text(LocaleKeys.noNotifications.tr()))
                  else
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.sizeOf(context).height * 0.6,
                      ),

                      child: ListView.builder(
                        shrinkWrap: true,

                        physics: const BouncingScrollPhysics(),
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    super.key,
    required this.notification,
    required this.makeRead,
  });

  final AppNotification notification;
  final VoidCallback makeRead;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.cTransparent,
      child: InkWell(
        onTap: () {
          makeRead();
          if (notification.operation.contains('service')) {
            context.push("/service-view?id=${notification.operationId}");
          }
          if (notification.operation.contains('vacancy')) {
            context.push("/vacancy-view?id=${notification.operationId}");
          }
          if (notification.operation.contains('task')) {
            context.push("/task-view?id=${notification.operationId}");
          }

          if (notification.operation.contains('message')) {
            context.push(Routes.chat, extra: notification.operationId);
          }
        },
        borderRadius: BorderRadius.circular(8.r),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: AppColors.cFFFFFF,
          ),
          child: Row(
            spacing: 15.w,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 15.r,
                width: 15.r,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color:
                        notification.read
                            ? AppColors.cB7BFCA
                            : AppColors.cFF9914,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Formatters.translateText(
                        uzText: notification.titleUz,
                        ruText: notification.titleRu,
                        defaultText: notification.title,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.size18Medium.copyWith(
                        color: AppColors.c2E3A59,
                      ),
                    ),
                    Text(
                      notification.body ?? "",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.size15Medium.copyWith(
                        color:
                            notification.read
                                ? AppColors.c000000.newWithOpacity(.5)
                                : AppColors.c000000,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ).paddingSymmetric(vertical: 11.h, horizontal: 8.w),
        ),
      ),
    );
  }
}
