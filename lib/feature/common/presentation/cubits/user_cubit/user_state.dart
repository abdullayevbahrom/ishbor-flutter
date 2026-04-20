part of 'user_cubit.dart';

@freezed
abstract class UserState with _$UserState {
  const factory UserState({
    @Default(RequestStatus.initial) RequestStatus status,
    @Default(RequestStatus.initial) RequestStatus editSt,
    @Default(RequestStatus.initial) RequestStatus portfolioSt,
    @Default(RequestStatus.initial) RequestStatus verificationDocSt,
    @Default(RequestStatus.initial) RequestStatus profileAvatarSt,
    @Default(false) bool hasToken,
    @Default(null) User? user,
    @Default(null) String? errorText,
  }) = _UserState;
}
