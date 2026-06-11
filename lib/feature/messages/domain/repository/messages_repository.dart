import 'package:dartz/dartz.dart';
import 'package:top_jobs/feature/messages/data/models/paginated_chat_message.dart';

import '../../../../core/network/api_http.dart';
import '../../../../models/message.dart';
import '../../../../models/message_record.dart';
import '../../../common/data/models/common_query_params.dart';
import '../../data/models/paginated_message_record.dart';

abstract class MessagesRepository {
  Future<Either<Failure, Message>> fetchMessageById({
    required Object messageId,
  });

  Future<Either<Failure, PaginatedChatMessageResponse>> fetchMessages({
    required CommonQueryParams queryParams,
    String? type,
  });

  Future<Either<Failure, Message>> createChat({
    required String receiverId,
    required String adType,
    required String adId,
  });

  Future<Either<Failure, PaginatedMessageRecordResponse>> fetchRecordsByChatId({
    required Object messageId,
    required CommonQueryParams queryParams,
  });

  Future<Either<Failure, MessageRecord>> getRecordDetail({
    required Object recordId,
  });

  Future<Either<Failure, MessageRecord>> sendMessage({
    required String receiverId,
    required String adType,
    required String adId,
    required String body,
    Object? messageId,
  });

  Future<Either<Failure, MessageRecord>> answerMessage({
    required String receiverId,
    required String adType,
    required String adId,
    required String body,
    Object? messageId,
  });

  Future<Either<Failure, void>> uploadFile({
    required Object messageId,
    required String path,
  });

  Future<Either<Failure, void>> makeMessageRead(Object messageId);

  Future<Either<Failure, void>> deleteRecords({required List<Object> ids});
}
