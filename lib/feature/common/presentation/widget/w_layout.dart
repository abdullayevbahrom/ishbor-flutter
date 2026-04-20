import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class WLayout extends StatelessWidget {
  const WLayout({super.key, required this.child, this.bottom, this.top});

  final Widget child;
  final bool? bottom;
  final bool? top;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.cFFFFFF,
      child: SafeArea(bottom: bottom ?? false, top: top ?? true, child: child),
    );
  }
}
