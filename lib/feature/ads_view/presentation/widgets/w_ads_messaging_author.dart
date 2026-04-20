import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_svg.dart';
import '../../../../export.dart';
import '../../../common/presentation/widget/app_button.dart';
import '../../../common/presentation/widget/app_text_form_field.dart';

class WAdsMessagingAuthor extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  final bool isLoading;
  final TextEditingController controller;

  const WAdsMessagingAuthor({
    super.key,
    required this.text,
    required this.onTap,
    required this.isLoading,
    required this.controller,
  });

  void show(BuildContext context) {
    showDialog(
      context: context,
      useRootNavigator: false,
      barrierDismissible: true,
      useSafeArea: true,
      builder:
          (context) => Center(
            child: Wrap(children: [this.paddingSymmetric(horizontal: 16.w)]),
          ).paddingOnly(bottom: MediaQuery.of(context).viewInsets.bottom),
    );
  }

  @override
  State<WAdsMessagingAuthor> createState() => _WAdsMessagingAuthorState();
}

class _WAdsMessagingAuthorState extends State<WAdsMessagingAuthor> {
  int currentLength = 0;

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Material(
        borderRadius: BorderRadius.circular(16.r),
        color: AppColors.cFFFFFF,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.cFFFFFF,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.c000000.withOpacity(.1),
                blurRadius: 8.r,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      widget.text,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.size24Bold.copyWith(
                        color: AppColors.c2E3A59,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: SvgPicture.asset(AppSvg.icCancelGrey),
                  ),
                ],
              ),
              AppUtils.hSizedBox24,
              Text(
                LocaleKeys.message.tr(),
                style: AppTextStyles.size15Medium.copyWith(
                  color: AppColors.c333333,
                ),
              ),
              AppUtils.hSizedBox8,
              AppTextFormField(
                maxLines: 8,
                minLines: 6,
                maxLength: 120,
                currentLength: currentLength,
                keyBoardType: TextInputType.text,
                fillColor: AppColors.cFFFFFF,
                hintText: LocaleKeys.askAQuestion.tr(),
                controller: widget.controller,
                formatters: [LengthLimitingTextInputFormatter(120)],
                onChanged: (value) {
                  setState(() {
                    currentLength = value.length;
                  });
                },
              ),
              AppUtils.hSizedBox32,
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  height: 40.h,
                  child: AppButton(
                    onPressed: widget.isLoading ? () {} : widget.onTap,
                    text:
                        widget.isLoading
                            ? LocaleKeys.loading.tr()
                            : LocaleKeys.send.tr(),
                    color: AppColors.c15CF74,
                  ),
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: 16.w, vertical: 24.h),
        ),
      ),
    );
  }
}
