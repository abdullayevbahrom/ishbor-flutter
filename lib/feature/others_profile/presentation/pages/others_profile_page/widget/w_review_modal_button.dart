import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/helpers/validators.dart';
import 'package:top_jobs/feature/common/data/models/feedback_model.dart';
import 'package:top_jobs/feature/common/presentation/cubits/feedback_cubit/feedback_cubit.dart';
import 'package:top_jobs/feature/others_profile/presentation/pages/others_profile_page/widget/w_review_mood_button.dart';

import '../../../../../../core/constants/locale_keys.g.dart';
import '../../../../../../core/constants/sizes_const.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_svg.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../common/presentation/widget/app_button.dart';
import '../../../../../common/presentation/widget/app_text_form_field.dart';

class WReviewModalButton extends StatefulWidget {
  const WReviewModalButton({
    super.key,
    required this.receiverId,
    required this.feedbackCubit,
  });

  final int receiverId;
  final FeedbackCubit feedbackCubit;

  show(BuildContext context) {
    showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      builder:
          (context) => Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: this,
          ),
    );
  }

  @override
  State<WReviewModalButton> createState() => _WReviewModalButtonState();
}

class _WReviewModalButtonState extends State<WReviewModalButton> {
  final TextEditingController controller = TextEditingController();
  int currentLength = 0;
  int isActive = 0;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> _keyForm = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedbackCubit, FeedbackState>(
      bloc: widget.feedbackCubit,
      builder: (context, state) {
        return Form(
          key: _keyForm,
          child: SafeArea(
            child: Material(
              color: AppColors.cFFFFFF,
              borderRadius:BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r)
              ),
              child: SizedBox(
                width: 100.sw,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: SizesCons.size_32.h),
                    Text(
                      LocaleKeys.addReview.tr(),
                      style: AppTextStyles.size24Bold.copyWith(
                        color: AppColors.c2E3A59,
                      ),
                    ),
                    SizedBox(height: SizesCons.size_8.h),
                    Text(
                      LocaleKeys.whatAreYourImpressions.tr(),
                      style: AppTextStyles.size15Medium.copyWith(
                        color: AppColors.c333333,
                      ),
                    ),
                    SizedBox(height: 19.h),
                    Row(
                      spacing: 10.w,
                      children: [
                        Expanded(
                          child: WReviewMood(
                            svg: AppIcons.icLike,
                            text: LocaleKeys.positive.tr(),
                            onPressed: () {
                              setState(() {
                                isActive = 1;
                              });
                            },
                            isActive: isActive == 1,
                          ),
                        ),
                        Expanded(
                          child: WReviewMood(
                            svg: AppIcons.icDislike,
                            text: LocaleKeys.negative.tr(),
                            isActive: isActive == 2,
                            onPressed: () {
                              setState(() {
                                isActive = 2;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 17.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        LocaleKeys.evaluateTheCompletedWork.tr(),
                        style: AppTextStyles.size15Regular.copyWith(
                          color: AppColors.cB7BFCA,
                        ),
                      ),
                    ).paddingOnly(bottom: 2.h),
                    AppTextFormField(
                      minLines: 5,
                      maxLines: 10,
                      maxLength: 120,
                      currentLength: currentLength,
                      fillColor: AppColors.cFFFFFF,
                      formatters: [LengthLimitingTextInputFormatter(120)],
                      validator: (value) {
                        return ValidatorHelpers.validateField(value: value!);
                      },
                      onChanged: (value) {
                        setState(() {
                          currentLength = value.length;
                        });
                      },
                      hintText: '',
                      controller: controller,
                    ),
                    SizedBox(height: 16.h),
                    AppButton(
                      onPressed: () {
                        if (_keyForm.currentState!.validate()) {
                          widget.feedbackCubit.addFeedBack(
                            feedBackRequest: FeedbackRequestModel(
                              message: controller.text.trim(),
                              receiver: widget.receiverId,
                              like: isActive == 1,
                              dislike: isActive == 2,
                            ),
                          );
                        }
                      },
                      isLoading: state.addReviewSt.isLoading(),
                      width: 100.sw,
                      verticalPadding: 15.h,
                      text: LocaleKeys.writeReview.tr(),
                      color: AppColors.c2E3A59,
                    ),
                    40.verticalSpace,
                  ],
                ).paddingSymmetric(horizontal: 18.w),
              ),
            ),
          ),
        );
      },
    );
  }
}
