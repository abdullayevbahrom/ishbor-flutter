import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/theme/app_svg.dart';
import 'package:top_jobs/feature/common/data/models/category.dart';
import 'package:top_jobs/feature/common/presentation/pages/w_modal_bottom_sheet_container.dart';

import '../../../../../../core/constants/locale_keys.g.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../common/presentation/cubits/category_cubit/category_cubit.dart';
import '../../../../../common/presentation/widget/app_text_form_field.dart';
import '../../../../../common/presentation/widget/w_check_box_list_tile.dart';
import '../../../cubits/map_view_cubit/map_view_cubit.dart';

class WMapAppBar extends StatefulWidget {
  WMapAppBar({super.key, required this.type});

  final String type;

  @override
  State<WMapAppBar> createState() => _WMapAppBarState();
}

class _WMapAppBarState extends State<WMapAppBar> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapViewCubit, MapViewState>(
      builder: (context, state) {
        _controller.text = state.categories
            .map((e) {
              return e
                  .translations[context.locale.languageCode == 'ru' ? 0 : 1]
                  .name;
            })
            .toList()
            .join(',');
        return DecoratedBox(
          decoration: BoxDecoration(color: AppColors.cFFFFFF),
          child: AppBar(
            backgroundColor: AppColors.cFFFFFF,
            leading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: SvgPicture.asset(AppSvg.icBack),
            ),
            title: Text(
              widget.type == 'vacancy'
                  ? LocaleKeys.nearbyVacancies.tr()
                  : widget.type == 'service'
                  ? LocaleKeys.nearbyService.tr()
                  : LocaleKeys.nearbyTasks.tr(),
              style: AppTextStyles.size20Medium.copyWith(
                color: AppColors.c2E3A59,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(80.h),
              child: AppTextFormField(
                maxLines: 1,
                minLines: 1,
                keyBoardType: TextInputType.none,
                hintText: LocaleKeys.selectCategory.tr(),
                fillColor: AppColors.cFFFFFF,
                controller: _controller,
                suffixIcon: Icon(
                  Icons.keyboard_arrow_right,
                  color: AppColors.cFF9914,
                  size: 29.r,
                ),
                onTap: () async {
                  final response = await WCommonCategoriesList(
                    savedCategories: state.categories,
                  ).show(context);

                  if (response != null) {
                    context.read<MapViewCubit>().addCategories(response);
                  }
                },
              ).paddingOnly(bottom: 25.h),
            ),
          ).paddingSymmetric(horizontal: 20.w),
        );
      },
    );
  }
}

class WCommonCategoriesList extends StatefulWidget {
  final List<CategoryModel> savedCategories;

  const WCommonCategoriesList({super.key, required this.savedCategories});

  show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.cFFFFFF,
      isScrollControlled: true,


      builder: (context) => this,
    );
  }

  @override
  State<WCommonCategoriesList> createState() => _WCommonCategoriesListState();
}

class _WCommonCategoriesListState extends State<WCommonCategoriesList> {
  List<CategoryModel> categories = [];

  @override
  void initState() {
    categories = List<CategoryModel>.from(widget.savedCategories);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        return SafeArea(
          child: DraggableScrollableSheet(
            minChildSize: 0.4,
            initialChildSize: 0.4,
            maxChildSize: 0.9,
            expand: false,
            builder: (context, scrollController) {
              return Column(
                children: [
                  11.verticalSpace,
                  WModalSheetDecoratedContainer(),
                  16.verticalSpace,
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      controller:scrollController,
                      itemBuilder: (context, index) {
                        return state.isLoadingMore &&
                                index == state.categories?.items.length
                            ? Center(child: CircularProgressIndicator.adaptive())
                            : WCheckedBoxListTile(
                              value: categories.contains(
                                context
                                    .read<CategoryCubit>()
                                    .state
                                    .categories
                                    ?.items[index],
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
                                if (categories.contains(
                                  context
                                      .read<CategoryCubit>()
                                      .state
                                      .categories
                                      ?.items[index],
                                )) {
                                  categories.remove(
                                    context
                                        .read<CategoryCubit>()
                                        .state
                                        .categories
                                        ?.items[index],
                                  );
                                } else {
                                  categories.add(
                                    context
                                        .read<CategoryCubit>()
                                        .state
                                        .categories!
                                        .items[index],
                                  );
                                }
                                setState(() {});
                              },
                            ).paddingSymmetric(horizontal: 16.w);
                      },
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
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            context.pop(null);
                          },
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20.r),
                          ),
                          child: Center(
                            child: Text(
                              LocaleKeys.cancel.tr(),
                              style: AppTextStyles.size20Bold.copyWith(
                                color: AppColors.cRed,
                              ),
                            ).paddingSymmetric(vertical: 15.h),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            context.pop(categories);
                          },
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20.r),
                          ),
                          child: Center(
                            child: Text(
                              LocaleKeys.save.tr(),
                              style: AppTextStyles.size20Bold.copyWith(
                                color: AppColors.c13A5E3,
                              ),
                            ).paddingSymmetric(vertical: 15.h),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
