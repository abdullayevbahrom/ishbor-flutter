import 'package:dartz/dartz.dart';
import 'package:top_jobs/core/network/api_http.dart';
import 'package:top_jobs/feature/messages/data/datasource/messages_datasource.dart';
import 'package:top_jobs/feature/messages/data/models/paginated_chat_message.dart';
import 'package:top_jobs/feature/messages/domain/repository/messages_repository.dart';
import 'package:top_jobs/models/message.dart';
import 'package:top_jobs/models/message_record.dart';

import '../../../common/data/models/common_query_params.dart';
import '../models/paginated_message_record.dart';

class MessagesRepositoryImpl extends MessagesRepository {
  final MessagesDataSource _messagesDataSource;

  MessagesRepositoryImpl(this._messagesDataSource);

  @override
  Future<Either<Failure, PaginatedChatMessageResponse>> fetchMessages({
    required CommonQueryParams queryParams,
    String? type,
  }) {
    return _messagesDataSource.fetchMessages(
      queryParams: queryParams,
      type: type,
    );
  }

  @override
  Future<Either<Failure, Message>> createChat({
    required String receiverId,
    required String adType,
    required String adId,
  }) {
    return _messagesDataSource.createChat(
      receiverId: receiverId,
      adType: adType,
      adId: adId,
    );
  }

  @override
  Future<Either<Failure, Message>> fetchMessageById({
    required Object messageId,
  }) {
    return _messagesDataSource.fetchMessageById(messageId: messageId);
  }

  @override
  Future<Either<Failure, PaginatedMessageRecordResponse>> fetchRecordsByChatId({
    required Object messageId,
    required CommonQueryParams queryParams,
  }) {
    return _messagesDataSource.fetchRecordsByChatId(
      messageId: messageId,
      queryParams: queryParams,
    );
  }

  @override
  Future<Either<Failure, void>> uploadFile({
    required Object messageId,
    required String path,
  }) {
    return _messagesDataSource.uploadFile(messageId: messageId, path: path);
  }

  @override
  Future<Either<Failure, MessageRecord>> sendMessage({
    required String receiverId,
    required String adType,
    required String adId,
    required String body,
    Object? messageId,
  }) {
    return _messagesDataSource.sendMessage(
      receiverId: receiverId,
      adType: adType,
      adId: adId,
      body: body,
      messageId: messageId,
    );
  }

  @override
  Future<Either<Failure, MessageRecord>> answerMessage({
    required String receiverId,
    required String adType,
    required String adId,
    required String body,
    Object? messageId,
  }) {
    return _messagesDataSource.answerMessage(
      receiverId: receiverId,
      adType: adType,
      adId: adId,
      body: body,
      messageId: messageId,
    );
  }

  @override
  Future<Either<Failure, void>> makeMessageRead(Object messageId) {
    return _messagesDataSource.makeMessageRead(messageId);
  }

  @override
  Future<Either<Failure, void>> deleteRecords({required List<Object> ids}) {
    return _messagesDataSource.deleteRecords(ids: ids);
  }

  @override
  Future<Either<Failure, MessageRecord>> getRecordDetail({
    required Object recordId,
  }) {
    return _messagesDataSource.getRecordDetail(recordId: recordId);
  }
}
