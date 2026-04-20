import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/theme/app_colors.dart';
import 'package:top_jobs/core/theme/app_png.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/router/route_names.dart';
import 'bottom_menu.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BottomMenu().paddingOnly(top: 60.h),
        Padding(
          padding: EdgeInsets.only(top: 60.h),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: DecoratedBox(
              decoration: BoxDecoration(color: AppColors.cFF9914),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 32.h),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: InkWell(
                      onTap: () {
                        navigatorKey.currentContext?.go(Routes.main);
                      },
                      child: Image.asset(
                        AppPng.imgFooter,
                        width: 80.r,
                        height: 80.r,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
