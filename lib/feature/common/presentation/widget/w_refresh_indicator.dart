import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class WRefreshIndicator extends StatelessWidget {
  const WRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
  });

  final Widget child;
  final RefreshCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      child: child,
      onRefresh: onRefresh,
      color: AppColors.cFF9914,
      backgroundColor: AppColors.cMainBg,
    );
  }
}
