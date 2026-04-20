
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../cubits/cities_cubit/cities_cubit.dart';

class WCitiesMapFilter extends StatelessWidget {
  show(BuildContext context) {
    return showDialog(
      context: context,
      builder:
          (context) => this.paddingSymmetric(horizontal: 20.w, vertical: 140.h),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Material(
        color: AppColors.cFFFFFF,
        borderRadius: BorderRadius.circular(16.r),
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 10.h),
          itemCount:
          context.read<CitiesCubit>().state.listCities?.cities.length ?? 0,
          itemBuilder:
              (context, index) => InkWell(
            onTap: () {
              context.pop(
                context.read<CitiesCubit>().state.listCities?.cities[index],
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context
                      .read<CitiesCubit>()
                      .state
                      .listCities
                      ?.cities[index]
                      .name ??
                      '',
                  style: AppTextStyles.size18Medium,
                ),
                // AppCheckBox(value: true, onChanged: (value) {}),
              ],
            ).paddingSymmetric(horizontal: 16.w, vertical: 8.h),
          ),
        ),
      ),
    );
  }
}
