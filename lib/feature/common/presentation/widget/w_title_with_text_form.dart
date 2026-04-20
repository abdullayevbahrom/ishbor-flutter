import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_jobs/core/utils/app_utils.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'app_text_form_field.dart';

class WTitleWithTextForm extends StatelessWidget {
  const WTitleWithTextForm({
    super.key,
    required this.textEditingController,
    required this.title,
    required this.hintText,
    this.paddingRight,
    this.suffixIcon,
    this.maxLines,
    this.minLines,
    this.maxLength,
    this.suffixWidget,
    this.prefixIcon,
    this.onTap,
    this.validator,
    this.keyBoardType,
    this.onChanged,
    this.currentLength,
    this.richText,
    this.formatters,
    this.fieldKey,
    this.bgColor
  });

  final TextEditingController textEditingController;
  final String title;
  final String hintText;
  final double? paddingRight;
  final Widget? suffixIcon;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final Widget? suffixWidget;
  final Widget? prefixIcon;
  final VoidCallback? onTap;
  final int? currentLength;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyBoardType;
  final Function(String value)? onChanged;
  final String? richText;
  final List<TextInputFormatter>? formatters;
  final Key? fieldKey;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: title,
            style: AppTextStyles.size15Medium.copyWith(
              color: AppColors.c333333,
            ),
            children: [
              TextSpan(
                text: richText,
                style: AppTextStyles.size15Medium.copyWith(
                  color: AppColors.cBDC0C6,
                ),
              ),
            ],
          ),
        ),
        Row(
          spacing: 4.w,
          children: [
            Expanded(
              child: AppTextFormField(

                fieldKey: fieldKey,
                onChanged: onChanged,
                keyBoardType: keyBoardType,
                validator: validator,
                onTap: onTap,
                fillColor: bgColor??AppColors.cFBFBFD,
                prefixIcon: prefixIcon,
                minLines: minLines,
                maxLines: maxLines ?? 1,
                maxLength: maxLength,
                suffixIcon: suffixIcon,
                hintText: hintText,
                controller: textEditingController,
                currentLength: currentLength,
                formatters: formatters,
              ),
            ),
            suffixWidget ?? AppUtils.kSizedBoxShrink,
          ],
        ),
      ],
    );
  }
}
