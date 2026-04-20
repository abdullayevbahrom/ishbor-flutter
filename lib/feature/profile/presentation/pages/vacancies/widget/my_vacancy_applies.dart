import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_jobs/feature/common/presentation/widget/vacancy_item.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_refresh_indicator.dart';
import 'package:top_jobs/feature/profile/presentation/cubits/my_vacancies_cubit/my_vacancies_cubit.dart';

import '../../../../../../core/constants/locale_keys.g.dart';
import '../../../../../common/presentation/widget/w_error_widget.dart';
import '../../../../../common/presentation/widget/w_loading_item.dart';

class SimilarVacancies extends StatelessWidget {
  const SimilarVacancies({super.key, required this.myVacanciesCubit});

  final MyVacanciesCubit myVacanciesCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyVacanciesCubit, MyVacanciesState>(
      bloc: myVacanciesCubit,
      builder: (context, state) {
        return AppliedVacanciesBody(state: state, onRefresh: () async {});
      },
    );
  }
}

class AppliedVacanciesBody extends StatelessWidget {
  final MyVacanciesState state;
  final RefreshCallback onRefresh;

  const AppliedVacanciesBody({
    super.key,
    required this.state,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    if (state.vacanciesSt.isLoading()) return WLoading();
    if (state.vacanciesSt.isError())
      return WErrorWidget(errorText: state.errorText);
    if (state.vacanciesSt.isLoaded())
      if (state.myAppliedVacancies?.items == null ||
          state.myAppliedVacancies?.items.length == 0)
        return WErrorWidget(errorText: LocaleKeys.noVacancies.tr());
    return WRefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        itemCount: state.myAppliedVacancies?.items.length ?? 0,
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 10.h),
        itemBuilder: (context, index) {
          final vacancy = state.myAppliedVacancies?.items[index];
          return VacancyItem(
              onPressedFavorite: () {

              },
              isFilterAvailable: true, vacancy: vacancy!);
        },
      ),
    );
  }
}
