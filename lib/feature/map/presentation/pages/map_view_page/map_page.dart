import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/extentions/color_extension.dart';
import 'package:top_jobs/core/helpers/category_helpers.dart';
import 'package:top_jobs/core/helpers/debouncer.dart';
import 'package:top_jobs/core/helpers/formatters.dart';
import 'package:top_jobs/core/router/route_names.dart';
import 'package:top_jobs/core/theme/app_colors.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_button.dart';
import 'package:top_jobs/feature/map/presentation/cubits/map_view_cubit/map_view_cubit.dart';
import 'package:top_jobs/feature/map/presentation/pages/map_view_page/widget/w_action_buttons.dart';
import 'package:top_jobs/feature/map/presentation/pages/map_view_page/widget/w_map_app_bar.dart';
import 'package:top_jobs/feature/map/presentation/pages/map_view_page/widget/w_transparent_circle_point.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../../../injection_container.dart';
import '../../../../common/presentation/widget/w_similar_content_item.dart';

class MapPage extends StatelessWidget {
  MapPage({super.key, required this.type});

  final String type;
  late ClusterizedPlacemarkCollection _collection;

  textButtonValue(String type, MapViewState state) {
    if (type == "vacancy") {
      if (state.listVacancy.isNotEmpty) {
        return LocaleKeys.showVacancies.tr(
          namedArgs: {"count": state.listVacancy.length.toString()},
        );
      } else {
        return LocaleKeys.noVacancies.tr();
      }
    }

    if (type == "service") {
      if (state.listService.isNotEmpty) {
        return LocaleKeys.showServices.tr(
          namedArgs: {"count": state.listService.length.toString()},
        );
      } else {
        return LocaleKeys.noServices.tr();
      }
    }

    if (type == "task") {
      if (state.listTask.isNotEmpty) {
        return LocaleKeys.showTasks.tr(
          namedArgs: {"count": state.listTask.length.toString()},
        );
      } else {
        return LocaleKeys.noTasks.tr();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MapViewCubit>(),
      child: BlocBuilder<MapViewCubit, MapViewState>(
        builder: (context, state) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(160.h),
              child: BlocProvider.value(
                value: context.read<MapViewCubit>(),
                child: WMapAppBar(type: type),
              ),
            ),
            body: Stack(
              children: [
                YandexMap(
                  onMapCreated: (controller) {
                    context.read<MapViewCubit>().mapController = controller;
                    context.read<MapViewCubit>().initializeUserLocation();
                  },
                  onCameraPositionChanged: (cameraPosition, reason, finished) {
                    if (finished) {
                      sl<Debounce>().run(
                        () => context.read<MapViewCubit>().fetchLocations(
                          type: type,
                          point: cameraPosition.target,
                        ),
                      );
                    }
                  },
                  mapObjects: [
                    if (context.read<MapViewCubit>().userPlaceMarkMapObject !=
                        null)
                      context.read<MapViewCubit>().userPlaceMarkMapObject!,
                    ...context.read<MapViewCubit>().placeMarkMapObjects,
                  ],
                ),
                IgnorePointer(
                  child: CustomPaint(
                    size: MediaQuery.of(context).size,
                    painter: TransparentCirclePainter(),
                  ),
                ),
                WActionButtons(
                  enableCurrentLoc: state.enableCurrentLoc,
                  onTapCurrentLoc: () {
                    context.read<MapViewCubit>().moveToCurrentLoc();
                  },
                  onTapAddBtn: () {
                    context.read<MapViewCubit>().increaseZoom();
                  },
                  onTapMinusBtn: () {
                    context.read<MapViewCubit>().decreaseZoom();
                  },
                ),
                Positioned(
                  bottom: 17.h,
                  left: 20.w,
                  right: 20.w,
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (state.selectedVacancies.isNotEmpty)
                          Material(
                            color: AppColors.cTransparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(18.r),
                              onTap: () {
                                context.push(
                                  "/vacancy-view?id=${state.selectedVacancies.first.id}",
                                );
                              },
                              focusColor: AppColors.cFFFFFF,
                              hoverColor: AppColors.cFFFFFF,

                              child: WSimilarContentViewItem(
                                bgColor: AppColors.cFFFFFF.newWithOpacity(.9),
                                category: CategoryHelpers.categoryName(
                                  state.selectedVacancies.first.categories,
                                  context,
                                ),
                                dateTime: Formatters.timeAgo(
                                  state.selectedVacancies.first.createdAt,
                                ),
                                imageUrl:
                                    (state.selectedVacancies.first.images ?? [])
                                                .isNotEmpty &&
                                            state
                                                .selectedVacancies
                                                .first
                                                .images!
                                                .first
                                                .urls
                                                .isNotEmpty
                                        ? state
                                            .selectedVacancies
                                            .first
                                            .images!
                                            .first
                                            .urls['original']
                                        : null,
                                salaryMin:
                                    state.selectedVacancies.first.salaryMin,
                                salaryMax:
                                    state.selectedVacancies.first.salaryMax,
                                title: state.selectedVacancies.first.title,
                              ),
                            ),
                          ),
                        if (state.selectedServices.isNotEmpty)
                          Material(
                            color: AppColors.cTransparent,
                            child: InkWell(
                              onTap: () {
                                context.push(
                                  "/service-view?id=${state.selectedServices.first.id}",
                                );
                              },
                              borderRadius: BorderRadius.circular(18.r),
                              child: WSimilarContentViewItem(
                                bgColor: AppColors.cFFFFFF.newWithOpacity(.9),
                                category: CategoryHelpers.categoryName(
                                  state.selectedServices.first.categories,
                                  context,
                                ),
                                dateTime: Formatters.timeAgo(
                                  state.selectedServices.first.createdAt,
                                ),
                                imageUrl:
                                    (state.selectedServices.first.images ?? [])
                                                .isNotEmpty &&
                                            state
                                                .selectedServices
                                                .first
                                                .images!
                                                .first
                                                .urls
                                                .isNotEmpty
                                        ? state
                                            .selectedServices
                                            .first
                                            .images!
                                            .first
                                            .urls['original']
                                        : null,
                                salaryMin: state.selectedServices.first.price,
                                title: state.selectedServices.first.title,
                              ),
                            ),
                          ),
                        if (state.selectedTasks.isNotEmpty)
                          Material(
                            color: AppColors.cTransparent,
                            child: InkWell(
                              onTap: () {
                                context.push(
                                  "/task-view?id=${state.selectedTasks.first.id}",
                                );
                              },
                              borderRadius: BorderRadius.circular(18.r),
                              child: WSimilarContentViewItem(
                                bgColor: AppColors.cFFFFFF.newWithOpacity(.9),
                                category: CategoryHelpers.categoryName(
                                  state.selectedTasks.first.categories,
                                  context,
                                ),
                                dateTime: Formatters.timeAgo(
                                  state.selectedTasks.first.createdAt,
                                ),
                                imageUrl:
                                    state.selectedTasks.first.images.isNotEmpty &&
                                            state
                                                .selectedTasks
                                                .first
                                                .images
                                                .first
                                                .urls
                                                .isNotEmpty
                                        ? state
                                            .selectedTasks
                                            .first
                                            .images
                                            .first
                                            .urls['original']
                                        : null,
                                salaryMin: state.selectedTasks.first.price,
                                title: state.selectedTasks.first.title,
                              ),
                            ),
                          ),
                        SizedBox(height: 12.h),
                        SizedBox(
                          height: 55.h,
                          child: AppButton(
                            width: 100.sw,
                            radius: 12.r,
                            isLoading: state.status.isLoading(),
                            onPressed: () {
                              if (state.listVacancy.isNotEmpty ||
                                  state.listService.isNotEmpty ||
                                  state.listTask.isNotEmpty) {
                                context.push(
                                  Routes.expandedView,
                                  extra: {
                                    "vacancy": state.listVacancy,
                                    "service": state.listService,
                                    "task": state.listTask,
                                  },
                                );
                              }
                            },
                            text: textButtonValue(type, state),
                            color: AppColors.c2E3A59,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
