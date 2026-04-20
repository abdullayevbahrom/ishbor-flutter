import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_jobs/feature/common/presentation/widget/service_item.dart';

import '../../../../../../core/constants/locale_keys.g.dart';
import '../../../../../common/presentation/widget/w_error_widget.dart';
import '../../../../../common/presentation/widget/w_loading_item.dart';
import '../../../../../common/presentation/widget/w_refresh_indicator.dart';
import '../../../cubits/favorites_cubit/favorites_cubit.dart';

class WServiceFavorites extends StatelessWidget {
  const WServiceFavorites({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        return WRefreshIndicator(
          onRefresh: () async {
            await context.read<FavoritesCubit>().fetchServiceFavorites();
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            scrollDirection: Axis.vertical,

            child: Column(
              children: [
                if (!state.serviceStatus.isLoaded()) WLoading(),
                if (state.serviceStatus.isLoaded())
                  if (state.listService.isEmpty)
                    WErrorWidget(errorText: LocaleKeys.noServices.tr()),
                ListView.builder(
                  padding: EdgeInsets.only(bottom: 50.h),
                  itemCount: state.listService.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ServiceItem(
                      service: state.listService[index],
                      onPressedFavorite: () {
                        context.read<FavoritesCubit>().toggleService(index);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
