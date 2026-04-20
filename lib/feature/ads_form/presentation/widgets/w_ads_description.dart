import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:top_jobs/core/extentions/color_extension.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/theme/app_svg.dart';
import 'package:top_jobs/feature/ads_form/presentation/cubits/vacancy_form_cubit/vacancy_form_cubit.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_button.dart';
import '../../../../core/constants/locale_keys.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class WAdsDescription extends StatefulWidget {
  const WAdsDescription({
    super.key,
    required TextEditingController descriptionController,
    required this.descriptionKey,
    required this.chatGptController,
  }) : _descriptionController = descriptionController;

  final TextEditingController _descriptionController;
  final TextEditingController chatGptController;
  final Key descriptionKey;

  @override
  State<WAdsDescription> createState() => _WAdsDescriptionState();
}

class _WAdsDescriptionState extends State<WAdsDescription> {
  int currentLength = 0;
  int maxLength = 900;
  late FocusNode _focusNode;

  @override
  void initState() {
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {});
    });
    widget._descriptionController.addListener(() {
      final text = widget._descriptionController.text;
      if (text.length > maxLength) {
        final newText = text.substring(0, maxLength);
        widget._descriptionController.value = widget
            ._descriptionController
            .value
            .copyWith(
              text: newText,
              selection: TextSelection.collapsed(offset: newText.length),
            );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VacancyFormCubit, VacancyFormState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.description.tr(),
              style: AppTextStyles.size15Medium.copyWith(
                color: AppColors.c333333,
              ),
            ),
            8.verticalSpace,
            DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.cFFFFFF,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color:
                      _focusNode.hasFocus
                          ? AppColors.cFF9914
                          : AppColors.cE0E5EB,
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  TextFormField(
                    focusNode: _focusNode,

                    minLines: 6,
                    maxLines: 1000,
                    enabled: true,
                    scrollPhysics: NeverScrollableScrollPhysics(),
                    style: AppTextStyles.size17Regular,
                    controller: widget._descriptionController,
                    keyboardType: TextInputType.text,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(900)
                    ],
                    onChanged: (value) {
                      setState(() {
                      });
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.cFFFFFF,
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  if (state.gptDesSt.isLoaded())
                    Align(
                      alignment: AlignmentGeometry.centerRight,
                      child: AppButton(
                        onPressed: () {
                          context.read<VacancyFormCubit>().initChatGptStatus();
                          widget._descriptionController.text =
                              widget.chatGptController.text;
                        },
                        leftIcon: SvgPicture.asset(
                          AppSvg.icRefresh,
                        ).paddingOnly(right: 5.w),
                        text: LocaleKeys.Return.tr(),
                        textStyle: AppTextStyles.size15Medium.copyWith(
                          color: AppColors.cFF3A44,
                        ),
                        color: AppColors.cFF3A44.newWithOpacity(.1),
                      ).paddingOnly(top: 16.h),
                    )
                  else
                    Align(
                      alignment: AlignmentGeometry.centerRight,
                      child: AppButton(
                        onPressed: () {
                          context.read<VacancyFormCubit>().generateVacancyDescription(
                            widget._descriptionController.text.trim(),
                          );
                        },
                        leftIcon: SvgPicture.asset(
                          AppSvg.icStarts,
                        ).paddingOnly(right: 5.w),
                        text: LocaleKeys.improvedText.tr(),
                        textStyle: AppTextStyles.size15Medium.copyWith(
                          color: AppColors.cFF9914,
                        ),
                        color: AppColors.cFF9914.newWithOpacity(.1),
                      ).paddingOnly(top: 16.h),
                    ),
                ],
              ).paddingSymmetric(horizontal: 16.w, vertical: 16.h),
            ),
            SizedBox(
              height: 40,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                              "${widget._descriptionController.text.trim().length}/900",
                          style: AppTextStyles.size13Medium,
                        ),
                      ],
                      text: LocaleKeys.maxNumberOfCharacter.tr(),
                      style: AppTextStyles.size13Medium.copyWith(
                        color: AppColors.c828282,
                      ),
                    ),
                  ),
                  6.horizontalSpace,
                  CircularPercentIndicator(
                    radius: 8.r,
                    lineWidth: 2.0,
                    backgroundColor: AppColors.cFFFFFF,
                    reverse: true,
                    percent:
                        widget._descriptionController.text.trim().length / 900,
                    progressColor: Colors.green,
                  ),
                ],
              ).paddingOnly(right: 20.w),
            ),

            // AppTextFormField(
            //   fieldKey: widget.descriptionKey,
            //   minLines: 7,
            //   maxLines: 100,
            //   borderRadius: 12.r,
            //   currentLength: currentLength,
            //   maxLength: maxLength,
            //   hintText: LocaleKeys.enterVacancyDescription.tr(),
            //   controller: widget._descriptionController,
            //   fillColor: AppColors.cFFFFFF,
            //   formatters: [LengthLimitingTextInputFormatter(maxLength)],
            //   onChanged: (value) {
            //     setState(() {
            //       currentLength = value.length;
            //     });
            //   },
            //   validator: (value) {
            //     if (value != null) {
            //       return ValidatorHelpers.validateField(value: value);
            //     } else {
            //       return null;
            //     }
            //   },
            // ),
          ],
        );
      },
    ).paddingSymmetric(horizontal: 16.w);
  }
}
