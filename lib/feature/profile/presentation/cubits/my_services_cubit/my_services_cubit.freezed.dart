// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_services_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MyServicesState {

 RequestStatus get myServicesSt; RequestStatus get myServicesAppliesSt; RequestStatus get liftUpSt; RequestStatus get deleteSt; bool get isLadingMore1; bool get isLadingMore2; RequestStatus get deactivateSt; PaginatedServiceResponse? get myServices; PaginatedServiceResponse? get myServicesApplies; String? get errorText;
/// Create a copy of MyServicesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MyServicesStateCopyWith<MyServicesState> get copyWith => _$MyServicesStateCopyWithImpl<MyServicesState>(this as MyServicesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyServicesState&&(identical(other.myServicesSt, myServicesSt) || other.myServicesSt == myServicesSt)&&(identical(other.myServicesAppliesSt, myServicesAppliesSt) || other.myServicesAppliesSt == myServicesAppliesSt)&&(identical(other.liftUpSt, liftUpSt) || other.liftUpSt == liftUpSt)&&(identical(other.deleteSt, deleteSt) || other.deleteSt == deleteSt)&&(identical(other.isLadingMore1, isLadingMore1) || other.isLadingMore1 == isLadingMore1)&&(identical(other.isLadingMore2, isLadingMore2) || other.isLadingMore2 == isLadingMore2)&&(identical(other.deactivateSt, deactivateSt) || other.deactivateSt == deactivateSt)&&(identical(other.myServices, myServices) || other.myServices == myServices)&&(identical(other.myServicesApplies, myServicesApplies) || other.myServicesApplies == myServicesApplies)&&(identical(other.errorText, errorText) || other.errorText == errorText));
}


@override
int get hashCode => Object.hash(runtimeType,myServicesSt,myServicesAppliesSt,liftUpSt,deleteSt,isLadingMore1,isLadingMore2,deactivateSt,myServices,myServicesApplies,errorText);

@override
String toString() {
  return 'MyServicesState(myServicesSt: $myServicesSt, myServicesAppliesSt: $myServicesAppliesSt, liftUpSt: $liftUpSt, deleteSt: $deleteSt, isLadingMore1: $isLadingMore1, isLadingMore2: $isLadingMore2, deactivateSt: $deactivateSt, myServices: $myServices, myServicesApplies: $myServicesApplies, errorText: $errorText)';
}


}

/// @nodoc
abstract mixin class $MyServicesStateCopyWith<$Res>  {
  factory $MyServicesStateCopyWith(MyServicesState value, $Res Function(MyServicesState) _then) = _$MyServicesStateCopyWithImpl;
@useResult
$Res call({
 RequestStatus myServicesSt, RequestStatus myServicesAppliesSt, RequestStatus liftUpSt, RequestStatus deleteSt, bool isLadingMore1, bool isLadingMore2, RequestStatus deactivateSt, PaginatedServiceResponse? myServices, PaginatedServiceResponse? myServicesApplies, String? errorText
});




}
/// @nodoc
class _$MyServicesStateCopyWithImpl<$Res>
    implements $MyServicesStateCopyWith<$Res> {
  _$MyServicesStateCopyWithImpl(this._self, this._then);

  final MyServicesState _self;
  final $Res Function(MyServicesState) _then;

/// Create a copy of MyServicesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? myServicesSt = null,Object? myServicesAppliesSt = null,Object? liftUpSt = null,Object? deleteSt = null,Object? isLadingMore1 = null,Object? isLadingMore2 = null,Object? deactivateSt = null,Object? myServices = freezed,Object? myServicesApplies = freezed,Object? errorText = freezed,}) {
  return _then(_self.copyWith(
myServicesSt: null == myServicesSt ? _self.myServicesSt : myServicesSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,myServicesAppliesSt: null == myServicesAppliesSt ? _self.myServicesAppliesSt : myServicesAppliesSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,liftUpSt: null == liftUpSt ? _self.liftUpSt : liftUpSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,deleteSt: null == deleteSt ? _self.deleteSt : deleteSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,isLadingMore1: null == isLadingMore1 ? _self.isLadingMore1 : isLadingMore1 // ignore: cast_nullable_to_non_nullable
as bool,isLadingMore2: null == isLadingMore2 ? _self.isLadingMore2 : isLadingMore2 // ignore: cast_nullable_to_non_nullable
as bool,deactivateSt: null == deactivateSt ? _self.deactivateSt : deactivateSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,myServices: freezed == myServices ? _self.myServices : myServices // ignore: cast_nullable_to_non_nullable
as PaginatedServiceResponse?,myServicesApplies: freezed == myServicesApplies ? _self.myServicesApplies : myServicesApplies // ignore: cast_nullable_to_non_nullable
as PaginatedServiceResponse?,errorText: freezed == errorText ? _self.errorText : errorText // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MyServicesState].
extension MyServicesStatePatterns on MyServicesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MyServicesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MyServicesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MyServicesState value)  $default,){
final _that = this;
switch (_that) {
case _MyServicesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MyServicesState value)?  $default,){
final _that = this;
switch (_that) {
case _MyServicesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestStatus myServicesSt,  RequestStatus myServicesAppliesSt,  RequestStatus liftUpSt,  RequestStatus deleteSt,  bool isLadingMore1,  bool isLadingMore2,  RequestStatus deactivateSt,  PaginatedServiceResponse? myServices,  PaginatedServiceResponse? myServicesApplies,  String? errorText)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MyServicesState() when $default != null:
return $default(_that.myServicesSt,_that.myServicesAppliesSt,_that.liftUpSt,_that.deleteSt,_that.isLadingMore1,_that.isLadingMore2,_that.deactivateSt,_that.myServices,_that.myServicesApplies,_that.errorText);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestStatus myServicesSt,  RequestStatus myServicesAppliesSt,  RequestStatus liftUpSt,  RequestStatus deleteSt,  bool isLadingMore1,  bool isLadingMore2,  RequestStatus deactivateSt,  PaginatedServiceResponse? myServices,  PaginatedServiceResponse? myServicesApplies,  String? errorText)  $default,) {final _that = this;
switch (_that) {
case _MyServicesState():
return $default(_that.myServicesSt,_that.myServicesAppliesSt,_that.liftUpSt,_that.deleteSt,_that.isLadingMore1,_that.isLadingMore2,_that.deactivateSt,_that.myServices,_that.myServicesApplies,_that.errorText);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestStatus myServicesSt,  RequestStatus myServicesAppliesSt,  RequestStatus liftUpSt,  RequestStatus deleteSt,  bool isLadingMore1,  bool isLadingMore2,  RequestStatus deactivateSt,  PaginatedServiceResponse? myServices,  PaginatedServiceResponse? myServicesApplies,  String? errorText)?  $default,) {final _that = this;
switch (_that) {
case _MyServicesState() when $default != null:
return $default(_that.myServicesSt,_that.myServicesAppliesSt,_that.liftUpSt,_that.deleteSt,_that.isLadingMore1,_that.isLadingMore2,_that.deactivateSt,_that.myServices,_that.myServicesApplies,_that.errorText);case _:
  return null;

}
}

}

/// @nodoc


class _MyServicesState implements MyServicesState {
  const _MyServicesState({this.myServicesSt = RequestStatus.initial, this.myServicesAppliesSt = RequestStatus.initial, this.liftUpSt = RequestStatus.initial, this.deleteSt = RequestStatus.initial, this.isLadingMore1 = false, this.isLadingMore2 = false, this.deactivateSt = RequestStatus.initial, this.myServices = null, this.myServicesApplies = null, this.errorText = null});
  

@override@JsonKey() final  RequestStatus myServicesSt;
@override@JsonKey() final  RequestStatus myServicesAppliesSt;
@override@JsonKey() final  RequestStatus liftUpSt;
@override@JsonKey() final  RequestStatus deleteSt;
@override@JsonKey() final  bool isLadingMore1;
@override@JsonKey() final  bool isLadingMore2;
@override@JsonKey() final  RequestStatus deactivateSt;
@override@JsonKey() final  PaginatedServiceResponse? myServices;
@override@JsonKey() final  PaginatedServiceResponse? myServicesApplies;
@override@JsonKey() final  String? errorText;

/// Create a copy of MyServicesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MyServicesStateCopyWith<_MyServicesState> get copyWith => __$MyServicesStateCopyWithImpl<_MyServicesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MyServicesState&&(identical(other.myServicesSt, myServicesSt) || other.myServicesSt == myServicesSt)&&(identical(other.myServicesAppliesSt, myServicesAppliesSt) || other.myServicesAppliesSt == myServicesAppliesSt)&&(identical(other.liftUpSt, liftUpSt) || other.liftUpSt == liftUpSt)&&(identical(other.deleteSt, deleteSt) || other.deleteSt == deleteSt)&&(identical(other.isLadingMore1, isLadingMore1) || other.isLadingMore1 == isLadingMore1)&&(identical(other.isLadingMore2, isLadingMore2) || other.isLadingMore2 == isLadingMore2)&&(identical(other.deactivateSt, deactivateSt) || other.deactivateSt == deactivateSt)&&(identical(other.myServices, myServices) || other.myServices == myServices)&&(identical(other.myServicesApplies, myServicesApplies) || other.myServicesApplies == myServicesApplies)&&(identical(other.errorText, errorText) || other.errorText == errorText));
}


@override
int get hashCode => Object.hash(runtimeType,myServicesSt,myServicesAppliesSt,liftUpSt,deleteSt,isLadingMore1,isLadingMore2,deactivateSt,myServices,myServicesApplies,errorText);

@override
String toString() {
  return 'MyServicesState(myServicesSt: $myServicesSt, myServicesAppliesSt: $myServicesAppliesSt, liftUpSt: $liftUpSt, deleteSt: $deleteSt, isLadingMore1: $isLadingMore1, isLadingMore2: $isLadingMore2, deactivateSt: $deactivateSt, myServices: $myServices, myServicesApplies: $myServicesApplies, errorText: $errorText)';
}


}

/// @nodoc
abstract mixin class _$MyServicesStateCopyWith<$Res> implements $MyServicesStateCopyWith<$Res> {
  factory _$MyServicesStateCopyWith(_MyServicesState value, $Res Function(_MyServicesState) _then) = __$MyServicesStateCopyWithImpl;
@override @useResult
$Res call({
 RequestStatus myServicesSt, RequestStatus myServicesAppliesSt, RequestStatus liftUpSt, RequestStatus deleteSt, bool isLadingMore1, bool isLadingMore2, RequestStatus deactivateSt, PaginatedServiceResponse? myServices, PaginatedServiceResponse? myServicesApplies, String? errorText
});




}
/// @nodoc
class __$MyServicesStateCopyWithImpl<$Res>
    implements _$MyServicesStateCopyWith<$Res> {
  __$MyServicesStateCopyWithImpl(this._self, this._then);

  final _MyServicesState _self;
  final $Res Function(_MyServicesState) _then;

/// Create a copy of MyServicesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? myServicesSt = null,Object? myServicesAppliesSt = null,Object? liftUpSt = null,Object? deleteSt = null,Object? isLadingMore1 = null,Object? isLadingMore2 = null,Object? deactivateSt = null,Object? myServices = freezed,Object? myServicesApplies = freezed,Object? errorText = freezed,}) {
  return _then(_MyServicesState(
myServicesSt: null == myServicesSt ? _self.myServicesSt : myServicesSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,myServicesAppliesSt: null == myServicesAppliesSt ? _self.myServicesAppliesSt : myServicesAppliesSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,liftUpSt: null == liftUpSt ? _self.liftUpSt : liftUpSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,deleteSt: null == deleteSt ? _self.deleteSt : deleteSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,isLadingMore1: null == isLadingMore1 ? _self.isLadingMore1 : isLadingMore1 // ignore: cast_nullable_to_non_nullable
as bool,isLadingMore2: null == isLadingMore2 ? _self.isLadingMore2 : isLadingMore2 // ignore: cast_nullable_to_non_nullable
as bool,deactivateSt: null == deactivateSt ? _self.deactivateSt : deactivateSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,myServices: freezed == myServices ? _self.myServices : myServices // ignore: cast_nullable_to_non_nullable
as PaginatedServiceResponse?,myServicesApplies: freezed == myServicesApplies ? _self.myServicesApplies : myServicesApplies // ignore: cast_nullable_to_non_nullable
as PaginatedServiceResponse?,errorText: freezed == errorText ? _self.errorText : errorText // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
