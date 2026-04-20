import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_jobs/feature/common/presentation/widget/service_item.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_refresh_indicator.dart';

import '../../../../../../core/constants/locale_keys.g.dart';
import '../../../../../common/presentation/widget/w_error_widget.dart';
import '../../../../../common/presentation/widget/w_loading_item.dart';
import '../../../cubits/my_services_cubit/my_services_cubit.dart';

class MyServiceApplies extends StatelessWidget {
  const MyServiceApplies({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyServicesCubit, MyServicesState>(
      builder: (context, state) {
        return MyServicesBody(state: state, onRefresh: () async {});
      },
    );
  }
}

class MyServicesBody extends StatelessWidget {
  final MyServicesState state;
  final RefreshCallback onRefresh;

  const MyServicesBody({
    super.key,
    required this.state,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    if (state.myServicesAppliesSt.isLoading()) return WLoading();
    if (state.myServicesAppliesSt.isError())
      return WErrorWidget(errorText: state.errorText);
    if (state.myServicesAppliesSt.isLoaded())
      if (state.myServicesApplies == null || state.myServicesApplies?.items.length == 0)
        return WErrorWidget(errorText: LocaleKeys.noServices.tr());
    return WRefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: state.myServicesApplies?.items.length ?? 0,
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.only(top: 10.h),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final service = state.myServicesApplies?.items[index];
          return ServiceItem(
              onPressedFavorite: () {

              },
              isPopButtonAvailable: true, service: service!);
        },
      ),
    );
  }
}
