import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:top_jobs/core/helpers/enum_helpers.dart';
import 'package:top_jobs/core/theme/app_png.dart';
import 'package:top_jobs/feature/common/data/models/map_filter_query.dart';
import 'package:top_jobs/feature/services/data/models/service.dart';
import 'package:top_jobs/feature/services/domain/repository/service_repository.dart';
import 'package:top_jobs/feature/tasks/data/models/task_model.dart';
import 'package:top_jobs/feature/tasks/domain/repository/task_repository.dart';
import 'package:top_jobs/feature/vacancies/domain/repository/vacancy_repository.dart';
import 'package:top_jobs/models/vacancy.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../../../core/constants/locale_keys.g.dart';
import '../../../../../core/router/app_routes.dart';
import '../../../../common/data/models/category.dart';

part 'map_view_state.dart';

part 'map_view_cubit.freezed.dart';

class MapViewCubit extends Cubit<MapViewState> {
  MapViewCubit(
    this._vacancyRepository,
    this._serviceRepository,
    this._taskRepository,
  ) : super(MapViewState());
  final VacancyRepository _vacancyRepository;
  final ServiceRepository _serviceRepository;
  final TaskRepository _taskRepository;
  YandexMapController? mapController;
  PlacemarkMapObject? userPlaceMarkMapObject;
  List<MapObject> placeMarkMapObjects = [];
  ClusterizedPlacemarkCollection? _collection;

  void updateMapObject(ClusterizedPlacemarkCollection collection) {
    placeMarkMapObjects.add(collection);
  }

  void emptyCategory() {
    emit(state.copyWith(categories: []));
  }

  void addCategories(List<CategoryModel> category) {
    if (category.isEmpty) {
      emit(state.copyWith(categories: []));
    } else {
      final newList = [...category];
      emit(state.copyWith(categories: newList));
    }
    fetchLocations(point: state.point!, type: state.type!);
  }

  Future<void> initializeUserLocation() async {
    final locStatus = await Permission.location.status;
    moveToCurrentLoc();
    if (locStatus.isDenied) {
      final newPerStatus = await Permission.location.request();
      if (newPerStatus.isGranted) {
        final userPoint = await fetchUserLocation();
        emit(state.copyWith(userPoint: userPoint, enableCurrentLoc: true));
        addCurrentLocationPlaceMark();
        moveToCurrentLoc();
      }
    }

    if (locStatus.isGranted) {
      final userPoint = await fetchUserLocation();
      emit(state.copyWith(userPoint: userPoint, enableCurrentLoc: true));
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

  Future<void> fetchLocations({
    required Point point,
    required String type,
  }) async {
    emit(
      state.copyWith(status: RequestStatus.loading, point: point, type: type),
    );
    final distance = await calculateDistance(point);
    if (type == "vacancy") {
      final response = await _vacancyRepository.fetchVacanciesGeo(
        queryParams: LocationFilterModel(
          lat: state.point!.latitude,
          lng: state.point!.longitude,
          distance: distance,
          categories:
              state.categories.map((e) {
                return e.id;
              }).toList(),
        ),
      );
      response.fold(
        (l) {
          emit(state.copyWith(status: RequestStatus.error));
        },
        (r) {
          emit(state.copyWith(status: RequestStatus.loaded, listVacancy: r));
          addVacancyMarkers();
        },
      );
    }

    if (type == 'service') {
      final response = await _serviceRepository.fetchServiceGeo(
        query: LocationFilterModel(
          lat: state.point!.latitude,
          lng: state.point!.longitude,
          distance: distance,
          categories:
              state.categories.map((e) {
                return e.id;
              }).toList(),
        ),
      );

      response.fold(
        (l) {
          emit(state.copyWith(status: RequestStatus.error));
        },
        (r) {
          emit(state.copyWith(status: RequestStatus.loaded, listService: r));
          addServiceMarkers();
        },
      );
    }
    if (type == 'task') {
      final response = await _taskRepository.fetchTaskGeo(
        query: LocationFilterModel(
          lat: state.point!.latitude,
          lng: state.point!.longitude,
          distance: distance,
          categories:
              state.categories.map((e) {
                return e.id;
              }).toList(),
        ),
      );

      response.fold(
        (l) {
          emit(state.copyWith(status: RequestStatus.error));
        },
        (r) {
          emit(state.copyWith(status: RequestStatus.loaded, listTask: r));
          addTaskMarkers();
        },
      );
    }
  }

  Future<void> increaseZoom() async {
    final cameraPosition = await mapController?.getCameraPosition();
    final newPosition = CameraPosition(
      target: cameraPosition!.target,
      zoom: cameraPosition.zoom + 1,
      azimuth: cameraPosition.azimuth,
      tilt: cameraPosition.tilt,
    );

    mapController?.moveCamera(
      animation: MapAnimation(type: MapAnimationType.smooth, duration: .3),
      CameraUpdate.newCameraPosition(newPosition),
    );
  }

  Future<void> decreaseZoom() async {
    final cameraPosition = await mapController?.getCameraPosition();
    final newPosition = CameraPosition(
      target: cameraPosition!.target,
      zoom: cameraPosition.zoom - 1,
      azimuth: cameraPosition.azimuth,
      tilt: cameraPosition.tilt,
    );

    mapController?.moveCamera(
      animation: MapAnimation(type: MapAnimationType.smooth, duration: .3),
      CameraUpdate.newCameraPosition(newPosition),
    );
  }

  Future<Point> fetchUserLocation() async {
    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );

    return Point(latitude: position.latitude, longitude: position.longitude);
  }

  Future<double> calculateDistance(Point point) async {
    final position = await mapController?.getCameraPosition();
    double metersPerPixel =
        156543.03392 * cos(point.latitude * pi / 180) / pow(2, position!.zoom);
    double distanceInMeters = 200.r * metersPerPixel;
    return distanceInMeters / 1000;
  }

  Future<void> moveToCurrentLoc() async {
    mapController?.moveCamera(
      animation: MapAnimation(duration: 1, type: MapAnimationType.smooth),
      CameraUpdate.newCameraPosition(
        CameraPosition(target: state.userPoint, zoom: 13),
      ),
    );
  }

  void addCurrentLocationPlaceMark() {
    userPlaceMarkMapObject = PlacemarkMapObject(
      mapId: MapObjectId("user_loc"),
      point: state.userPoint,
      opacity: 1,
      icon: PlacemarkIcon.single(
        PlacemarkIconStyle(
          image: BitmapDescriptor.fromAssetImage(AppPng.imgCurrentLoc),
          scale: 0.3,
        ),
      ),
    );
  }

  addVacancyMarkers() {
    if (state.listVacancy.isNotEmpty) {
      _collection = ClusterizedPlacemarkCollection(
        mapId: MapObjectId("collection_vacancy"),

        placemarks:
            state.listVacancy.map((e) {
              return PlacemarkMapObject(
                mapId: MapObjectId(
                  "placeMark${e.address?.longitude}${e.address?.latitude}",
                ),
                onTap: (mapObject, point) {
                  final newMapObjects = mapObject.mapId;
                  final newVacancyList = [e];
                  mapController?.moveCamera(
                    animation: MapAnimation(
                      type: MapAnimationType.smooth,
                      duration: 1,
                    ),
                    CameraUpdate.newCameraPosition(
                      CameraPosition(target: point),
                    ),
                  );
                  emit(
                    state.copyWith(
                      selectedMapObjects: newMapObjects,
                      selectedVacancies: newVacancyList,
                    ),
                  );
                  addVacancyMarkers();
                },
                opacity: 1,
                icon: PlacemarkIcon.single(
                  PlacemarkIconStyle(
                    scale: 2,
                    image: BitmapDescriptor.fromAssetImage(
                      state.selectedMapObjects ==
                              MapObjectId(
                                "placeMark${e.address?.longitude}${e.address?.latitude}",
                              )
                          ? AppPng.imgLocActive
                          : AppPng.imgDefaultMarker,
                    ),
                  ),
                ),
                point: Point(
                  latitude: e.address?.latitude ?? state.userPoint.latitude,
                  longitude: e.address?.longitude ?? state.userPoint.longitude,
                ),
              );
            }).toList(),
        onClusterAdded: (self, cluster) async {
          return cluster.copyWith(
            appearance: cluster.appearance.copyWith(
              opacity: 1,
              icon: PlacemarkIcon.single(
                PlacemarkIconStyle(
                  image: BitmapDescriptor.fromAssetImage(
                    AppPng.imgDefaultMarker,
                  ),
                  scale: 2,
                ),
              ),
            ),
          );
        },
        onClusterTap: (self, cluster) {
          mapController?.moveCamera(
            animation: MapAnimation(duration: 1, type: MapAnimationType.smooth),
            CameraUpdate.newCameraPosition(
              CameraPosition(target: self.placemarks.first.point, zoom: 13),
            ),
          );

        },
        radius: 60,
        minZoom: 12,
      );
      placeMarkMapObjects = [];
      placeMarkMapObjects.add(_collection!);
    } else {
      placeMarkMapObjects = [];
    }
  }

  addServiceMarkers() {
    if (state.listService.isNotEmpty) {
      _collection = ClusterizedPlacemarkCollection(
        mapId: MapObjectId("collectionService"),
        placemarks:
            state.listService.map((e) {
              return PlacemarkMapObject(
                onTap: (mapObject, point) {
                  final newMapObjects = mapObject.mapId;
                  final newVacancyList = [e];
                  mapController?.moveCamera(
                    animation: MapAnimation(
                      type: MapAnimationType.smooth,
                      duration: 1,
                    ),
                    CameraUpdate.newCameraPosition(
                      CameraPosition(target: point),
                    ),
                  );
                  emit(
                    state.copyWith(
                      selectedMapObjects: newMapObjects,
                      selectedServices: newVacancyList,
                    ),
                  );
                },
                opacity: 1,
                mapId: MapObjectId(
                  "placeMark${e.address?.longitude}${e.address?.latitude}",
                ),

                icon: PlacemarkIcon.single(
                  PlacemarkIconStyle(
                    scale: 2,
                    image: BitmapDescriptor.fromAssetImage(
                      state.selectedMapObjects ==
                              MapObjectId(
                                "placeMark${e.address?.longitude}${e.address?.latitude}",
                              )
                          ? AppPng.imgLocActive
                          : AppPng.imgDefaultMarker,
                    ),
                  ),
                ),
                point: Point(
                  latitude: e.address?.latitude ?? state.userPoint.latitude,
                  longitude: e.address?.longitude ?? state.userPoint.longitude,
                ),
              );
            }).toList(),
        onClusterAdded: (self, cluster) async {
          return cluster.copyWith(
            appearance: cluster.appearance.copyWith(
              opacity: 1,
              icon: PlacemarkIcon.single(
                PlacemarkIconStyle(
                  image: BitmapDescriptor.fromAssetImage(
                    AppPng.imgDefaultMarker,
                  ),
                  scale: 2,
                ),
              ),
            ),
          );
        },
        onClusterTap: (self, cluster) {
          mapController?.moveCamera(
            animation: MapAnimation(duration: 1, type: MapAnimationType.smooth),
            CameraUpdate.newCameraPosition(
              CameraPosition(target: self.placemarks.first.point, zoom: 13),
            ),
          );
        },
        radius: 60,
        minZoom: 12,
      );
      placeMarkMapObjects = [];
      placeMarkMapObjects.add(_collection!);
    } else {
      placeMarkMapObjects = [];
    }
  }

  addTaskMarkers() {
    if (state.listTask.isNotEmpty) {
      _collection = ClusterizedPlacemarkCollection(
        mapId: MapObjectId("collectionTask"),
        placemarks:
            state.listTask.map((e) {
              return PlacemarkMapObject(
                mapId: MapObjectId(
                  "placeMark${e.addresses.first.longitude}${e.addresses.first.latitude}",
                ),
                onTap: (mapObject, point) {
                  final newMapObjects = mapObject.mapId;
                  final newVacancyList = [e];
                  mapController?.moveCamera(
                    animation: MapAnimation(
                      type: MapAnimationType.smooth,
                      duration: 1,
                    ),
                    CameraUpdate.newCameraPosition(
                      CameraPosition(target: point),
                    ),
                  );
                  emit(
                    state.copyWith(
                      selectedMapObjects: newMapObjects,
                      selectedTasks: newVacancyList,
                    ),
                  );
                },
                opacity: 1,
                icon: PlacemarkIcon.single(
                  PlacemarkIconStyle(
                    scale: 2,
                    image: BitmapDescriptor.fromAssetImage(
                      state.selectedMapObjects ==
                              MapObjectId(
                                "placeMark${e.addresses.first.longitude}${e.addresses.first.latitude}",
                              )
                          ? AppPng.imgLocActive
                          : AppPng.imgDefaultMarker,
                    ),
                  ),
                ),
                point: Point(
                  latitude:
                      e.addresses.first.latitude ?? state.userPoint.latitude,
                  longitude:
                      e.addresses.first.longitude ?? state.userPoint.longitude,
                ),
              );
            }).toList(),
        onClusterAdded: (self, cluster) async {
          return cluster.copyWith(
            appearance: cluster.appearance.copyWith(
              opacity: 1,
              icon: PlacemarkIcon.single(
                PlacemarkIconStyle(
                  image: BitmapDescriptor.fromAssetImage(
                    AppPng.imgDefaultMarker,
                  ),
                  scale: 2,
                ),
              ),
            ),
          );
        },
        onClusterTap: (self, cluster) {
          mapController?.moveCamera(
            animation: MapAnimation(duration: 1, type: MapAnimationType.smooth),
            CameraUpdate.newCameraPosition(
              CameraPosition(target: self.placemarks.first.point, zoom: 13),
            ),
          );
        },
        radius: 60,
        minZoom: 12,
      );
      placeMarkMapObjects = [];
      placeMarkMapObjects.add(_collection!);
    } else {
      placeMarkMapObjects = [];
    }
  }
}
