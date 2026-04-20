import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:top_jobs/core/theme/app_lottie.dart';

class WLoadingLottie extends StatelessWidget {
  const WLoadingLottie({super.key,  this.height,  this.width});

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        AppLottie.wLoading,
        fit: BoxFit.contain,
        height: height??30.r,
        width: width??30.r,
      ),
    );
  }
}
