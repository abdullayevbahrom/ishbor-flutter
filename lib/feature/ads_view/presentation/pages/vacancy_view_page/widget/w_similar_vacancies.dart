import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/helpers/formatters.dart';
import 'package:top_jobs/core/theme/app_colors.dart';
import 'package:top_jobs/core/theme/app_text_styles.dart';
import 'package:top_jobs/feature/ads_view/presentation/widgets/w_similar_ads_loading.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_similar_content_item.dart';

import '../../../../../../core/helpers/category_helpers.dart';
import '../../../../../../models/vacancy.dart';

class WSimilarVacancies extends StatelessWidget {
  final List<Vacancy>? vacancies;
  final bool isLoading;
  final bool isLoadingMore;

  const WSimilarVacancies({
    super.key,
    required this.vacancies,
    required this.isLoading,
    required this.isLoadingMore,
  });

  @override
  Widget build(BuildContext context) {
    final hasData = (vacancies ?? []).isNotEmpty;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasData)
          Text(
            LocaleKeys.similarVacancies.tr(),
            style: AppTextStyles.size22Medium.copyWith(
              color: AppColors.c2E3A59,
            ),
          ),
        16.verticalSpace,
        if (isLoading) WSimilarAdsLoading(),
        if (hasData)
          ListView.separated(
            shrinkWrap: true,
            itemCount: vacancies?.length ?? 0,
            scrollDirection: Axis.vertical,
            keyboardDismissBehavior:
            ScrollViewKeyboardDismissBehavior.onDrag,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => 8.verticalSpace,
            itemBuilder: (context, index) {
              final vacancy = vacancies![index];
              return InkWell(
                onTap: () {
                  context.push("/vacancy-view?id=${vacancy.id}");
                },
                borderRadius: BorderRadius.circular(18.r),
                child: WSimilarContentViewItem(
                  category: CategoryHelpers.categoryName(
                    vacancy.categories,
                    context,
                  ),
                  dateTime: Formatters.timeAgo(
                   vacancy.createdAt,
                  ),
                  title: Formatters.translateText(
                    uzText: vacancy.titleUz,
                    ruText: vacancy.titleRu,
                    defaultText: vacancy.title,
                  ),
                  salaryMin: vacancy.salaryMin,
                  salaryMax: vacancy.salaryMax,
                  imageUrl: (vacancy.images ?? []).isNotEmpty &&
                      vacancy.images?.first.urls != null
                      ? vacancy.images?.first.urls['original']
                      : null,
                  bgColor: AppColors.cF7F9FC,
                ),
              );
            },
          ),
        if (isLoadingMore) WSimilarAdsLoading(),
      ],
    ).paddingSymmetric(horizontal: 16.w);
  }
}
