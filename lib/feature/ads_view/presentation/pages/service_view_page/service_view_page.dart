import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:top_jobs/core/helpers/formatters.dart';
import 'package:top_jobs/export.dart';
import 'package:top_jobs/feature/ads_view/presentation/cubits/service_view_cubit/service_view_cubit.dart';
import 'package:top_jobs/feature/ads_view/presentation/pages/service_view_page/widget/w_service_description.dart';
import 'package:top_jobs/feature/ads_view/presentation/pages/service_view_page/widget/w_similar_services.dart';
import 'package:top_jobs/feature/ads_view/presentation/widgets/w_ads_author_connect.dart';
import 'package:top_jobs/feature/ads_view/presentation/widgets/w_ads_author_pre_view.dart';
import 'package:top_jobs/feature/ads_view/presentation/widgets/w_ads_header_action.dart';
import 'package:top_jobs/feature/ads_view/presentation/widgets/w_ads_loading.dart';
import 'package:top_jobs/feature/ads_view/presentation/widgets/w_ads_location_view.dart';
import 'package:top_jobs/feature/ads_view/presentation/widgets/w_ads_title_view.dart';
import 'package:top_jobs/feature/auth/presentation/pages/login_page/login_page.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_banner.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_cached_network_image.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_header.dart';
import 'package:top_jobs/feature/common/presentation/widget/footer.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_layout.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_refresh_indicator.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_share_content_actions.dart';

import '../../../../../core/router/route_names.dart';
import '../../../../../injection_container.dart';
import '../../../../common/presentation/cubits/user_cubit/user_cubit.dart';

class WServiceViewPage extends StatefulWidget {
  WServiceViewPage({super.key, required this.serviceId});

  final int serviceId;

  @override
  State<WServiceViewPage> createState() => _WServiceViewPageState();
}

class _WServiceViewPageState extends State<WServiceViewPage> {
  final serviceViewCubit = sl<ServiceViewCubit>();
  late ScrollController _scrollController;
  static const _scrollThreshold = 800;

  @override
  void initState() {
    _scrollController =
        ScrollController()..addListener(() {
          final maxScroll = _scrollController.position.maxScrollExtent;
          final currentScroll = _scrollController.position.pixels;

          if (maxScroll - currentScroll < _scrollThreshold) {
            serviceViewCubit.checkLoadMoreData();
          }
        });
    serviceViewCubit.fetchData(widget.serviceId);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listenWhen: (previous, current) => previous.status != current.status,
      buildWhen: (previous, current) => previous.status != current.status,
      listener: (context, userState) {
        if (!userState.status.isLoaded()) {
          context.read<UserCubit>().checkUser();
        }
      },
      builder:
          (context, state) => BlocProvider.value(
            value: serviceViewCubit,
            child: BlocBuilder<ServiceViewCubit, ServiceViewState>(
              builder: (context, state) {
                return WLayout(
                  child: Scaffold(
                    backgroundColor: AppColors.cFFFFFF,
                    body: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppHeader(
                          isPopAvailable: true,
                          popUpMenu: WAdsHeaderAction(
                            onPressedReply: () {},
                            onPressedFavorite: () {
                              context.read<ServiceViewCubit>().toggleService();
                            },
                            isFavorite: state.service?.isFavorite ?? false,
                          ),
                        ),
                        Expanded(child: buildBody(state, context)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
    );
  }

  Widget buildBody(ServiceViewState state, BuildContext context) {
    if (state.status.isLoaded()) {
      final service = state.service;
      return Skeletonizer(
        enabled: !state.status.isLoaded(),
        child: WRefreshIndicator(
          onRefresh: () async {
            context.read<ServiceViewCubit>().fetchData(widget.serviceId);
          },
          child: ListView(
            padding: EdgeInsets.zero,
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: [
              WAdsViewTitle(
                title: Formatters.translateText(
                  uzText: service?.titleUz,
                  ruText: service?.titleRu,
                  defaultText: service?.title,
                ),
                createdAt: service?.createdAt ?? DateTime.now(),
                city: service?.city,
                categories: service?.categories,
                salary: Formatters.formatSalary(salaryMin: service?.price),
              ),
              26.verticalSpace,
              WServiceDescription(service: service),
              17.verticalSpace,
              if ((service?.images ?? []).isNotEmpty &&
                  service?.images?.first.urls != null)
                AppCachedNetworkImage(
                  height: 295.h,
                  radius: 16.r,
                  imageUrl: service?.images?.first.urls['original'],
                ).paddingSymmetric(horizontal: 16.w),
              if (context.read<UserCubit>().state.user != service?.customer)
                19.verticalSpace,
              if (context.read<UserCubit>().state.user != service?.customer)
                WAdsAuthorConnect(
                  phoneNumbers: [
                    service?.phoneNumber,
                    service?.phoneNumber1,
                    service?.phoneNumber2,
                    service?.phoneNumber3,
                  ],
                  customerId: service?.customer.id ?? 0,
                  serviceId: service?.id,
                ),
              22.verticalSpace,
              WShareAdsLink(
                link: "https://api.ishbor.uz/service-view?id=${service?.id}",
              ),
              WAdsAuthorPreView(
                onPressedAuthorAds: () {
                  if (context.read<UserCubit>().state.user ==
                      service?.customer) {
                    context.push(Routes.profileInfo);
                  } else {
                    context.push(
                      Routes.othersProfile,
                      extra: service?.customer,
                    );
                  }
                },
                name: service?.customer.fullName ?? '',
                city: service?.customer.city ?? 'Tashkent',
                countLike: "${service?.customer.likesCount ?? 0}",
                countDislike: "${service?.customer.dislikesCount ?? 0}",
                actionName: LocaleKeys.authorAllAds.tr(),
                isVerified: service?.customer.documentVerified,
                imageUrl: service?.customer.avatar?.urls['original'],
              ),
              WAdsLocationView(serviceModel: state.service),
              BlocProvider.value(
                value: serviceViewCubit,
                child: WSimilarServices(),
              ),
              14.verticalSpace,
              AppBanner(
                title: LocaleKeys.createService.tr(),
                onPressed: () {
                  if (context.read<UserCubit>().state.status.isLoaded()) {
                    context.push(Routes.createService);
                  } else {
                    LoginPage().show(context);
                  }
                },
              ),
              Footer(),
            ],
          ),
        ),
      );
    }
    return const WAdsViewLoading();
  }
}
