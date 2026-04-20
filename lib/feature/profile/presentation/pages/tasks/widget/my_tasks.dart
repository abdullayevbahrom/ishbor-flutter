import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:top_jobs/feature/common/presentation/widget/task_item.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_loading.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_refresh_indicator.dart';
import 'package:top_jobs/feature/profile/presentation/pages/vacancies/widget/my_vacancies.dart';

import '../../../../../../core/constants/locale_keys.g.dart';
import '../../../../../common/presentation/widget/w_error_widget.dart';
import '../../../../../common/presentation/widget/w_loading_item.dart';
import '../../../cubits/my_tasks_cubit/my_tasks_cubit.dart';

class MyTasks extends StatefulWidget {
  const MyTasks({super.key});

  @override
  State<MyTasks> createState() => _MyTasksState();
}

class _MyTasksState extends State<MyTasks> {
  static const double _scrollThreshold = 80;
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      context.read<MyTasksCubit>().checkLoadMoreMyTs();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyTasksCubit, MyTasksState>(
      builder: (context, state) {
        return MyTasksBody(
          state: state,
          scrollController: _scrollController,
          onRefresh: () async {
            context.read<MyTasksCubit>().fetchMyTsData();
          },
        );
      },
    );
  }
}

class MyTasksBody extends StatelessWidget {
  final MyTasksState state;
  final RefreshCallback onRefresh;
  final ScrollController scrollController;

  const MyTasksBody({
    super.key,
    required this.state,
    required this.onRefresh,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    if (state.myTaskSt.isLoading()) return WLoading();
    if (state.myTaskSt.isError())
      return WErrorWidget(errorText: state.errorText);

    if (state.myTaskSt.isLoaded())
      if (state.myTasks == null || state.myTasks?.items.length == 0)
        return WErrorWidget(errorText: LocaleKeys.noTasks.tr());
    return WRefreshIndicator(
      onRefresh: onRefresh,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(maxHeight: constraints.maxHeight),
            child: ListView.builder(
              itemCount:
                  state.isLoadingMore1
                      ? (state.myTasks?.items.length ?? 0) + 1
                      : state.myTasks?.items.length ?? 0,
              controller: scrollController,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.only(top: 10.h),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                if (state.isLoadingMore1 &&
                    state.myTasks?.items.length == index) {
                  return WLoadingLottie();
                } else {
                  final task = state.myTasks?.items[index];
                  return TaskItem(
                    onPressedFavorite: () {
                      context.read<MyTasksCubit>().toggleMyTask(index);
                    },
                    isPopButtonAvailable: true,
                    enableStatus: true,
                    enableLiftUp: task?.isNeedLiftUp ?? false,
                    task: task!,
                    onTapLiftUp: () {
                      context.read<MyTasksCubit>().liftUpTaskById(task.id);
                    },
                    onTapActivate: () {
                      context.read<MyTasksCubit>().activateTaskById(
                        task.id,
                        index,
                      );
                    },
                    onTapDeactivate: () {
                      context.read<MyTasksCubit>().deactivateTaskById(
                        task.id,
                        index,
                      );
                    },
                    onTapDelete: () {
                      WDeleteCupertinoDialog(
                        onPressedYes: () {
                          context.read<MyTasksCubit>().deleteTaskById(
                            task.id,
                            index,
                          );
                          context.pop();
                        },
                      ).show(context);
                    },
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
