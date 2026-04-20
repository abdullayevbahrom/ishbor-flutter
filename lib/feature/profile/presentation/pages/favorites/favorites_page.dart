import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_header.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_layout.dart';
import 'package:top_jobs/feature/profile/presentation/cubits/favorites_cubit/favorites_cubit.dart';
import 'package:top_jobs/feature/profile/presentation/pages/favorites/widgets/w_service_favorite.dart';
import 'package:top_jobs/feature/profile/presentation/pages/favorites/widgets/w_task_favorite.dart';
import 'package:top_jobs/feature/profile/presentation/pages/favorites/widgets/w_vacancy_favorite.dart';

import '../../../../../core/constants/locale_keys.g.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../injection_container.dart';
import '../../../../common/presentation/widget/app_tab_bar.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int currentIndex = 0;
  List<String> titles = [
    LocaleKeys.Vacancies.tr(),
    LocaleKeys.services.tr(),
    LocaleKeys.tasks.tr(),
  ];
  final cubit = sl<FavoritesCubit>();

  @override
  void initState() {
    cubit.fetchVacancyFavorites();
    cubit.fetchServiceFavorites();
    cubit.fetchTaskFavorites();

    _tabController = TabController(length: titles.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          return WLayout(
            child: Scaffold(
              body: Column(
                children: [
                  AppHeader(isPopAvailable: true),
                  AppTabBar(
                    tabController: _tabController,
                    onTap: (index) {
                      _tabController.animateTo(index);
                    },
                    titles: List.generate(titles.length, (index) {
                      return Text(titles[index]);
                    }),
                    indicatorColor: AppColors.c13A5E3,
                    selectedTextStyle: AppTextStyles.size17Medium,
                    unSelectedTextStyle: AppTextStyles.size17Medium.copyWith(
                      color: AppColors.cBDC0C6,
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        BlocProvider.value(
                          value: cubit,
                          child: WVacancyFavorites(),
                        ),
                        BlocProvider.value(
                          value: cubit,
                          child: WServiceFavorites(),
                        ),
                        BlocProvider.value(
                          value: cubit,
                          child: WTaskFavorites(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
