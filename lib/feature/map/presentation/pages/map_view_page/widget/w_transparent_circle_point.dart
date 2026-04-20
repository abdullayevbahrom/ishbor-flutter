import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/theme/app_colors.dart';

class TransparentCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint whitePaint = Paint()..color = AppColors.c2E3A59.withOpacity(0.2);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), whitePaint);
    Paint clearPaint =
    Paint()
      ..blendMode = BlendMode.clear
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = 200.0.r;

    canvas.drawCircle(center, radius, clearPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
