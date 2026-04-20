import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/helpers/debouncer.dart';
import 'package:top_jobs/core/utils/app_utils.dart';
import 'package:top_jobs/feature/common/presentation/pages/w_error_page/w_error_page.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_search_form.dart';
import 'package:top_jobs/feature/common/presentation/widget/service_item.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_error_widget.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_layout.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_loading.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_loading_item.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_refresh_indicator.dart';
import 'package:top_jobs/feature/services/presentation/cubits/service_cubit/service_cubit.dart';
import 'package:top_jobs/feature/vacancies/data/models/vacancy_query_params.dart';

import '../../../../../core/router/route_names.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../injection_container.dart';
import '../../../../common/presentation/cubits/locale_cubit/locale_cubit.dart';
import '../../../../common/presentation/cubits/user_cubit/user_cubit.dart';
import '../../../../common/presentation/widget/app_button.dart';

class ServicesPage extends StatefulWidget {
  ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  final serviceCubit = sl<ServiceCubit>();
  bool enableCancel = false;

  @override
  void initState() {
    serviceCubit
      ..initialize()
      ..resetFilter()
      ..fetchServices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, state) {
        return BlocProvider.value(
          value: serviceCubit,
          child: BlocBuilder<ServiceCubit, ServiceState>(
            builder: (context, state) {
              return WLayout(
                child: Scaffold(
                  backgroundColor: AppColors.cF6F7FB,

                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppSearchForm(
                        enableCancel: enableCancel,
                        controller: serviceCubit.searchController,
                        onPressedCancel: () {
                          setState(() {
                            enableCancel = false;
                            serviceCubit.searchController.clear();
                          });
                          serviceCubit.fetchServices();
                        },
                        enableFilter: serviceCubit.filters.hasActiveFilters,
                        onChanged: (value) {
                          setState(() {
                            enableCancel = value.toString().trim().isNotEmpty;
                          });

                          sl<Debounce>().run(() {
                            serviceCubit.fetchServices();
                          });
                        },
                        onTapLocation: () {
                          context.push(Routes.map, extra: "service");
                        },
                        onTapFilter: () async {
                          final QueryParams? response = await context.push(
                            Routes.filterForm,
                            extra: serviceCubit.filters,
                          );

                          if (response != null) {
                            serviceCubit.updateFilter(response);
                            serviceCubit
                              ..reset()
                              ..fetchServices();
                          } else {
                            serviceCubit
                              ..resetFilter()
                              ..reset()
                              ..fetchServices();
                          }
                        },
                      ),
                      Expanded(
                        child: buildBody(
                          state: state,
                          onPressedReTry: () async {
                            context.read<UserCubit>().checkUser();
                            serviceCubit
                              ..resetFilter()
                              ..reset()
                              ..fetchServices();
                          },
                          scrollController: serviceCubit.scrollController,
                          onRefresh: () async {
                            serviceCubit
                              ..reset()
                              ..fetchServices();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget buildBody({
    required ServiceState state,
    required RefreshCallback onRefresh,
    required ScrollController scrollController,
    required VoidCallback onPressedReTry,
  }) {
    if (state.status.isLoading()) {
      return WLoading();
    }

    if (state.status.isError()) {
      return WErrorPage(onPressedReTry: onPressedReTry);
    }
    if (state.status.isLoaded()) {
      if (state.listService == null ||
          (state.listService?.items ?? []).isEmpty) {
        return Column(
          spacing: 20.h,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WErrorWidget(errorText: LocaleKeys.noServices.tr()),
            if (serviceCubit.filters.hasActiveFilters)
              AppButton(
                onPressed: () {
                  serviceCubit
                    ..resetFilter()
                    ..fetchServices();
                },
                text: LocaleKeys.clearFilter.tr(),
                color: AppColors.cFF9914,
              ),
          ],
        );
      }

      return WRefreshIndicator(
        onRefresh: onRefresh,
        child: LayoutBuilder(
          builder:
              (context, constraints) => ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: ListView.builder(
                  shrinkWrap: false,
                  controller: scrollController,
                  itemCount: state.listService?.items.length ?? 0,
                  scrollDirection: Axis.vertical,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  itemBuilder: (context, index) {
                    if (state.isLoadingMore &&
                        state.listService?.items.length == index + 1) {
                      return WLoadingLottie();
                    }

                    final service = state.listService?.items[index];
                    return ServiceItem(
                      onPressedFavorite: () {
                        serviceCubit.toggleServiceFavorite(index);
                      },
                      service: service!,
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
