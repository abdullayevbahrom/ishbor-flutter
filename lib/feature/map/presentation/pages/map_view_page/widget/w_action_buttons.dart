import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';

import '../../../../../../core/theme/app_colors.dart';

class WActionButtons extends StatelessWidget {
  const WActionButtons({
    super.key,
    required this.onTapCurrentLoc,
    required this.onTapAddBtn,
    required this.onTapMinusBtn,
    required this.enableCurrentLoc,
  });

  final VoidCallback onTapCurrentLoc;
  final VoidCallback onTapAddBtn;
  final VoidCallback onTapMinusBtn;
  final bool enableCurrentLoc;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20.h,
      left: 15.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          enableCurrentLoc
              ? MaterialButton(
            onPressed: onTapCurrentLoc,
            height: 30.r,
            padding: EdgeInsets.zero,
            color: AppColors.cFFFFFF,
            minWidth: 30.r,
            shape: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Icon(CupertinoIcons.location).paddingAll(12.r),
          )
              : DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
              color: AppColors.cFFFFFF,
            ),
            child: Icon(CupertinoIcons.location_slash).paddingAll(12.r),
          ),
          SizedBox(height: 10.h),
          MaterialButton(
            onPressed: onTapAddBtn,
            height: 50.r,
            padding: EdgeInsets.zero,
            color: AppColors.cFFFFFF,
            minWidth: 30.r,
            shape: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                topRight: Radius.circular(12.r),
              ),
            ),
            child: Icon(CupertinoIcons.add, size: 20.r).paddingAll(12.r),
          ),
          MaterialButton(
            onPressed: onTapMinusBtn,
            height: 50.r,
            padding: EdgeInsets.zero,
            color: AppColors.cFFFFFF,
            minWidth: 30.r,

            shape: OutlineInputBorder(

              borderSide: BorderSide.none,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12.r),
                bottomRight: Radius.circular(12.r),
              ),
            ),
            child: Icon(CupertinoIcons.minus, size: 20.r).paddingAll(12.r),
          ),
        ],
      ),
    );
  }
}
