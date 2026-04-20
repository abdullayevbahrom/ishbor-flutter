import 'package:circle_splash/circle_splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:top_jobs/core/theme/app_colors.dart';
import 'package:top_jobs/core/theme/app_png.dart';

import '../../../../../app_state.dart';
import '../../../../../core/router/route_names.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key, this.payload});

  final Map<String, dynamic>? payload;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool hasNewVersion = false;

  Future<void> navigateNextPage() async {
    final newVersion = NewVersionPlus(
      androidId: "uz.ishbor.app.com",
      iOSId: "com.ishbor.app.uz",
    );
    final value = await newVersion.getVersionStatus();
    await Future.delayed(const Duration(milliseconds: 2500));
    if (!mounted) {
      return;
    }

    final localVersions = value?.localVersion.split('.') ?? const <String>[];
    final storeVersions = value?.storeVersion.split('.') ?? const <String>[];
    final maxLength =
        localVersions.length > storeVersions.length
            ? localVersions.length
            : storeVersions.length;

    for (int i = 0; i < maxLength; i++) {
      final storePart =
          i < storeVersions.length ? int.tryParse(storeVersions[i]) ?? 0 : 0;
      final localPart =
          i < localVersions.length ? int.tryParse(localVersions[i]) ?? 0 : 0;

      if (storePart > localPart) {
        hasNewVersion = true;
        break;
      }
      if (storePart < localPart) {
        break;
      }
    }

    if (hasNewVersion && (value?.appStoreLink?.isNotEmpty ?? false)) {
      context.go(Routes.newVersion, extra: value!.appStoreLink);
    } else {
      context.go(Routes.main, extra: widget.payload);
    }
  }

  @override
  void initState() {
    navigateNextPage();
    AppState.isActive = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CircleSplashScreen(
        config: CircleSplashConfig(
          animationType: CircleSplashAnimationType.bottomRight,
          circleColor: AppColors.cFF9914,
        ),
        child: Image.asset(AppPng.imgNewSplash,height: 110.h,),
      ),
    );
  }
}


/*
Stack(
        children: [
          Center(
            child: SizedBox(
              height: 150,
              child: SvgPicture.asset(AppSvg.icIshBor),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: 60.w,
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: AppColors.cFF9914,
                size: 50,
              ),
            ).paddingOnly(bottom: 50.h),
          ),
        ],
      ),
 */

/*
CircleSplashScreen(
        config: CircleSplashConfig(
          animationType: CircleSplashAnimationType.bottomRight,
          circleColor: AppColors.cFF9914,
        ),
        child: Image.asset(AppPng.imgLogo),
      )
 */
