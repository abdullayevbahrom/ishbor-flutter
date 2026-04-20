import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_loading_item.dart';

class WLoadingMore extends StatelessWidget {
  const WLoadingMore({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      width: 80.w,
      child: Center(
        child: WLoading(),
      ),
    );
  }
}
