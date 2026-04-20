import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/router/app_routes.dart';
import 'package:top_jobs/feature/auth/presentation/pages/login_page/login_page.dart';
import 'package:top_jobs/feature/common/presentation/cubits/user_cubit/user_cubit.dart';

import '../../../../core/constants/locale_keys.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'app_button.dart';

class AppBanner extends StatelessWidget {
  const AppBanner({super.key, required this.title, required this.onPressed});

  final String title;
  final VoidCallback onPressed;

  bool get userLogged =>
      navigatorKey.currentContext?.read<UserCubit>().state.status.isLoaded() ??
      false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.sw,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [AppColors.c15CF74, AppColors.c15CF9D],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              LocaleKeys.wantToFindAReliableAssistant.tr(),
              textAlign: TextAlign.center,
              style: AppTextStyles.size22Bold.copyWith(
                color: AppColors.cFFFFFF,
              ),
            ),
            Text(
              LocaleKeys
                  .topJobHelpsYouQuicklySolveAnyHouseholdAndBusinessProblems
                  .tr(),
              textAlign: TextAlign.center,
              style: AppTextStyles.size17Regular.copyWith(
                color: AppColors.cFFFFFF,
              ),
            ).paddingOnly(top: 16.h, bottom: 32.h),
            AppButton(
              onPressed: () {
                if (userLogged) {
                  onPressed();
                } else {
                  LoginPage().show(context);
                }
              },
              text: title,
              color: AppColors.cFFFFFF,
              textStyle: AppTextStyles.size20Bold,
              radius: 8.r,
              verticalPadding: 12.h,
            ),
          ],
        ).paddingSymmetric(horizontal: 30.w, vertical: 24.h),
      ),
    );
  }
}
