import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/constants/locale_keys.g.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../common/presentation/cubits/category_cubit/category_cubit.dart';
import '../../../../../common/presentation/widget/app_divider.dart';
import '../../../../../common/presentation/widget/w_check_box_list_tile.dart';
import '../../../../../common/presentation/widget/w_dialog_action_button.dart';

class WCategoriesFilterList extends StatefulWidget {
  final List<int> listCategories;

  WCategoriesFilterList({super.key, required this.listCategories});

  show(BuildContext context) {
    return showDialog(
      context: context,
      useSafeArea: true,
      barrierDismissible: true,
      useRootNavigator: true,
      builder:
          (context) => this.paddingSymmetric(vertical: 180.h, horizontal: 20.w),
    );
  }

  @override
  State<WCategoriesFilterList> createState() => _WCategoriesFilterListState();
}

class _WCategoriesFilterListState extends State<WCategoriesFilterList> {
  late List ids;

  @override
  void initState() {
    ids = List.from(widget.listCategories);
    context.read<CategoryCubit>().initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          return Material(
            color: AppColors.cFFFFFF,
            borderRadius: BorderRadius.circular(16.r),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(bottom: 16.r),
                    itemCount:
                        state.isLoadingMore
                            ? context
                                    .read<CategoryCubit>()
                                    .state
                                    .categories
                                    ?.items
                                    .length ??
                                0 + 1
                            : context
                                    .read<CategoryCubit>()
                                    .state
                                    .categories
                                    ?.items
                                    .length ??
                                0,
                    controller: context.read<CategoryCubit>().scrollController,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return state.isLoadingMore &&
                              index == state.categories?.items.length
                          ? Center(child: CircularProgressIndicator.adaptive())
                          : WCheckedBoxListTile(
                            value: ids.contains(
                              context
                                  .read<CategoryCubit>()
                                  .state
                                  .categories
                                  ?.items[index]
                                  .id,
                            ),
                            title:
                                context
                                    .read<CategoryCubit>()
                                    .state
                                    .categories
                                    ?.items[index]
                                    .translations[context.locale == 'ru'
                                        ? 0
                                        : 1]
                                    .name ??
                                "",
                            onTap: () {
                              if (ids.contains(
                                context
                                    .read<CategoryCubit>()
                                    .state
                                    .categories
                                    ?.items[index]
                                    .id,
                              )) {
                                ids.remove(
                                  context
                                      .read<CategoryCubit>()
                                      .state
                                      .categories
                                      ?.items[index]
                                      .id,
                                );
                              } else {
                                ids.add(
                                  context
                                      .read<CategoryCubit>()
                                      .state
                                      .categories
                                      ?.items[index]
                                      .id,
                                );
                              }
                              setState(() {});
                            },
                          );
                    },
                  ).paddingOnly(top: 16.r, right: 16.r, left: 16.r),
                ),
                AppDivider(width: 100.sw, height: 1.h),
                Row(
                  children: [
                    WDialogActionButton(
                      onTap: () {
                        context.pop(null);
                      },
                      title: LocaleKeys.cancel.tr(),
                      isEnable: true,
                    ),
                    AppDivider(width: 1.w, height: 55.h),
                    WDialogActionButton(
                      onTap: () {
                        context.pop(ids);
                      },
                      title: LocaleKeys.save.tr(),
                      isEnable: false,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
