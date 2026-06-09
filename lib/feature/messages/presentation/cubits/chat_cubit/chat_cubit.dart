import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/constants/time_delay_cons.dart';
import 'package:top_jobs/core/helpers/enum_helpers.dart';
import 'package:top_jobs/core/services/web_socket_client.dart';
import 'package:top_jobs/feature/common/data/models/common_query_params.dart';
import 'package:top_jobs/feature/messages/domain/repository/messages_repository.dart';
import 'package:top_jobs/models/message_record.dart';
import 'package:web_socket_channel/io.dart';

import '../../../../../models/message.dart';
import '../../../data/models/paginated_message_record.dart';

part 'chat_state.dart';
part 'chat_cubit.freezed.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this._messagesRepository) : super(const ChatState());
  final MessagesRepository _messagesRepository;
  IOWebSocketChannel? _channel;
  String? _messageId;

  Map<String, GlobalKey> messageKey = {};

  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  int pageNumber = 1;
  int pageSize = 10;
  double _lastScrollOffset = 0;
  bool _isInitialized = false;

  void reset() {
    pageNumber = 1;
  }

  void scrollToEnd() {
    if (scrollController.hasClients) {
      scrollController.jumpTo(scrollController.position.minScrollExtent);
    }
  }

  void initialize() {
    if (_isInitialized) {
      return;
    }
    _isInitialized = true;
    scrollController.addListener(onScroll);
  }

  void onScroll() {
    if (!scrollController.hasClients) return;

    final maxScroll = scrollController.position.maxScrollExtent;
    final minScroll = scrollController.position.minScrollExtent;
    final currentScroll = scrollController.position.pixels;
    if (currentScroll - minScroll > 80 && currentScroll < _lastScrollOffset) {
      emit(state.copyWith(enableDownIcon: true));
    } else {
      emit(state.copyWith(enableDownIcon: false));
    }

    if (maxScroll - currentScroll < 20 && !state.isLoadingMore) {
      checkLoadMoreMessage();
    }
    _lastScrollOffset = currentScroll;
  }

  void checkLoadMoreMessage() {
    final itemsLength = state.messageRecords?.items.length ?? 0;
    final totalCount = state.messageRecords?.totalCount ?? 0;
    if (itemsLength != totalCount) {
      increasePage();
      fetchMoreMessageReports();
    }
  }

  void increasePage() {
    pageNumber += 1;
  }

  Future<void> fetchData(Object messageId) async {
    _messageId = messageId.toString();
    reset();
    fetchRecordsByChatId(messageId);
    initChat(messageId);
  }

  Future<void> fetchRecordsByChatId(Object messageId) async {
    emit(state.copyWith(fetchSt: RequestStatus.loading));
    final response = await _messagesRepository.fetchRecordsByChatId(
      messageId: messageId,
      queryParams: CommonQueryParams(
        pageNumber: pageNumber,
        pageSize: pageSize,
      ),
    );

    response.fold(
      (l) {
        emit(state.copyWith(fetchSt: RequestStatus.error, errorText: l.message));
      },
      (r) {
        emit(state.copyWith(fetchSt: RequestStatus.loaded, messageRecords: r));
        scrollToFirstUnreadMessage(state.messageRecords?.items ?? []);
      },
    );
  }

  Future<void> fetchMoreMessageReports() async {
    if (_messageId == null || _messageId!.isEmpty) {
      return;
    }

    emit(state.copyWith(isLoadingMore: true));
    final response = await _messagesRepository.fetchRecordsByChatId(
      messageId: _messageId!,
      queryParams: CommonQueryParams(
        pageNumber: pageNumber,
        pageSize: pageSize,
      ),
    );

    response.fold(
      (l) {
        emit(
          state.copyWith(
            fetchSt: RequestStatus.error,
            errorText: l.message,
            isLoadingMore: false,
          ),
        );
      },
      (r) {
        emit(
          state.copyWith(
            fetchSt: RequestStatus.loaded,
            isLoadingMore: false,
            messageRecords: r.copyWith(
              items: [...state.messageRecords?.items ?? [], ...r.items],
            ),
          ),
        );
      },
    );
  }

  void scrollToFirstUnreadMessage(List<MessageRecord> messages) {
    if (messages.isEmpty) return;
    final key = messageKey[messages.first.id];
    if (key != null && key.currentContext != null) {
      Future.delayed(TimeDelayCons.durationMill100, () {
        Scrollable.ensureVisible(
          key.currentContext!,
          duration: TimeDelayCons.durationMill400,
          curve: Curves.easeInOut,
        );
      });
    }
  }

  Future<void> makeMessageRead(Object messageId) async {
    final response = await _messagesRepository.makeMessageRead(messageId);
    response.fold((l) {}, (r) {});
  }

  Future<void> initChat(Object messageId) async {
    _channel = await WebsocketClient.initChat(messageId);
    _channel?.stream.listen(
      (event) {
        final decoded = jsonDecode(event);
        if (decoded is List) {
          final messages = decoded.map<MessageRecord>((e) {
            final parsed = e is String ? jsonDecode(e) : e;
            return MessageRecord.fromMap(parsed);
          }).toList();
          onIncomingMessage(messages);
        } else {
          final single = MessageRecord.fromMap(decoded);
          onIncomingMessage([single]);
        }
      },
      onError: (_, __) {
        emit(
          state.copyWith(
            fetchSt: RequestStatus.error,
            errorText: LocaleKeys.connectionError.tr(),
          ),
        );
      },
    );
  }

  Future<void> sendWebSocketMessage(Map<String, dynamic> messageData) async {
    final messages = List.from(state.sendingMessages);
    messages.add(messageData['body']);
    _channel?.sink.add(jsonEncode(messageData));
    messageController.clear();
    emit(state.copyWith(sendingMessages: messages));
  }

  Future<void> sendHttpMessage({
    required String receiverId,
    required String adType,
    required String adId,
    required String body,
  }) async {
    emit(state.copyWith(sendingMessages: [...state.sendingMessages, body]));
    final response = await _messagesRepository.sendMessage(
      receiverId: receiverId,
      adType: adType,
      adId: adId,
      body: body,
      messageId: _messageId,
    );

    response.fold(
      (l) {
        final messages = List.from(state.sendingMessages);
        messages.remove(body);
        emit(state.copyWith(sendingMessages: messages));
      },
      (r) {
        onIncomingMessage([r]);
        messageController.clear();
      },
    );
  }

  void onIncomingMessage(List<MessageRecord> messageRecord) async {
    final sendingMessages = List.from(state.sendingMessages);
    for (var element in messageRecord) {
      sendingMessages.remove(element.body);
    }
    emit(
      state.copyWith(
        sendingMessages: sendingMessages,
        messageRecords: state.messageRecords?.copyWith(
          items: [...messageRecord, ...state.messageRecords?.items ?? []],
        ),
        fetchSt: RequestStatus.loaded,
      ),
    );
    scrollToEnd();
  }

  Future<void> pickFile(Object messageId) async {
    try {
      final result = await FilePicker.platform.pickFiles();
      if (result != null && result.files.single.path != null) {
        final response = await _messagesRepository.uploadFile(
          messageId: messageId,
          path: result.files.single.path!,
        );
        response.fold((l) {}, (r) {});
      }
    } catch (_) {
      return;
    }
  }

  Future<void> checkFile(MessageRecord messageRecord) async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File(
      "$dir/${messageRecord.file?.originalName}.${messageRecord.file?.extension}",
    );
    bool need = !(await file.exists());
    emit(state.copyWith(needToDownload: need));
  }

  Future<void> deleteRecords(List<Object> ids) async {
    final response = await _messagesRepository.deleteRecords(ids: ids);
    response.fold(
      (l) {},
      (r) {
        final currentItems = state.messageRecords?.items ?? [];
        final newItems = currentItems.where((e) => !ids.contains(e.id)).toList();
        emit(state.copyWith(
          messageRecords: state.messageRecords?.copyWith(items: newItems),
        ));
      },
    );
  }

  Future<void> closeConnection() async {
    await _channel?.sink.close();
  }

  @override
  Future<void> close() {
    _channel?.sink.close();
    return super.close();
  }

  Future<void> fetchMessageById(Object id) async {
    emit(state.copyWith(messageSt: RequestStatus.loading));
    final response = await _messagesRepository.fetchMessageById(messageId: id);
    response.fold(
      (l) {
        emit(state.copyWith(messageSt: RequestStatus.error));
      },
      (r) {
        emit(state.copyWith(messageSt: RequestStatus.loaded, message: r));
      },
    );
  }
}
