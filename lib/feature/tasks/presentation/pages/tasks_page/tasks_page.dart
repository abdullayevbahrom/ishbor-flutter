import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/helpers/debouncer.dart';
import 'package:top_jobs/core/utils/app_utils.dart';
import 'package:top_jobs/feature/common/presentation/pages/w_error_page/w_error_page.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_search_form.dart';
import 'package:top_jobs/feature/common/presentation/widget/task_item.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_error_widget.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_loading.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_loading_item.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_refresh_indicator.dart';
import 'package:top_jobs/feature/tasks/presentation/cubits/task_cubit/task_cubit.dart';
import 'package:top_jobs/feature/vacancies/data/models/vacancy_query_params.dart';

import '../../../../../core/router/route_names.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../injection_container.dart';
import '../../../../common/presentation/cubits/locale_cubit/locale_cubit.dart';
import '../../../../common/presentation/cubits/user_cubit/user_cubit.dart';
import '../../../../common/presentation/widget/app_button.dart';
import '../../../../common/presentation/widget/w_layout.dart';

class TasksPage extends StatefulWidget {
  TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  final taskCubit = sl<TaskCubit>();

  bool enableCancel = false;

  @override
  void initState() {
    taskCubit
      ..initialize()
      ..reset()
      ..fetchTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, state) {
        return BlocProvider.value(
          value: taskCubit,
          child: BlocBuilder<TaskCubit, TaskState>(
            builder: (context, state) {
              return WLayout(
                child: Scaffold(
                  backgroundColor: AppColors.cF6F7FB,

                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppSearchForm(
                        enableCancel: enableCancel,
                        controller: taskCubit.controller,
                        onPressedCancel: () {
                          setState(() {
                            enableCancel = false;
                            taskCubit.controller.clear();
                          });
                          taskCubit.fetchTasks();
                        },
                        enableFilter: taskCubit.filters.hasActiveFilters,

                        onChanged: (value) {
                          setState(() {
                            enableCancel = value.toString().trim().isNotEmpty;
                          });

                          sl<Debounce>().run(() {
                            taskCubit.fetchTasks();
                          });
                        },
                        onTapLocation: () {
                          context.push(Routes.map, extra: "task");
                        },
                        onTapFilter: () async {
                          final QueryParams? response = await context.push(
                            Routes.filterForm,
                            extra: taskCubit.filters,
                          );

                          if (response != null) {
                            taskCubit
                              ..updateFilter(response)
                              ..reset()
                              ..fetchTasks();
                          } else {
                            taskCubit
                              ..resetFilters()
                              ..reset()
                              ..fetchTasks();
                          }
                        },
                      ),
                      Expanded(
                        child: buildBody(
                          scrollController: taskCubit.scrollController,
                          onPressedReTry: () async {
                            context.read<UserCubit>().checkUser();
                            taskCubit
                              ..resetFilters()
                              ..reset();
                            taskCubit.fetchTasks();
                          },
                          onRefresh: () async {
                            taskCubit
                              ..reset()
                              ..fetchTasks();
                          },
                          state: state,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget buildBody({
    required TaskState state,
    required RefreshCallback onRefresh,
    required ScrollController scrollController,
    required VoidCallback onPressedReTry,
  }) {
    if (state.status.isLoading()) return WLoading();
    if (state.status.isError()) {
      return WErrorPage(onPressedReTry: onPressedReTry);
    }

    if (state.status.isLoaded()) {
      if ((state.listTask?.items ?? []).isEmpty) {
        return Column(
          spacing: 20.h,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WErrorWidget(errorText: LocaleKeys.noTasks.tr()),
            if (taskCubit.filters.hasActiveFilters)
              AppButton(
                onPressed: () {
                  taskCubit
                    ..resetFilters()
                    ..fetchTasks();
                },
                text: LocaleKeys.clearFilter.tr(),
                color: AppColors.cFF9914,
              ),
          ],
        );
      }
      return WRefreshIndicator(
        onRefresh: onRefresh,
        child: LayoutBuilder(
          builder:
              (context, constraints) => ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: ListView.builder(
                  shrinkWrap: false,
                  controller: scrollController,
                  itemCount: state.listTask?.items.length ?? 0,
                  scrollDirection: Axis.vertical,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  itemBuilder: (context, index) {
                    if (state.isLoadingMore &&
                        state.listTask?.items.length == index + 1) {
                      return WLoadingLottie();
                    }
                    final task = state.listTask?.items[index];
                    return TaskItem(
                      onPressedFavorite: () {
                        taskCubit.toggleTaskFavorite(index);
                      },
                      task: task!,
                    );
                  },
                ),
              ),
        ),
      );
    }

    return AppUtils.kSizedBoxShrink;
  }
}
