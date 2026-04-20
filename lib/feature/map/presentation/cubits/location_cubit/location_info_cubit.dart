import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/extension_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';
import 'package:top_jobs/core/helpers/enum_helpers.dart';
import 'package:top_jobs/core/services/location_service.dart';
import 'package:top_jobs/feature/map/domain/repository/location_info.dart';

import '../../../data/model/location_info.dart';
import '../../../data/model/suggested_location.dart';

part 'location_info_state.dart';

part 'location_info_cubit.freezed.dart';

class LocationInfoCubit extends Cubit<LocationInfoState> {
  LocationInfoCubit(this._infoRepository) : super(const LocationInfoState());
  final LocationInfoRepository _infoRepository;
  final TextEditingController controller = TextEditingController();
  final PopupController popupLayerController = PopupController();
  final MapController mapController = MapController();
  LatLng defaultCenter = LatLng(41.311081, 69.230562);

  void initializeStatus(){
    emit(state.copyWith(suggestionStatus: RequestStatus.initial));
  }

  Future<void> fetchLocationInfo(LatLng point) async {
    emit(state.copyWith(status: RequestStatus.loading));

    final response = await _infoRepository.fetchLocationFromPoint(point: point);

    response.fold(
      (l) {
        emit(state.copyWith(status: RequestStatus.error));
      },
      (r) {
        controller.text = r.displayName ?? '';
        emit(state.copyWith(status: RequestStatus.loaded, locationInfo: r));
      },
    );
  }

  Future<void> searchLocationByQuery() async {
    emit(state.copyWith(suggestionStatus: RequestStatus.loading));
    final response = await _infoRepository.fetchSuggestionsFromQuery(
      controller.text.trim(),
    );
    response.fold(
      (l) {
        emit(state.copyWith(suggestionStatus: RequestStatus.error));
      },
      (r) {
        //controller.text = r.displayName ?? '';
        emit(
          state.copyWith(
            suggestionStatus: RequestStatus.loaded,
            suggestions: r,
          ),
        );
      },
    );
  }

  Future<void> initializeMarker() async {
    try {
      emit(state.copyWith(status: RequestStatus.loading));
      final position = await LocationService().determinePosition();
      defaultCenter = LatLng(position.latitude, position.longitude);
      emit(
        state.copyWith(
          status: RequestStatus.loaded,
          defaultCenter: defaultCenter,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: RequestStatus.loaded,
          defaultCenter: defaultCenter,
        ),
      );
    }
  }
}
