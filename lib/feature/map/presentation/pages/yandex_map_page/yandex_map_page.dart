import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:top_jobs/core/helpers/debouncer.dart';
import 'package:top_jobs/core/helpers/string_helpers.dart';
import 'package:top_jobs/core/theme/app_svg.dart';
import 'package:top_jobs/export.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_button.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_text_form_field.dart';
import 'package:top_jobs/feature/map/presentation/cubits/suggestions_cubit/suggestions_cubit.dart';
import 'package:top_jobs/feature/map/presentation/cubits/yandex_map_cubit/yandex_map_cubit.dart';
import 'package:yandex_geocoder/yandex_geocoder.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../../../injection_container.dart';

class YandexMapPage extends StatelessWidget {
  const YandexMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<YandexMapCubit>(),
      child: BlocBuilder<YandexMapCubit, YandexMapState>(
        builder: (context, state) {
          return LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  YandexMap(
                    // focusRect: ScreenRect(
                    //   topLeft: ScreenPoint(
                    //     x: 20,
                    //     y: 356,
                    //   ),
                    //   bottomRight: ScreenPoint(
                    //     x: MediaQuery.sizeOf(context).width / 2 + 20,
                    //     y: 456,
                    //   ),
                    // ),
                    onMapCreated: (controller) async {
                      context.read<YandexMapCubit>().mapController = controller;
                      context.read<YandexMapCubit>().getUserCurrentLocation();
                    },
                    onCameraPositionChanged: (
                      cameraPosition,
                      reason,
                      finished,
                    ) {
                      sl<Debounce>().run(
                        () => context
                            .read<YandexMapCubit>()
                            .fetchAddressFromPosition(position: cameraPosition),
                      );
                    },
                    mapObjects: [
                      if (context.read<YandexMapCubit>().placeMarkMapObject !=
                          null)
                        context.read<YandexMapCubit>().placeMarkMapObject!,
                    ],
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      AppSvg.icLocationActive,
                    ).paddingOnly(bottom: 40.h),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            WMapDecoratedBox(
                              child: InkWell(
                                onTap: () {
                                  context.pop();
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.arrow_back_ios),
                                    Text(
                                      LocaleKeys.pop.tr(),
                                      style: AppTextStyles.size20Medium,
                                    ),
                                  ],
                                ).paddingSymmetric(horizontal: 5.w),
                              ),
                            ),
                            WMapDecoratedBox(
                              child: InkWell(
                                onTap:
                                    state.enableFindMe
                                        ? () {
                                          context
                                              .read<YandexMapCubit>()
                                              .moveToLocation();
                                        }
                                        : null,
                                child: Icon(
                                  state.enableFindMe
                                      ? CupertinoIcons.location_fill
                                      : CupertinoIcons.location_slash_fill,
                                  color:
                                      state.enableFindMe
                                          ? AppColors.c000000
                                          : AppColors.cE0E5EB,
                                  size: 30,
                                ),
                              ),
                            ),
                          ],
                        ).paddingSymmetric(horizontal: 20.w),
                        AppUtils.hSizedBox16,
                        Material(
                          color: AppColors.cFFFFFF,
                          borderRadius: BorderRadius.horizontal(
                            right: Radius.circular(30.r),
                            left: Radius.circular(30.r),
                          ),
                          child: SizedBox(
                            width: 100.sw,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: AppColors.cFFFFFF,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.c000000.withOpacity(.3),
                                    blurRadius: 20,
                                  ),
                                ],
                                borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(30.r),
                                  left: Radius.circular(30.r),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 30.h),
                                  Text(
                                    LocaleKeys.selectLocation.tr(),
                                    style: AppTextStyles.size28Bold,
                                  ),
                                  SizedBox(height: 20.h),
                                  InkWell(
                                    onTap: () async {
                                      final response =
                                          await WMapSearchListView().show(
                                            context,
                                          );

                                      if (response != null) {
                                        context.read<YandexMapCubit>().update(
                                          response,
                                        );
                                      }
                                    },
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: AppColors.cEBEEF3,
                                        borderRadius: BorderRadius.circular(
                                          20.r,
                                        ),
                                      ),
                                      child: Row(
                                        spacing: 13.w,
                                        children: [
                                          SvgPicture.asset(
                                            AppSvg.icLocationDefault,
                                            height: 28.h,
                                          ),
                                          Flexible(
                                            child: Text(
                                              state.response != null
                                                  ? StringHelpers.extractStreet(
                                                        "${(state.response as GeocodeResponse).response?.geoObjectCollection?.featureMember?[0].geoObject?.metaDataProperty?.geocoderMetaData?.text}",
                                                      ).isEmpty
                                                      ? state.addressName
                                                      : StringHelpers.extractStreet(
                                                        "${(state.response as GeocodeResponse).response?.geoObjectCollection?.featureMember?[0].geoObject?.metaDataProperty?.geocoderMetaData?.text}",
                                                      )
                                                  : state.addressName,
                                              maxLines: 10,
                                              style: AppTextStyles.size22Medium,
                                            ),
                                          ),
                                        ],
                                      ).paddingSymmetric(
                                        horizontal: 15.w,
                                        vertical: 15.h,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 30.h),
                                  SizedBox(
                                    height: 60.h,
                                    width: 100.sw,
                                    child: AppButton(
                                      onPressed:
                                          !state.isLoading
                                              ? () {
                                                context.pop(
                                                  state.response
                                                      as GeocodeResponse,
                                                );
                                              }
                                              : () {},
                                      isLoading: state.status.isLoading(),
                                      radius: 20.r,
                                      shadow: [
                                        BoxShadow(
                                          color: AppColors.c15CF74.withOpacity(
                                            .4,
                                          ),
                                          offset: Offset(0, 4),
                                          blurRadius: 15.r,
                                        ),
                                      ],
                                      textStyle: AppTextStyles.size20Medium
                                          .copyWith(color: AppColors.cFFFFFF),
                                      text: LocaleKeys.select.tr(),
                                      color: AppColors.c15CF74,
                                    ),
                                  ),
                                  SizedBox(height: 50.h),
                                ],
                              ).paddingSymmetric(horizontal: 20.w),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class WMapSearchListView extends StatelessWidget {
  const WMapSearchListView({super.key});

  show(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: AppColors.cTransparent,
      useSafeArea: true,
      context: context,
      builder: (context) {
        return this;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SuggestionsCubit>(),
      child: BlocBuilder<SuggestionsCubit, SuggestionsState>(
        builder: (context, state) {
          final cubit = context.read<SuggestionsCubit>();
          return DraggableScrollableSheet(
            initialChildSize: .95,
            maxChildSize: .95,
            minChildSize: .95,
            builder: (context, scrollController) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.cFFFFFF,
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(20.r),
                    right: Radius.circular(20.r),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppUtils.hSizedBox32,
                    AppTextFormField(
                      hintText: LocaleKeys.pleaseTypeToSearch.tr(),
                      controller: cubit.searchController,
                      suffixIcon: IconButton(
                        onPressed: () {
                          cubit.clearController();
                        },
                        icon: Icon(Icons.cancel, color: AppColors.cFF9914),
                      ),
                      onChanged: (value) {
                        sl<Debounce>().run(() {
                          cubit.fetchSuggestions();
                        });
                      },
                    ),
                    AppUtils.hSizedBox16,
                    Expanded(
                      child: Column(
                        children: [
                          Skeletonizer(
                            enabled: state.status.isLoading(),
                            child: ListView.builder(
                              itemCount: state.suggestions.length,
                              controller: scrollController,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: const AlwaysScrollableScrollPhysics(),
                              keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    context.pop(state.suggestions[index]);
                                  },
                                  splashColor: AppColors.cFF9914,
                                  child: Row(
                                    spacing: 10.w,
                                    children: [
                                      SvgPicture.asset(
                                        AppSvg.icLocationDefault,
                                        height: 24.r,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "${state.suggestions[index]}",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: AppTextStyles.size17Medium,
                                        ),
                                      ),
                                    ],
                                  ).paddingSymmetric(vertical: 8.h),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: AppButton(
                        width: 100.sw,
                        textStyle: AppTextStyles.size15Medium,
                        onPressed: () {
                          context.pop();
                        },
                        text: LocaleKeys.back.tr(),
                        color: AppColors.cEBEEF3,
                      ),
                    ).paddingOnly(top: 8.h),
                    AppUtils.hSizedBox24,
                  ],
                ).paddingSymmetric(horizontal: 20.w),
              );
            },
          );
        },
      ),
    );
  }
}

class WMapDecoratedBox extends StatelessWidget {
  const WMapDecoratedBox({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.cFFFFFF,
      borderRadius: BorderRadius.circular(40.r),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.cFFFFFF,
          borderRadius: BorderRadius.circular(40.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.c000000.withOpacity(.3),
              blurRadius: 20.r,
            ),
          ],
        ),
        child: child.paddingAll(12.r),
      ),
    );
  }
}


