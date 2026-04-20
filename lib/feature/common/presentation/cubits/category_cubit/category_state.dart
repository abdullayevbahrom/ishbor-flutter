part of 'category_cubit.dart';

@freezed
abstract class CategoryState with _$CategoryState {
  const factory CategoryState({
    @Default(RequestStatus.initial) RequestStatus status,
    @Default(null) CategoryListResponse? categories,
    @Default(null) String? errorText,
    @Default(false) bool isLoadingMore
  }) = _CategoryState;
}
