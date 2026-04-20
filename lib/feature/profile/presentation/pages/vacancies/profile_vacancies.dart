import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/constants/time_delay_cons.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_layout.dart';
import 'package:top_jobs/feature/profile/presentation/cubits/my_vacancies_cubit/my_vacancies_cubit.dart';
import 'package:top_jobs/feature/profile/presentation/pages/vacancies/widget/my_vacancies.dart';
import 'package:top_jobs/feature/profile/presentation/pages/vacancies/widget/my_vacancy_applies.dart';

import '../../../../../injection_container.dart';
import '../../../../common/presentation/widget/app_header.dart';
import '../../../../common/presentation/widget/app_tab_bar.dart';

class ProfileVacancies extends StatefulWidget {
  const ProfileVacancies({super.key});

  @override
  State<ProfileVacancies> createState() => _ProfileVacanciesState();
}

class _ProfileVacanciesState extends State<ProfileVacancies> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              sl<MyVacanciesCubit>()
                ..fetchMyVcData()
                ..fetchMyFcVcData(),
      child: BlocBuilder<MyVacanciesCubit, MyVacanciesState>(
        builder: (context, state) {
          return WLayout(
            child: Scaffold(
              body: DefaultTabController(
                length: 2,
                animationDuration: TimeDelayCons.durationMill200,
                initialIndex: currentIndex,
                child: Column(
                  children: [
                    AppHeader(isPopAvailable: true),
                    AppTabBar(
                      onTap: (index) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                      titles: [
                        Text(LocaleKeys.myVacancies.tr()),
                        Text(
                          LocaleKeys.vacanciesWithMyRequest.tr(),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          MyVacancies(
                          ),
                          SimilarVacancies(
                            myVacanciesCubit: context.read<MyVacanciesCubit>(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
