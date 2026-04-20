import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:top_jobs/core/extentions/color_extension.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/theme/app_colors.dart';
import 'package:top_jobs/core/theme/app_text_styles.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_png.dart';
import '../../../../models/vacancy.dart';
import '../../../services/data/models/service.dart';
import '../../../tasks/data/models/task_model.dart';

class WAdsLocationView extends StatefulWidget {
  WAdsLocationView({
    super.key,

    this.vacancy,
    this.serviceModel,
    this.taskModel,
  });

  final Vacancy? vacancy;
  final ServiceModel? serviceModel;
  final TaskModel? taskModel;

  @override
  State<WAdsLocationView> createState() => _WAdsLocationViewState();
}

class _WAdsLocationViewState extends State<WAdsLocationView> {
  bool isActive = false;
  YandexMapController? _controller;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140.h,
      width: 100.sw,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: SizedBox(
              height: 150.h,
              width: 100.sw,
              child:
                  isActive
                      ? YandexMap(
                        onMapCreated: (controller) {
                          _controller = controller;
                          _controller?.moveCamera(
                            animation: MapAnimation(
                              type: MapAnimationType.linear,
                              duration: 1,
                            ),
                            CameraUpdate.newCameraPosition(
                              CameraPosition(
                                target:
                                    widget.vacancy != null
                                        ? Point(
                                          latitude:
                                              widget
                                                  .vacancy
                                                  ?.address
                                                  ?.latitude ??
                                              0,
                                          longitude:
                                              widget
                                                  .vacancy
                                                  ?.address
                                                  ?.longitude ??
                                              0,
                                        )
                                        : widget.serviceModel != null
                                        ? Point(
                                          latitude:
                                              widget
                                                  .serviceModel
                                                  ?.address
                                                  ?.latitude ??
                                              0,
                                          longitude:
                                              widget
                                                  .serviceModel
                                                  ?.address
                                                  ?.longitude ??
                                              0,
                                        )
                                        : Point(
                                          latitude:
                                              widget
                                                  .taskModel
                                                  ?.addresses
                                                  .first
                                                  .latitude ??
                                              0,
                                          longitude:
                                              widget
                                                  .taskModel
                                                  ?.addresses
                                                  .first
                                                  .longitude ??
                                              0,
                                        ),
                                zoom: 18,
                              ),
                            ),
                          );
                        },
                      )
                      : Image.asset(AppPng.imgLocationView, fit: BoxFit.cover),
            ),
          ),

          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Image.asset(AppPng.imgLocActive),
                20.verticalSpace,
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(8.r),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: SizedBox(
                      width: 100.sw,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: AppColors.cFFFFFF.newWithOpacity(.7),
                        ),
                        child: Center(
                          child: Text(
                            widget.vacancy != null
                                ? widget.vacancy?.address?.addressLine ?? ''
                                : widget.serviceModel != null
                                ? widget.serviceModel?.address?.addressLine ?? ""
                                : widget.taskModel?.addresses.first.addressLine ?? '',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.size12Medium.copyWith(
                              color: AppColors.c2E3A59,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ).paddingSymmetric(horizontal: 10,vertical: 6),
                      ),
                    ).paddingSymmetric(horizontal: 10.w),
                  ),
                ),
              ],
            ),
          ),

          Positioned.fill(
            child: InkWell(
              onTap: () {
                context
                    .push(
                      Routes.yandexMapView,
                      extra: {
                        if (widget.vacancy != null) "vacancy": widget.vacancy!,
                        if (widget.serviceModel != null)
                          "service": widget.serviceModel!,
                        if (widget.taskModel != null) "task": widget.taskModel!,
                      },
                    )
                    .then((value) {
                      setState(() {
                        isActive = true;
                      });
                    });
              },
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
        ],
      ),
    ).paddingSymmetric(horizontal: 16.w, vertical: 16.h);
  }
}
