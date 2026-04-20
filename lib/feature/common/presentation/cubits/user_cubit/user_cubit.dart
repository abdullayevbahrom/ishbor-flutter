import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:top_jobs/core/helpers/enum_helpers.dart';
import 'package:top_jobs/feature/common/data/models/user_update_request.dart';
import 'package:top_jobs/feature/common/domain/repository/user_repository.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_toasttifications.dart';

import '../../../../../core/network/api_http.dart';
import '../../../../../core/services/storage_service.dart';
import '../../../../../core/services/web_socket_client.dart';
import '../../../../../injection_container.dart';
import '../../../../../models/user.dart';

part 'user_state.dart';

part 'user_cubit.freezed.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository _userRepository;
  final WebsocketClient _webSocketClient;

  UserCubit(this._userRepository, this._webSocketClient)
    : super(const UserState());

  Future<void> checkUser() async {
    final token = await sl<StorageService>().fetchToken();
    final expireDate = await sl<StorageService>().getExpireDate();

    if (token != null && expireDate!=null) {
      final difference = expireDate.difference(
        DateTime.now().add(const Duration(hours: 5)),
      );
      if (difference.inSeconds < 0) {
        await sl<StorageService>().putToken(null);
        await sl<StorageService>().putExpireDate(null);
        emit(state.copyWith(user: null, hasToken: false));
      } else {
        emit(state.copyWith(hasToken: true));
        fetchUser();
      }
    } else {
      emit(state.copyWith(user: null, hasToken: false));
    }
  }

  Future<void> initUserStatus() async {
    _webSocketClient.initUserStatus(onError: () {}, onMessages: (data) {});
  }

  Future<void> _handleRequest<T>({
    required Future<Either<Failure, T>> Function() request,
    required RequestStatus Function(UserState state) statusSelector,
    required UserState Function(
      UserState state,
      RequestStatus status, {
      User? user,
    })
    stateUpdater,
    bool showSuccess = false,
    String? errorMessage,
  }) async {
    emit(stateUpdater(state, RequestStatus.loading));
    final response = await request();
    response.fold(
      (l) {
        emit(stateUpdater(state, RequestStatus.error));
        showErrorToast(errorMessage);
      },
      (r) {
        emit(
          stateUpdater(
            state,
            RequestStatus.loaded,
            user: r is User ? r : state.user,
          ),
        );
      },
    );
  }

  Future<void> fetchUser() async {
    emit(state.copyWith(status: RequestStatus.loading));
    final token = await sl<StorageService>().fetchToken();
    if (token != null && token.isNotEmpty) {
      final response = await _userRepository.fetchUser();
      response.fold(
        (l) => emit(state.copyWith(status: RequestStatus.error, user: null)),
        (r) async {
          await sl<StorageService>().putUserId(r.id);
          emit(
            state.copyWith(
              status: RequestStatus.loaded,
              user: r,
              hasToken: true,
            ),
          );
        },
      );
    } else {
      emit(
        state.copyWith(
          user: null,
          hasToken: false,
          status: RequestStatus.warning,
        ),
      );
    }
  }

  Future<void> updatePortfolios({required List<File> portfolios}) async {
    await _handleRequest(
      request: () => _userRepository.uploadPortfolios(portfolios: portfolios),
      statusSelector: (s) => s.portfolioSt,
      stateUpdater:
          (s, st, {user}) => s.copyWith(portfolioSt: st, user: user ?? s.user),
      showSuccess: true,
      errorMessage: "Portfolios uploaded failure",
    );
  }

  Future<void> uploadVerificationDoc({required File file}) async {
    await _handleRequest(
      request: () => _userRepository.uploadVerificationDoc(file: file),
      statusSelector: (s) => s.verificationDocSt,
      stateUpdater:
          (s, st, {user}) =>
              s.copyWith(verificationDocSt: st, user: user ?? s.user),
      showSuccess: true,
      errorMessage: "Verification document updated failure",
    );
  }

  Future<void> editUser({required UserProfileUpdateRequest user}) async {
    await _handleRequest(
      request: () => _userRepository.editUser(userProfile: user),
      statusSelector: (s) => s.editSt,
      stateUpdater:
          (s, st, {user}) => s.copyWith(editSt: st, user: user ?? s.user),
      showSuccess: true,
      errorMessage: "Profile update failure",
    );
  }

  Future<void> updateAvatar(File file) async {
    await _handleRequest(
      request: () => _userRepository.uploadAvatar(file: file),
      statusSelector: (s) => s.profileAvatarSt,
      stateUpdater:
          (s, st, {user}) =>
              s.copyWith(profileAvatarSt: st, user: user ?? s.user),
      showSuccess: true,
      errorMessage: "Avatar uploaded error!",
    );
  }

  Future<void> updateLocale(String locale) async {
    final response = await _userRepository.updateLocale(locale: locale);
    response.fold(
      (l) => debugPrint("Locale update failed"),
      (r) => debugPrint("Locale updated successfully!"),
    );
  }

  Future<void> updateProfile({
    required UserProfileUpdateRequest user,
    File? avatar,
    List<File>? portfolios,
    File? verifyDoc,
  }) async {
    await editUser(user: user);

    if (avatar != null) {
      await updateAvatar(avatar);
    } else {
      emit(state.copyWith(profileAvatarSt: RequestStatus.loaded));
    }
    if (portfolios != null && portfolios.isNotEmpty) {
      await updatePortfolios(portfolios: portfolios);
    } else {
      emit(state.copyWith(portfolioSt: RequestStatus.loaded));
    }

    if (verifyDoc != null) {
      await uploadVerificationDoc(file: verifyDoc);
    } else {
      emit(state.copyWith(verificationDocSt: RequestStatus.loaded));
    }
  }

  Future<void> updateProfileParallel({
    required UserProfileUpdateRequest user,
    File? avatar,
    List<File>? portfolios,
    File? verifyDoc,
  }) async {
    final futures = <Future>[];

    futures.add(editUser(user: user));
    if (avatar != null) {
      futures.add(updateAvatar(avatar));
    } else {
      emit(state.copyWith(profileAvatarSt: RequestStatus.loaded));
    }
    if (portfolios != null && portfolios.isNotEmpty) {
      futures.add(updatePortfolios(portfolios: portfolios));
    } else {
      emit(state.copyWith(portfolioSt: RequestStatus.loaded));
    }
    if (verifyDoc != null) futures.add(uploadVerificationDoc(file: verifyDoc));
    emit(state.copyWith(verificationDocSt: RequestStatus.loaded));

    await Future.wait(futures);
  }
}
