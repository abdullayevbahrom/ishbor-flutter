import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';

class WSvgIcon extends StatelessWidget {
  const WSvgIcon({super.key, required this.svgUrl});

  final String svgUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20.r,
      width: 20.r,
      child: SvgPicture.asset(svgUrl).paddingAll(1.r),
    );
  }
}
