part of 'locale_cubit.dart';

@freezed
abstract class LocaleState with _$LocaleState {
  const factory LocaleState({
    @Default(null) Locale? locale,
  }) = _LocaleState;
}
