import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_tab_bar.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_layout.dart';
import 'package:top_jobs/feature/profile/presentation/cubits/my_tasks_cubit/my_tasks_cubit.dart';
import 'package:top_jobs/feature/profile/presentation/pages/tasks/widget/my_tasks.dart';
import 'package:top_jobs/feature/profile/presentation/pages/tasks/widget/my_task_applies.dart';

import '../../../../../injection_container.dart';
import '../../../../common/presentation/widget/app_header.dart';

class ProfileTasks extends StatefulWidget {
  const ProfileTasks({super.key});

  @override
  State<ProfileTasks> createState() => _ProfileTasksState();
}

class _ProfileTasksState extends State<ProfileTasks> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              sl<MyTasksCubit>()
                ..fetchMyTsData()
                ..fetchMyFcTs(),
      child: BlocBuilder<MyTasksCubit, MyTasksState>(
        builder: (context, state) {
          return WLayout(
            child: Scaffold(
              body: DefaultTabController(
                length: 2,
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
                        Text(LocaleKeys.myTasks.tr()),
                        Text(LocaleKeys.tasksWithMyRequest.tr()),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(children: [MyTasks(), MyTaskApplies()]),
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
