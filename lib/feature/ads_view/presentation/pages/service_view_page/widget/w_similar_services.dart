import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/theme/app_colors.dart';
import 'package:top_jobs/core/theme/app_text_styles.dart';
import 'package:top_jobs/feature/ads_view/presentation/cubits/service_view_cubit/service_view_cubit.dart';
import 'package:top_jobs/feature/ads_view/presentation/widgets/w_similar_ads_loading.dart';

import '../../../../../../core/helpers/category_helpers.dart';
import '../../../../../../core/helpers/formatters.dart';
import '../../../../../common/presentation/widget/w_similar_content_item.dart';

class WSimilarServices extends StatelessWidget {
  const WSimilarServices({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceViewCubit, ServiceViewState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (state.similarServiceSt.isLoaded() &&
                (state.listService?.items ?? []).isNotEmpty)
              Text(
                LocaleKeys.similarServices.tr(),
                style: AppTextStyles.size22Medium.copyWith(
                  color: AppColors.c2E3A59,
                ),
              ),
            if (state.similarServiceSt.isLoaded() &&
                (state.listService?.items ?? []).isNotEmpty)
              16.verticalSpace,
            if (state.similarServiceSt.isLoading()) WSimilarAdsLoading(),
            if (state.similarServiceSt.isLoaded())
              ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: state.listService?.items.length ?? 0,
                scrollDirection: Axis.vertical,
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => 8.verticalSpace,
                itemBuilder: (context, index) {
                  final service = state.listService?.items[index];
                  return InkWell(
                    onTap: () {
                      context.push("/service-view?id=${service.id}");
                    },
                    borderRadius: BorderRadius.circular(18.r),
                    child: WSimilarContentViewItem(
                      category: CategoryHelpers.categoryName(
                        service!.categories,
                        context,
                      ),
                      dateTime: Formatters.timeAgo(service.createdAt),
                      title: Formatters.translateText(
                        uzText: service.title,
                        ruText: service.titleRu,
                        defaultText: service.titleUz,
                      ),
                      salaryMin: service.price,
                      imageUrl:
                          (service.images ?? []).isNotEmpty &&
                                  service.images?.first.urls != null
                              ? service.images?.first.urls['original']
                              : null,
                      bgColor: AppColors.cF7F9FC,
                    ),
                  );
                },
              ),
            if (state.isLoadingMore) WSimilarAdsLoading(),
          ],
        ).paddingSymmetric(horizontal: 16.w);
      },
    );
  }
}
