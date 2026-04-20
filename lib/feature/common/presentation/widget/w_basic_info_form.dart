import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/helpers/validators.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_text_form_field.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_decorated_box.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_title_with_text_form.dart';
import '../../../../core/constants/locale_keys.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/app_utils.dart';
import '../cubits/category_cubit/category_cubit.dart';

class WBasicInfoForm extends StatefulWidget {
  const WBasicInfoForm({
    super.key,
    required this.serviceController,
    required this.categoriesController,
    required this.onTapCategories,
    this.title,
    required this.basicTitle,
    required this.onChanged,
    this.titleKey,
    this.categoryKey,
  });

  final String? title;
  final String basicTitle;
  final TextEditingController serviceController;
  final TextEditingController categoriesController;
  final VoidCallback onTapCategories;
  final Function({int? value, String? valueStr}) onChanged;
  final Key? titleKey;
  final Key? categoryKey;

  @override
  State<WBasicInfoForm> createState() => _WBasicInfoFormState();
}

class _WBasicInfoFormState extends State<WBasicInfoForm> {
  @override
  void initState() {
    context.read<CategoryCubit>()
      ..reset()
      ..fetchCategories()
      ..initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.title != null
                ? Text(
                  widget.title!,
                  style: AppTextStyles.size28Bold.copyWith(
                    color: AppColors.c2E3A59
                  ),
                ).paddingSymmetric(vertical: 24.h, horizontal: 8.w)
                : AppUtils.kSizedBoxShrink,
            WDecoratedBox(
              radius: 16.r,
              bgColor: AppColors.cFBFBFD,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.basicTitle,
                    style: AppTextStyles.size22Bold.copyWith(
                      color: AppColors.c2E3A59,
                    ),
                  ),
                  AppUtils.hSizedBox16,
                  WTitleWithTextForm(
                    fieldKey: widget.titleKey,
                    validator: (value) {
                      return ValidatorHelpers.validateField(
                        value: value!,
                        message: LocaleKeys.serviceName.tr(),
                      );
                    },
                    keyBoardType: TextInputType.text,
                    textEditingController: widget.serviceController,
                    title: LocaleKeys.serviceName.tr(),
                    hintText: LocaleKeys.enterName.tr(),
                  ),
                  AppUtils.hSizedBox24,
                  Text(
                    LocaleKeys.categories.tr(),
                    style: AppTextStyles.size15Medium.copyWith(
                      color: AppColors.c333333,
                    ),
                  ),
                  AppUtils.hSizedBox8,
                  AppTextFormField(
                    fieldKey: widget.categoryKey,
                    hintText: LocaleKeys.selectCategory.tr(),
                    controller: widget.categoriesController,
                    fillColor:AppColors.cFBFBFD,
                    keyBoardType: TextInputType.none,
                    suffixIcon: Icon(
                      Icons.keyboard_arrow_right_rounded,
                      color: AppColors.cBDC0C6,
                      size: 25.sp,
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return FadeInUp(
                            child: BlocBuilder<CategoryCubit, CategoryState>(
                              builder: (context, state) {
                                return Material(
                                  borderRadius: BorderRadius.circular(20.r),
                                  color: AppColors.cFFFFFF,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    controller:
                                        context
                                            .read<CategoryCubit>()
                                            .scrollController,
                                    padding: EdgeInsets.symmetric(
                                      vertical: 16.h,
                                    ),
                                    itemBuilder: (context, index) {
                                      return state.isLoadingMore &&
                                              index ==
                                                  state.categories?.items.length
                                          ? Center(
                                            child:
                                                CircularProgressIndicator.adaptive(),
                                          )
                                          : InkWell(
                                            onTap: () {
                                              context.pop();
                                              widget.onChanged(
                                                value:
                                                    state
                                                        .categories
                                                        ?.items[index]
                                                        .id,
                                                valueStr:
                                                    '${state.categories?.items[index].translations[context.locale.languageCode == 'ru' ? 0 : 1].name}',
                                              );
                                            },
                                            child: Text(
                                              '${state.categories?.items[index].translations[context.locale.languageCode == 'ru' ? 0 : 1].name}',
                                              style: AppTextStyles.size17Medium,
                                            ).paddingSymmetric(
                                              horizontal: 16.w,
                                              vertical: 8.h,
                                            ),
                                          );
                                    },
                                    itemCount:
                                        !state.isLoadingMore
                                            ? state.categories?.items.length ??
                                                0
                                            : state.categories?.items.length ??
                                                0 + 1,
                                  ),
                                );
                              },
                            ).paddingSymmetric(
                              horizontal: 20.w,
                              vertical: 220.h,
                            ),
                          );
                        },
                      );
                    },
                    onChanged: (value) {},
                    validator: (value) {
                      return ValidatorHelpers.validateField(value: value!);
                    },
                  ),
                  // WDropDownMenu(
                  //   onChanged: onChanged,
                  //                value: categoriesController.text.trim(),
                  // ),
                ],
              ).paddingAll(16.r),
            ),
          ],
        );
      },
    );
  }
}
