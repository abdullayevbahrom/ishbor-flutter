import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:top_jobs/core/extentions/color_extension.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_svg.dart';
import '../../../../../common/presentation/cubits/notification_cubit/notification_cubit.dart';

class WAnimatedNotificationFb extends StatelessWidget {
  const WAnimatedNotificationFb({
    super.key,
    required this.onTapFb,
    required this.open,
  });

  final VoidCallback onTapFb;
  final bool open;
  static const _dur = Duration(milliseconds: 300);
  static const _curve = Curves.easeInOut;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        return Positioned(
          right: 26,
          bottom: 90,
          child: GestureDetector(
            onTap: onTapFb,
            child: AnimatedContainer(
              duration: _dur,
              curve: _curve,
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: open ? AppColors.cFF9914 : AppColors.cFFFFFF,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 40,
                    spreadRadius: 0,
                    offset: const Offset(0, 5),
                    color: AppColors.c000000.newWithOpacity(.1),
                  ),
                ],
              ),
              child: Center(
                child: AnimatedSwitcher(
                  duration: _dur,
                  child: SizedBox(
                    height: 27.r,
                    width: 27.r,
                    child: Badge(
                      isLabelVisible:state.hasNewNotification,
                      child: SvgPicture.asset(
                        open ? AppSvg.icBellLight : AppSvg.icBell,
                        fit: BoxFit.contain,
                      ).paddingOnly(top: 2.r, right: 2.r),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
