import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:top_jobs/core/router/route_names.dart';
import 'package:top_jobs/core/theme/app_svg.dart';
import 'package:top_jobs/export.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_button.dart';
import 'package:top_jobs/feature/common/presentation/widget/footer.dart';

import '../../../../../common/presentation/widget/w_layout.dart';
import '../../../cubits/vacancy_form_cubit/vacancy_form_cubit.dart';

class WGenerateVacancy extends StatefulWidget {
  const WGenerateVacancy({super.key});

  @override
  State<WGenerateVacancy> createState() => _WGenerateVacancyState();
}

class _WGenerateVacancyState extends State<WGenerateVacancy> {
  late final TextEditingController _shortDesc;

  final String hintText = LocaleKeys.enterJobDescription.tr();
  String _animatedHint = "";
  int _charIndex = 0;
  Timer? _timer;
  int currentLength = 0;

  int get dynamicMaxLength => currentLength >= 50 ? 600 : 50;

  @override
  void initState() {
    _shortDesc = TextEditingController();
    _shortDesc.addListener(_controllerListener);
    _startTypingHint();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<VacancyFormCubit>().getVacancyParamsFromStorage();
    });
    super.initState();
  }

  void _controllerListener() {
    if (_shortDesc.text.length > 600) {
      final newText = _shortDesc.text.substring(0, 600);
      _shortDesc.value = _shortDesc.value.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }
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
    _shortDesc.removeListener(_controllerListener);
    _shortDesc.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VacancyFormCubit, VacancyFormState>(
      builder: (context, state) {
        return WLayout(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      40.verticalSpace,
                      Text(
                        LocaleKeys.createVacancy.tr(),
                        style: AppTextStyles.size28Bold.copyWith(
                          color: AppColors.c2E3A59,
                        ),
                      ).paddingOnly(left: 8.w),
                      24.verticalSpace,
                      Text(
                        LocaleKeys.description.tr(),
                        style: AppTextStyles.size15Medium.copyWith(
                          color: AppColors.c333333,
                        ),
                      ),
                      8.verticalSpace,
                      Column(
                        spacing: 8.h,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DecoratedBox(
                            decoration: BoxDecoration(
                              color: AppColors.cFFFFFF,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: AppColors.cE0E5EB,
                                width: 1.r,
                              ),
                            ),
                            child: Column(
                              children: [
                                TextField(
                                  enabled: true,
                                  style: AppTextStyles.size17Medium,
                                  onChanged: (value) {
                                    setState(() {
                                      currentLength = value.length;
                                    });
                                  },
                                  controller: _shortDesc,
                                  minLines: 7,
                                  maxLines: 50,
                                  maxLength: 600,
                                  maxLengthEnforcement:
                                      MaxLengthEnforcement.enforced,
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
                                    radius: 30.r,
                                    lineWidth: 8.0,
                                    backgroundColor: AppColors.cFFFFFF,
                                    reverse: true,
                                    percent: (currentLength / dynamicMaxLength)
                                        .clamp(0.0, 1.0),
                                    progressColor: AppColors.cGreen,
                                  ),
                                ),
                              ],
                            ).paddingAll(16.r),
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
                                    text: "  $currentLength/$dynamicMaxLength",
                                    style: AppTextStyles.size13Medium,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      40.verticalSpace,
                      Align(
                        alignment: Alignment.center,
                        child: AppButton(
                          onPressed: () {
                            context.pushReplacement(
                              Routes.vacancyForm,
                              extra: {"prompt": _shortDesc.text.trim()},
                            );
                          },
                          isAvailable: currentLength >= 50,
                          leftIcon: SvgPicture.asset(
                            AppSvg.icMagic2,
                          ).paddingOnly(right: 5.w),
                          text: LocaleKeys.Creation.tr(),
                          textStyle: AppTextStyles.size18Bold.copyWith(
                            color: AppColors.cFFFFFF,
                          ),
                          color:
                              currentLength >= 50
                                  ? AppColors.cFF9914
                                  : AppColors.c888888,
                        ),
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 16.w),
                  Footer(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
