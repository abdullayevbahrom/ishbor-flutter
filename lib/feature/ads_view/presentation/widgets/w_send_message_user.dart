import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/extentions/color_extension.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/helpers/validators.dart';
import 'package:top_jobs/core/theme/app_colors.dart';
import 'package:top_jobs/core/theme/app_text_styles.dart';
import 'package:top_jobs/feature/common/presentation/cubits/ask_question_cubit/ask_question_cubit.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_button.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_text_form_field.dart';
import 'package:top_jobs/feature/profile/data/model/ask_question_model.dart';

class WSendMessageUser extends StatefulWidget {
  const WSendMessageUser({
    super.key,
    required this.title,
    required this.receiverId,
    this.vacancyId,
    this.serviceId,
    this.taskId,
  });

  final String title;
  final int receiverId;
  final int? vacancyId;
  final int? serviceId;
  final int? taskId;

  show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: AppColors.cFFFFFF,
      builder: (context) {
        return Wrap(
          children: [this],
        ).paddingOnly(bottom: MediaQuery.viewInsetsOf(context).bottom);
      },
    );
  }

  @override
  State<WSendMessageUser> createState() => _WSendMessageUserState();
}

class _WSendMessageUserState extends State<WSendMessageUser> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _controller;
  int currentLength = 0;
  int maxLength = 120;

  @override
  void initState() {
    _controller = TextEditingController();
    _controller.addListener(() {
      final text = _controller.text;
      if (text.length > maxLength) {
        final newText = text.substring(0, maxLength);
        _controller.value = _controller.value.copyWith(
          text: newText,
          selection: TextSelection.collapsed(offset: newText.length),
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AskQuestionCubit, AskQuestionState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.cFFFFFF,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.r),
                topLeft: Radius.circular(20.r),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.c000000.newWithOpacity(.1),
                  offset: const Offset(0, 4),
                  blurRadius: 8.r,
                ),
              ],
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  11.verticalSpace,
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 5.h,
                      width: 95.w,
                      decoration: BoxDecoration(
                        color: AppColors.cE0E5EB,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                  ),
                  22.verticalSpace,
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.size24Bold.copyWith(
                        color: AppColors.c2E3A59,
                      ),
                    ),
                  ),
                  13.verticalSpace,
                  Text(
                    LocaleKeys.message.tr(),
                    style: AppTextStyles.size15Regular.copyWith(
                      color: AppColors.cB7BFCA,
                    ),
                  ),
                  3.verticalSpace,
                  AppTextFormField(
                    hintText: "",
                    controller: _controller,
                    currentLength: currentLength,
                    borderRadius: 12.r,
                    minLines: 6,
                    maxLines: 10,
                    maxLength: maxLength,
                    fillColor: AppColors.cFFFFFF,
                    keyBoardType: TextInputType.text,
                    formatters: [LengthLimitingTextInputFormatter(maxLength)],
                    onChanged: (value) {
                      setState(() {
                        currentLength = value.length;
                      });
                    },
                    validator: (value) {
                      return ValidatorHelpers.validateField(value: value!);
                    },
                  ),
                  20.verticalSpace,
                  SizedBox(
                    height: 50.h,
                    child: AppButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          context.read<AskQuestionCubit>().askQuestion(
                            SendMessageRequest(
                              vacancy: widget.vacancyId,
                              service: widget.serviceId,
                              task: widget.taskId,
                              receiver: widget.receiverId,
                              body: _controller.text.trim(),
                            ),
                          );
                        }
                      },
                      isLoading: state.status.isLoading(),

                      width: 100.sw,
                      text: LocaleKeys.send.tr(),
                      color: AppColors.c2E3A59,
                      textStyle: AppTextStyles.size15Medium.copyWith(
                        color: AppColors.cFFFFFF,
                      ),
                    ),
                  ),
                  40.verticalSpace,
                ],
              ).paddingSymmetric(horizontal: 16.w),
            ),
          ),
        );
      },
    );
  }
}
