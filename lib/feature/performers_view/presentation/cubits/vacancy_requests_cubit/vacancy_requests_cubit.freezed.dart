// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vacancy_requests_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VacancyRequestsState implements DiagnosticableTreeMixin {

 RequestStatus get status; RequestStatus get changeStatusSt; PaginatedVacancyRequestList? get listVacancyRequest; Vacancy? get vacancy; VacancyRequest? get vacancyRequest;
/// Create a copy of VacancyRequestsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VacancyRequestsStateCopyWith<VacancyRequestsState> get copyWith => _$VacancyRequestsStateCopyWithImpl<VacancyRequestsState>(this as VacancyRequestsState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'VacancyRequestsState'))
    ..add(DiagnosticsProperty('status', status))..add(DiagnosticsProperty('changeStatusSt', changeStatusSt))..add(DiagnosticsProperty('listVacancyRequest', listVacancyRequest))..add(DiagnosticsProperty('vacancy', vacancy))..add(DiagnosticsProperty('vacancyRequest', vacancyRequest));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VacancyRequestsState&&(identical(other.status, status) || other.status == status)&&(identical(other.changeStatusSt, changeStatusSt) || other.changeStatusSt == changeStatusSt)&&(identical(other.listVacancyRequest, listVacancyRequest) || other.listVacancyRequest == listVacancyRequest)&&(identical(other.vacancy, vacancy) || other.vacancy == vacancy)&&(identical(other.vacancyRequest, vacancyRequest) || other.vacancyRequest == vacancyRequest));
}


@override
int get hashCode => Object.hash(runtimeType,status,changeStatusSt,listVacancyRequest,vacancy,vacancyRequest);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'VacancyRequestsState(status: $status, changeStatusSt: $changeStatusSt, listVacancyRequest: $listVacancyRequest, vacancy: $vacancy, vacancyRequest: $vacancyRequest)';
}


}

/// @nodoc
abstract mixin class $VacancyRequestsStateCopyWith<$Res>  {
  factory $VacancyRequestsStateCopyWith(VacancyRequestsState value, $Res Function(VacancyRequestsState) _then) = _$VacancyRequestsStateCopyWithImpl;
@useResult
$Res call({
 RequestStatus status, RequestStatus changeStatusSt, PaginatedVacancyRequestList? listVacancyRequest, Vacancy? vacancy, VacancyRequest? vacancyRequest
});




}
/// @nodoc
class _$VacancyRequestsStateCopyWithImpl<$Res>
    implements $VacancyRequestsStateCopyWith<$Res> {
  _$VacancyRequestsStateCopyWithImpl(this._self, this._then);

  final VacancyRequestsState _self;
  final $Res Function(VacancyRequestsState) _then;

/// Create a copy of VacancyRequestsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? changeStatusSt = null,Object? listVacancyRequest = freezed,Object? vacancy = freezed,Object? vacancyRequest = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,changeStatusSt: null == changeStatusSt ? _self.changeStatusSt : changeStatusSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,listVacancyRequest: freezed == listVacancyRequest ? _self.listVacancyRequest : listVacancyRequest // ignore: cast_nullable_to_non_nullable
as PaginatedVacancyRequestList?,vacancy: freezed == vacancy ? _self.vacancy : vacancy // ignore: cast_nullable_to_non_nullable
as Vacancy?,vacancyRequest: freezed == vacancyRequest ? _self.vacancyRequest : vacancyRequest // ignore: cast_nullable_to_non_nullable
as VacancyRequest?,
  ));
}

}


/// Adds pattern-matching-related methods to [VacancyRequestsState].
extension VacancyRequestsStatePatterns on VacancyRequestsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VacancyRequestsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VacancyRequestsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VacancyRequestsState value)  $default,){
final _that = this;
switch (_that) {
case _VacancyRequestsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VacancyRequestsState value)?  $default,){
final _that = this;
switch (_that) {
case _VacancyRequestsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestStatus status,  RequestStatus changeStatusSt,  PaginatedVacancyRequestList? listVacancyRequest,  Vacancy? vacancy,  VacancyRequest? vacancyRequest)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VacancyRequestsState() when $default != null:
return $default(_that.status,_that.changeStatusSt,_that.listVacancyRequest,_that.vacancy,_that.vacancyRequest);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestStatus status,  RequestStatus changeStatusSt,  PaginatedVacancyRequestList? listVacancyRequest,  Vacancy? vacancy,  VacancyRequest? vacancyRequest)  $default,) {final _that = this;
switch (_that) {
case _VacancyRequestsState():
return $default(_that.status,_that.changeStatusSt,_that.listVacancyRequest,_that.vacancy,_that.vacancyRequest);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestStatus status,  RequestStatus changeStatusSt,  PaginatedVacancyRequestList? listVacancyRequest,  Vacancy? vacancy,  VacancyRequest? vacancyRequest)?  $default,) {final _that = this;
switch (_that) {
case _VacancyRequestsState() when $default != null:
return $default(_that.status,_that.changeStatusSt,_that.listVacancyRequest,_that.vacancy,_that.vacancyRequest);case _:
  return null;

}
}

}

/// @nodoc


class _VacancyRequestsState with DiagnosticableTreeMixin implements VacancyRequestsState {
  const _VacancyRequestsState({this.status = RequestStatus.initial, this.changeStatusSt = RequestStatus.initial, this.listVacancyRequest = null, this.vacancy = null, this.vacancyRequest = null});
  

@override@JsonKey() final  RequestStatus status;
@override@JsonKey() final  RequestStatus changeStatusSt;
@override@JsonKey() final  PaginatedVacancyRequestList? listVacancyRequest;
@override@JsonKey() final  Vacancy? vacancy;
@override@JsonKey() final  VacancyRequest? vacancyRequest;

/// Create a copy of VacancyRequestsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VacancyRequestsStateCopyWith<_VacancyRequestsState> get copyWith => __$VacancyRequestsStateCopyWithImpl<_VacancyRequestsState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'VacancyRequestsState'))
    ..add(DiagnosticsProperty('status', status))..add(DiagnosticsProperty('changeStatusSt', changeStatusSt))..add(DiagnosticsProperty('listVacancyRequest', listVacancyRequest))..add(DiagnosticsProperty('vacancy', vacancy))..add(DiagnosticsProperty('vacancyRequest', vacancyRequest));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VacancyRequestsState&&(identical(other.status, status) || other.status == status)&&(identical(other.changeStatusSt, changeStatusSt) || other.changeStatusSt == changeStatusSt)&&(identical(other.listVacancyRequest, listVacancyRequest) || other.listVacancyRequest == listVacancyRequest)&&(identical(other.vacancy, vacancy) || other.vacancy == vacancy)&&(identical(other.vacancyRequest, vacancyRequest) || other.vacancyRequest == vacancyRequest));
}


@override
int get hashCode => Object.hash(runtimeType,status,changeStatusSt,listVacancyRequest,vacancy,vacancyRequest);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'VacancyRequestsState(status: $status, changeStatusSt: $changeStatusSt, listVacancyRequest: $listVacancyRequest, vacancy: $vacancy, vacancyRequest: $vacancyRequest)';
}


}

/// @nodoc
abstract mixin class _$VacancyRequestsStateCopyWith<$Res> implements $VacancyRequestsStateCopyWith<$Res> {
  factory _$VacancyRequestsStateCopyWith(_VacancyRequestsState value, $Res Function(_VacancyRequestsState) _then) = __$VacancyRequestsStateCopyWithImpl;
@override @useResult
$Res call({
 RequestStatus status, RequestStatus changeStatusSt, PaginatedVacancyRequestList? listVacancyRequest, Vacancy? vacancy, VacancyRequest? vacancyRequest
});




}
/// @nodoc
class __$VacancyRequestsStateCopyWithImpl<$Res>
    implements _$VacancyRequestsStateCopyWith<$Res> {
  __$VacancyRequestsStateCopyWithImpl(this._self, this._then);

  final _VacancyRequestsState _self;
  final $Res Function(_VacancyRequestsState) _then;

/// Create a copy of VacancyRequestsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? changeStatusSt = null,Object? listVacancyRequest = freezed,Object? vacancy = freezed,Object? vacancyRequest = freezed,}) {
  return _then(_VacancyRequestsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,changeStatusSt: null == changeStatusSt ? _self.changeStatusSt : changeStatusSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,listVacancyRequest: freezed == listVacancyRequest ? _self.listVacancyRequest : listVacancyRequest // ignore: cast_nullable_to_non_nullable
as PaginatedVacancyRequestList?,vacancy: freezed == vacancy ? _self.vacancy : vacancy // ignore: cast_nullable_to_non_nullable
as Vacancy?,vacancyRequest: freezed == vacancyRequest ? _self.vacancyRequest : vacancyRequest // ignore: cast_nullable_to_non_nullable
as VacancyRequest?,
  ));
}


}

// dart format on
