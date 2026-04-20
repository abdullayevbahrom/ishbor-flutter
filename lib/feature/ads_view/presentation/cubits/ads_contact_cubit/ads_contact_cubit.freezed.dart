// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ads_contact_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AdsContactState {

 RequestStatus get status; AdsContactModel? get contact; int get countOfPhoneReq;
/// Create a copy of AdsContactState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdsContactStateCopyWith<AdsContactState> get copyWith => _$AdsContactStateCopyWithImpl<AdsContactState>(this as AdsContactState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdsContactState&&(identical(other.status, status) || other.status == status)&&(identical(other.contact, contact) || other.contact == contact)&&(identical(other.countOfPhoneReq, countOfPhoneReq) || other.countOfPhoneReq == countOfPhoneReq));
}


@override
int get hashCode => Object.hash(runtimeType,status,contact,countOfPhoneReq);

@override
String toString() {
  return 'AdsContactState(status: $status, contact: $contact, countOfPhoneReq: $countOfPhoneReq)';
}


}

/// @nodoc
abstract mixin class $AdsContactStateCopyWith<$Res>  {
  factory $AdsContactStateCopyWith(AdsContactState value, $Res Function(AdsContactState) _then) = _$AdsContactStateCopyWithImpl;
@useResult
$Res call({
 RequestStatus status, AdsContactModel? contact, int countOfPhoneReq
});




}
/// @nodoc
class _$AdsContactStateCopyWithImpl<$Res>
    implements $AdsContactStateCopyWith<$Res> {
  _$AdsContactStateCopyWithImpl(this._self, this._then);

  final AdsContactState _self;
  final $Res Function(AdsContactState) _then;

/// Create a copy of AdsContactState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? contact = freezed,Object? countOfPhoneReq = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,contact: freezed == contact ? _self.contact : contact // ignore: cast_nullable_to_non_nullable
as AdsContactModel?,countOfPhoneReq: null == countOfPhoneReq ? _self.countOfPhoneReq : countOfPhoneReq // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AdsContactState].
extension AdsContactStatePatterns on AdsContactState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdsContactState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdsContactState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdsContactState value)  $default,){
final _that = this;
switch (_that) {
case _AdsContactState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdsContactState value)?  $default,){
final _that = this;
switch (_that) {
case _AdsContactState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestStatus status,  AdsContactModel? contact,  int countOfPhoneReq)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdsContactState() when $default != null:
return $default(_that.status,_that.contact,_that.countOfPhoneReq);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestStatus status,  AdsContactModel? contact,  int countOfPhoneReq)  $default,) {final _that = this;
switch (_that) {
case _AdsContactState():
return $default(_that.status,_that.contact,_that.countOfPhoneReq);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestStatus status,  AdsContactModel? contact,  int countOfPhoneReq)?  $default,) {final _that = this;
switch (_that) {
case _AdsContactState() when $default != null:
return $default(_that.status,_that.contact,_that.countOfPhoneReq);case _:
  return null;

}
}

}

/// @nodoc


class _AdsContactState implements AdsContactState {
  const _AdsContactState({this.status = RequestStatus.initial, this.contact = null, this.countOfPhoneReq = 0});
  

@override@JsonKey() final  RequestStatus status;
@override@JsonKey() final  AdsContactModel? contact;
@override@JsonKey() final  int countOfPhoneReq;

/// Create a copy of AdsContactState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdsContactStateCopyWith<_AdsContactState> get copyWith => __$AdsContactStateCopyWithImpl<_AdsContactState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdsContactState&&(identical(other.status, status) || other.status == status)&&(identical(other.contact, contact) || other.contact == contact)&&(identical(other.countOfPhoneReq, countOfPhoneReq) || other.countOfPhoneReq == countOfPhoneReq));
}


@override
int get hashCode => Object.hash(runtimeType,status,contact,countOfPhoneReq);

@override
String toString() {
  return 'AdsContactState(status: $status, contact: $contact, countOfPhoneReq: $countOfPhoneReq)';
}


}

/// @nodoc
abstract mixin class _$AdsContactStateCopyWith<$Res> implements $AdsContactStateCopyWith<$Res> {
  factory _$AdsContactStateCopyWith(_AdsContactState value, $Res Function(_AdsContactState) _then) = __$AdsContactStateCopyWithImpl;
@override @useResult
$Res call({
 RequestStatus status, AdsContactModel? contact, int countOfPhoneReq
});




}
/// @nodoc
class __$AdsContactStateCopyWithImpl<$Res>
    implements _$AdsContactStateCopyWith<$Res> {
  __$AdsContactStateCopyWithImpl(this._self, this._then);

  final _AdsContactState _self;
  final $Res Function(_AdsContactState) _then;

/// Create a copy of AdsContactState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? contact = freezed,Object? countOfPhoneReq = null,}) {
  return _then(_AdsContactState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,contact: freezed == contact ? _self.contact : contact // ignore: cast_nullable_to_non_nullable
as AdsContactModel?,countOfPhoneReq: null == countOfPhoneReq ? _self.countOfPhoneReq : countOfPhoneReq // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
