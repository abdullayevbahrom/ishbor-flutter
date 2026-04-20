import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_jobs/core/constants/sizes_const.dart';

sealed class AppUtils {
  static SizedBox kSizedBoxShrink = SizedBox.shrink();
  static SizedBox wSizedBox4 = SizedBox(width: SizesCons.size_4.w);
  static SizedBox wSizedBox8 = SizedBox(width: SizesCons.size_8.w);
  static SizedBox wSizedBox10 = SizedBox(width: SizesCons.size_10.w);
  static SizedBox wSizedBox15= SizedBox(width: SizesCons.size_15.w);
  static SizedBox wSizedBox16 = SizedBox(width: SizesCons.size_16.w);
  static SizedBox wSizedBox20 = SizedBox(width: SizesCons.size_20.w);

  static SizedBox hSizedBox4 = SizedBox(height: SizesCons.size_4.h);
  static SizedBox hSizedBox8 = SizedBox(height: SizesCons.size_8.h);
  static SizedBox hSizedBox16 = SizedBox(height: SizesCons.size_16.h);
  static SizedBox hSizedBox24 = SizedBox(height: SizesCons.size_24.h);
  static SizedBox hSizedBox30 = SizedBox(height: SizesCons.size_30.h);
  static SizedBox hSizedBox32 = SizedBox(height: SizesCons.size_32.h);
  static SizedBox hSizedBox40 = SizedBox(height: SizesCons.size_40.h);

}
