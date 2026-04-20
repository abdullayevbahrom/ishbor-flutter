import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_header.dart';
import 'package:top_jobs/feature/common/presentation/widget/service_item.dart';
import 'package:top_jobs/feature/common/presentation/widget/task_item.dart';
import 'package:top_jobs/feature/common/presentation/widget/vacancy_item.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_layout.dart';
import 'package:top_jobs/feature/services/data/models/service.dart';
import 'package:top_jobs/models/vacancy.dart';


class WExpandedViewPage extends StatelessWidget {
  const WExpandedViewPage({super.key, required this.list});

  final Map<String, dynamic> list;

  @override
  Widget build(BuildContext context) {
    return WLayout(
      child: Scaffold(
        body: Column(
          children: [
            AppHeader(isPopAvailable: true),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),

                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.only(top: 10.h),
                      child: Column(
                        children: [
                          if (list['vacancy'] != null)
                            ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: (list['vacancy'] as List).length,
                              scrollDirection: Axis.vertical,
                              keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder:
                                  (context, index) => VacancyItem(
                                    onPressedFavorite: () {},

                                    vacancy: list['vacancy'][index] as Vacancy,
                                  ),
                            ),
                          if (list['service'] != null)
                            ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: (list['service'] as List).length,
                              scrollDirection: Axis.vertical,
                              keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder:
                                  (context, index) => ServiceItem(
                                    onPressedFavorite: () {},
                                    service:
                                        list['service'][index] as ServiceModel,
                                  ),
                            ),
                          if (list['task'] != null)
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: (list['task'] as List).length,
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.vertical,
                              keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder:
                                  (context, index) => TaskItem(
                                    onPressedFavorite: () {},
                                    task: list['task'][index],
                                  ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
