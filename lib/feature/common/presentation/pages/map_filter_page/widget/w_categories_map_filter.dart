import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:top_jobs/export.dart';
import 'package:top_jobs/feature/common/data/models/category.dart';
import 'package:top_jobs/feature/common/presentation/cubits/category_cubit/category_cubit.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_check_box.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_divider.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_dialog_action_button.dart';



class WCategoriesMapFilter extends StatefulWidget {
  final List<CategoryModel> categories;

  const WCategoriesMapFilter({super.key, required this.categories});

  @override
  State<WCategoriesMapFilter> createState() => _WCategoriesMapFilterState();

  show(BuildContext context) {
    return showDialog(
      context: context,
      builder:
          (context) => this.paddingSymmetric(horizontal: 20.w, vertical: 140.h),
    );
  }
}

class _WCategoriesMapFilterState extends State<WCategoriesMapFilter> {
  late List<CategoryModel> categories;

  @override
  void initState() {
    categories = List.from(widget.categories);
    context.read<CategoryCubit>().initialize();
    super.initState();
  }

  void updateCategories(int index) {
    if (categories.contains(
      context.read<CategoryCubit>().state.categories?.items[index],
    )) {
      categories.remove(
        context.read<CategoryCubit>().state.categories?.items[index],
      );
    } else {
      categories.add(
        context.read<CategoryCubit>().state.categories!.items[index],
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        return FadeInUp(
          child: Material(
            color: AppColors.cFFFFFF,
            borderRadius: BorderRadius.circular(16.r),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    controller: context.read<CategoryCubit>().scrollController,
                    itemCount:
                    state.isLoadingMore
                        ? (context
                        .read<CategoryCubit>()
                        .state
                        .categories
                        ?.items
                        .length ??
                        0) +
                        1
                        : context
                        .read<CategoryCubit>()
                        .state
                        .categories
                        ?.items
                        .length ??
                        0,
                    itemBuilder:
                        (context, index) =>
                    state.isLoadingMore &&
                        state.categories?.items.length == index
                        ? Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                        : InkWell(
                      onTap: () {
                        updateCategories(index);
                      },
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            context
                                .read<CategoryCubit>()
                                .state
                                .categories
                                ?.items[index]
                                .translations[context.locale ==
                                'ru'
                                ? 0
                                : 1]
                                .name ??
                                '',
                            style: AppTextStyles.size18Medium,
                          ),
                          AppCheckBox(
                            value: categories.contains(
                              context
                                  .read<CategoryCubit>()
                                  .state
                                  .categories
                                  ?.items[index],
                            ),
                            onChanged: (value) {
                              updateCategories(index);
                            },
                          ),
                        ],
                      ).paddingSymmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                    ),
                  ),
                ),
                AppDivider(width: 100.sw, height: 1.h),
                Row(
                  children: [
                    WDialogActionButton(
                      onTap: () {
                        context.pop();
                      },
                      title: LocaleKeys.cancel.tr(),
                      isEnable: true,
                    ),
                    AppDivider(width: 1.w, height: 60.h),
                    WDialogActionButton(
                      onTap: () {
                        context.pop(categories);
                      },
                      title: LocaleKeys.save.tr(),
                      isEnable: false,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

