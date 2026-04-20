import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/extentions/color_extension.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/theme/app_colors.dart';
import 'package:top_jobs/core/theme/app_svg.dart';
import 'package:top_jobs/core/theme/app_text_styles.dart';
import 'package:top_jobs/feature/common/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_decorated_box.dart';
import 'package:top_jobs/feature/main/presentation/cubit/main_cubit/main_cubit.dart';

import '../../../../core/constants/easy_locale.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/utils/app_utils.dart';
import '../../../auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import '../../../common/presentation/cubits/locale_cubit/locale_cubit.dart';
import '../../../common/presentation/widget/app_cached_network_image.dart';
import '../../../common/presentation/widget/app_header.dart';
import '../../../common/presentation/widget/w_default_user_avatar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, state) {
        return BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state.logOutSt.isLoaded()) {
              context.read<MainCubit>().updateIndex(0);
              context.read<UserCubit>().fetchUser();
            }
          },
          builder: (context, state) {
            return BlocBuilder<LocaleCubit, LocaleState>(
  builder: (context, state) {
    return BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                return Scaffold(
                  backgroundColor: AppColors.cFFFFFF,
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppHeader(
                        popUpMenu: PopupMenuButton(
                          color: AppColors.cFFFFFF,
                          offset: Offset(-25, 30),
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                value: 'ru',
                                child: Row(
                                  spacing: 40.w,
                                  children: [
                                    SizedBox(
                                      width: 65,
                                      child: Text(
                                        "Русский",
                                        style: AppTextStyles.size13Medium
                                            .copyWith(color: AppColors.c222222),
                                      ),
                                    ),
                                    if (context.locale.languageCode == 'ru')
                                      Icon(
                                        Icons.check,
                                        color: AppColors.cFF9914,
                                      ),
                                  ],
                                ),
                                onTap: () async {
                                  await context.setLocale(EasyLocale.all.first);
                                  context.read<UserCubit>().updateLocale(
                                    EasyLocale.all.first.languageCode,
                                  );
                                  context.read<LocaleCubit>().changeLocale(
                                    EasyLocale.all.first,
                                    context,
                                  );
                                  setState(() {});
                                },
                              ),
                              PopupMenuItem(
                                value: 'uz',
                                child: Row(
                                  spacing: 40.w,
                                  children: [
                                    SizedBox(
                                      width: 65,
                                      child: Text(
                                        "O‘zbekcha",
                                        style: AppTextStyles.size13Medium
                                            .copyWith(color: AppColors.c222222),
                                      ),
                                    ),
                                    if (context.locale.languageCode == 'uz')
                                      Icon(
                                        Icons.check,
                                        color: AppColors.cFF9914,
                                      ),
                                  ],
                                ),
                                onTap: () async {
                                  await context.setLocale(EasyLocale.all.last);
                                  context.read<UserCubit>().updateLocale(
                                    EasyLocale.all.last.languageCode,
                                  );
                                  context.read<LocaleCubit>().changeLocale(
                                    EasyLocale.all.last,
                                    context,
                                  );
                                  setState(() {});
                                },
                              ),
                            ];
                          },
                          child: Row(
                            spacing: 4.w,
                            children: [
                              SvgPicture.asset(AppSvg.icLang),
                              Text(
                                context.locale.languageCode == "ru"
                                    ? "Рус"
                                    : "O‘zb",
                                style: AppTextStyles.size13Medium.copyWith(
                                  color: AppColors.c2E3A59,
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: AppColors.cFF9914,
                              ),
                            ],
                          ),
                        ).paddingOnly(right: 16.w),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          scrollDirection: Axis.vertical,
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                LocaleKeys.myProfile.tr(),
                                style: AppTextStyles.size28Bold.copyWith(
                                  color: AppColors.c2E3A59,
                                ),
                              ).paddingSymmetric(vertical: 24.h),

                              Column(
                                spacing: 8.h,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BlocBuilder<UserCubit, UserState>(
                                    builder: (context, state) {
                                      final user = state.user;
                                      return WDecoratedBox(
                                        radius: 18.r,
                                        bgColor: AppColors.cF7F9FC,
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              spacing: 24.w,
                                              children: [
                                                user?.avatar == null
                                                    ? WDefaultUserAvatar(
                                                      height: 82.h,
                                                    )
                                                    :
                                                    //ToDo if avatar url null we use default avatar
                                                    AppCachedNetworkImage(
                                                      height: 82.h,
                                                      radius: 41.sp,
                                                      imageUrl:
                                                          user
                                                              ?.avatar
                                                              ?.urls['original'],
                                                    ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    spacing: 4.h,
                                                    children: [
                                                      Text(
                                                        "${user?.fullName ?? ""}",
                                                        style:
                                                            AppTextStyles
                                                                .size17Medium,
                                                      ),
                                                      Text(
                                                        "${user?.balance == 0 ? 0 : user?.balance} ${LocaleKeys.sum.tr()}",
                                                        style: AppTextStyles
                                                            .size18Bold
                                                            .copyWith(
                                                              color:
                                                                  AppColors
                                                                      .cFF9914,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            AppUtils.hSizedBox16,
                                            InkWell(
                                              onTap: () {
                                                context.push(
                                                  Routes.payment,
                                                  extra: user?.balance,
                                                );
                                              },
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                  color: AppColors.c15CF74,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        12.r,
                                                      ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: AppColors.c15CF74
                                                          .newWithOpacity(.4),
                                                      blurRadius: 15.r,
                                                      offset: Offset(0, 4),
                                                    ),
                                                  ],
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                      AppSvg.icPayment,
                                                    ),
                                                    Text(
                                                      LocaleKeys.fillUpBalance
                                                          .tr(),
                                                      style: AppTextStyles
                                                          .size15Medium
                                                          .copyWith(
                                                            color:
                                                                AppColors
                                                                    .cFFFFFF,
                                                          ),
                                                    ).paddingSymmetric(
                                                      vertical: 12.h,
                                                      horizontal: 16.w,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            AppUtils.hSizedBox16,
                                          ],
                                        ).paddingAll(16.r),
                                      );
                                    },
                                  ),

                                  ProfileItem(
                                    onTap: () {
                                      context.push(Routes.profileInfo);
                                      (context as Element).markNeedsBuild();
                                    },
                                    title: LocaleKeys.myInfo.tr(),
                                  ),
                                  ProfileItem(
                                    onTap: () {
                                      context.push(Routes.profileVacancies);
                                    },
                                    title: LocaleKeys.myVacancies.tr(),
                                  ),
                                  ProfileItem(
                                    onTap: () {
                                      context.push(Routes.profileServices);
                                    },
                                    title: LocaleKeys.myServices.tr(),
                                  ),
                                  ProfileItem(
                                    onTap: () {
                                      context.push(Routes.profileTasks);
                                    },
                                    title: LocaleKeys.myTasks.tr(),
                                  ),
                                  ProfileItem(
                                    onTap: () {
                                      context.push(Routes.myFavorites);
                                    },
                                    title: LocaleKeys.favorites.tr(),
                                  ),
                                  ProfileItem(
                                    onTap: () {
                                      showCupertinoDialog(
                                        context: context,
                                        builder: (context) {
                                          return CupertinoAlertDialog(
                                            title: Text(
                                              LocaleKeys.logOut.tr(),
                                              style: AppTextStyles.size20Bold
                                                  .copyWith(
                                                    color: AppColors.cRed,
                                                  ),
                                            ),
                                            content: Text(
                                              LocaleKeys.areYouSureLogOut.tr(),
                                              style: AppTextStyles.size18Medium,
                                            ),
                                            actions: [
                                              CupertinoDialogAction(
                                                onPressed: () async {
                                                  context
                                                      .read<AuthCubit>()
                                                      .logOut();
                                                  context.pop();
                                                },
                                                child: Text(
                                                  LocaleKeys.yes.tr(),
                                                  style: AppTextStyles
                                                      .size15Medium
                                                      .copyWith(
                                                        color: AppColors.cRed,
                                                      ),
                                                ),
                                              ),
                                              CupertinoDialogAction(
                                                isDestructiveAction: true,
                                                isDefaultAction: false,

                                                onPressed: () {
                                                  context.pop();
                                                },

                                                child: Text(
                                                  LocaleKeys.no.tr(),
                                                  style: AppTextStyles
                                                      .size15Medium
                                                      .copyWith(
                                                        color: AppColors.cGreen,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    title: LocaleKeys.logout.tr(),
                                    textColor: AppColors.cRed,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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

class ProfileItem extends StatelessWidget {
  const ProfileItem({
    super.key,
    required this.title,
    required this.onTap,
    this.textColor,
  });

  final String title;
  final VoidCallback onTap;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),

      child: Ink(
        decoration: BoxDecoration(
          color: AppColors.cF7F9FC,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            Text(
              title,
              style: AppTextStyles.size20Bold.copyWith(
                color: textColor ?? AppColors.c2E3A59,
              ),
            ),
            Spacer(),
            SvgPicture.asset(AppSvg.icNext).paddingOnly(right: 16.w),
          ],
        ).paddingAll(16.r),
      ),
    );
  }
}
