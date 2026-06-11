import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:top_jobs/core/constants/api_const.dart';
import 'package:top_jobs/core/helpers/mime_helpers.dart';
import 'package:top_jobs/feature/common/data/models/common_query_params.dart';
import 'package:top_jobs/feature/messages/data/models/paginated_chat_message.dart';

import '../../../../core/network/api_http.dart';
import '../../../../core/network/api_response.dart';
import '../../../../models/message.dart';
import '../../../profile/data/model/ask_question_model.dart';
import '../models/paginated_message_record.dart';
import '../../../../models/message_record.dart';

abstract class MessagesDataSource {
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

  Future<Either<Failure, MessageRecord>> askQuestion({
    required SendMessageRequest sendMessage,
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

class MessagesDataSourceImpl extends MessagesDataSource {
  final Dio _dio;

  MessagesDataSourceImpl(this._dio);

  @override
  Future<Either<Failure, Message>> createChat({
    required String receiverId,
    required String adType,
    required String adId,
  }) async {
    try {
      debugPrint(
        '[DEBUG][messages] create chat receiverId=$receiverId adType=$adType adId=$adId',
      );
      final response = await _dio.post(
        ApiConstants.postMessage,
        data: {'receiver_id': receiverId, 'ad_type': adType, 'ad_id': adId},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(Message.fromMap(response.data['data'] ?? response.data));
      } else {
        return Left(Failure(message: _extractMessage(response.data)));
      }
    } on DioException catch (e) {
      return Left(Failure(message: DioFailure.fromDioError(e).message));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, Message>> fetchMessageById({
    required Object messageId,
  }) async {
    try {
      debugPrint('[DEBUG][messages] fetch chat id=${messageId.toString()}');
      final response = await _dio.get(ApiConstants.fetchMessage(messageId));

      if (response.statusCode == 200) {
        return Right(Message.fromMap(response.data['data'] ?? response.data));
      } else {
        return Left(Failure(message: _extractMessage(response.data)));
      }
    } on DioException catch (e) {
      return Left(Failure(message: DioFailure.fromDioError(e).message));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, PaginatedChatMessageResponse>> fetchMessages({
    required CommonQueryParams queryParams,
    String? type,
  }) async {
    try {
      final url =
          type != null
              ? ApiConstants.listMessages(type)
              : ApiConstants.messages;
      debugPrint(
        '[DEBUG][messages] fetch chats type=${type ?? 'all'} page=${queryParams.pageNumber} size=${queryParams.pageSize}',
      );
      final response = await _dio.get(
        url,
        queryParameters: queryParams.toMap(),
      );

      if (response.statusCode == 200) {
        return Right(PaginatedChatMessageResponse.fromMap(response.data));
      } else {
        return Left(Failure(message: _extractMessage(response.data)));
      }
    } on DioException catch (e) {
      return Left(Failure(message: DioFailure.fromDioError(e).message));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, PaginatedMessageRecordResponse>> fetchRecordsByChatId({
    required Object messageId,
    required CommonQueryParams queryParams,
  }) async {
    try {
      debugPrint(
        '[DEBUG][messages] fetch records messageId=${messageId.toString()} page=${queryParams.pageNumber} size=${queryParams.pageSize}',
      );
      final response = await _dio.get(
        ApiConstants.messageRecords(messageId),
        queryParameters: queryParams.toMap(),
      );

      if (response.statusCode == 200) {
        return Right(PaginatedMessageRecordResponse.fromMap(response.data));
      } else {
        return Left(Failure(message: _extractMessage(response.data)));
      }
    } on DioException catch (e) {
      return Left(Failure(message: DioFailure.fromDioError(e).message));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, MessageRecord>> getRecordDetail({
    required Object recordId,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.fetchMessageRecord(recordId),
      );
      if (response.statusCode == 200) {
        return Right(
          MessageRecord.fromMap(response.data['data'] ?? response.data),
        );
      } else {
        return Left(Failure(message: _extractMessage(response.data)));
      }
    } on DioException catch (e) {
      return Left(Failure(message: DioFailure.fromDioError(e).message));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, MessageRecord>> sendMessage({
    required String receiverId,
    required String adType,
    required String adId,
    required String body,
    Object? messageId,
  }) async {
    try {
      debugPrint(
        '[DEBUG][messages] send message receiverId=$receiverId adType=$adType adId=$adId hasMessageId=${messageId != null}',
      );
      final response = await _dio.post(
        ApiConstants.postMessageRecord,
        data: {
          'receiver_id': receiverId,
          'ad_type': adType,
          'ad_id': adId,
          'body': body,
          if (messageId != null) 'message_id': messageId.toString(),
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(
          MessageRecord.fromMap(response.data['data'] ?? response.data),
        );
      } else {
        return Left(Failure(message: _extractMessage(response.data)));
      }
    } on DioException catch (e) {
      return Left(Failure(message: DioFailure.fromDioError(e).message));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, MessageRecord>> answerMessage({
    required String receiverId,
    required String adType,
    required String adId,
    required String body,
    Object? messageId,
  }) async {
    try {
      debugPrint(
        '[DEBUG][messages] answer message receiverId=$receiverId adType=$adType adId=$adId hasMessageId=${messageId != null}',
      );
      final response = await _dio.post(
        ApiConstants.answerMessage,
        data: {
          'receiver_id': receiverId,
          'ad_type': adType,
          'ad_id': adId,
          'body': body,
          if (messageId != null) 'message_id': messageId.toString(),
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(
          MessageRecord.fromMap(response.data['data'] ?? response.data),
        );
      } else {
        return Left(Failure(message: _extractMessage(response.data)));
      }
    } on DioException catch (e) {
      return Left(Failure(message: DioFailure.fromDioError(e).message));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, void>> uploadFile({
    required Object messageId,
    required String path,
  }) async {
    try {
      debugPrint(
        '[DEBUG][messages] upload attachment messageId=${messageId.toString()} path=$path',
      );
      final file = File(path);
      if (!file.existsSync()) {
        debugPrint(
          '[WARN][messages] attachment validation failed: file does not exist path=$path messageId=${messageId.toString()}',
        );
        return Left(Failure(message: 'Attachment file not found'));
      }

      final mimeTypes = lookupMimeType(path);
      if (mimeTypes == null) {
        debugPrint(
          '[WARN][messages] attachment validation warning: mime type unresolved path=$path messageId=${messageId.toString()}',
        );
      }
      final data = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          path,
          filename: path.split('/').last,
          contentType: DioMediaType.parse(
            mimeTypes ?? 'application/octet-stream',
          ),
        ),
      });

      final response = await _dio.post(
        ApiConstants.uploadMessageFile(messageId),
        data: data,
      );

      if (response.statusCode == 204 || response.statusCode == 200) {
        return const Right(null);
      } else {
        return Left(Failure(message: _extractMessage(response.data)));
      }
    } on DioException catch (e) {
      return Left(Failure(message: DioFailure.fromDioError(e).message));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, void>> makeMessageRead(Object messageId) async {
    try {
      debugPrint('[DEBUG][messages] make message read messageId=${messageId.toString()}');
      final response = await _dio.post(ApiConstants.makeMessageRead(messageId));
      if (response.statusCode == 204 || response.statusCode == 200) {
        return const Right(null);
      } else {
        return Left(Failure(message: _extractMessage(response.data)));
      }
    } on DioException catch (e) {
      return Left(Failure(message: DioFailure.fromDioError(e).message));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, void>> deleteRecords({
    required List<Object> ids,
  }) async {
    try {
      debugPrint(
        '[DEBUG][messages] delete records count=${ids.length} ids=${ids.map((e) => e.toString()).join(',')}',
      );
      final response = await _dio.delete(
        ApiConstants.deleteMessageRecords,
        data: {'ids': ids.map((e) => e.toString()).toList()},
      );
      if (response.statusCode == 204 || response.statusCode == 200) {
        return const Right(null);
      } else {
        return Left(Failure(message: _extractMessage(response.data)));
      }
    } on DioException catch (e) {
      return Left(Failure(message: DioFailure.fromDioError(e).message));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  String _extractMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data['message']?.toString() ?? data.toString();
    }
    return data?.toString() ?? 'Unknown error';
  }

  @override
  Future<Either<Failure, MessageRecord>> askQuestion({
    required SendMessageRequest sendMessage,
  }) {
    debugPrint(
      '[DEBUG][messages] ask question receiverId=${sendMessage.receiverId} adType=${sendMessage.adType} adId=${sendMessage.adId}',
    );
    return this.sendMessage(
      receiverId: sendMessage.receiverId,
      adType: sendMessage.adType,
      adId: sendMessage.adId,
      body: sendMessage.body,
      messageId: sendMessage.messageId,
    );
  }
}
