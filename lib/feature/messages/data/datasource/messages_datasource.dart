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

abstract class MessagesDataSource {
  Future<Either<Failure, Message>> fetchMessageById({
    required Object messageId,
  });

  Future<Either<Failure, PaginatedChatMessageResponse>> fetchMessages({
    required CommonQueryParams queryParams,
  });

  Future<Either<Failure, Message>> createMessage({
    required String receiverId,
    required String adType,
    required String adId,
  });

  Future<Either<Failure, PaginatedMessageRecordResponse>> fetchRecordsById({
    required Object messageId,
    required CommonQueryParams queryParams,
  });

  Future<Either<Failure, void>> uploadFile({
    required Object messageId,
    required String path,
  });

  Future<Either<Failure, void>> askQuestion({
    required SendMessageRequest sendMessage,
  });

  Future<Either<Failure, void>> makeMessageRead(Object messageId);
}

class MessagesDataSourceImpl extends MessagesDataSource {
  final Dio _dio;

  MessagesDataSourceImpl(this._dio);

  @override
  Future<Either<Failure, Message>> createMessage({
    required String receiverId,
    required String adType,
    required String adId,
  }) async {
    try {
      if (kDebugMode) {
        debugPrint(
          '[FIX][MESSAGE][create] receiverId=$receiverId adType=$adType adId=$adId',
        );
      }
      final response = await _dio.post(
        ApiConstants.postMessage,
        data: {'receiver_id': receiverId, 'ad_type': adType, 'ad_id': adId},
      );

      if (response.statusCode == 200) {
        final payload = ApiDataResponse.fromJson(
          response.data,
          (json) => Message.fromMap(Map<String, dynamic>.from(json as Map)),
        );
        if (payload.data == null) {
          return const Left(Failure(message: 'Malformed message payload'));
        }
        return Right(payload.data!);
      } else {
        if (response.data is Map<String, dynamic>) {
          return Left(Failure(message: response.data['message']));
        } else {
          return Left(Failure(message: response.data));
        }
      }
    } on DioException catch (e) {
      final failure = DioFailure.fromDioError(e);
      if (kDebugMode) {
        debugPrint(
          '[FIX][MESSAGE][create][error] receiverId=$receiverId adType=$adType adId=$adId message=${failure.message}',
        );
      }
      return Left(Failure(message: failure.message));
    } on Exception catch (e) {
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
        final payload = ApiDataResponse.fromJson(
          response.data,
          (json) => Message.fromMap(Map<String, dynamic>.from(json as Map)),
        );
        if (payload.data == null) {
          return const Left(Failure(message: 'Malformed message payload'));
        }
        return Right(payload.data!);
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
    required Object messageId,
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
  Future<Either<Failure, void>> uploadFile({
    required Object messageId,
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

      if (response.statusCode == 204 || response.statusCode == 200) {
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
  Future<Either<Failure, void>> askQuestion({
    required SendMessageRequest sendMessage,
  }) async {
    try {
      if (kDebugMode) {
        debugPrint(
          '[FIX][MESSAGE][record-create] receiverId=${sendMessage.receiverId} adType=${sendMessage.adType} adId=${sendMessage.adId}',
        );
      }
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
      if (kDebugMode) {
        debugPrint(
          '[FIX][MESSAGE][record-create][error] receiverId=${sendMessage.receiverId} adType=${sendMessage.adType} adId=${sendMessage.adId} message=${failure.message}',
        );
      }
      return Left(Failure(message: failure.message));
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, void>> makeMessageRead(Object messageId) async {
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
