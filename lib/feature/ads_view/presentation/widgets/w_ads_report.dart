import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/theme/app_colors.dart';
import 'package:top_jobs/core/theme/app_text_styles.dart';
import 'package:top_jobs/feature/ads_view/data/models/reports_param.dart';
import 'package:top_jobs/feature/common/presentation/cubits/ask_question_cubit/ask_question_cubit.dart';
import 'package:top_jobs/feature/common/presentation/pages/w_modal_bottom_sheet_container.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_button.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_text_form_field.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_toasttifications.dart';

class WAdsReport extends StatefulWidget {
  const WAdsReport({
    super.key,
    this.userId,
    this.vacancyId,
    this.serviceId,
    this.taskId,
  });

  final int? userId;
  final int? vacancyId;
  final int? serviceId;
  final int? taskId;

  show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => Wrap(
            children: [this],
          ).paddingOnly(bottom: MediaQuery.viewInsetsOf(context).bottom),
    );
  }

  @override
  State<WAdsReport> createState() => _WAdsReportState();
}

class _WAdsReportState extends State<WAdsReport> {
  late TextEditingController _controller;
  int _currentLength = 0;
  int _maxLength = 120;

  void _controllerListener() {
    final text = _controller.text;
    if (text.length > _maxLength) {
      final newText = text.substring(0, _maxLength);
      _controller.value = _controller.value.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }
  }

  @override
  void initState() {
    _controller = TextEditingController();
    _controller.addListener(_controllerListener);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_controllerListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AskQuestionCubit, AskQuestionState>(
      listener: (context, state) {
        if (state.reportSt.isLoaded()) {
          context.pop();
          showSuccessToast(LocaleKeys.reportSend.tr());
        }
      },
      builder: (context, state) {
        return Material(
          color: AppColors.cTransparent,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.cFFFFFF,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.r),
                topLeft: Radius.circular(20.r),
              ),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  12.verticalSpace,
                  WModalSheetDecoratedContainer(),
                  22.verticalSpace,
                  Text(
                    LocaleKeys.complainAboutAds.tr(),
                    style: AppTextStyles.size24Bold.copyWith(
                      color: AppColors.c2E3A59,
                    ),
                  ),
                  20.verticalSpace,
                  Text(
                    LocaleKeys.description.tr(),
                    style: AppTextStyles.size15Regular.copyWith(
                      color: AppColors.cB7BFCA,
                    ),
                  ),
                  5.verticalSpace,
                  AppTextFormField(
                    hintText: "",
                    controller: _controller,
                    minLines: 6,
                    maxLines: 15,
                    fillColor: AppColors.cFFFFFF,
                    currentLength: _currentLength,
                    maxLength: _maxLength,
                    keyBoardType: TextInputType.text,
                    formatters: [LengthLimitingTextInputFormatter(_maxLength)],
                    onChanged: (value) {
                      setState(() {
                        _currentLength = value.length;
                      });
                    },
                  ),
                  16.verticalSpace,
                  SizedBox(
                    height: 50.h,
                    child: AppButton(
                      onPressed: () {
                        context.read<AskQuestionCubit>().reportAd(
                          ReportsParam(
                            userId: widget.userId,
                            taskId: widget.taskId,
                            serviceId: widget.serviceId,
                            vacancyId: widget.vacancyId,
                            body: _controller.text.trim(),
                          ),
                        );
                      },
                      isLoading: state.reportSt.isLoading(),
                      width: 100.sw,
                      text: LocaleKeys.send.tr(),
                      color: AppColors.c2E3A59,
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
