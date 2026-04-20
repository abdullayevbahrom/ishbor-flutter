// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vacancy_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VacancyState {

 RequestStatus get status; RequestStatus get similarVacSt; String? get errorText;//@Default(null) VacancyPaginationResponse? listVacancy,
 VacancyPaginationResponse? get listSimilarVacancy; PaginationResponse<NewVacancyModel>? get newVacancies; bool get isLoadingMore;
/// Create a copy of VacancyState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VacancyStateCopyWith<VacancyState> get copyWith => _$VacancyStateCopyWithImpl<VacancyState>(this as VacancyState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VacancyState&&(identical(other.status, status) || other.status == status)&&(identical(other.similarVacSt, similarVacSt) || other.similarVacSt == similarVacSt)&&(identical(other.errorText, errorText) || other.errorText == errorText)&&(identical(other.listSimilarVacancy, listSimilarVacancy) || other.listSimilarVacancy == listSimilarVacancy)&&(identical(other.newVacancies, newVacancies) || other.newVacancies == newVacancies)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore));
}


@override
int get hashCode => Object.hash(runtimeType,status,similarVacSt,errorText,listSimilarVacancy,newVacancies,isLoadingMore);

@override
String toString() {
  return 'VacancyState(status: $status, similarVacSt: $similarVacSt, errorText: $errorText, listSimilarVacancy: $listSimilarVacancy, newVacancies: $newVacancies, isLoadingMore: $isLoadingMore)';
}


}

/// @nodoc
abstract mixin class $VacancyStateCopyWith<$Res>  {
  factory $VacancyStateCopyWith(VacancyState value, $Res Function(VacancyState) _then) = _$VacancyStateCopyWithImpl;
@useResult
$Res call({
 RequestStatus status, RequestStatus similarVacSt, String? errorText, VacancyPaginationResponse? listSimilarVacancy, PaginationResponse<NewVacancyModel>? newVacancies, bool isLoadingMore
});




}
/// @nodoc
class _$VacancyStateCopyWithImpl<$Res>
    implements $VacancyStateCopyWith<$Res> {
  _$VacancyStateCopyWithImpl(this._self, this._then);

  final VacancyState _self;
  final $Res Function(VacancyState) _then;

/// Create a copy of VacancyState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? similarVacSt = null,Object? errorText = freezed,Object? listSimilarVacancy = freezed,Object? newVacancies = freezed,Object? isLoadingMore = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,similarVacSt: null == similarVacSt ? _self.similarVacSt : similarVacSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,errorText: freezed == errorText ? _self.errorText : errorText // ignore: cast_nullable_to_non_nullable
as String?,listSimilarVacancy: freezed == listSimilarVacancy ? _self.listSimilarVacancy : listSimilarVacancy // ignore: cast_nullable_to_non_nullable
as VacancyPaginationResponse?,newVacancies: freezed == newVacancies ? _self.newVacancies : newVacancies // ignore: cast_nullable_to_non_nullable
as PaginationResponse<NewVacancyModel>?,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [VacancyState].
extension VacancyStatePatterns on VacancyState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VacancyState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VacancyState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VacancyState value)  $default,){
final _that = this;
switch (_that) {
case _VacancyState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VacancyState value)?  $default,){
final _that = this;
switch (_that) {
case _VacancyState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestStatus status,  RequestStatus similarVacSt,  String? errorText,  VacancyPaginationResponse? listSimilarVacancy,  PaginationResponse<NewVacancyModel>? newVacancies,  bool isLoadingMore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VacancyState() when $default != null:
return $default(_that.status,_that.similarVacSt,_that.errorText,_that.listSimilarVacancy,_that.newVacancies,_that.isLoadingMore);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestStatus status,  RequestStatus similarVacSt,  String? errorText,  VacancyPaginationResponse? listSimilarVacancy,  PaginationResponse<NewVacancyModel>? newVacancies,  bool isLoadingMore)  $default,) {final _that = this;
switch (_that) {
case _VacancyState():
return $default(_that.status,_that.similarVacSt,_that.errorText,_that.listSimilarVacancy,_that.newVacancies,_that.isLoadingMore);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestStatus status,  RequestStatus similarVacSt,  String? errorText,  VacancyPaginationResponse? listSimilarVacancy,  PaginationResponse<NewVacancyModel>? newVacancies,  bool isLoadingMore)?  $default,) {final _that = this;
switch (_that) {
case _VacancyState() when $default != null:
return $default(_that.status,_that.similarVacSt,_that.errorText,_that.listSimilarVacancy,_that.newVacancies,_that.isLoadingMore);case _:
  return null;

}
}

}

/// @nodoc


class _VacancyState implements VacancyState {
  const _VacancyState({this.status = RequestStatus.initial, this.similarVacSt = RequestStatus.initial, this.errorText = null, this.listSimilarVacancy = null, this.newVacancies = null, this.isLoadingMore = false});
  

@override@JsonKey() final  RequestStatus status;
@override@JsonKey() final  RequestStatus similarVacSt;
@override@JsonKey() final  String? errorText;
//@Default(null) VacancyPaginationResponse? listVacancy,
@override@JsonKey() final  VacancyPaginationResponse? listSimilarVacancy;
@override@JsonKey() final  PaginationResponse<NewVacancyModel>? newVacancies;
@override@JsonKey() final  bool isLoadingMore;

/// Create a copy of VacancyState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VacancyStateCopyWith<_VacancyState> get copyWith => __$VacancyStateCopyWithImpl<_VacancyState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VacancyState&&(identical(other.status, status) || other.status == status)&&(identical(other.similarVacSt, similarVacSt) || other.similarVacSt == similarVacSt)&&(identical(other.errorText, errorText) || other.errorText == errorText)&&(identical(other.listSimilarVacancy, listSimilarVacancy) || other.listSimilarVacancy == listSimilarVacancy)&&(identical(other.newVacancies, newVacancies) || other.newVacancies == newVacancies)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore));
}


@override
int get hashCode => Object.hash(runtimeType,status,similarVacSt,errorText,listSimilarVacancy,newVacancies,isLoadingMore);

@override
String toString() {
  return 'VacancyState(status: $status, similarVacSt: $similarVacSt, errorText: $errorText, listSimilarVacancy: $listSimilarVacancy, newVacancies: $newVacancies, isLoadingMore: $isLoadingMore)';
}


}

/// @nodoc
abstract mixin class _$VacancyStateCopyWith<$Res> implements $VacancyStateCopyWith<$Res> {
  factory _$VacancyStateCopyWith(_VacancyState value, $Res Function(_VacancyState) _then) = __$VacancyStateCopyWithImpl;
@override @useResult
$Res call({
 RequestStatus status, RequestStatus similarVacSt, String? errorText, VacancyPaginationResponse? listSimilarVacancy, PaginationResponse<NewVacancyModel>? newVacancies, bool isLoadingMore
});




}
/// @nodoc
class __$VacancyStateCopyWithImpl<$Res>
    implements _$VacancyStateCopyWith<$Res> {
  __$VacancyStateCopyWithImpl(this._self, this._then);

  final _VacancyState _self;
  final $Res Function(_VacancyState) _then;

/// Create a copy of VacancyState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? similarVacSt = null,Object? errorText = freezed,Object? listSimilarVacancy = freezed,Object? newVacancies = freezed,Object? isLoadingMore = null,}) {
  return _then(_VacancyState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,similarVacSt: null == similarVacSt ? _self.similarVacSt : similarVacSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,errorText: freezed == errorText ? _self.errorText : errorText // ignore: cast_nullable_to_non_nullable
as String?,listSimilarVacancy: freezed == listSimilarVacancy ? _self.listSimilarVacancy : listSimilarVacancy // ignore: cast_nullable_to_non_nullable
as VacancyPaginationResponse?,newVacancies: freezed == newVacancies ? _self.newVacancies : newVacancies // ignore: cast_nullable_to_non_nullable
as PaginationResponse<NewVacancyModel>?,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
