import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_jobs/feature/common/presentation/widget/task_item.dart';

import '../../../../../../core/constants/locale_keys.g.dart';
import '../../../../../common/presentation/widget/w_error_widget.dart';
import '../../../../../common/presentation/widget/w_loading_item.dart';
import '../../../../../common/presentation/widget/w_refresh_indicator.dart';
import '../../../cubits/my_tasks_cubit/my_tasks_cubit.dart';

class MyTaskApplies extends StatelessWidget {
  const MyTaskApplies({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyTasksCubit, MyTasksState>(
      builder: (context, state) {
        return MyTaskAppliesBody(
          state: state,
          onRefresh: () async {
            context.read<MyTasksCubit>().fetchMyTaskApplies();
          },
        );
      },
    );
  }
}

class MyTaskAppliesBody extends StatelessWidget {
  final MyTasksState state;
  final RefreshCallback onRefresh;

  const MyTaskAppliesBody({
    super.key,
    required this.state,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    if (state.myTaskAppliesSt.isLoading()) return WLoading();
    if (state.myTaskAppliesSt.isError())
      return WErrorWidget(errorText: state.errorText);

    if (state.myTaskAppliesSt.isLoaded())
      if (state.myTaskApplies == null || state.myTaskApplies?.items.length == 0)
        return WErrorWidget(errorText: LocaleKeys.noTasks.tr());
    return WRefreshIndicator(
      onRefresh: onRefresh,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(maxHeight: constraints.maxHeight),
            child: ListView.builder(
              itemCount: state.myTaskApplies?.items.length ?? 0,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.only(top: 10.h),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final task = state.myTaskApplies?.items[index].task;
                return TaskItem(
                  onPressedFavorite: () {
                    context.read<MyTasksCubit>().toggleMyAppLiedTask(index);
                  },
                  enableStatus: true,
                  task: task!,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
