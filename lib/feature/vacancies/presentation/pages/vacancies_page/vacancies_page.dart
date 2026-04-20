import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/helpers/debouncer.dart';

import 'package:top_jobs/core/router/route_names.dart';
import 'package:top_jobs/core/theme/app_colors.dart';
import 'package:top_jobs/core/utils/app_utils.dart';
import 'package:top_jobs/feature/common/presentation/pages/w_error_page/w_error_page.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_button.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_search_form.dart';
import 'package:top_jobs/feature/common/presentation/widget/new_vacancy_item.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_error_widget.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_loading.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_refresh_indicator.dart';
import 'package:top_jobs/feature/vacancies/data/models/vacancy_query_params.dart';
import 'package:top_jobs/feature/vacancies/presentation/cubits/vacancy_cubit/vacancy_cubit.dart';
import '../../../../../injection_container.dart';
import '../../../../common/presentation/cubits/locale_cubit/locale_cubit.dart';
import '../../../../common/presentation/cubits/user_cubit/user_cubit.dart';
import '../../../../common/presentation/widget/w_loading_item.dart';

class VacancyList extends StatefulWidget {
  @override
  State<VacancyList> createState() => _VacancyListState();
}

class _VacancyListState extends State<VacancyList> {
  final vacancyCubit = sl<VacancyCubit>();

  bool enableCancel = false;

  void test() {
  //   for (int i = 0; i <= 700; i++) {
  //     if (i < 700) {
  //       sl<Dio>().get('https://api.ishbor.uz/vacancies/2022');
  //     }
  //   }
  }

  @override
  void initState() {
    test();
    vacancyCubit
      ..reset()
      ..fetchVacancies()
      ..initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, state) {
        return BlocProvider(
          create: (context) => vacancyCubit,
          child: BlocBuilder<VacancyCubit, VacancyState>(
            bloc: vacancyCubit,
            builder: (context, state) {
              return Container(
                color: AppColors.cFFFFFF,
                child: SafeArea(
                  top: true,
                  child: Scaffold(
                    backgroundColor: AppColors.cF6F7FB,
                    body: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppSearchForm(
                          onPressedCancel: () {
                            setState(() {
                              enableCancel = false;
                              vacancyCubit.searchController.clear();
                            });
                            vacancyCubit.fetchVacancies();
                          },
                          enableCancel: enableCancel,
                          controller: vacancyCubit.searchController,

                          enableFilter: vacancyCubit.filters.hasActiveFilters,
                          onChanged: (value) {
                            setState(() {
                              enableCancel = value.toString().trim().isNotEmpty;
                            });

                            sl<Debounce>().run(() {
                              vacancyCubit.fetchVacancies();
                            });
                          },
                          onTapLocation: () {
                            context.push(Routes.map, extra: "vacancy");
                          },
                          onTapFilter: () async {
                            final QueryParams? result = await context.push(
                              Routes.filterForm,
                              extra: vacancyCubit.filters,
                            );
                            if (result != null) {
                              vacancyCubit.updateFilter(result);
                              vacancyCubit
                                ..reset()
                                ..fetchVacancies();
                            } else {
                              vacancyCubit
                                ..resetFilter()
                                ..reset()
                                ..fetchVacancies();
                            }
                          },
                        ),
                        Expanded(child: buildBody(state, vacancyCubit)),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget buildBody(VacancyState state, VacancyCubit cubit) {
    if (state.status.isLoading()) {
      return WLoading();
    }

    if (state.status.isError()) {
      return WErrorPage(
        onPressedReTry: () async {
          test();
          context.read<UserCubit>().checkUser();
          await vacancyCubit.fetchVacancies();
        },
      );
    }

    if (state.status.isLoaded()) {
      final list = state.newVacancies?.items;
      if ((list ?? []).isEmpty) {
        return Column(
          spacing: 20.h,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WErrorWidget(errorText: LocaleKeys.noVacancies.tr()),
            if (vacancyCubit.filters.hasActiveFilters)
              AppButton(
                onPressed: () {
                  vacancyCubit.resetFilter();
                  vacancyCubit.fetchVacancies();
                },
                text: LocaleKeys.clearFilter.tr(),
                color: AppColors.cFF9914,
              ),
          ],
        );
      }
      return WRefreshIndicator(
        onRefresh: () async {
          test();
          //cubit.resetFilter();
          cubit.reset();
          cubit.fetchVacancies();
        },
        child: LayoutBuilder(
          builder:
              (context, constraints) => ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: list?.length ?? 0 + (state.isLoadingMore ? 1 : 0),
                  controller: vacancyCubit.scrollController,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    if (state.isLoadingMore && list?.length == index + 1) {
                      return WLoadingLottie();
                    }
                    return GestureDetector(
                      onTap: () {
                        context.push(Routes.vacancyView);
                      },
                      child: NewVacancyItem(
                        vacancy: list![index],
                        onPressedFavorite:
                            () => vacancyCubit.updateFavorite(index),
                      ),
                      // child: VacancyItem(
                      //   vacancy: list![index],
                      //   onPressedFavorite: () {
                      //     vacancyCubit.updateFavorite(index);
                      //   },
                      // ),
                    );
                  },
                ),
              ),
        ),
      );
    }
    return AppUtils.kSizedBoxShrink;
  }
}
