import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_jobs/feature/ads_view/presentation/pages/service_view_page/service_view_page.dart';
import 'package:top_jobs/feature/ads_view/presentation/pages/task_view_page/task_view_page.dart';
import 'package:top_jobs/feature/ads_view/presentation/pages/vacancy_view_page/vacancy_view_page.dart';
import 'package:top_jobs/feature/common/presentation/cubits/notification_details/notification_details_cubit.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_error_widget.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_loading_item.dart';

import '../../../../../injection_container.dart';
import '../../../../messages/presentation/pages/chat/chat_page.dart';

class NotificationsDetail extends StatefulWidget {
  const NotificationsDetail({super.key, required this.params});

  final Map<String, dynamic> params;

  @override
  State<NotificationsDetail> createState() => _NotificationsDetailState();
}

class _NotificationsDetailState extends State<NotificationsDetail> {
  final cubit = sl<NotificationDetailsCubit>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocConsumer<NotificationDetailsCubit, NotificationDetailsState>(
        listener: (context, state) {},
        bloc:
            cubit..fetchDetails(
              type: widget.params['type'],
              id: widget.params['id'],
            ),
        builder: (context, state) {
          return Scaffold(body: buildBody(state));
        },
      ),
    );
  }

  Widget buildBody(NotificationDetailsState state) {
    if (state.status.isLoading()) return WLoading();
    if (state.status.isError()) return WErrorWidget(errorText: state.errorText);
    if (state.status.isLoaded())
      if (widget.params['type'] == 'vacancy')
        if (state.vacancy != null)
          return WVacancyViewPage(vacancyId: state.vacancy!.id);
    if (widget.params['type'] == 'service')
      if (state.service != null)
        return WServiceViewPage(serviceId: state.service!.id);
    if (widget.params['type'] == 'task')
      if (state.task != null) return WTaskViewPage(taskId: state.task!.id);
    if (widget.params['type'] == "message")
      if (state.message != null) return ChatPage(messageId: state.message!.id);
    return SizedBox();
  }
}
