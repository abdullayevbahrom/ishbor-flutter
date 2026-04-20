import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_jobs/core/extentions/color_extension.dart';

import '../../../../../../core/theme/app_colors.dart';

class WAnimatedAddFb extends StatelessWidget {
  const WAnimatedAddFb({super.key, required this.onTapFb, required this.open});
  final VoidCallback onTapFb;
  final bool open;
  static const _dur = Duration(milliseconds: 300);
  static const _curve = Curves.easeInOut;
  @override
  Widget build(BuildContext context) {
    return  Positioned(
      right: 21,
      bottom: 24,
      child: IgnorePointer(
        ignoring: false,
        child: GestureDetector(
          onTap:  onTapFb,
          behavior: HitTestBehavior.translucent,
          child: AnimatedContainer(
            duration: _dur,
            curve: _curve,
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color:
              open
                  ? AppColors.c2E3A59
                  : AppColors.cFFFFFF,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black.newWithOpacity(.06),
                width: 1.r,
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 40,
                  spreadRadius: 0,
                  offset: const Offset(0, 5),
                  color: AppColors.c000000
                      .newWithOpacity(.1),
                ),
              ],
            ),
            child: Center(
              child: AnimatedSwitcher(
                duration: _dur,
                child: Icon(
                  Icons.add,
                  key: ValueKey("add menu "),
                  size: 32,
                  color:
                  open
                      ? AppColors.cFFFFFF
                      : AppColors.c2E3A59,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
