import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/feature/services/data/models/service.dart';
import 'package:top_jobs/feature/tasks/data/models/task_model.dart';

import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_png.dart';
import '../../../../models/vacancy.dart';

/// This widget used to service, task or vacancy view page to view of location
class WLocationView extends StatelessWidget {
  WLocationView({
    super.key,

    this.vacancy,
    this.serviceModel,
    this.taskModel,
  });

  final Vacancy? vacancy;
  final ServiceModel? serviceModel;
  final TaskModel? taskModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.h,
      width: 100.sw,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: SizedBox(
              height: 140.h,
              width: 100.sw,
              child: Image.asset(AppPng.map,fit: BoxFit.cover,),
            ),
          ),

          Positioned.fill(
            child: InkWell(
              onTap: () {
                context.push(
                  Routes.yandexMapView,
                  extra: {
                    if (vacancy != null) "vacancy": vacancy!,
                    if (serviceModel != null) "service": serviceModel!,
                    if (taskModel != null) "task": taskModel!,
                  },
                );
              },
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
        ],
      ),
    ).paddingSymmetric(horizontal: 16.w, vertical: 16.h);
  }
}
