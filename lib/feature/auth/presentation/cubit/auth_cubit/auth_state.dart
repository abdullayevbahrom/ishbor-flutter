part of 'auth_cubit.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({
    @Default(RequestStatus.initial) RequestStatus status,
    @Default(RequestStatus.initial) RequestStatus registerSt,
    @Default(RequestStatus.initial) RequestStatus logOutSt,
    @Default(RequestStatus.initial) RequestStatus verifyPhoneSt,
    @Default(RequestStatus.initial) RequestStatus loginSt,
    @Default(RequestStatus.initial) RequestStatus resendSt,
    @Default(null) String? errorText,
   @Default(null) String? validateError,
    @Default(null) String? type
  }) = _AuthState;
}
