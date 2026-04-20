import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/helpers/formatters.dart';
import 'package:top_jobs/core/theme/app_colors.dart';
import 'package:top_jobs/feature/ads_view/presentation/cubits/vacancy_view_cubit/vacancy_view_cubit.dart';
import 'package:top_jobs/feature/ads_view/presentation/pages/vacancy_view_page/widget/vacancy_description.dart';
import 'package:top_jobs/feature/ads_view/presentation/pages/vacancy_view_page/widget/w_similar_vacancies.dart';
import 'package:top_jobs/feature/ads_view/presentation/widgets/w_ads_author_pre_view.dart';
import 'package:top_jobs/feature/ads_view/presentation/widgets/w_ads_loading.dart';
import 'package:top_jobs/feature/ads_view/presentation/widgets/w_ads_location_view.dart';
import 'package:top_jobs/feature/common/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_banner.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_header.dart';
import 'package:top_jobs/feature/common/presentation/widget/footer.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_layout.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_refresh_indicator.dart';

import '../../../../../core/constants/locale_keys.g.dart';
import '../../../../../core/router/route_names.dart';
import '../../../../common/presentation/widget/app_cached_network_image.dart';
import '../../../../common/presentation/widget/w_share_content_actions.dart';
import '../../widgets/w_ads_author_connect.dart';
import '../../widgets/w_ads_header_action.dart';
import '../../widgets/w_ads_title_view.dart';

class WVacancyViewPage extends StatefulWidget {
  WVacancyViewPage({super.key, required this.vacancyId});

  final int vacancyId;

  @override
  State<WVacancyViewPage> createState() => _WVacancyViewPageState();
}

class _WVacancyViewPageState extends State<WVacancyViewPage> {
  late ScrollController _scrollController;
  static const _scrollThreshold = 800;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    super.initState();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll < _scrollThreshold) {
      context.read<VacancyViewCubit>().checkLoadMoreData();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
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

      builder: (context, state) {
        return BlocBuilder<VacancyViewCubit, VacancyViewState>(
          builder: (context, state) {
            return WLayout(
              child: Scaffold(
                backgroundColor: AppColors.cFFFFFF,
                body: Column(
                  children: [
                    AppHeader(
                      isPopAvailable: true,
                      popUpMenu: WAdsHeaderAction(
                        onPressedFavorite: () {
                          context.read<VacancyViewCubit>().toggleFavorite();
                        },
                        onPressedReply: () {},
                        isFavorite: state.vacancy?.isFavorite ?? false,
                      ),
                    ),
                    buildBody(state, context),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildBody(VacancyViewState state, BuildContext context) {
    if (state.status.isLoaded()) {
      final vacancy = state.vacancy;
      return Expanded(
        child: WRefreshIndicator(
          onRefresh: () async {
            context.read<VacancyViewCubit>().fetchData(widget.vacancyId);
          },
          child: ListView(
            shrinkWrap: true,
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.zero,
            children: [
              WAdsViewTitle(
                vacancy: vacancy,
                title: Formatters.translateText(
                  uzText: vacancy?.title,
                  ruText: vacancy?.titleUz,
                  defaultText: vacancy?.title,
                ),
                createdAt: vacancy?.createdAt ?? DateTime.now(),
                categories: vacancy?.categories,
                city: vacancy?.city ?? '-',
                salary: Formatters.formatSalary(
                  salaryMax: vacancy?.salaryMax,
                  salaryMin: vacancy?.salaryMin,
                ),
              ),

              26.verticalSpace,
              WVacancyDescription(vacancy: vacancy),
              17.verticalSpace,
              if ((vacancy?.images ?? []).isNotEmpty &&
                  vacancy?.images?.first.urls != null)
                AppCachedNetworkImage(
                  height: 295.h,
                  radius: 16.r,

                  imageUrl: vacancy?.images?.first.urls['original'],
                ).paddingSymmetric(horizontal: 16.w),
              if (context.read<UserCubit>().state.user != vacancy?.customer)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    18.verticalSpace,

                    if (context.read<UserCubit>().state.user !=
                        vacancy?.customer)
                      WAdsAuthorConnect(
                        customerId: vacancy?.customer.id ?? 0,
                        vacancyId: vacancy?.id,
                        phoneNumbers: [
                          vacancy?.phoneNumber,
                          vacancy?.phoneNumber1,
                          vacancy?.phoneNumber2,
                          vacancy?.phoneNumber3,
                        ],
                      ),
                  ],
                ),
              18.verticalSpace,
              WShareAdsLink(
                link: "https://api.ishbor.uz/vacancy-view?id=${vacancy?.id}",
              ),
              17.verticalSpace,
              WAdsAuthorPreView(
                onPressedAuthorAds: () {
                  if (context.read<UserCubit>().state.user !=
                      vacancy?.customer) {
                    context.push(
                      Routes.othersProfile,
                      extra: vacancy?.customer,
                    );
                  } else {
                    context.push(Routes.profileInfo);
                  }
                },
                name: vacancy?.customer.fullName ?? '',
                city: vacancy?.customer.city ?? '',
                countLike: "${vacancy?.customer.likesCount ?? 0}",
                countDislike: "${vacancy?.customer.dislikesCount ?? 0}",
                actionName: LocaleKeys.authorAllAds.tr(),
                isVerified: vacancy?.customer.documentVerified,
                imageUrl: vacancy?.customer.avatar?.urls['original'],
              ),
              if (vacancy?.address?.longitude != null &&
                  vacancy?.address?.latitude != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    15.verticalSpace,
                    WAdsLocationView(vacancy: vacancy),
                  ],
                ),
              Builder(
                builder: (context) {
                  final vacancies = context.select(
                    (VacancyViewCubit cubit) =>
                        cubit.state.listSimilarVacancy?.items,
                  );
                  final isLoading = context.select(
                    (VacancyViewCubit cubit) =>
                        cubit.state.similarVacanciesSt.isLoading(),
                  );
                  final isLoadingMore = context.select(
                    (VacancyViewCubit cubit) => cubit.state.isLoadingMore,
                  );

                  return WSimilarVacancies(
                    vacancies: vacancies,
                    isLoading: isLoading,
                    isLoadingMore: isLoadingMore,
                  );
                },
              ),

              14.verticalSpace,
              AppBanner(
                onPressed: () {
                  context.push(Routes.createVacancy);
                },
                title: LocaleKeys.createVacancy.tr(),
              ),
              Footer(),
            ],
          ),
        ),
      );
    }
    return const Expanded(child: WAdsViewLoading());
  }
}
