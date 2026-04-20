import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/feature/common/presentation/widget/vacancy_item.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_error_widget.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_loading_item.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_refresh_indicator.dart';

import '../../../cubits/favorites_cubit/favorites_cubit.dart';

class WVacancyFavorites extends StatelessWidget {
  const WVacancyFavorites({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        return WRefreshIndicator(
          onRefresh: () async {
            await context.read<FavoritesCubit>().fetchVacancyFavorites();
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            scrollDirection: Axis.vertical,

            child: Column(
              children: [
                if (!state.vacancyStatus.isLoaded()) WLoading(),
                if (state.vacancyStatus.isLoaded())
                  if (state.listVacancy.isEmpty)
                    WErrorWidget(errorText: LocaleKeys.noVacancies.tr()),
                ListView.builder(
                  padding: EdgeInsets.only(bottom: 50.h),
                  itemCount: state.listVacancy.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return VacancyItem(
                      vacancy: state.listVacancy[index],
                      onPressedFavorite: () {
                        context.read<FavoritesCubit>().toggleVacancy(index);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
