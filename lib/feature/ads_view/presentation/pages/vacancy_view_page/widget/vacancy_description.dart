import 'package:flutter/material.dart';
import 'package:top_jobs/core/helpers/formatters.dart';
import 'package:top_jobs/export.dart';

import '../../../../../../models/vacancy.dart';

class WVacancyDescription extends StatelessWidget {
  const WVacancyDescription({super.key, required this.vacancy});

  final Vacancy? vacancy;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.r),
        color: AppColors.cFFFFFF,
        border: Border.all(color: AppColors.cE0E5EB, width: 1.r),
      ),
      child: Column(
        children: [
          Text(
            Formatters.translateText(
              uzText: vacancy?.descriptionUz?.replaceAll("**", ""),
              ruText: vacancy?.descriptionRu?.replaceAll("**", ""),
              defaultText: vacancy?.description?.replaceAll("**", ""),
            ),
            style: AppTextStyles.size17Regular,
          ),

          //TODO

          // Text(vacancy!.partialJobOpportunity.toString()),
          // Text(vacancy.jobModes.toString()),
          // Text(vacancy.whoCanRespond.toString()) ,
          // Text(vacancy.skills.toString())
        ],
      ).paddingAll(16.r),
    ).paddingSymmetric(horizontal: 16.w);
  }
}
