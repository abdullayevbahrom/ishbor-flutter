import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:top_jobs/feature/ads_form/presentation/pages/vacancy_form_page/widgets/vacancy_form_keys.dart';
import 'package:top_jobs/feature/ads_form/presentation/pages/vacancy_form_page/widgets/vacancy_form_state.dart';
import 'package:yandex_geocoder/yandex_geocoder.dart' show GeocodeResponse;

import '../../../../../../core/constants/locale_keys.g.dart';
import '../../../../../../core/helpers/string_helpers.dart';
import '../../../../../../core/router/route_names.dart';
import '../../../widgets/w_ads_address.dart';

class VacancyFormAddress extends StatefulWidget {
  const VacancyFormAddress({
    super.key,
    required this.formKeys,
    required this.formCustomState,
  });

  final VacancyFormKeys formKeys;
  final VacancyFormCustomState formCustomState;

  @override
  State<VacancyFormAddress> createState() => _VacancyFormAddressState();
}

class _VacancyFormAddressState extends State<VacancyFormAddress> {
  Future<void> updateAddress() async {
    final response = await context.push(Routes.yandexMap) as GeocodeResponse?;
    if (response != null) {
      widget.formCustomState.city = StringHelpers.extractCity(
        "${response.response?.geoObjectCollection?.featureMember?[0].geoObject?.metaDataProperty?.geocoderMetaData?.text}",
      );
      widget.formCustomState.address = StringHelpers.extractStreet(
        "${response.response?.geoObjectCollection?.featureMember?[0].geoObject?.metaDataProperty?.geocoderMetaData?.text}",
      );
      widget.formCustomState.lat = double.parse(
        "${response.response?.geoObjectCollection?.metaDataProperty?.geocoderResponseMetaData?.point?.latitude}",
      );
      widget.formCustomState.long = double.parse(
        "${response.response?.geoObjectCollection?.metaDataProperty?.geocoderResponseMetaData?.point?.longitude}",
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return WAdsAddress(
      onPressedMap: updateAddress,
      city: widget.formCustomState.city ?? "",
      address: widget.formCustomState.address ?? "",
      title: LocaleKeys.selectVacancyAddress.tr(),
      addressKey: widget.formKeys.addressKey,
    );
  }
}
