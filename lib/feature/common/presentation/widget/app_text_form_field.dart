import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/utils/app_utils.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class AppTextFormField extends StatefulWidget {
  AppTextFormField({
    super.key,
    required this.hintText,
    this.suffixIcon,
    required this.controller,
    this.maxLines,
    this.minLines,
    this.maxLength,
    this.prefixIcon,
    this.fillColor,
    this.onTap,
    this.validator,
    this.keyBoardType,
    this.onChanged,
    this.currentLength,
    this.formatters,
    this.obscureTextAvailable,
    this.prefixText,
    this.borderRadius,
    this.fieldKey,
    this.prefix,
    this.onSaved,
    this.onSubmitted,
    this.textAlign=TextAlign.start
  });

  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController controller;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final int? currentLength;
  final Color? fillColor;
  final VoidCallback? onTap;
  FormFieldValidator<String>? validator;
  final TextInputType? keyBoardType;
  final Function(String value)? onChanged;
  final List<TextInputFormatter>? formatters;
  final bool? obscureTextAvailable;
  final double? borderRadius;
  final String? prefixText;
  bool obscureText = false;
  final Key? fieldKey;
  final Widget? prefix;
  final VoidCallback? onSaved;
  final VoidCallback? onSubmitted;
  final TextAlign textAlign;

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  int currentIndex = 0;

  @override
  void initState() {
    setState(() {
      currentIndex = widget.controller.text.length;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.fieldKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      expands: false,
      textAlign: widget.textAlign,
      style: AppTextStyles.size17Medium.copyWith(color: AppColors.c333333),
      inputFormatters: widget.formatters,
      keyboardType: widget.keyBoardType,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      maxLength: widget.maxLength,
      controller: widget.controller,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      validator: widget.validator,
      obscureText: widget.obscureText ?? false,

      onFieldSubmitted: (value) {
        widget.onSubmitted ?? ();
      },

      decoration: InputDecoration(
        enabled: true,
        isDense: true,
        prefixText: widget.prefixText,

        prefixStyle: AppTextStyles.size17Medium.copyWith(
          color: AppColors.c333333,
        ),
        prefix: widget.prefix,
        prefixIcon: widget.prefixIcon,
        prefixIconConstraints: BoxConstraints(
          minWidth: 0,
          minHeight: 0,
          maxHeight: 50.h,
        ),
        counter:
            widget.maxLength != null
                ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                                "  ${widget.currentLength}/${widget.maxLength}",
                            style: AppTextStyles.size13Medium,
                          ),
                        ],
                        text: LocaleKeys.maxNumberOfCharacter.tr(),
                        style: AppTextStyles.size13Medium.copyWith(
                          color: AppColors.c828282,
                        ),
                      ),
                    ),
                    AppUtils.wSizedBox8,
                    CircularPercentIndicator(
                      radius: 8.r,
                      lineWidth: 2.0,
                      backgroundColor: AppColors.cFFFFFF,
                      reverse: true,
                      percent: widget.currentLength! / widget.maxLength!,
                      progressColor: Colors.green,
                    ),
                  ],
                ).paddingOnly(top: 4.h)
                : null,
        filled: Theme.of(context).inputDecorationTheme.filled,
        fillColor:
            widget.fillColor ??
            Theme.of(context).inputDecorationTheme.fillColor,
        hintText: widget.hintText,
        suffixIcon: SizedBox(
          child:
              widget.obscureTextAvailable ?? false
                  ? IconButton(
                    onPressed: () {
                      setState(() {
                        widget.obscureText = !widget.obscureText;
                      });
                    },
                    splashColor: AppColors.cEDEDED,
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      widget.obscureText
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: AppColors.cFF9914,
                    ),
                  )
                  : widget.suffixIcon,
        ).paddingOnly(right: 8),
        suffixIconConstraints: BoxConstraints(minHeight: 50.h, maxHeight: 50.h),
        hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
        contentPadding: Theme.of(context).inputDecorationTheme.contentPadding,
        focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
        enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
        focusedErrorBorder:
            Theme.of(context).inputDecorationTheme.focusedErrorBorder,
        disabledBorder: Theme.of(context).inputDecorationTheme.disabledBorder,
        border: Theme.of(context).inputDecorationTheme.border,
      ),
    );
  }
}
