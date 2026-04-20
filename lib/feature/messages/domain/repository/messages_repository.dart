
import 'package:dartz/dartz.dart';
import 'package:top_jobs/feature/messages/data/models/paginated_chat_message.dart';

import '../../../../core/network/api_http.dart';
import '../../../../models/message.dart';
import '../../../common/data/models/common_query_params.dart';
import '../../../profile/data/model/ask_question_model.dart';
import '../../data/models/paginated_message_record.dart';

abstract class MessagesRepository {
  Future<Either<Failure, Message>> fetchMessageById({required int messageId});

  Future<Either<Failure, PaginatedChatMessageResponse>> fetchMessages({
    required CommonQueryParams queryParams,
  });

  Future<Either<Failure, Message>> createMessage({
    required int taskId,
    required int receiverId,
  });

  Future<Either<Failure, PaginatedMessageRecordResponse>> fetchRecordsById({
    required int messageId,
    required CommonQueryParams queryParams,
  });

  Future<Either<Failure, Message>> uploadFile({
    required int messageId,
    required String path,
  });

  Future<Either<Failure, void>> askQuestion({
    required SendMessageRequest sendMessage,
  });

  Future<Either<Failure, void>> makeMessageRead(int messageId);

}
