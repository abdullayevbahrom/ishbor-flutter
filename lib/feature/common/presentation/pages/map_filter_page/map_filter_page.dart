import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_jobs/core/theme/app_png.dart';
import 'package:top_jobs/export.dart';
import 'package:top_jobs/feature/common/data/models/category.dart';
import 'package:top_jobs/feature/common/data/models/cities_list.dart';
import 'package:top_jobs/feature/common/data/models/map_filter_query.dart';
import 'package:top_jobs/feature/common/presentation/cubits/location_filter_cubit/location_filter_cubit.dart';
import 'package:top_jobs/feature/common/presentation/pages/map_filter_page/widget/w_categories_map_filter.dart';
import 'package:top_jobs/feature/common/presentation/pages/map_filter_page/widget/w_cities_map_filter.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_button.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_header.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_text_form_field.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_layout.dart';

import '../../../../../injection_container.dart';

class MapFilterPage extends StatefulWidget {
  const MapFilterPage({super.key, required this.type});

  final String type;

  @override
  State<MapFilterPage> createState() => _MapFilterPageState();
}

class _MapFilterPageState extends State<MapFilterPage> {
  final cityController = TextEditingController(text: "Tashkent");
  final categoryController = TextEditingController();
  City? city;
  List<CategoryModel> categories = [];
  double distance = 2.0;
  final cubit = sl<LocationFilterCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocBuilder<LocationFilterCubit, LocationFilterState>(
        bloc: cubit,
        builder: (context, state) {
          return WLayout(
            child: Scaffold(
              backgroundColor: AppColors.cFFFFFF,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppHeader(isPopAvailable: true),
                  Expanded(
                    child: Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppUtils.hSizedBox40,
                            Row(
                              spacing: 8.w,
                              children: [
                                Expanded(
                                  child: AppTextFormField(
                                    keyBoardType: TextInputType.none,
                                    hintText: LocaleKeys.chooseCity.tr(),
                                    controller: cityController,
                                    fillColor: AppColors.cFFFFFF,
                                    suffixIcon: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: AppColors.c888888,
                                    ),
                                    maxLines: 1,
                                    minLines: 1,
                                    onTap: () async {
                                      final response = await WCitiesMapFilter()
                                          .show(context);
                                      if (response != null) {
                                        setState(() {
                                          city = response;
                                          cityController.text =
                                              (response as City).name ?? "NO";
                                        });
                                      }
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: AppTextFormField(
                                    keyBoardType: TextInputType.none,
                                    hintText: LocaleKeys.chooseCategory.tr(),
                                    controller: categoryController,
                                    fillColor: AppColors.cFFFFFF,
                                    maxLines: 1,
                                    minLines: 1,
                                    suffixIcon: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: AppColors.c888888,
                                    ),
                                    onTap: () async {
                                      final response =
                                          await WCategoriesMapFilter(
                                            categories: categories,
                                          ).show(context);
                                      if (response != null) {
                                        setState(() {
                                          categories = response;
                                        });
                                        categoryController.text = (response
                                                as List<CategoryModel>)
                                            .map(
                                              (e) =>
                                                  e
                                                      .translations[context
                                                                  .locale
                                                                  .languageCode ==
                                                              'ru'
                                                          ? 0
                                                          : 1]
                                                      .name ??
                                                  '',
                                            )
                                            .join(',');
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            AppUtils.hSizedBox24,
                            Text(
                              '${LocaleKeys.showResultsFromADistance.tr()}: ${distance} ${LocaleKeys.km.tr()}',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: AppColors.c548bf4,
                                inactiveTrackColor: AppColors.cCCCCCC,
                                trackShape: RectangularSliderTrackShape(),
                                trackHeight: 6.0,
                                thumbColor: AppColors.cFF9914,
                                thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: 12.0,
                                ),
                                overlayColor: AppColors.cGrey,
                                overlayShape: RoundSliderOverlayShape(
                                  overlayRadius: 10,
                                ),
                                activeTickMarkColor: AppColors.cTransparent,
                                inactiveTickMarkColor: AppColors.cTransparent,
                              ),
                              child: Slider(
                                value: distance,
                                min: 0,
                                max: 30,
                                divisions: 30,
                                label: '$distance',
                                onChanged: (double value) {
                                  setState(() {
                                    distance = value;
                                  });
                                },
                              ),
                            ).paddingSymmetric(vertical: 5.h),
                            AppUtils.hSizedBox24,
                            AppButton(
                              onPressed: () {
                                if (widget.type == 'vacancy') {
                                  cubit.fetchVacanciesGeo(
                                    LocationFilterModel(
                                      lat: city?.coords.lat ?? 41.311081,
                                      lng: city?.coords.lng ?? 69.240562,
                                      distance: distance,
                                      categories:
                                          categories
                                              .map((category) => category.id)
                                              .toList(),
                                    ),
                                  );
                                }
                                if (widget.type == 'service') {
                                  cubit.fetchServiceGeo(
                                    LocationFilterModel(
                                      lat: city?.coords.lat ?? 41.311081,
                                      lng: city?.coords.lng ?? 69.240562,
                                      distance: distance,
                                      categories:
                                      categories
                                          .map((category) => category.id)
                                          .toList(),
                                    ),
                                  );
                                }if (widget.type == 'task') {
                                  cubit.fetchTaskGeo(
                                    LocationFilterModel(
                                      lat: city?.coords.lat ?? 41.311081,
                                      lng: city?.coords.lng ?? 69.240562,
                                      distance: distance,
                                      categories:
                                      categories
                                          .map((category) => category.id)
                                          .toList(),
                                    ),
                                  );
                                }
                              },
                              isLoading: state.status.isLoading(),
                              text: LocaleKeys.find.tr(),
                              color: AppColors.cFF9914,
                              textStyle: AppTextStyles.size17Medium.copyWith(
                                color: AppColors.cFFFFFF,
                              ),
                              verticalPadding: 16.h,
                              width: 100.sw,
                              radius: 0,
                            ),
                            AppUtils.hSizedBox24,
                            Image.asset(AppPng.map),
                          ],
                        ).paddingSymmetric(horizontal: 16.w),
                       const Spacer(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: AppColors.cFF9914,
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 32.h
                              ),
                              child: Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.r),
                                  child: Image.asset(
                                    AppPng.imgFooter,
                                    width: 80.r,
                                    height: 80.r,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
