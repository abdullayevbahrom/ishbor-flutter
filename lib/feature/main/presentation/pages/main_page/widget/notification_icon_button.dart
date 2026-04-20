import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../core/helpers/key_helpers.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_svg.dart';

class NotificationIconButton extends StatelessWidget {
  const NotificationIconButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55.r,
      width: 55.r,
      child: FloatingActionButton(
        key: notificationKey,
        heroTag: null,
        onPressed: onPressed,
        mini: false,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.r),
        ),
        backgroundColor: AppColors.cFF9914,
        elevation: 6,
        splashColor: Colors.white.withOpacity(0.3),
        child: SizedBox(
          height: 50,
          child: SvgPicture.asset(
            AppSvg.icBellLight,
            height: 25.r,
            width: 25.r,
          ),
        ),
      ),
    );
  }
}
