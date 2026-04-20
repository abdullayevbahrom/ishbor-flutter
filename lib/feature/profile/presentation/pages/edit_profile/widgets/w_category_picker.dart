import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:top_jobs/core/constants/app_locale_keys.dart';
import 'package:top_jobs/export.dart';
import 'package:top_jobs/feature/common/data/models/category.dart';
import 'package:top_jobs/feature/common/presentation/cubits/category_cubit/category_cubit.dart';
import 'package:top_jobs/feature/common/presentation/pages/w_modal_bottom_sheet_container.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_button.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_check_box_list_tile.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_sheet_title.dart';

class WCategoryPicker extends StatefulWidget {
  WCategoryPicker({super.key, required this.categories});

  List<CategoryModel> categories;

  show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.r),
        borderSide: BorderSide.none,
      ),
      backgroundColor: AppColors.cFFFFFF,
      useSafeArea: true,
      isScrollControlled: true,

      builder:
          (context) => Wrap(
            children: [
              this.paddingOnly(bottom: MediaQuery.viewInsetsOf(context).bottom),
            ],
          ),
    );
  }

  @override
  State<WCategoryPicker> createState() => _WCategoryPickerState();
}

class _WCategoryPickerState extends State<WCategoryPicker> {
  List<CategoryModel> selectedCategories = [];

  late DraggableScrollableController _controller;

  @override
  void initState() {
    _controller = DraggableScrollableController();
    selectedCategories = widget.categories;

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.cFFFFFF,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                11.verticalSpace,
                WModalSheetDecoratedContainer(),
                22.verticalSpace,
                WSheetTitle(title: LocaleKeys.categories.tr()),
                15.verticalSpace,
                if (state.status.isLoading())
                  Skeletonizer(
                    enabled: true,
                    child: SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.55,
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        controller:
                            context.read<CategoryCubit>().scrollController,
                        itemCount: 15,
                        separatorBuilder: (context, index) => 10.verticalSpace,
                        itemBuilder: (context, index) {
                          return Text(AppLocaleKeys.lorem, maxLines: 1);
                        },
                      ),
                    ),
                  ),
                if (state.status.isLoaded())
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.55,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      controller:
                          context.read<CategoryCubit>().scrollController,
                      itemCount: state.categories?.items.length,
                      itemBuilder: (context, index) {
                        final category = state.categories?.items[index];
                        return WCheckedBoxListTile(
                          title:
                              category
                                  ?.translations[context.locale.languageCode ==
                                          'ru'
                                      ? 0
                                      : 1]
                                  .name ??
                              "",
                          value: selectedCategories.contains(category),
                          onTap: () {
                            setState(() {
                              if (selectedCategories.contains(category)) {
                                selectedCategories.remove(category);
                              } else {
                                selectedCategories.add(category!);
                              }
                            });
                          },
                        );
                      },
                    ),
                  ),
                10.verticalSpace,
                Row(
                  spacing: 10.w,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50.h,
                        child: AppButton(
                          onPressed: () {
                            context.pop();
                          },
                          text: LocaleKeys.cancel.tr(),
                          textStyle: AppTextStyles.size17Medium.copyWith(
                            color: AppColors.c000000,
                          ),
                          borderColor: AppColors.c2E3A59,
                          color: AppColors.cF7F9FC,
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 50.h,
                        child: AppButton(
                          onPressed: () {
                            context.pop(selectedCategories);
                          },
                          text: LocaleKeys.save.tr(),
                          textStyle: AppTextStyles.size17Medium.copyWith(
                            color: AppColors.cF7F9FC,
                          ),
                          color: AppColors.cFF9914,
                        ),
                      ),
                    ),
                  ],
                ).paddingSymmetric(horizontal: 16.w),
              ],
            ),
          ),
        );
      },
    );
  }
}

/*
 return WRadioListTile(
                        title:
                            category
                                ?.translations[context.locale.languageCode ==
                                        'ru'
                                    ? 0
                                    : 1]
                                .name ??
                            "",
                        value: selectedCategories.contains(category),
                        onTap: () {
                          setState(() {
                            if (selectedCategories.contains(category)) {
                              selectedCategories.remove(category);
                            } else {
                              selectedCategories.add(category!);
                            }
                          });
                        },
                      );
 */
