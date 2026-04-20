import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_locale_keys.dart';
import '../../../../core/theme/app_colors.dart';

class AppCachedNetworkImage extends StatelessWidget {
  const AppCachedNetworkImage({
    super.key,
    this.imageUrl,
    required this.height,
    required this.radius,
    this.width,
    this.enableBoxShow,
  });

  final String? imageUrl;
  final double? width;
  final double height;
  final double radius;
  final bool? enableBoxShow;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow:
            enableBoxShow ?? false
                ? [
                  BoxShadow(
                    color: AppColors.c000000.withOpacity(.15),
                    offset: Offset(0, 4),
                    blurRadius: 10.r,
                  ),
                ]
                : [],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: CachedNetworkImage(
          imageUrl: imageUrl ?? AppLocaleKeys.imageUrl,
          progressIndicatorBuilder:
              (context, url, progress) => Container(
                height: height,
                width: width ?? height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius ?? 5.r),
                  color: AppColors.cF7F9FC,
                ),
              ),
          errorWidget: (context, url, error) {
            return Icon(Icons.error, color: AppColors.cRed);
          },
          height: height,
          width: width ?? height,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
