// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_vacancies_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MyVacanciesState {

 RequestStatus get vacanciesSt; RequestStatus get appliedVacanciesSt; RequestStatus get liftUpSt; RequestStatus get deleteSt; RequestStatus get deactivateSt; bool get isLoadingMore1; bool get isLoadingMore2; VacancyPaginationResponse? get myVacancies; VacancyPaginationResponse? get myAppliedVacancies; String? get errorText;
/// Create a copy of MyVacanciesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MyVacanciesStateCopyWith<MyVacanciesState> get copyWith => _$MyVacanciesStateCopyWithImpl<MyVacanciesState>(this as MyVacanciesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyVacanciesState&&(identical(other.vacanciesSt, vacanciesSt) || other.vacanciesSt == vacanciesSt)&&(identical(other.appliedVacanciesSt, appliedVacanciesSt) || other.appliedVacanciesSt == appliedVacanciesSt)&&(identical(other.liftUpSt, liftUpSt) || other.liftUpSt == liftUpSt)&&(identical(other.deleteSt, deleteSt) || other.deleteSt == deleteSt)&&(identical(other.deactivateSt, deactivateSt) || other.deactivateSt == deactivateSt)&&(identical(other.isLoadingMore1, isLoadingMore1) || other.isLoadingMore1 == isLoadingMore1)&&(identical(other.isLoadingMore2, isLoadingMore2) || other.isLoadingMore2 == isLoadingMore2)&&(identical(other.myVacancies, myVacancies) || other.myVacancies == myVacancies)&&(identical(other.myAppliedVacancies, myAppliedVacancies) || other.myAppliedVacancies == myAppliedVacancies)&&(identical(other.errorText, errorText) || other.errorText == errorText));
}


@override
int get hashCode => Object.hash(runtimeType,vacanciesSt,appliedVacanciesSt,liftUpSt,deleteSt,deactivateSt,isLoadingMore1,isLoadingMore2,myVacancies,myAppliedVacancies,errorText);

@override
String toString() {
  return 'MyVacanciesState(vacanciesSt: $vacanciesSt, appliedVacanciesSt: $appliedVacanciesSt, liftUpSt: $liftUpSt, deleteSt: $deleteSt, deactivateSt: $deactivateSt, isLoadingMore1: $isLoadingMore1, isLoadingMore2: $isLoadingMore2, myVacancies: $myVacancies, myAppliedVacancies: $myAppliedVacancies, errorText: $errorText)';
}


}

/// @nodoc
abstract mixin class $MyVacanciesStateCopyWith<$Res>  {
  factory $MyVacanciesStateCopyWith(MyVacanciesState value, $Res Function(MyVacanciesState) _then) = _$MyVacanciesStateCopyWithImpl;
@useResult
$Res call({
 RequestStatus vacanciesSt, RequestStatus appliedVacanciesSt, RequestStatus liftUpSt, RequestStatus deleteSt, RequestStatus deactivateSt, bool isLoadingMore1, bool isLoadingMore2, VacancyPaginationResponse? myVacancies, VacancyPaginationResponse? myAppliedVacancies, String? errorText
});




}
/// @nodoc
class _$MyVacanciesStateCopyWithImpl<$Res>
    implements $MyVacanciesStateCopyWith<$Res> {
  _$MyVacanciesStateCopyWithImpl(this._self, this._then);

  final MyVacanciesState _self;
  final $Res Function(MyVacanciesState) _then;

/// Create a copy of MyVacanciesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? vacanciesSt = null,Object? appliedVacanciesSt = null,Object? liftUpSt = null,Object? deleteSt = null,Object? deactivateSt = null,Object? isLoadingMore1 = null,Object? isLoadingMore2 = null,Object? myVacancies = freezed,Object? myAppliedVacancies = freezed,Object? errorText = freezed,}) {
  return _then(_self.copyWith(
vacanciesSt: null == vacanciesSt ? _self.vacanciesSt : vacanciesSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,appliedVacanciesSt: null == appliedVacanciesSt ? _self.appliedVacanciesSt : appliedVacanciesSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,liftUpSt: null == liftUpSt ? _self.liftUpSt : liftUpSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,deleteSt: null == deleteSt ? _self.deleteSt : deleteSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,deactivateSt: null == deactivateSt ? _self.deactivateSt : deactivateSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,isLoadingMore1: null == isLoadingMore1 ? _self.isLoadingMore1 : isLoadingMore1 // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore2: null == isLoadingMore2 ? _self.isLoadingMore2 : isLoadingMore2 // ignore: cast_nullable_to_non_nullable
as bool,myVacancies: freezed == myVacancies ? _self.myVacancies : myVacancies // ignore: cast_nullable_to_non_nullable
as VacancyPaginationResponse?,myAppliedVacancies: freezed == myAppliedVacancies ? _self.myAppliedVacancies : myAppliedVacancies // ignore: cast_nullable_to_non_nullable
as VacancyPaginationResponse?,errorText: freezed == errorText ? _self.errorText : errorText // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MyVacanciesState].
extension MyVacanciesStatePatterns on MyVacanciesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MyVacanciesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MyVacanciesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MyVacanciesState value)  $default,){
final _that = this;
switch (_that) {
case _MyVacanciesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MyVacanciesState value)?  $default,){
final _that = this;
switch (_that) {
case _MyVacanciesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestStatus vacanciesSt,  RequestStatus appliedVacanciesSt,  RequestStatus liftUpSt,  RequestStatus deleteSt,  RequestStatus deactivateSt,  bool isLoadingMore1,  bool isLoadingMore2,  VacancyPaginationResponse? myVacancies,  VacancyPaginationResponse? myAppliedVacancies,  String? errorText)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MyVacanciesState() when $default != null:
return $default(_that.vacanciesSt,_that.appliedVacanciesSt,_that.liftUpSt,_that.deleteSt,_that.deactivateSt,_that.isLoadingMore1,_that.isLoadingMore2,_that.myVacancies,_that.myAppliedVacancies,_that.errorText);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestStatus vacanciesSt,  RequestStatus appliedVacanciesSt,  RequestStatus liftUpSt,  RequestStatus deleteSt,  RequestStatus deactivateSt,  bool isLoadingMore1,  bool isLoadingMore2,  VacancyPaginationResponse? myVacancies,  VacancyPaginationResponse? myAppliedVacancies,  String? errorText)  $default,) {final _that = this;
switch (_that) {
case _MyVacanciesState():
return $default(_that.vacanciesSt,_that.appliedVacanciesSt,_that.liftUpSt,_that.deleteSt,_that.deactivateSt,_that.isLoadingMore1,_that.isLoadingMore2,_that.myVacancies,_that.myAppliedVacancies,_that.errorText);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestStatus vacanciesSt,  RequestStatus appliedVacanciesSt,  RequestStatus liftUpSt,  RequestStatus deleteSt,  RequestStatus deactivateSt,  bool isLoadingMore1,  bool isLoadingMore2,  VacancyPaginationResponse? myVacancies,  VacancyPaginationResponse? myAppliedVacancies,  String? errorText)?  $default,) {final _that = this;
switch (_that) {
case _MyVacanciesState() when $default != null:
return $default(_that.vacanciesSt,_that.appliedVacanciesSt,_that.liftUpSt,_that.deleteSt,_that.deactivateSt,_that.isLoadingMore1,_that.isLoadingMore2,_that.myVacancies,_that.myAppliedVacancies,_that.errorText);case _:
  return null;

}
}

}

/// @nodoc


class _MyVacanciesState implements MyVacanciesState {
  const _MyVacanciesState({this.vacanciesSt = RequestStatus.initial, this.appliedVacanciesSt = RequestStatus.initial, this.liftUpSt = RequestStatus.initial, this.deleteSt = RequestStatus.initial, this.deactivateSt = RequestStatus.initial, this.isLoadingMore1 = false, this.isLoadingMore2 = false, this.myVacancies = null, this.myAppliedVacancies = null, this.errorText = null});
  

@override@JsonKey() final  RequestStatus vacanciesSt;
@override@JsonKey() final  RequestStatus appliedVacanciesSt;
@override@JsonKey() final  RequestStatus liftUpSt;
@override@JsonKey() final  RequestStatus deleteSt;
@override@JsonKey() final  RequestStatus deactivateSt;
@override@JsonKey() final  bool isLoadingMore1;
@override@JsonKey() final  bool isLoadingMore2;
@override@JsonKey() final  VacancyPaginationResponse? myVacancies;
@override@JsonKey() final  VacancyPaginationResponse? myAppliedVacancies;
@override@JsonKey() final  String? errorText;

/// Create a copy of MyVacanciesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MyVacanciesStateCopyWith<_MyVacanciesState> get copyWith => __$MyVacanciesStateCopyWithImpl<_MyVacanciesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MyVacanciesState&&(identical(other.vacanciesSt, vacanciesSt) || other.vacanciesSt == vacanciesSt)&&(identical(other.appliedVacanciesSt, appliedVacanciesSt) || other.appliedVacanciesSt == appliedVacanciesSt)&&(identical(other.liftUpSt, liftUpSt) || other.liftUpSt == liftUpSt)&&(identical(other.deleteSt, deleteSt) || other.deleteSt == deleteSt)&&(identical(other.deactivateSt, deactivateSt) || other.deactivateSt == deactivateSt)&&(identical(other.isLoadingMore1, isLoadingMore1) || other.isLoadingMore1 == isLoadingMore1)&&(identical(other.isLoadingMore2, isLoadingMore2) || other.isLoadingMore2 == isLoadingMore2)&&(identical(other.myVacancies, myVacancies) || other.myVacancies == myVacancies)&&(identical(other.myAppliedVacancies, myAppliedVacancies) || other.myAppliedVacancies == myAppliedVacancies)&&(identical(other.errorText, errorText) || other.errorText == errorText));
}


@override
int get hashCode => Object.hash(runtimeType,vacanciesSt,appliedVacanciesSt,liftUpSt,deleteSt,deactivateSt,isLoadingMore1,isLoadingMore2,myVacancies,myAppliedVacancies,errorText);

@override
String toString() {
  return 'MyVacanciesState(vacanciesSt: $vacanciesSt, appliedVacanciesSt: $appliedVacanciesSt, liftUpSt: $liftUpSt, deleteSt: $deleteSt, deactivateSt: $deactivateSt, isLoadingMore1: $isLoadingMore1, isLoadingMore2: $isLoadingMore2, myVacancies: $myVacancies, myAppliedVacancies: $myAppliedVacancies, errorText: $errorText)';
}


}

/// @nodoc
abstract mixin class _$MyVacanciesStateCopyWith<$Res> implements $MyVacanciesStateCopyWith<$Res> {
  factory _$MyVacanciesStateCopyWith(_MyVacanciesState value, $Res Function(_MyVacanciesState) _then) = __$MyVacanciesStateCopyWithImpl;
@override @useResult
$Res call({
 RequestStatus vacanciesSt, RequestStatus appliedVacanciesSt, RequestStatus liftUpSt, RequestStatus deleteSt, RequestStatus deactivateSt, bool isLoadingMore1, bool isLoadingMore2, VacancyPaginationResponse? myVacancies, VacancyPaginationResponse? myAppliedVacancies, String? errorText
});




}
/// @nodoc
class __$MyVacanciesStateCopyWithImpl<$Res>
    implements _$MyVacanciesStateCopyWith<$Res> {
  __$MyVacanciesStateCopyWithImpl(this._self, this._then);

  final _MyVacanciesState _self;
  final $Res Function(_MyVacanciesState) _then;

/// Create a copy of MyVacanciesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? vacanciesSt = null,Object? appliedVacanciesSt = null,Object? liftUpSt = null,Object? deleteSt = null,Object? deactivateSt = null,Object? isLoadingMore1 = null,Object? isLoadingMore2 = null,Object? myVacancies = freezed,Object? myAppliedVacancies = freezed,Object? errorText = freezed,}) {
  return _then(_MyVacanciesState(
vacanciesSt: null == vacanciesSt ? _self.vacanciesSt : vacanciesSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,appliedVacanciesSt: null == appliedVacanciesSt ? _self.appliedVacanciesSt : appliedVacanciesSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,liftUpSt: null == liftUpSt ? _self.liftUpSt : liftUpSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,deleteSt: null == deleteSt ? _self.deleteSt : deleteSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,deactivateSt: null == deactivateSt ? _self.deactivateSt : deactivateSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,isLoadingMore1: null == isLoadingMore1 ? _self.isLoadingMore1 : isLoadingMore1 // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore2: null == isLoadingMore2 ? _self.isLoadingMore2 : isLoadingMore2 // ignore: cast_nullable_to_non_nullable
as bool,myVacancies: freezed == myVacancies ? _self.myVacancies : myVacancies // ignore: cast_nullable_to_non_nullable
as VacancyPaginationResponse?,myAppliedVacancies: freezed == myAppliedVacancies ? _self.myAppliedVacancies : myAppliedVacancies // ignore: cast_nullable_to_non_nullable
as VacancyPaginationResponse?,errorText: freezed == errorText ? _self.errorText : errorText // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
