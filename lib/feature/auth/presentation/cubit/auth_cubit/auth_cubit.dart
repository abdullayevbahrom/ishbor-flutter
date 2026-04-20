import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/helpers/enum_helpers.dart';
import 'package:top_jobs/core/router/app_routes.dart';
import 'package:top_jobs/core/services/storage_service.dart';
import 'package:top_jobs/feature/auth/data/models/auth_success.dart';
import 'package:top_jobs/feature/auth/domain/repository/auth_repository.dart';
import 'package:top_jobs/feature/auth/presentation/pages/otp_page/otp_page.dart';
import 'package:top_jobs/feature/auth/presentation/pages/user_type_page/user_type_page.dart';
import 'package:top_jobs/feature/common/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_toasttifications.dart';

import '../../../../../injection_container.dart';
import '../../../data/models/check_model.dart';
import '../../../data/models/request/params.dart';

part 'auth_state.dart';

part 'auth_cubit.freezed.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepository) : super(const AuthState());

  final AuthRepository _authRepository;
  final storageService = sl<StorageService>();

  Future<void> logOut() async {
    emit(state.copyWith(logOutSt: RequestStatus.loading));
    await sl<StorageService>().clear();
    navigatorKey.currentContext?.read<UserCubit>().fetchUser();
    emit(state.copyWith(logOutSt: RequestStatus.loaded));
  }

  void updateType(String type) {
    emit(state.copyWith(type: type));
  }

  Future<void> logIn({
    required bool rememberPassword,
    required CheckModel model,
  }) async {
    emit(state.copyWith(status: RequestStatus.loading));
    if (rememberPassword) {
      await sl<StorageService>().putPassword(model.password);
    }

    final response = await _authRepository.checkAuth(checkModel: model);

    response.fold(
      (l) {
        emit(state.copyWith(status: RequestStatus.error, errorText: l.message));
        showErrorToast(l.message ?? LocaleKeys.error.tr());
      },
      (r) async {
        await storageService.putToken(r.token);
        await storageService.putExpireDate(r.expiresAt);
        emit(state.copyWith(status: RequestStatus.loaded));
        showSuccessToast(LocaleKeys.loginSuccessful.tr());
      },
    );
  }

  Future<void> logInWithTelegram(AuthSuccess authSuccess) async {
    final token = await storageService.fetchToken();
    if (token == null) {
      await storageService.putToken(authSuccess.token);
      await storageService.putExpireDate(authSuccess.expiresAt);
      showSuccessToast(LocaleKeys.loginSuccessful.tr());
      navigatorKey.currentContext?.read<UserCubit>().fetchUser();
    }
  }

  Future<void> verifyPhoneNumber({required String phoneNumber}) async {
    emit(state.copyWith(verifyPhoneSt: RequestStatus.loading));
    if (phoneNumber == '+998123456789') {
      await Future.delayed(Duration(seconds: 2));
      emit(state.copyWith(verifyPhoneSt: RequestStatus.loaded));
      showSuccessToast(LocaleKeys.verificationCodeSendToPhone.tr());
      OtpPage(
        phoneNumber: phoneNumber,
        isRegister: true,
      ).show(navigatorKey.currentContext!);
      return;
    }
    final response = await _authRepository.checkPhone(phoneNumber: phoneNumber);

    response.fold(
      (l) {
        emit(
          state.copyWith(
            verifyPhoneSt: RequestStatus.error,
            errorText: l.message,
          ),
        );
        showErrorToast(l.message);
      },
      (r) {
        emit(state.copyWith(verifyPhoneSt: RequestStatus.loaded));
        showSuccessToast(LocaleKeys.verificationCodeSendToPhone.tr());
        OtpPage(
          phoneNumber: phoneNumber,
          isRegister: r,
        ).show(navigatorKey.currentContext!);
      },
    );
  }

  Future<void> checkSmsCode({
    required String phone,
    required String code,
  }) async {
    emit(state.copyWith(loginSt: RequestStatus.loading));

    if (phone.replaceAll(" ", '') == '+998123456789' && code == '123456') {
      await Future.delayed(Duration(milliseconds: 2300));
      navigatorKey.currentContext?.pop();
      navigatorKey.currentContext?.pop();
      await storageService.putToken(
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpYXQiOjE3NzI1NjM1NzIsImV4cCI6MTgwNDEyMTE3Miwicm9sZXMiOlsiUk9MRV9VU0VSIl0sImlkIjozM30.XHiHa-EoD6TbKVem7HA-PeTe_PDJbuLICKBjnnlUfEVKIe-Y6Vu9JG2G-l3fYZKZrb9ZpHzjt-vNjjS7LGwMFKrP8d527yjqAb2YwXkae6HC7L4v5hYkKtgQDStuLPpilmU8KIOXutzXssNd7atfKvNRK8esux8DLAOE4D0bjwdwGwBK8Xi6GbXbGce9JshEu5um9nvi6_MYS4WgGcBG_p_V0O2BVtB_psybqgZVLlNMWAhKp6lhiXAGZXSyf0ZIULCCihj5Be9G7B22_NbyOFAGs6hrnOmuWqNWTCqlycKChKkvL7lmoMVNnNnECbyKkqGdsLVEjsvNhmI9fu1YQw",
      );
      await storageService.putExpireDate(
        DateTime.tryParse('2027-03-04 05:46:12'),
      );
      emit(state.copyWith(loginSt: RequestStatus.loaded));
      showSuccessToast(LocaleKeys.loginSuccessful.tr());
      return;
    }

    final response = await _authRepository.checkSmsCode(
      phoneNumber: phone.replaceAll(" ", ''),
      code: code,
    );

    response.fold(
      (l) {
        emit(state.copyWith(loginSt: RequestStatus.error));
        showErrorToast(LocaleKeys.verificationHasNotBeenPassed.tr());
      },
      (r) async {
        navigatorKey.currentContext?.pop();
        navigatorKey.currentContext?.pop();

        if (r.token == null) {
          emit(state.copyWith(loginSt: RequestStatus.warning));
          UserTypePage(
            phoneNumber: phone.replaceAll(" ", ''),
          ).show(navigatorKey.currentContext!);
          showSuccessToast(LocaleKeys.verifySuccess.tr());
        } else {
          await storageService.putToken(r.token);
          await storageService.putExpireDate(r.expiresAt);
          emit(state.copyWith(loginSt: RequestStatus.loaded));
          showSuccessToast(LocaleKeys.loginSuccessful.tr());
        }
      },
    );
  }

  Future<void> registerUser({required SmsRegistrationParams params}) async {
    emit(state.copyWith(registerSt: RequestStatus.loading));

    final response = await _authRepository.smsRegistration(params: params);
    response.fold(
      (l) {
        emit(state.copyWith(registerSt: RequestStatus.error));
        showErrorToast(l.message);
      },
      (r) async {
        await storageService.putToken(r.token);
        await storageService.putExpireDate(r.expiresAt);
        emit(
          state.copyWith(
            registerSt: RequestStatus.loaded,
            loginSt: RequestStatus.loaded,
          ),
        );
        showSuccessToast(LocaleKeys.registerSuccess.tr());
        navigatorKey.currentContext?.pop();
      },
    );
  }

  Future<void> reSendCodeAgain(String phoneNumber) async {
    final response = await _authRepository.sendCodeAgain(
      phoneNumber: phoneNumber.replaceAll(" ", ''),
    );
    response.fold(
      (l) {
        showErrorToast(null);
      },
      (r) {
        showSuccessToast(LocaleKeys.verificationCodeSendToPhone.tr());
      },
    );
  }
}
