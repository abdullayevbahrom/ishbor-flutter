import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:top_jobs/core/constants/api_const.dart';
import 'package:top_jobs/core/helpers/enum_helpers.dart';
import 'package:top_jobs/core/router/app_routes.dart';
import 'package:top_jobs/export.dart';
import 'package:top_jobs/feature/map/domain/repository/yandex_repository.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../../../core/theme/app_png.dart';

part 'yandex_map_state.dart';

part 'yandex_map_cubit.freezed.dart';

class YandexMapCubit extends Cubit<YandexMapState> {
  YandexMapCubit(this._yandexRepository) : super(const YandexMapState());
  final YandexRepository _yandexRepository;
  YandexMapController? mapController;
  PlacemarkMapObject? placeMarkMapObject;

  void update(String value) {
    emit(state.copyWith(addressName: value));
    fetchLocationFromAddress(value);
  }

  Future<void> fetchAddressFromPosition({
    required CameraPosition position,
  }) async {
    emit(state.copyWith(status: RequestStatus.loading));
    final response = await _yandexRepository.fetchAddressFromPosition(
      geocodeApiKey: ApiConstants.yandexGeocodeKey,
      lat: position.target.latitude,
      long: position.target.longitude,
      language:
          navigatorKey.currentContext?.locale.languageCode == 'ru'
              ? "ru_RU"
              : "uz_UZ",
    );

    response.fold(
      (l) {
        emit(state.copyWith(status: RequestStatus.error, error: l.message));
      },
      (r) {
        emit(state.copyWith(status: RequestStatus.loaded, response: r));
      },
    );
  }

  Future<void> fetchLocationFromAddress(String address) async {
    emit(state.copyWith(status: RequestStatus.loading));

    final response = await _yandexRepository.fetchPositionFromAddress(
      query: address,
      language:
          navigatorKey.currentContext?.locale.languageCode == 'ru'
              ? "ru_RU"
              : "uz_UZ",
    );
    response.fold(
      (l) {
        emit(state.copyWith(status: RequestStatus.error, error: l.message));
      },
      (r) {
        mapController?.moveCamera(
          animation: MapAnimation(type: MapAnimationType.smooth,duration: 0.8),
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: Point(
                latitude:
                r
                    .response
                    ?.geoObjectCollection
                    ?.featureMember
                    ?.first
                    .geoObject
                    ?.point
                    ?.latitude ??
                    0,
                longitude:
                r
                    .response
                    ?.geoObjectCollection
                    ?.featureMember
                    ?.first
                    .geoObject
                    ?.point
                    ?.longitude ??
                    0,
              ),
            ),
          ),
        );
        emit(state.copyWith(status: RequestStatus.loading, response: r));

      },
    );
  }

  Future<void> getUserCurrentLocation() async {
    try {
      final permissionStatus = await Permission.location.status;
      mapController?.moveCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: Point(
              latitude: state.userPoint.latitude,
              longitude: state.userPoint.longitude,
            ),
            zoom: 14,
          ),
        ),
        animation: MapAnimation(duration: 1, type: MapAnimationType.smooth),
      );
      if (permissionStatus.isDenied) {
        final newPerStatus = await Permission.location.request();
        if (newPerStatus.isGranted) {
          final userPoint = await fetchLocation();
          emit(state.copyWith(userPoint: userPoint, enableFindMe: true));
          moveToLocation();
        }
      }

      if (permissionStatus.isGranted) {
        final userPoint = await fetchLocation();
        emit(state.copyWith(userPoint: userPoint, enableFindMe: true));
        moveToLocation();
      }

      if (permissionStatus.isPermanentlyDenied) {
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
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          error: 'Failed to get location: ${e.toString()}',
        ),
      );
    }
  }

  Future<Point> fetchLocation() async {
    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );

    return Point(latitude: position.latitude, longitude: position.longitude);
  }

  Future<void> moveToLocation() async {
    // mapController?.moveCamera(
    //   CameraUpdate.newGeometry(
    //     Geometry.fromPoint( Point(
    //       latitude: state.userPoint.latitude,
    //       longitude: state.userPoint.longitude,
    //     )),
    //     focusRect: ScreenRect(
    //       topLeft: ScreenPoint(x: 0, y: 0),
    //       bottomRight: ScreenPoint(x: 50, y: 50),
    //     ),
    //   ),
    // );

    mapController?.moveCamera(
      animation: MapAnimation(type: MapAnimationType.smooth, duration: 1),
      CameraUpdate.newCameraPosition(CameraPosition(target: state.userPoint)),
    );
    placeMarkMapObject = PlacemarkMapObject(
      mapId: MapObjectId("user_loc"),
      isVisible: true,
      opacity: 1,
      icon: PlacemarkIcon.single(
        PlacemarkIconStyle(
          image: BitmapDescriptor.fromAssetImage(AppPng.imgCurrentLoc),
          scale: 0.3,
        ),
      ),
      point: Point(
        latitude: state.userPoint.latitude,
        longitude: state.userPoint.longitude,
      ),
    );
  }
}
