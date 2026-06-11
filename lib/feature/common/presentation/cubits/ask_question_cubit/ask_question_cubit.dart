import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/helpers/enum_helpers.dart';
import 'package:top_jobs/core/router/app_routes.dart';
import 'package:top_jobs/feature/ads_view/data/models/reports_param.dart';
import 'package:top_jobs/feature/ads_view/domain/repository/reports_repository.dart';
import 'package:top_jobs/feature/common/domain/repository/contact_click_repository.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_toasttifications.dart';
import 'package:top_jobs/feature/messages/domain/repository/messages_repository.dart';

import '../../../../profile/data/model/ask_question_model.dart';
import '../../../data/models/contact_click_params.dart';

part 'ask_question_state.dart';

part 'ask_question_cubit.freezed.dart';

class AskQuestionCubit extends Cubit<AskQuestionState> {
  AskQuestionCubit(
    this._messagesRepository,
    this._clickRepository,
    this._reportsRepository,
  ) : super(const AskQuestionState());
  final MessagesRepository _messagesRepository;
  final ContactClickRepository _clickRepository;
  final ReportsRepository _reportsRepository;

  Future<void> askQuestion(SendMessageRequest sendMessage) async {
    debugPrint(
      '[DEBUG][messages] ask question receiverId=${sendMessage.receiverId} adType=${sendMessage.adType} adId=${sendMessage.adId} bodyLength=${sendMessage.body.length}',
    );
    emit(state.copyWith(status: RequestStatus.loading));
    final response = await _messagesRepository.askQuestion(
      sendMessage: sendMessage,
    );
    response.fold(
      (l) {
        emit(state.copyWith(status: RequestStatus.error, errorText: l.message));
      },
      (r) {
        emit(state.copyWith(status: RequestStatus.loaded));
        navigatorKey.currentContext?.pop();
        showSuccessToast(LocaleKeys.messageHasBeenSendSuccessfully.tr());
      },
    );
  }

  Future<void> addContactClick({required ContactClickParams params}) async {
    if (kDebugMode) {
      final maskedContact = params.contact.length <= 4
          ? '****'
          : '${params.contact.substring(0, 2)}***${params.contact.substring(params.contact.length - 2)}';
      debugPrint(
        '[DEBUG][contact-click] action=contact_click type=${params.type} id=${params.id} contact=$maskedContact',
      );
    }
    final response = await _clickRepository.addContactClick(
      contactClickParams: params,
    );

    response.fold((l) {}, (r) {});
  }

  Future<void> reportAd(ReportsParam params) async {
    emit(state.copyWith(reportSt: RequestStatus.loading));
    if (kDebugMode) {
      final targetType = params.vacancyId != null
          ? 'vacancy'
          : params.serviceId != null
              ? 'service'
              : params.taskId != null
                  ? 'task'
                  : params.userId != null
                      ? 'user'
                      : 'unknown';
      final targetId = (params.vacancyId ??
              params.serviceId ??
              params.taskId ??
              params.userId)
          ?.toString();
      debugPrint(
        '[DEBUG][reports] action=report targetType=$targetType targetId=${targetId ?? ''} bodyLength=${params.body.length}',
      );
    }
    final response = await _reportsRepository.reportAd(params: params);

    response.fold(
      (l) {
        emit(state.copyWith(reportSt: RequestStatus.error));
      },
      (r) {
        emit(state.copyWith(reportSt: RequestStatus.loaded));
      },
    );
  }
}
