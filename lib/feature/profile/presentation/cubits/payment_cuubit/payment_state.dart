part of 'payment_cubit.dart';

@freezed
abstract class PaymentState with _$PaymentState {
  const factory PaymentState({
    @Default(RequestStatus.initial) RequestStatus status,
  }) = _PaymentState;
}
