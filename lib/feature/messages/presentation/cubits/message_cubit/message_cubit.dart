import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:top_jobs/core/helpers/enum_helpers.dart';
import 'package:top_jobs/feature/common/data/models/common_query_params.dart';

import '../../../../../models/message.dart';
import '../../../data/models/paginated_chat_message.dart';
import '../../../domain/repository/messages_repository.dart';

part 'message_state.dart';

part 'message_cubit.freezed.dart';

class MessageCubit extends Cubit<MessageState> {
  final MessagesRepository _messagesRepository;

  MessageCubit(this._messagesRepository) : super(const MessageState());
  int size = 10;
  int page = 1;

  void fetchData() {
    reset();
    fetchMessages();
  }

  void reset() {
    page = 1;
  }

  void checkLoadMoreData() {
    if (state.messages?.totalCount != state.messages?.items.length &&
        !state.isLoading) {
      increasePage();
      fetchMoreMessages();
    }
  }

  void increasePage() {
    page += 1;
  }

  Future<void> fetchMessages() async {
    emit(state.copyWith(status: RequestStatus.loading));

    final response = await _messagesRepository.fetchMessages(
      queryParams: CommonQueryParams(pageNumber: page, pageSize: size),
    );

    response.fold(
      (l) {
        emit(state.copyWith(status: RequestStatus.error));
      },
      (r) {
        emit(state.copyWith(status: RequestStatus.loaded, messages: r));
        checkHasUnReadMessages();
      },
    );
  }

  Future<void> fetchMoreMessages() async {
    emit(state.copyWith(isLoading: true));

    final response = await _messagesRepository.fetchMessages(
      queryParams: CommonQueryParams(pageNumber: page, pageSize: size),
    );

    response.fold(
      (l) {
        emit(state.copyWith(status: RequestStatus.error, isLoading: false));
      },
      (r) {
        emit(
          state.copyWith(
            status: RequestStatus.loaded,
            isLoading: false,
            messages: r.copyWith(
              items: [...state.messages?.items ?? [], ...r.items],
            ),
          ),
        );
        checkHasUnReadMessages();
      },
    );
  }

  void makeMessageRead(int index) {
    final messages = List<Message>.from(state.messages?.items ?? []);
    messages[index] = messages[index].copyWith(hasNewRecord: false);
    emit(state.copyWith(messages: state.messages?.copyWith(items: messages)));
    checkHasUnReadMessages();
  }

  void checkHasUnReadMessages() {
    List<bool> messagesStatus = [];
    for (Message element in (state.messages?.items ?? [])) {
      messagesStatus.add(element.hasNewRecord ?? false);
    }
    if (messagesStatus.contains(true)) {
      emit(state.copyWith(hasUnreadMessage: true));
    } else {
      emit(state.copyWith(hasUnreadMessage: false));
    }
  }
}
