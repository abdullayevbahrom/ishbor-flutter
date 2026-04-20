import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_jobs/feature/common/presentation/widget/task_item.dart';

import '../../../../../../core/constants/locale_keys.g.dart';
import '../../../../../common/presentation/widget/w_error_widget.dart';
import '../../../../../common/presentation/widget/w_loading_item.dart';
import '../../../../../common/presentation/widget/w_refresh_indicator.dart';
import '../../../cubits/favorites_cubit/favorites_cubit.dart';

class WTaskFavorites extends StatelessWidget {
  const WTaskFavorites({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        return WRefreshIndicator(
          onRefresh: () async {
            await context.read<FavoritesCubit>().fetchTaskFavorites();
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            scrollDirection: Axis.vertical,

            child: Column(
              children: [
                if (!state.taskStatus.isLoaded()) WLoading(),
                if (state.taskStatus.isLoaded())
                  if (state.listTAsk.isEmpty)
                    WErrorWidget(errorText: LocaleKeys.noTasks.tr()),
                ListView.builder(
                  padding: EdgeInsets.only(bottom: 50.h),
                  itemCount: state.listTAsk.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return TaskItem(
                      task: state.listTAsk[index],
                      onPressedFavorite: () {
                        context.read<FavoritesCubit>().toggleTask(index);
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
