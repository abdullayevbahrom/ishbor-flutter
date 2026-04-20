import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/theme/app_colors.dart';
import 'package:top_jobs/core/theme/app_png.dart';
import 'package:top_jobs/core/theme/app_text_styles.dart';
import 'package:top_jobs/feature/services/data/models/service.dart';
import 'package:top_jobs/feature/tasks/data/models/task_model.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import '../../../../../core/constants/locale_keys.g.dart';
import '../../../../../core/router/app_routes.dart';
import '../../../../../models/vacancy.dart';

class YandexMapViewPage extends StatefulWidget {
  YandexMapViewPage({super.key, required this.locations});

  final Map<String, dynamic> locations;

  @override
  State<YandexMapViewPage> createState() => _YandexMapViewPageState();
}

class _YandexMapViewPageState extends State<YandexMapViewPage> {
  YandexMapController? _mapController;
  PlacemarkMapObject? _placeMarkMapObject;
  PlacemarkMapObject? _userPlaceMarkMapObject;
  Point? userLocation;

  @override
  void initState() {
    super.initState();
  }

  Future<void> initializeUserLocation() async {
    final locStatus = await Permission.location.status;
    if (locStatus.isDenied) {
      final newPerStatus = await Permission.location.request();
      if (newPerStatus.isGranted) {
        await fetchUserLocation();
        addCurrentLocationPlaceMark();
        moveToCurrentLoc();
      }
    }

    if (locStatus.isGranted) {
      final userPoint = await fetchUserLocation();
      addCurrentLocationPlaceMark();
      moveToCurrentLoc();
    }

    if (locStatus.isPermanentlyDenied) {
      showCupertinoDialog(
        context: navigatorKey.currentContext!,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(LocaleKeys.permissionDenied.tr()),
            content: Text(LocaleKeys.goSettings.tr()),
            actions: [
              TextButton(
                onPressed: () {
                  navigatorKey.currentContext?.pop();
                },
                child: Text(LocaleKeys.cancel.tr()),
              ),
              TextButton(
                onPressed: () async {
                  await openAppSettings();
                },
                child: Text(LocaleKeys.next.tr()),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> moveToCurrentLoc() async {
    _mapController?.moveCamera(
      animation: MapAnimation(duration: 1, type: MapAnimationType.smooth),
      CameraUpdate.newCameraPosition(
        CameraPosition(target: userLocation!, zoom: 13),
      ),
    );
  }

  Future<void> fetchUserLocation() async {
    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );

    setState(() {
      userLocation = Point(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    });
  }

  initializeTitle(String locale) {
    if (widget.locations['vacancy'] != null) {
      final vacancy = (widget.locations['vacancy'] as Vacancy);
      return locale == 'ru'
          ? vacancy.titleRu ?? vacancy.title
          : vacancy.titleUz ?? vacancy.title;
    }

    if (widget.locations['service'] != null) {
      final service = (widget.locations['service'] as ServiceModel);
      return locale == 'ru'
          ? service.titleRu ?? service.title
          : service.titleUz ?? service.title;
    }

    if (widget.locations['task'] != null) {
      final task = (widget.locations['task'] as TaskModel);
      return locale == 'ru'
          ? task.titleRu ?? task.title
          : task.titleUz ?? task.title;
    }
  }

  void addCurrentLocationPlaceMark() {
    _userPlaceMarkMapObject = PlacemarkMapObject(
      opacity: 1,
      isVisible: true,
      icon: PlacemarkIcon.single(
        PlacemarkIconStyle(
          image: BitmapDescriptor.fromAssetImage(AppPng.imgCurrentLoc),
          scale: 0.3,
        ),
      ),
      mapId: MapObjectId("user_point"),
      point: userLocation!,
    );
  }

  initializeAddress() {
    if (widget.locations['vacancy'] != null) {
      final vacancy = (widget.locations['vacancy'] as Vacancy);
      return vacancy.address?.addressLine ?? '';
    }

    if (widget.locations['service'] != null) {
      final service = (widget.locations['service'] as ServiceModel);
      return service.address?.addressLine ?? '';
    }

    if (widget.locations['task'] != null) {
      final task = (widget.locations['task'] as TaskModel);
      return task.addresses.first.addressLine ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.locale.languageCode;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(140.h),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.cFFFFFF,
            boxShadow: [
              BoxShadow(
                color: AppColors.c000000.withOpacity(.1),
                blurRadius: 10.r,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: AppColors.cFFFFFF,
            leading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: Icon(CupertinoIcons.arrow_left, color: AppColors.c333333),
            ),
            title: Text(
              initializeTitle(locale),
              style: AppTextStyles.size20Bold.copyWith(
                color: AppColors.c2E3A59,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(80.h),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      initializeAddress(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.size17Medium,
                    ),
                  ),

                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      CupertinoIcons.location_solid,
                      size: 33.r,
                      color: AppColors.c2E3A59,
                    ),
                  ),
                ],
              ).paddingOnly(bottom: 15.h, left: 20.w, right: 20.w),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          YandexMap(
            onMapCreated: (controller) {
              _mapController = controller;
              if (widget.locations['vacancy'] != null) {
                final vacancy = widget.locations['vacancy'] as Vacancy;
                _mapController?.moveCamera(
                  animation: MapAnimation(
                    duration: 1,
                    type: MapAnimationType.smooth,
                  ),
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: Point(
                        latitude: vacancy.address?.latitude ?? 41.311081,
                        longitude: vacancy.address?.longitude ?? 69.240562,
                      ),
                    ),
                  ),
                );

                _placeMarkMapObject = PlacemarkMapObject(
                  mapId: MapObjectId("vacancy"),
                  isVisible: true,
                  opacity: 1,
                  icon: PlacemarkIcon.single(
                    PlacemarkIconStyle(
                      image: BitmapDescriptor.fromAssetImage(
                        AppPng.imgLocActive,
                      ),
                      scale: 2,
                    ),
                  ),
                  point: Point(
                    latitude: vacancy.address?.latitude ?? 41.311081,
                    longitude: vacancy.address?.longitude ?? 69.240562,
                  ),
                );
              }

              if (widget.locations['service'] != null) {
                final service = widget.locations['service'] as ServiceModel;
                _mapController?.moveCamera(
                  animation: MapAnimation(
                    duration: 1,
                    type: MapAnimationType.smooth,
                  ),
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: Point(
                        latitude: service.address?.latitude ?? 41.311081,
                        longitude: service.address?.longitude ?? 69.240562,
                      ),
                    ),
                  ),
                );

                _placeMarkMapObject = PlacemarkMapObject(
                  mapId: MapObjectId("service"),
                  opacity: 1,
                  isVisible: true,
                  icon: PlacemarkIcon.single(
                    PlacemarkIconStyle(
                      image: BitmapDescriptor.fromAssetImage(
                        AppPng.imgLocActive,
                      ),
                      scale: 2,
                    ),
                  ),
                  point: Point(
                    latitude: service.address?.latitude ?? 41.311081,
                    longitude: service.address?.longitude ?? 69.240562,
                  ),
                );
              }

              if (widget.locations['task'] != null) {
                final task = widget.locations['task'] as TaskModel;
                _mapController?.moveCamera(
                  animation: MapAnimation(
                    duration: 1,
                    type: MapAnimationType.smooth,
                  ),
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: Point(
                        latitude: task.addresses.first.latitude ?? 41.311081,
                        longitude: task.addresses.first.longitude ?? 69.240562,
                      ),
                    ),
                  ),
                );
                _placeMarkMapObject = PlacemarkMapObject(
                  opacity: 1,
                  isVisible: true,
                  mapId: MapObjectId("task"),
                  icon: PlacemarkIcon.single(
                    PlacemarkIconStyle(
                      image: BitmapDescriptor.fromAssetImage(
                        AppPng.imgLocActive,
                      ),
                      scale: 2,
                    ),
                  ),
                  point: Point(
                    latitude: task.addresses.first.latitude ?? 41.311081,
                    longitude: task.addresses.first.longitude ?? 69.240562,
                  ),
                );
              }
              setState(() {});
            },
            mapObjects: [if (_placeMarkMapObject != null) _placeMarkMapObject!],
          ),
          Positioned(
            right: 15.w,
            bottom: 150.h,
            child: MaterialButton(
              onPressed: () async {
                await initializeUserLocation();
              },
              height: 70.h,
              minWidth: 70.h,
              color: AppColors.cFFFFFF,
              child: Icon(CupertinoIcons.location, size: 30),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.r),
                side: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
