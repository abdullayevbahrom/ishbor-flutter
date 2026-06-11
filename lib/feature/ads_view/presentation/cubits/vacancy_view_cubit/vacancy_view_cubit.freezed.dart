// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vacancy_view_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VacancyViewState implements DiagnosticableTreeMixin {

 RequestStatus get status; RequestStatus get similarVacanciesSt; RequestStatus get applyVacancySt; RequestStatus get ownRequestSt; bool get isLoadingMore; VacancyPaginationResponse? get listSimilarVacancy; Vacancy? get vacancy; String? get vacancyId; VacancyRequest? get ownRequest;
/// Create a copy of VacancyViewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VacancyViewStateCopyWith<VacancyViewState> get copyWith => _$VacancyViewStateCopyWithImpl<VacancyViewState>(this as VacancyViewState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'VacancyViewState'))
    ..add(DiagnosticsProperty('status', status))..add(DiagnosticsProperty('similarVacanciesSt', similarVacanciesSt))..add(DiagnosticsProperty('applyVacancySt', applyVacancySt))..add(DiagnosticsProperty('ownRequestSt', ownRequestSt))..add(DiagnosticsProperty('isLoadingMore', isLoadingMore))..add(DiagnosticsProperty('listSimilarVacancy', listSimilarVacancy))..add(DiagnosticsProperty('vacancy', vacancy))..add(DiagnosticsProperty('vacancyId', vacancyId))..add(DiagnosticsProperty('ownRequest', ownRequest));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VacancyViewState&&(identical(other.status, status) || other.status == status)&&(identical(other.similarVacanciesSt, similarVacanciesSt) || other.similarVacanciesSt == similarVacanciesSt)&&(identical(other.applyVacancySt, applyVacancySt) || other.applyVacancySt == applyVacancySt)&&(identical(other.ownRequestSt, ownRequestSt) || other.ownRequestSt == ownRequestSt)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.listSimilarVacancy, listSimilarVacancy) || other.listSimilarVacancy == listSimilarVacancy)&&(identical(other.vacancy, vacancy) || other.vacancy == vacancy)&&(identical(other.vacancyId, vacancyId) || other.vacancyId == vacancyId)&&(identical(other.ownRequest, ownRequest) || other.ownRequest == ownRequest));
}


@override
int get hashCode => Object.hash(runtimeType,status,similarVacanciesSt,applyVacancySt,ownRequestSt,isLoadingMore,listSimilarVacancy,vacancy,vacancyId,ownRequest);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'VacancyViewState(status: $status, similarVacanciesSt: $similarVacanciesSt, applyVacancySt: $applyVacancySt, ownRequestSt: $ownRequestSt, isLoadingMore: $isLoadingMore, listSimilarVacancy: $listSimilarVacancy, vacancy: $vacancy, vacancyId: $vacancyId, ownRequest: $ownRequest)';
}


}

/// @nodoc
abstract mixin class $VacancyViewStateCopyWith<$Res>  {
  factory $VacancyViewStateCopyWith(VacancyViewState value, $Res Function(VacancyViewState) _then) = _$VacancyViewStateCopyWithImpl;
@useResult
$Res call({
 RequestStatus status, RequestStatus similarVacanciesSt, RequestStatus applyVacancySt, RequestStatus ownRequestSt, bool isLoadingMore, VacancyPaginationResponse? listSimilarVacancy, Vacancy? vacancy, String? vacancyId, VacancyRequest? ownRequest
});




}
/// @nodoc
class _$VacancyViewStateCopyWithImpl<$Res>
    implements $VacancyViewStateCopyWith<$Res> {
  _$VacancyViewStateCopyWithImpl(this._self, this._then);

  final VacancyViewState _self;
  final $Res Function(VacancyViewState) _then;

/// Create a copy of VacancyViewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? similarVacanciesSt = null,Object? applyVacancySt = null,Object? ownRequestSt = null,Object? isLoadingMore = null,Object? listSimilarVacancy = freezed,Object? vacancy = freezed,Object? vacancyId = freezed,Object? ownRequest = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,similarVacanciesSt: null == similarVacanciesSt ? _self.similarVacanciesSt : similarVacanciesSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,applyVacancySt: null == applyVacancySt ? _self.applyVacancySt : applyVacancySt // ignore: cast_nullable_to_non_nullable
as RequestStatus,ownRequestSt: null == ownRequestSt ? _self.ownRequestSt : ownRequestSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,listSimilarVacancy: freezed == listSimilarVacancy ? _self.listSimilarVacancy : listSimilarVacancy // ignore: cast_nullable_to_non_nullable
as VacancyPaginationResponse?,vacancy: freezed == vacancy ? _self.vacancy : vacancy // ignore: cast_nullable_to_non_nullable
as Vacancy?,vacancyId: freezed == vacancyId ? _self.vacancyId : vacancyId // ignore: cast_nullable_to_non_nullable
as String?,ownRequest: freezed == ownRequest ? _self.ownRequest : ownRequest // ignore: cast_nullable_to_non_nullable
as VacancyRequest?,
  ));
}

}


/// Adds pattern-matching-related methods to [VacancyViewState].
extension VacancyViewStatePatterns on VacancyViewState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VacancyViewState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VacancyViewState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VacancyViewState value)  $default,){
final _that = this;
switch (_that) {
case _VacancyViewState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VacancyViewState value)?  $default,){
final _that = this;
switch (_that) {
case _VacancyViewState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestStatus status,  RequestStatus similarVacanciesSt,  RequestStatus applyVacancySt,  RequestStatus ownRequestSt,  bool isLoadingMore,  VacancyPaginationResponse? listSimilarVacancy,  Vacancy? vacancy,  String? vacancyId,  VacancyRequest? ownRequest)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VacancyViewState() when $default != null:
return $default(_that.status,_that.similarVacanciesSt,_that.applyVacancySt,_that.ownRequestSt,_that.isLoadingMore,_that.listSimilarVacancy,_that.vacancy,_that.vacancyId,_that.ownRequest);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestStatus status,  RequestStatus similarVacanciesSt,  RequestStatus applyVacancySt,  RequestStatus ownRequestSt,  bool isLoadingMore,  VacancyPaginationResponse? listSimilarVacancy,  Vacancy? vacancy,  String? vacancyId,  VacancyRequest? ownRequest)  $default,) {final _that = this;
switch (_that) {
case _VacancyViewState():
return $default(_that.status,_that.similarVacanciesSt,_that.applyVacancySt,_that.ownRequestSt,_that.isLoadingMore,_that.listSimilarVacancy,_that.vacancy,_that.vacancyId,_that.ownRequest);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestStatus status,  RequestStatus similarVacanciesSt,  RequestStatus applyVacancySt,  RequestStatus ownRequestSt,  bool isLoadingMore,  VacancyPaginationResponse? listSimilarVacancy,  Vacancy? vacancy,  String? vacancyId,  VacancyRequest? ownRequest)?  $default,) {final _that = this;
switch (_that) {
case _VacancyViewState() when $default != null:
return $default(_that.status,_that.similarVacanciesSt,_that.applyVacancySt,_that.ownRequestSt,_that.isLoadingMore,_that.listSimilarVacancy,_that.vacancy,_that.vacancyId,_that.ownRequest);case _:
  return null;

}
}

}

/// @nodoc


class _VacancyViewState with DiagnosticableTreeMixin implements VacancyViewState {
  const _VacancyViewState({this.status = RequestStatus.initial, this.similarVacanciesSt = RequestStatus.initial, this.applyVacancySt = RequestStatus.initial, this.ownRequestSt = RequestStatus.initial, this.isLoadingMore = false, this.listSimilarVacancy = null, this.vacancy = null, this.vacancyId = null, this.ownRequest = null});
  

@override@JsonKey() final  RequestStatus status;
@override@JsonKey() final  RequestStatus similarVacanciesSt;
@override@JsonKey() final  RequestStatus applyVacancySt;
@override@JsonKey() final  RequestStatus ownRequestSt;
@override@JsonKey() final  bool isLoadingMore;
@override@JsonKey() final  VacancyPaginationResponse? listSimilarVacancy;
@override@JsonKey() final  Vacancy? vacancy;
@override@JsonKey() final  String? vacancyId;
@override@JsonKey() final  VacancyRequest? ownRequest;

/// Create a copy of VacancyViewState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VacancyViewStateCopyWith<_VacancyViewState> get copyWith => __$VacancyViewStateCopyWithImpl<_VacancyViewState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'VacancyViewState'))
    ..add(DiagnosticsProperty('status', status))..add(DiagnosticsProperty('similarVacanciesSt', similarVacanciesSt))..add(DiagnosticsProperty('applyVacancySt', applyVacancySt))..add(DiagnosticsProperty('ownRequestSt', ownRequestSt))..add(DiagnosticsProperty('isLoadingMore', isLoadingMore))..add(DiagnosticsProperty('listSimilarVacancy', listSimilarVacancy))..add(DiagnosticsProperty('vacancy', vacancy))..add(DiagnosticsProperty('vacancyId', vacancyId))..add(DiagnosticsProperty('ownRequest', ownRequest));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VacancyViewState&&(identical(other.status, status) || other.status == status)&&(identical(other.similarVacanciesSt, similarVacanciesSt) || other.similarVacanciesSt == similarVacanciesSt)&&(identical(other.applyVacancySt, applyVacancySt) || other.applyVacancySt == applyVacancySt)&&(identical(other.ownRequestSt, ownRequestSt) || other.ownRequestSt == ownRequestSt)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.listSimilarVacancy, listSimilarVacancy) || other.listSimilarVacancy == listSimilarVacancy)&&(identical(other.vacancy, vacancy) || other.vacancy == vacancy)&&(identical(other.vacancyId, vacancyId) || other.vacancyId == vacancyId)&&(identical(other.ownRequest, ownRequest) || other.ownRequest == ownRequest));
}


@override
int get hashCode => Object.hash(runtimeType,status,similarVacanciesSt,applyVacancySt,ownRequestSt,isLoadingMore,listSimilarVacancy,vacancy,vacancyId,ownRequest);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'VacancyViewState(status: $status, similarVacanciesSt: $similarVacanciesSt, applyVacancySt: $applyVacancySt, ownRequestSt: $ownRequestSt, isLoadingMore: $isLoadingMore, listSimilarVacancy: $listSimilarVacancy, vacancy: $vacancy, vacancyId: $vacancyId, ownRequest: $ownRequest)';
}


}

/// @nodoc
abstract mixin class _$VacancyViewStateCopyWith<$Res> implements $VacancyViewStateCopyWith<$Res> {
  factory _$VacancyViewStateCopyWith(_VacancyViewState value, $Res Function(_VacancyViewState) _then) = __$VacancyViewStateCopyWithImpl;
@override @useResult
$Res call({
 RequestStatus status, RequestStatus similarVacanciesSt, RequestStatus applyVacancySt, RequestStatus ownRequestSt, bool isLoadingMore, VacancyPaginationResponse? listSimilarVacancy, Vacancy? vacancy, String? vacancyId, VacancyRequest? ownRequest
});




}
/// @nodoc
class __$VacancyViewStateCopyWithImpl<$Res>
    implements _$VacancyViewStateCopyWith<$Res> {
  __$VacancyViewStateCopyWithImpl(this._self, this._then);

  final _VacancyViewState _self;
  final $Res Function(_VacancyViewState) _then;

/// Create a copy of VacancyViewState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? similarVacanciesSt = null,Object? applyVacancySt = null,Object? ownRequestSt = null,Object? isLoadingMore = null,Object? listSimilarVacancy = freezed,Object? vacancy = freezed,Object? vacancyId = freezed,Object? ownRequest = freezed,}) {
  return _then(_VacancyViewState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,similarVacanciesSt: null == similarVacanciesSt ? _self.similarVacanciesSt : similarVacanciesSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,applyVacancySt: null == applyVacancySt ? _self.applyVacancySt : applyVacancySt // ignore: cast_nullable_to_non_nullable
as RequestStatus,ownRequestSt: null == ownRequestSt ? _self.ownRequestSt : ownRequestSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,listSimilarVacancy: freezed == listSimilarVacancy ? _self.listSimilarVacancy : listSimilarVacancy // ignore: cast_nullable_to_non_nullable
as VacancyPaginationResponse?,vacancy: freezed == vacancy ? _self.vacancy : vacancy // ignore: cast_nullable_to_non_nullable
as Vacancy?,vacancyId: freezed == vacancyId ? _self.vacancyId : vacancyId // ignore: cast_nullable_to_non_nullable
as String?,ownRequest: freezed == ownRequest ? _self.ownRequest : ownRequest // ignore: cast_nullable_to_non_nullable
as VacancyRequest?,
  ));
}


}

// dart format on
