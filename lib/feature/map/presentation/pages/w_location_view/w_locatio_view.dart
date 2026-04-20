import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/theme/app_png.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class WLocationMapView extends StatefulWidget {
  final Point? point;

  const WLocationMapView({super.key, required this.point});

  @override
  _WLocationMapViewState createState() => _WLocationMapViewState();
}

class _WLocationMapViewState extends State<WLocationMapView> {
  late YandexMapController _mapController;
  List<PlacemarkMapObject> _placemarks = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.h,
      width: 100.sw,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: YandexMap(
          onMapCreated: (controller) {
            _mapController = controller;
            _mapController.moveCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  zoom: 13,
                  target:
                      widget.point ??
                      Point(latitude: 41.311081, longitude: 69.240562),
                ),
              ),
              animation: MapAnimation(
                type: MapAnimationType.smooth,
                duration: 1,
              ),
            );
          },
          mapObjects: [
            PlacemarkMapObject(
              opacity: 1,
              mapId: MapObjectId("map${widget.point?.longitude ?? 41.311081}"),
              point:
                  widget.point ??
                  Point(latitude: 41.311081, longitude: 69.240562),
              icon: PlacemarkIcon.single(

                PlacemarkIconStyle(
                  scale: 2,
                  isVisible: true,

                  image: BitmapDescriptor.fromAssetImage(AppPng.imgLocActive),
                ),
              ),
            ),
          ],
        ),
      ),
    ).paddingSymmetric(horizontal: 16.w);
  }
}
