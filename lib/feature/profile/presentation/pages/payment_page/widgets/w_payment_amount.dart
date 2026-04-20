import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_jobs/core/extentions/color_extension.dart';

import '../../../../../../core/helpers/formatters.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../common/presentation/widget/app_button.dart';

final List<int> _amounts = [20000, 50000, 100000, 200000, 300000, 400000];

class WPaymentAmount extends StatelessWidget {
  const WPaymentAmount({
    super.key,
    required this.onPressedAmount,
    required this.currentValue,
  });

  final Function(String amount) onPressedAmount;
  final String currentValue;

  @override 
  Widget build(BuildContext context) {
    return GridView.builder(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _amounts.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10.r,
        crossAxisSpacing: 10.r,
        mainAxisExtent: 33,
        //childAspectRatio: 110.w/ 33.h,
      ),
      itemBuilder: (context, index) {
        return AppButton(
          onPressed: () {
            onPressedAmount(Formatters.moneyFormat("${_amounts[index]}"));
          },
          textStyle: AppTextStyles.size15Medium.copyWith(
            color:
            AppColors.c2E3A59,
          ),
          text: Formatters.moneyFormat("${_amounts[index]}"),
          verticalPadding: 0,
          color:
          currentValue == Formatters.moneyFormat("${_amounts[index]}")
              ? AppColors.cFF9914.newWithOpacity(.3)
              : AppColors.c2E3A59.newWithOpacity(.05),
        );
      },
    );
  }
}
