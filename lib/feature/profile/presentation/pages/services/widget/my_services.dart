import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_error_widget.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_loading.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_loading_item.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_refresh_indicator.dart';
import 'package:top_jobs/feature/profile/presentation/cubits/my_services_cubit/my_services_cubit.dart';
import 'package:top_jobs/feature/profile/presentation/pages/vacancies/widget/my_vacancies.dart';

import '../../../../../common/presentation/widget/service_item.dart';

class MyServices extends StatefulWidget {
  const MyServices({super.key});

  @override
  State<MyServices> createState() => _MyServicesState();
}

class _MyServicesState extends State<MyServices> {
  static const double _scrollThreshold = 80;
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      context.read<MyServicesCubit>().checkLoadMoreMySv();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyServicesCubit, MyServicesState>(
      builder: (context, state) {
        return MyServicesBody(
          state: state,
          scrollController: _scrollController,
          onRefresh: () async {
            context.read<MyServicesCubit>().fetchMySvData();
          },
        );
      },
    );
  }
}

class MyServicesBody extends StatelessWidget {
  final MyServicesState state;
  final RefreshCallback onRefresh;
  final ScrollController scrollController;

  const MyServicesBody({
    super.key,
    required this.state,
    required this.onRefresh,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    if (state.myServicesSt.isLoading()) return WLoading();
    if (state.myServicesSt.isError())
      return WErrorWidget(errorText: state.errorText);
    if (state.myServicesSt.isLoaded())
      if (state.myServices == null || state.myServices?.items.length == 0)
        return WErrorWidget(errorText: LocaleKeys.noServices.tr());
    return WRefreshIndicator(
      onRefresh: onRefresh,
      child: LayoutBuilder(
        builder:
            (context, constraints) =>
            ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: ListView.builder(
                shrinkWrap: true,
                controller: scrollController,
                itemCount:
                state.isLadingMore1
                    ? (state.myServices?.items.length ?? 0) + 1
                    : state.myServices?.items.length ?? 0,
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.only(top: 10.h),
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  if (state.isLadingMore1 &&
                      state.myServices?.items.length == index)
                    return WLoadingLottie(); else {
                    final service = state.myServices?.items[index];
                    return ServiceItem(
                      onPressedFavorite: () {
                        context.read<MyServicesCubit>().toggleService(index);
                      },
                      enableLiftUp: (service?.isNeedLiftUp ?? false),
                      isPopButtonAvailable: true,
                      service: service!,
                      enableStatus: true,
                      onTapLiftUp: () {
                        context.read<MyServicesCubit>().liftUpServiceById(
                            index);
                      },
                      onTapDelete: () {
                        WDeleteCupertinoDialog(
                          onPressedYes: () {
                            context.read<MyServicesCubit>().deleteServiceById(
                              index,
                            );
                            context.pop();
                          },
                        ).show(context);
                      },
                      onTapActivate: () {
                        context.read<MyServicesCubit>().activateServiceById(
                            service.id, index);
                      },
                      onTapDeactivate: () {
                        context.read<MyServicesCubit>().deactivateServiceById(
                          service.id,
                          index,
                        );
                      },
                    );
                  }
                },
              ),
            ),
      ),
    );
  }
}
