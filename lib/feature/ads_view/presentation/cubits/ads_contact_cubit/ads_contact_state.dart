part of 'ads_contact_cubit.dart';

@freezed
abstract class AdsContactState with _$AdsContactState {
  const factory AdsContactState({
    @Default(RequestStatus.initial) RequestStatus status,
    @Default(null) AdsContactModel? contact,
    @Default(0) int countOfPhoneReq,
  }) = _AdsContactState;
}
