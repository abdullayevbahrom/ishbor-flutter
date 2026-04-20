part of 'suggestions_cubit.dart';

@freezed
abstract class SuggestionsState with _$SuggestionsState {
  const factory SuggestionsState({
    @Default(RequestStatus.initial) RequestStatus status,
    @Default([]) List<String> suggestions,
    @Default(null) String? errorText,
  }) = _SuggestionsState;
}
