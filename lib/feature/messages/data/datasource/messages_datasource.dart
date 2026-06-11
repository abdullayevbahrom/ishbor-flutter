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
      final mimeTypes = lookupMimeType(path);
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
}
