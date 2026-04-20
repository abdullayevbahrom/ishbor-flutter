import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_view/photo_view.dart';

import '../../../../core/theme/app_colors.dart';

class WPhotoView extends StatefulWidget {
  const WPhotoView({super.key, required this.imageUrl});

  final List<String> imageUrl;

  show(BuildContext context) {
    return showDialog(
      context: context,
      useSafeArea: false,
      barrierDismissible: true,
      builder: (context) => this,
    );
  }

  @override
  State<WPhotoView> createState() => _WPhotoViewState();
}

class _WPhotoViewState extends State<WPhotoView> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: PageView(
            scrollDirection: Axis.horizontal,
            onPageChanged: (value) {
              setState(() {
                currentIndex = value;
              });
            },
            children: List.generate(widget.imageUrl.length, (index) {
              return PhotoView(
                backgroundDecoration: BoxDecoration(
                  color: AppColors.c000000.withOpacity(.3),
                ),
                imageProvider: NetworkImage(widget.imageUrl[index]),
              );
            }),
          ),
        ),
        Positioned(
          right: 16.w,
          top: 80.h,
          child: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(Icons.cancel, color: AppColors.cFFFFFF),
          ),
        ),
        if (widget.imageUrl.length > 1)
          Positioned(
            left: 0,
            right: 0,
            bottom: 150.h,
            child: DotsIndicator(
              dotsCount: widget.imageUrl.length,
              position: currentIndex.toDouble(),
              decorator: DotsDecorator(
                color: AppColors.cMainBg, // Inactive color
                activeColor: AppColors.cFF9914,
                activeSize: Size(14.r, 14.r),
                size: Size(12.r, 12.r),
              ),
            ),
          ),
      ],
    );
  }
}
