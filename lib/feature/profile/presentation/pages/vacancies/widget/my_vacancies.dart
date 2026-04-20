import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart'
    show CupertinoAlertDialog, showCupertinoDialog;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/theme/app_colors.dart';
import 'package:top_jobs/core/theme/app_text_styles.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_loading.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_loading_item.dart';
import 'package:top_jobs/feature/profile/presentation/cubits/my_vacancies_cubit/my_vacancies_cubit.dart';

import '../../../../../common/presentation/widget/vacancy_item.dart';
import '../../../../../common/presentation/widget/w_error_widget.dart';
import '../../../../../common/presentation/widget/w_refresh_indicator.dart';

class MyVacancies extends StatefulWidget {
  const MyVacancies({super.key});

  @override
  State<MyVacancies> createState() => _MyVacanciesState();
}

class _MyVacanciesState extends State<MyVacancies> {
  static const double _scrollThreshold = 40;
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
      context.read<MyVacanciesCubit>().checkLoadMoreMyVacancies();
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
    return BlocBuilder<MyVacanciesCubit, MyVacanciesState>(
      builder: (context, state) {
        return buildBody(
          state: state,
          onRefresh: () async {
            context.read<MyVacanciesCubit>()..fetchMyVcData();
          },
        );
      },
    );
  }

  Widget buildBody({
    required MyVacanciesState state,
    required RefreshCallback onRefresh,
  }) {
    if (state.vacanciesSt.isLoading()) return WLoading();
    if (state.vacanciesSt.isError())
      return WErrorWidget(errorText: state.errorText);
    if (state.vacanciesSt.isLoaded())
      if (state.myVacancies?.items == null ||
          state.myVacancies?.items.length == 0)
        return WErrorWidget(errorText: LocaleKeys.noVacancies.tr());
    return WRefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        controller: _scrollController,
        itemCount:
            state.isLoadingMore1
                ? (state.myVacancies?.items.length ?? 0) + 1
                : state.myVacancies?.items.length ?? 0,
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 10.h),
        itemBuilder: (context, index) {
          if (state.isLoadingMore1 && index == state.myVacancies?.items.length)
            return WLoadingLottie();
          else {
            final vacancy = state.myVacancies?.items[index];
            return VacancyItem(
              onPressedFavorite: () {
                context.read<MyVacanciesCubit>().toggleVacancy(index);
              },
              isFilterAvailable: true,
              enableStatus: true,
              enableLiftUp: vacancy!.isNeedLiftUp,
              vacancy: vacancy,
              onTapDelete: () {
                WDeleteCupertinoDialog(
                  onPressedYes: () {
                    context.read<MyVacanciesCubit>().deleteVacancyById(
                      vacancy.id,
                      index,
                    );
                    context.pop();
                  },
                ).show(context);
              },
              onTapActivate: () {
                context.read<MyVacanciesCubit>().activateVacancyById(vacancy.id, index);
              },
              onTapDeactivate: () {
                context.read<MyVacanciesCubit>().deactivateVacancyById(
                  vacancy.id,
                  index,
                );
              },
              onTapLiftUp: () {
                context.read<MyVacanciesCubit>().liftUpVacancyById(vacancy.id);
              },
            );
          }
        },
      ),
    );
  }
}

class WDeleteCupertinoDialog extends StatelessWidget {
  const WDeleteCupertinoDialog({super.key, required this.onPressedYes});

  final VoidCallback onPressedYes;

  show(BuildContext context) {
    showCupertinoDialog(context: context, builder: (context) => this);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(
        LocaleKeys.attention.tr(),
        style: AppTextStyles.size20Bold.copyWith(color: AppColors.c2E3A59),
      ),
      content: Text(
        LocaleKeys.areSureToDelete.tr(),
        style: AppTextStyles.size15Medium,
      ).paddingOnly(top: 10.h),
      actions: [
        MaterialButton(
          onPressed: onPressedYes,
          child: Text(
            LocaleKeys.yes.tr(),
            style: AppTextStyles.size15Regular.copyWith(color: AppColors.cRed),
          ),
        ),
        MaterialButton(
          onPressed: () {
            context.pop();
          },
          child: Text(
            LocaleKeys.no.tr(),
            style: AppTextStyles.size15Regular.copyWith(
              color: AppColors.c13A5E3,
            ),
          ),
        ),
      ],
    );
  }
}
