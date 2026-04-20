import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:top_jobs/core/theme/app_svg.dart';

import '../../../../../../core/theme/app_lottie.dart';
import '../../../../../../export.dart';
import '../../../../../common/presentation/widget/app_button.dart';
import '../../../../../common/presentation/widget/w_decorated_box.dart';

class GenerateVacancy extends StatefulWidget {
  const GenerateVacancy({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onTapButton,
    required this.isAvailable,
    required this.isLoading,
  });

  final TextEditingController controller;
  final Function(String? value) onChanged;
  final VoidCallback onTapButton;
  final bool isAvailable;
  final bool isLoading;

  @override
  State<GenerateVacancy> createState() => _GenerateVacancyState();
}

class _GenerateVacancyState extends State<GenerateVacancy> {
  final String hintText = LocaleKeys.enterJobDescription.tr();
  String _animatedHint = "";
  int _charIndex = 0;
  Timer? _timer;
  int currentLength = 0;

  @override
  void initState() {
    _startTypingHint();
    super.initState();
  }

  void _startTypingHint() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_charIndex < hintText.length) {
        setState(() {
          _animatedHint += hintText[_charIndex];
          _charIndex++;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  int get dynamicMaxLength => currentLength >= 50 ? 500 : 50;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        WDecoratedBox(
          radius: 12.r,
          child: Column(
            spacing: 8.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.description.tr(),
                textAlign: TextAlign.start,
                style: AppTextStyles.size15Medium.copyWith(
                  color: AppColors.c333333,
                ),
              ),

              SizedBox(
                width: 100.sw,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.cFFFFFF,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: AppColors.cE0E5EB),
                  ),
                  child: Column(
                    children: [
                      TextField(
                        enabled: true,
                        style: AppTextStyles.size17Medium,
                        onChanged: (value) {
                          widget.onChanged(value);
                          setState(() {
                            currentLength = value.length;
                          });
                        },
                        controller: widget.controller,
                        minLines: 7,
                        maxLines: 30,
                        maxLength: dynamicMaxLength,
                        maxLengthEnforcement: MaxLengthEnforcement.none,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(598),
                        ],
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          enabled: true,
                          filled: true,
                          hintText: _animatedHint,
                          counter: AppUtils.kSizedBoxShrink,
                          contentPadding: EdgeInsets.zero,
                          fillColor: AppColors.cFFFFFF,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: CircularPercentIndicator(
                          radius: 40.r,
                          lineWidth: 10.0,
                          backgroundColor: AppColors.cFFFFFF,
                          reverse: true,
                          percent: (currentLength / dynamicMaxLength).clamp(
                            0.0,
                            1.0,
                          ),
                          progressColor: AppColors.cGreen,
                        ),
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 16.r, vertical: 8.r),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: RichText(
                  text: TextSpan(
                    text:
                        dynamicMaxLength <= 50
                            ? LocaleKeys.minNumOfChar.tr()
                            : LocaleKeys.maxNumberOfCharacter.tr(),
                    style: AppTextStyles.size13Medium.copyWith(
                      color: AppColors.c828282,
                    ),
                    children: [
                      TextSpan(
                        text: "  ${currentLength}/${dynamicMaxLength}",
                        style: AppTextStyles.size13Medium,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ).paddingAll(16.r),
        ),

        AppUtils.hSizedBox24,
        AppButton(
          onPressed: widget.onTapButton,
          isAvailable: widget.isAvailable,
          isLoading: widget.isLoading,
          leftIcon: SvgPicture.asset(
            AppSvg.icMagic2,
            height: 20.r,
          ).paddingOnly(right: 5.r),
          loadingWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              1,
              (index) => Lottie.asset(
                AppLottie.ai,
                height: 28.h,
                animate: true,
                repeat: true,
              ),
            ),
          ),
          width: 150.w,
          text: LocaleKeys.Creation.tr(),
          radius: 6.r,
          color: widget.isAvailable ? AppColors.cFF9914 : AppColors.c888888,
        ),
      ],
    );
  }
}
