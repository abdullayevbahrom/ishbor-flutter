import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_tab_bar.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_layout.dart';
import 'package:top_jobs/feature/profile/presentation/cubits/my_services_cubit/my_services_cubit.dart';
import 'package:top_jobs/feature/profile/presentation/pages/services/widget/my_services.dart';
import 'package:top_jobs/feature/profile/presentation/pages/services/widget/my_service_applies.dart';

import '../../../../../injection_container.dart';
import '../../../../common/presentation/widget/app_header.dart';

class ProfileServices extends StatefulWidget {
  ProfileServices({super.key});

  @override
  State<ProfileServices> createState() => _ProfileServicesState();
}

class _ProfileServicesState extends State<ProfileServices> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              sl<MyServicesCubit>()
                ..fetchMySvData()
                ..fetchMyFvSvData(),
      child: WLayout(
        child: Scaffold(
          body: DefaultTabController(
            length: 2,
            initialIndex: 0,
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
                    Text(LocaleKeys.myServices.tr()),
                    Text(LocaleKeys.servicesWithMyRequest.tr()),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [MyServices(), MyServiceApplies()],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
