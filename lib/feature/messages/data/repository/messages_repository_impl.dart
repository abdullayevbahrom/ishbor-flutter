
import 'package:dartz/dartz.dart';
import 'package:top_jobs/core/network/api_http.dart';
import 'package:top_jobs/feature/messages/data/datasource/messages_datasource.dart';
import 'package:top_jobs/feature/profile/data/model/ask_question_model.dart';
import 'package:top_jobs/feature/messages/data/models/paginated_chat_message.dart';
import 'package:top_jobs/feature/messages/domain/repository/messages_repository.dart';
import 'package:top_jobs/models/message.dart';

import '../../../common/data/models/common_query_params.dart';
import '../models/paginated_message_record.dart';

class MessagesRepositoryImpl extends MessagesRepository {
  final MessagesDataSource _messagesDataSource;

  MessagesRepositoryImpl(this._messagesDataSource);

  @override
  Future<Either<Failure, PaginatedChatMessageResponse>> fetchMessages({
    required CommonQueryParams queryParams,
  }) async {
    final response = await _messagesDataSource.fetchMessages(
      queryParams: queryParams,
    );
    return response.fold(
      (l) {
        return Left(Failure(message: l.message));
      },
      (r) {
        return Right(r);
      },
    );
  }

  @override
  Future<Either<Failure, Message>> createMessage({
    required int taskId,
    required int receiverId,
  }) async {
    final response = await _messagesDataSource.createMessage(
      taskId: taskId,
      receiverId: receiverId,
    );

    return response.fold(
      (l) {
        return Left(Failure(message: l.message));
      },
      (r) {
        return Right(r);
      },
    );
  }

  @override
  Future<Either<Failure, Message>> fetchMessageById({
    required int messageId,
  }) async {
    final response = await _messagesDataSource.fetchMessageById(
      messageId: messageId,
    );
    return response.fold(
      (l) {
        return Left(Failure(message: l.message));
      },
      (r) {
        return Right(r);
      },
    );
  }

  @override
  Future<Either<Failure, PaginatedMessageRecordResponse>> fetchRecordsById({
    required int messageId,
    required CommonQueryParams queryParams,
  }) async {
    final response = await _messagesDataSource.fetchRecordsById(
      messageId: messageId,
      queryParams: queryParams,
    );

    return response.fold(
      (l) {
        return Left(Failure(message: l.message));
      },
      (r) {
        return Right(r);
      },
    );
  }

  @override
  Future<Either<Failure, Message>> uploadFile({
    required int messageId,
    required String path,
  }) async {
    final response = await _messagesDataSource.uploadFile(
      messageId: messageId,
      path: path,
    );

    return response.fold(
      (l) {
        return Left(Failure(message: l.message));
      },
      (r) {
        return Right(r);
      },
    );
  }

  @override
  Future<Either<Failure, void>> askQuestion({
    required SendMessageRequest sendMessage,
  }) async {
    final response = await _messagesDataSource.askQuestion(
      sendMessage: sendMessage,
    );
    return response.fold(
      (l) {
        return Left(Failure(message: l.message));
      },
      (r) {
        return Right(r);
      },
    );
  }

  @override
  Future<Either<Failure, void>> makeMessageRead(int messageId)async {
    final response= await _messagesDataSource.makeMessageRead(messageId);
    return response.fold(
          (l) {
        return Left(Failure(message: l.message));
      },
          (r) {
        return Right(r);
      },
    );

  }
}
