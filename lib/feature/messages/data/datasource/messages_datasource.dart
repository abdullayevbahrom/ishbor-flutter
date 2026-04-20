import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:top_jobs/core/constants/api_const.dart';
import 'package:top_jobs/core/helpers/mime_helpers.dart';
import 'package:top_jobs/feature/common/data/models/common_query_params.dart';
import 'package:top_jobs/feature/messages/data/models/paginated_chat_message.dart';

import '../../../../core/network/api_http.dart';
import '../../../../models/message.dart';
import '../../../profile/data/model/ask_question_model.dart';
import '../models/paginated_message_record.dart';

abstract class MessagesDataSource {
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

class MessagesDataSourceImpl extends MessagesDataSource {
  final Dio _dio;

  MessagesDataSourceImpl(this._dio);

  @override
  Future<Either<Failure, Message>> createMessage({
    required int taskId,
    required int receiverId,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.postMessage(),
        data: {'task': taskId, 'receiver': receiverId},
      );

      if (response.statusCode == 200) {
        return Right(Message.fromMap(response.data));
      } else {
        if (response.data is Map<String, dynamic>) {
          return Left(Failure(message: response.data['message']));
        } else {
          return Left(Failure(message: response.data));
        }
      }
    } on DioException catch (e) {
      final failure = DioFailure.fromDioError(e);
      return Left(Failure(message: failure.message));
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, Message>> fetchMessageById({
    required int messageId,
  }) async {
    try {
      final response = await _dio.get(ApiConstants.fetchMessage(messageId));

      if (response.statusCode == 200) {
        return Right(Message.fromMap(response.data));
      } else {
        if (response.data is Map<String, dynamic>) {
          return Left(Failure(message: response.data['message']));
        } else {
          return Left(Failure(message: response.data));
        }
      }
    } on DioException catch (e) {
      final failure = DioFailure.fromDioError(e);
      return Left(Failure(message: failure.message));
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, PaginatedChatMessageResponse>> fetchMessages({
    required CommonQueryParams queryParams,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.messages,
        queryParameters: queryParams.toMap(),
      );

      if (response.statusCode == 200) {
        return Right(PaginatedChatMessageResponse.fromJson(response.data));
      } else {
        if (response.data is Map<String, dynamic>) {
          return Left(Failure(message: response.data['message']));
        } else {
          return Left(Failure(message: response.data));
        }
      }
    } on DioException catch (e) {
      final failure = DioFailure.fromDioError(e);
      return Left(Failure(message: failure.message));
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, PaginatedMessageRecordResponse>> fetchRecordsById({
    required int messageId,
    required CommonQueryParams queryParams,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.messageRecords(messageId),
        queryParameters: queryParams.toMap(),
      );

      if (response.statusCode == 200) {
        return Right(PaginatedMessageRecordResponse.fromJson(response.data));
      } else {
        if (response.data is Map<String, dynamic>) {
          return Left(Failure(message: response.data['message']));
        } else {
          return Left(Failure(message: response.data));
        }
      }
    } on DioException catch (e) {
      final failure = DioFailure.fromDioError(e);
      return Left(Failure(message: failure.message));
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, Message>> uploadFile({
    required int messageId,
    required String path,
  }) async {
    try {
      String? mimeTypes = MimeTypeHelpers.getMimeParts(path);

      final data = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          path,
          filename: path,
          contentType: DioMediaType.parse(mimeTypes ?? ''),
        ),
      });

      final response = await _dio.post(
        ApiConstants.uploadMessageFile(messageId),
        data: data,
      );

      if (response.statusCode == 204) {
        return Right(Message.fromMap(response.data));
      } else {
        if (response.data is Map<String, dynamic>) {
          return Left(Failure(message: response.data['message']));
        } else {
          return Left(Failure(message: response.data));
        }
      }
    } on DioException catch (e) {
      final failure = DioFailure.fromDioError(e);
      return Left(Failure(message: failure.message));
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, void>> askQuestion({
    required SendMessageRequest sendMessage,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.askQuestion,
        data: sendMessage.toJson(),
      );

      if (response.statusCode == 200) {
        return const Right(null);
      } else {
        if (response.data is Map<String, dynamic>) {
          return Left(Failure(message: response.data['message']));
        } else {
          return Left(Failure(message: response.data));
        }
      }
    } on DioException catch (e) {
      final failure = DioFailure.fromDioError(e);
      return Left(Failure(message: failure.message));
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, void>> makeMessageRead(int messageId) async {
    try {
      final response = await _dio.post(ApiConstants.makeMessageRead(messageId));
      if (response.statusCode == 204) {
        return const Right(null);
      } else {
        if (response.data is Map<String, dynamic>) {
          return Left(Failure(message: response.data['message']));
        } else {
          return Left(Failure(message: response.data));
        }
      }
    } on DioException catch (e) {
      final failure = DioFailure.fromDioError(e);
      return Left(Failure(message: failure.message));
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
