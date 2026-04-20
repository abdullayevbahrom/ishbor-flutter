import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/constants/time_delay_cons.dart';
import 'package:top_jobs/core/extentions/color_extension.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/router/app_routes.dart';
import 'package:top_jobs/core/theme/app_colors.dart';
import 'package:top_jobs/core/theme/app_svg.dart';
import 'package:top_jobs/core/theme/app_text_styles.dart';
import 'package:top_jobs/feature/common/presentation/cubits/notification_cubit/notification_cubit.dart';
import 'package:top_jobs/feature/common/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:top_jobs/feature/common/presentation/pages/w_modal_bottom_sheet_container.dart';
import 'package:top_jobs/feature/main/presentation/pages/main_page/widget/animated_add_fb.dart';
import 'package:top_jobs/feature/main/presentation/pages/main_page/widget/animated_menu_container.dart';
import 'package:top_jobs/feature/main/presentation/pages/main_page/widget/animated_notification_fb.dart';
import 'package:top_jobs/feature/main/presentation/pages/main_page/widget/animated_notification_menu_container.dart';
import 'package:top_jobs/feature/main/presentation/pages/main_page/widget/keep_alive.dart';
import 'package:top_jobs/feature/main/presentation/pages/main_page/widget/notifications_dialog_widget.dart';
import 'package:top_jobs/feature/main/presentation/pages/main_page/widget/scale_indexed_stack.dart';
import 'package:top_jobs/feature/messages/presentation/pages/messages_page/messages_page.dart';
import 'package:top_jobs/feature/profile/presentation/pages/profile_page.dart';
import 'package:top_jobs/feature/services/presentation/pages/services_page/services_page.dart';
import 'package:top_jobs/feature/tasks/presentation/pages/tasks_page/tasks_page.dart';

import '../../../../../core/services/fcm_service.dart';
import '../../../../auth/data/models/auth_success.dart';
import '../../../../auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import '../../../../auth/presentation/pages/login_page/login_page.dart';
import '../../../../common/presentation/cubits/cities_cubit/cities_cubit.dart';
import '../../../../common/presentation/cubits/locale_cubit/locale_cubit.dart';
import '../../../../messages/presentation/cubits/message_cubit/message_cubit.dart';
import '../../../../vacancies/presentation/pages/vacancies_page/vacancies_page.dart';
import '../../cubit/main_cubit/main_cubit.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.payload});

  final Map<String, dynamic>? payload;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  final List<Widget> pages = [
    WKeepAlive(child: VacancyList()),
    WKeepAlive(child: ServicesPage()),
    WKeepAlive(child: TasksPage()),
    const WKeepAlive(child: MessagesPage()),
    const WKeepAlive(child: ProfilePage()),
  ];

  @override
  void initState() {
    context.read<UserCubit>().checkUser();
    context.read<CitiesCubit>().fetchCities();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await FcmNotificationService.instance.initialize();

      if (widget.payload != null) {
        initPayload();
      }
    });
    super.initState();
  }

  Future<void> initPayload() async {
    await Future.delayed(TimeDelayCons.duration1);
    if (widget.payload?.containsKey("vacancyId") ?? false) {
      navigatorKey.currentContext?.push(
        "/vacancy-view?id=${widget.payload?['vacancyId']}",
      );
    }
    if (widget.payload?.containsKey("serviceId") ?? false) {
      context.push("/service-view?id=${widget.payload?['serviceId']}");
    }
    if (widget.payload?.containsKey("taskId") ?? false) {
      context.push("/task-view?id=${widget.payload?['taskId']}");
    }

    if (widget.payload?.containsKey("token") ?? false) {
      final expiresAtRaw = widget.payload?['expires_at'];
      final expiresAt =
          expiresAtRaw is String ? DateTime.tryParse(expiresAtRaw) : null;
      if (expiresAt == null) {
        return;
      }
      if (context.canPop()) {
        context.pop();
      }
      context.read<AuthCubit>().logInWithTelegram(
        AuthSuccess(
          token: widget.payload?['token'],
          expiresAt: expiresAt,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, state) {
        return BlocConsumer<UserCubit, UserState>(
          listener: (context, state) {
            if (state.status.isLoaded()) {
              context.read<UserCubit>().initUserStatus();
              context.read<NotificationCubit>().fetchNotifications();
            }
          },
          builder: (context, state) {
            return BlocBuilder<MainCubit, MainState>(
              builder: (context, mainState) {
                return BlocBuilder<MessageCubit, MessageState>(
                  builder: (context, messageState) {
                    return Container(
                      color: AppColors.cFFFFFF,
                      child: SafeArea(
                        bottom:false,
                        child: Stack(
                          children: [
                            Scaffold(
                              body: Stack(
                                children: [
                                  ScaleIndexedStack(
                                    index: mainState.currentIndex,
                                    duration: TimeDelayCons.durationMill300,
                                    children: pages,
                                  ),
                                  if (mainState.isOpen)
                                    Positioned.fill(
                                      child: GestureDetector(
                                        onTap: () {
                                          if (mainState.isOpen) {
                                            context
                                                .read<MainCubit>()
                                                .updateOpen(false);
                                          }
                                        },
                                      ),
                                    ),
                                  if (mainState.isNotificationMenuOpen)
                                    Positioned.fill(
                                      child: GestureDetector(
                                        onTap: () {
                                          if (mainState
                                              .isNotificationMenuOpen) {
                                            context
                                                .read<MainCubit>()
                                                .updateNtfMenu(false);
                                          }
                                        },
                                      ),
                                    ),
                                  WAnimatedNotificationMenuContainer(
                                    open: mainState.isNotificationMenuOpen,
                                  ),
                                  if (state.hasToken)
                                    WAnimatedNotificationFb(
                                      onTapFb: () {
                                        WNotificationsList().show(context);

                                        // context.read<MainCubit>().updateNtfMenu(
                                        //   !mainState.isNotificationMenuOpen,
                                        // );
                                        // context.read<MainCubit>().updateOpen(
                                        //   false,
                                        // );
                                      },
                                      open: mainState.isNotificationMenuOpen,
                                    ),
                                  WAnimatedMenuContainer(
                                    open: mainState.isOpen,
                                  ),
                                  WAnimatedAddFb(
                                    onTapFb: () {
                                      if (state.hasToken) {
                                        context.read<MainCubit>().updateOpen(
                                          !mainState.isOpen,
                                        );
                                        context.read<MainCubit>().updateNtfMenu(
                                          false,
                                        );
                                      } else {
                                        LoginPage().show(context);
                                      }
                                    },
                                    open: mainState.isOpen,
                                  ),
                                ],
                              ),
                              bottomNavigationBar: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.cFFFFFF,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.c000000.newWithOpacity(
                                        .06,
                                      ),
                                      offset: const Offset(0, -10),
                                      blurRadius: 30.r,
                                    ),
                                  ],
                                ),

                                child: BottomNavigationBar(
                                  onTap: (value) {
                                    if (mainState.isOpen) {
                                      context.read<MainCubit>().updateOpen(
                                        false,
                                      );
                                    }

                                    if (mainState.isNotificationMenuOpen) {
                                      if (mainState.isNotificationMenuOpen) {
                                        context.read<MainCubit>().updateNtfMenu(
                                          false,
                                        );
                                      }
                                    }
                                    if (value != 4 && value != 3) {
                                      context.read<MainCubit>().updateIndex(
                                        value,
                                      );
                                    } else {
                                      if (state.hasToken) {
                                        context.read<MainCubit>().updateIndex(
                                          value,
                                        );
                                      } else {
                                        LoginPage().show(context);
                                      }
                                    }
                                  },

                                  elevation: 0,
                                  currentIndex: mainState.currentIndex,
                                  backgroundColor: AppColors.cFFFFFF,
                                  items: [
                                    BottomNavigationBarItem(
                                      backgroundColor: AppColors.cFFFFFF,
                                      icon: SvgPicture.asset(
                                        AppIcons.icVacancies,
                                        height: 23.r,
                                      ).paddingOnly(top: 12.h),
                                      activeIcon: SvgPicture.asset(
                                        AppIcons.icVacanciesActive,
                                        height: 23.r,
                                      ).paddingOnly(top: 12.h),
                                      label: LocaleKeys.works.tr(),
                                    ),
                                    BottomNavigationBarItem(
                                      backgroundColor: AppColors.cFFFFFF,
                                      icon: SvgPicture.asset(
                                        AppIcons.icServices,
                                        height: 23.r,
                                      ).paddingOnly(top: 12.h),
                                      activeIcon: SvgPicture.asset(
                                        AppIcons.icServicesActive,
                                        height: 23.r,
                                      ).paddingOnly(top: 12.h),
                                      label: LocaleKeys.services.tr(),
                                    ),
                                    BottomNavigationBarItem(
                                      backgroundColor: AppColors.cFFFFFF,
                                      icon: SvgPicture.asset(
                                        AppIcons.icDailyTask,
                                        height: 23.r,
                                      ).paddingOnly(top: 12.h),
                                      activeIcon: SvgPicture.asset(
                                        AppIcons.icDailyTaskActive,
                                        height: 23.r,
                                      ).paddingOnly(top: 12.h),
                                      label: LocaleKeys.tasks.tr(),
                                    ),
                                    BottomNavigationBarItem(
                                      icon: Badge(
                                        isLabelVisible:
                                        messageState.hasUnreadMessage,
                                        child: SvgPicture.asset(
                                          AppIcons.icMessage,
                                          height: 23.r,
                                        ).paddingOnly(top: 5.h, right: 2.w),
                                      ).paddingOnly(top: 7.h),
                                      activeIcon: Badge(
                                        isLabelVisible:
                                        messageState.hasUnreadMessage,
                                        padding: EdgeInsetsGeometry.only(
                                          bottom: 5,
                                          left: 5,
                                        ),
                                        child: SvgPicture.asset(
                                          AppIcons.icMessageActive,
                                          height: 23.r,
                                        ).paddingOnly(top: 5.h, right: 2.w),
                                      ).paddingOnly(top: 7.h),
                                      label: LocaleKeys.messages.tr(),
                                      backgroundColor: AppColors.cFFFFFF,
                                    ),
                                    BottomNavigationBarItem(
                                      icon: SvgPicture.asset(
                                        AppIcons.icAccount,
                                        height: 23.r,
                                      ).paddingOnly(top: 12.h),
                                      activeIcon: SvgPicture.asset(
                                        AppIcons.icAccountActive,
                                        height: 23.r,
                                      ).paddingOnly(top: 12.h),
                                      label: LocaleKeys.profile.tr(),
                                      backgroundColor: AppColors.cFFFFFF,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}

class WNotificationsList extends StatefulWidget {
  const WNotificationsList({super.key});

  void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isDismissible: true,
      isScrollControlled: true,
      backgroundColor: AppColors.cMainBg,
      builder: (context) => this,
    );
  }

  @override
  State<WNotificationsList> createState() => _WNotificationsListState();
}

class _WNotificationsListState extends State<WNotificationsList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        final notifications = state.listNotification?.items;
        return DraggableScrollableSheet(
          minChildSize: 0.5,
          initialChildSize: 0.5,
          maxChildSize: 0.98,
          expand: false,
          builder: (context, scrollController) {
            return Column(
              children: [
                11.verticalSpace,
                WModalSheetDecoratedContainer(),
                10.verticalSpace,
                Text(
                  LocaleKeys.notifications.tr(),
                  style: AppTextStyles.size18Bold.copyWith(
                    color: AppColors.c2E3A59,
                  ),
                ),
                // 4.verticalSpace,
                // AppDivider(
                //   height: 1.h,
                //   width: 100.sw,
                //   color: AppColors.cE0E5EB,
                // ),
                16.verticalSpace,

                if (state.status.isError())Center(
                  child: Text(state.errorText ?? ''),),
                if (state.status.isLoading())
                  Expanded(
                    child: Skeletonizer(
                      enabled: true,
                      child: ListView.builder(
                        itemCount: notifications?.length,
                        shrinkWrap: true,
                        controller: scrollController,
                        scrollDirection: Axis.vertical,
                        physics: const AlwaysScrollableScrollPhysics(),
                        keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 50,
                            width: 100.sw,
                            color: AppColors.cRed,
                          ).paddingOnly(bottom: 8.h);
                        },
                      ),
                    ),
                  ),
                if (state.status.isLoaded())
                  Expanded(
                    child: ListView.builder(
                      itemCount: notifications?.length,
                      shrinkWrap: true,
                      controller: scrollController,
                      scrollDirection: Axis.vertical,
                      physics: const AlwaysScrollableScrollPhysics(),
                      keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                      itemBuilder: (context, index) {
                        return NotificationItem(
                          makeRead: () {
                            context
                                .read<NotificationCubit>()
                                .makeNotificationRead(index);
                          },
                          notification: notifications![index],
                        ).paddingOnly(bottom: 8.h);
                      },
                    ),
                  ),
              ],
            ).paddingSymmetric(horizontal: 16.w);
          },
        );
      },
    );
  }
}
