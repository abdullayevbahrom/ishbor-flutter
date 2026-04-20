part of 'main_cubit.dart';

@freezed
abstract class MainState with _$MainState {
  const factory MainState({
    @Default(0) int currentIndex,
    @Default(false) bool isOpen,
    @Default(false) bool isNotificationMenuOpen,
  }) = _MainState;
}
