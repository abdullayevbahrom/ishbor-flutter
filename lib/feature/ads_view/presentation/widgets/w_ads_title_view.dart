import 'package:flutter/material.dart';
import 'package:top_jobs/core/helpers/category_helpers.dart';
import 'package:top_jobs/export.dart';
import 'package:top_jobs/feature/ads_view/presentation/widgets/w_ads_chipbox.dart';
import 'package:top_jobs/feature/common/data/models/category.dart';

import '../../../../core/helpers/formatters.dart';
import '../../../../models/vacancy.dart';
import '../../../common/presentation/widget/app_divider.dart';

class WAdsViewTitle extends StatelessWidget {
  const WAdsViewTitle({
    super.key,
    required this.title,
    required this.createdAt,
    required this.city,
    required this.salary,
    this.jobMode,
    this.isTemporary,
    this.withoutResume,
    this.categories,
    this.vacancy,
  });

  final String title;
  final DateTime createdAt;
  final String? city;
  final String salary;
  final String? jobMode;
  final bool? isTemporary;
  final String? withoutResume;
  final List<CategoryModel>? categories;
  final Vacancy? vacancy;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8.w,
          children: [
            Text(
              Formatters.timeAgo(createdAt),
              style: AppTextStyles.size16Regular.copyWith(
                color: AppColors.c888888,
              ),
            ),
            const AppDivider(),

            Text(
              city ?? '',
              style: AppTextStyles.size16Regular.copyWith(
                color: AppColors.c888888,
              ),
            ),
          ],
        ),
        10.verticalSpace,
        Text(
          title,
          style: AppTextStyles.size28Bold.copyWith(color: AppColors.c2E3A59),
        ),
        12.verticalSpace,
        if (vacancy != null)
          WAdsChipBox(
            employmentType: vacancy?.employmentType,
            withFullResume: vacancy?.whoCanRespond != null ? false : true,
            temporaryWork: vacancy?.partialJobOpportunity ?? false,
            category: CategoryHelpers.categoryName(categories ?? [], context),
          )
        else
          WAdsChipBox(
            category: CategoryHelpers.categoryName(categories ?? [], context),
          ),
        23.verticalSpace,
        Text(
          salary,
          style: AppTextStyles.size24Bold.copyWith(color: AppColors.cFF9914),
        ),
      ],
    ).paddingOnly(left: 24.w, top: 30.h, right: 24.w);
  }
}

class WChipButton extends StatelessWidget {
  const WChipButton({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.cF7F9FC,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Text(
        text,
        style: AppTextStyles.size14Medium,
      ).paddingSymmetric(vertical: 5.h, horizontal: 13.w),
    );
  }
}
