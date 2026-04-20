import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
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

  @override
  Future<Either<Failure, User>> fetchUser() async {
    try {
      final response = await _dio.get(ApiConstants.me);

      if (response.statusCode == 200) {
        return Right(User.fromMap(response.data));
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
  Future<Either<Failure, User>> editUser({
    required UserProfileUpdateRequest userProfile,
  }) async {
    try {
      final response = await _dio.patch(
        ApiConstants.meEdit,
        data: userProfile.toJson(),
      );

      if (response.statusCode == 200) {
        return Right(User.fromMap(response.data));
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
  Future<Either<Failure, User>> uploadPortfolios({
    required List<File> portfolios,
  }) async {
    try {
      FormData data = FormData.fromMap({});

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
        return Right(User.fromMap(response.data));
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
  Future<Either<Failure, User>> uploadVerificationDoc({
    required File file,
  }) async {
    FormData data = FormData.fromMap({});

    final String fileName = file.path.split("/").last;
    final String type = file.path.split(".").last;
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
        return Right(User.fromMap(response.data));
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
  Future<Either<Failure, void>> updateLocale({required String locale}) async {
    try {
      final response = await _dio.post(
        ApiConstants.meLocale,
        options: Options(headers: {'Accept-Language': locale}),
      );

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

  //
  // Post("me/avatar")
  // uploadedAvatar : file

  @override
  Future<Either<Failure, User>> uploadAvatar({required File file}) async {
    try {
      FormData data = FormData.fromMap({});

      final String fileName = file.path.split("/").last;
      final String type = file.path.split(".").last;
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
        return Right(User.fromMap(response.data));
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
