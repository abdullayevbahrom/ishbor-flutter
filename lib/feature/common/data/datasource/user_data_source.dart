import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:top_jobs/core/network/api_http.dart';
import 'package:top_jobs/core/constants/api_const.dart';

import '../../../../models/user.dart';
import '../models/user_update_request.dart';

abstract class UserDataSource {
  Future<Either<Failure, User>> fetchUser();

  Future<Either<Failure, void>> updateLocale({required String locale});

  Future<Either<Failure, User>> editUser({
    required UserProfileUpdateRequest userProfile,
  });

  Future<Either<Failure, User>> uploadPortfolios({
    required List<File> portfolios,
  });

  Future<Either<Failure, User>> uploadAvatar({required File file});

  Future<Either<Failure, User>> uploadVerificationDoc({required File file});
}

class UserDataSourceImpl extends UserDataSource {
  final Dio _dio;

  UserDataSourceImpl(this._dio);

  Map<String, dynamic> _payload(dynamic responseData) {
    if (responseData is Map<String, dynamic>) {
      final data = responseData['data'];
      if (data is Map<String, dynamic>) {
        return Map<String, dynamic>.from(data);
      }

      return Map<String, dynamic>.from(responseData);
    }

    return <String, dynamic>{};
  }

  String _messageFromResponse(dynamic responseData) {
    if (responseData is Map<String, dynamic>) {
      final fallback =
          responseData.values.isNotEmpty
              ? responseData.values.first
              : 'Unknown error';
      return (responseData['message'] ?? responseData['error'] ?? fallback)
          .toString();
    }

    return responseData?.toString() ?? 'Unknown error';
  }

  @override
  Future<Either<Failure, User>> fetchUser() async {
    try {
      if (kDebugMode) {
        debugPrint('[PROFILE][fetch] GET ${ApiConstants.me}');
      }
      final response = await _dio.get(ApiConstants.me);

      if (response.statusCode == 200) {
        return Right(User.fromMap(_payload(response.data)));
      } else {
        return Left(Failure(message: _messageFromResponse(response.data)));
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
  Future<Either<Failure, User>> editUser({
    required UserProfileUpdateRequest userProfile,
  }) async {
    try {
      final response = await _dio.patch(
        ApiConstants.meEdit,
        data: userProfile.toJson(),
      );

      if (kDebugMode) {
        debugPrint('[PROFILE][edit] PATCH ${ApiConstants.meEdit}');
      }

      if (response.statusCode == 200) {
        return Right(User.fromMap(_payload(response.data)));
      } else {
        return Left(Failure(message: _messageFromResponse(response.data)));
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
  Future<Either<Failure, User>> uploadPortfolios({
    required List<File> portfolios,
  }) async {
    try {
      if (kDebugMode) {
        debugPrint(
          '[PROFILE][portfolio] POST ${ApiConstants.mePortfolios} files=${portfolios.length}',
        );
      }
      final FormData data = FormData.fromMap({});

      if (portfolios.isNotEmpty) {
        for (File file in portfolios) {
          final String fileName = file.path.split("/").last;
          final String type = file.path.split(".").last;
          data.files.add(
            MapEntry<String, MultipartFile>(
              "uploadedPortfolios",
              MultipartFile.fromBytes(
                file.readAsBytesSync(),
                filename: fileName,
                contentType: DioMediaType("image", type),
              ),
            ),
          );
        }
      }

      final response = await _dio.post(ApiConstants.mePortfolios, data: data);
      if (response.statusCode == 200) {
        return Right(User.fromMap(_payload(response.data)));
      } else {
        return Left(Failure(message: _messageFromResponse(response.data)));
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
  Future<Either<Failure, User>> uploadVerificationDoc({
    required File file,
  }) async {
    final FormData data = FormData.fromMap({});

    final String fileName = file.path.split("/").last;
    final String type = file.path.split(".").last;
    if (kDebugMode) {
      debugPrint(
        '[PROFILE][verification-doc] POST ${ApiConstants.meVerificationDoc} file=$fileName type=$type',
      );
    }
    data.files.add(
      MapEntry<String, MultipartFile>(
        "uploadedVerificationDoc",
        MultipartFile.fromBytes(
          file.readAsBytesSync(),
          filename: fileName,
          contentType: DioMediaType("image", type),
        ),
      ),
    );

    try {
      final response = await _dio.post(
        ApiConstants.meVerificationDoc,
        data: data,
      );

      if (response.statusCode == 200) {
        return Right(User.fromMap(_payload(response.data)));
      } else {
        return Left(Failure(message: _messageFromResponse(response.data)));
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
  Future<Either<Failure, void>> updateLocale({required String locale}) async {
    try {
      if (kDebugMode) {
        debugPrint(
          '[PROFILE][locale] POST ${ApiConstants.meLocale} locale=$locale',
        );
      }
      final response = await _dio.post(
        ApiConstants.meLocale,
        data: {'locale': locale},
      );

      if (response.statusCode == 204) {
        return const Right(null);
      } else {
        return Left(Failure(message: _messageFromResponse(response.data)));
      }
    } on DioException catch (e) {
      final failure = DioFailure.fromDioError(e);
      return Left(Failure(message: failure.message));
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  //
  // Post("me/avatar")
  // uploadedAvatar : file

  @override
  Future<Either<Failure, User>> uploadAvatar({required File file}) async {
    try {
      FormData data = FormData.fromMap({});

      final String fileName = file.path.split("/").last;
      final String type = file.path.split(".").last;
      if (kDebugMode) {
        debugPrint(
          '[PROFILE][avatar] POST ${ApiConstants.meAvatar} file=$fileName type=$type',
        );
      }
      data.files.add(
        MapEntry<String, MultipartFile>(
          "uploadedAvatar",
          MultipartFile.fromBytes(
            file.readAsBytesSync(),
            filename: fileName,
            contentType: DioMediaType("image", type),
          ),
        ),
      );
      final response = await _dio.post(ApiConstants.meAvatar, data: data);

      if (response.statusCode == 200) {
        return Right(User.fromMap(_payload(response.data)));
      } else {
        return Left(Failure(message: _messageFromResponse(response.data)));
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
