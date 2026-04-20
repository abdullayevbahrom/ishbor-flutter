// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthState {

 RequestStatus get status; RequestStatus get registerSt; RequestStatus get logOutSt; RequestStatus get verifyPhoneSt; RequestStatus get loginSt; RequestStatus get resendSt; String? get errorText; String? get validateError; String? get type;
/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthStateCopyWith<AuthState> get copyWith => _$AuthStateCopyWithImpl<AuthState>(this as AuthState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthState&&(identical(other.status, status) || other.status == status)&&(identical(other.registerSt, registerSt) || other.registerSt == registerSt)&&(identical(other.logOutSt, logOutSt) || other.logOutSt == logOutSt)&&(identical(other.verifyPhoneSt, verifyPhoneSt) || other.verifyPhoneSt == verifyPhoneSt)&&(identical(other.loginSt, loginSt) || other.loginSt == loginSt)&&(identical(other.resendSt, resendSt) || other.resendSt == resendSt)&&(identical(other.errorText, errorText) || other.errorText == errorText)&&(identical(other.validateError, validateError) || other.validateError == validateError)&&(identical(other.type, type) || other.type == type));
}


@override
int get hashCode => Object.hash(runtimeType,status,registerSt,logOutSt,verifyPhoneSt,loginSt,resendSt,errorText,validateError,type);

@override
String toString() {
  return 'AuthState(status: $status, registerSt: $registerSt, logOutSt: $logOutSt, verifyPhoneSt: $verifyPhoneSt, loginSt: $loginSt, resendSt: $resendSt, errorText: $errorText, validateError: $validateError, type: $type)';
}


}

/// @nodoc
abstract mixin class $AuthStateCopyWith<$Res>  {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) _then) = _$AuthStateCopyWithImpl;
@useResult
$Res call({
 RequestStatus status, RequestStatus registerSt, RequestStatus logOutSt, RequestStatus verifyPhoneSt, RequestStatus loginSt, RequestStatus resendSt, String? errorText, String? validateError, String? type
});




}
/// @nodoc
class _$AuthStateCopyWithImpl<$Res>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._self, this._then);

  final AuthState _self;
  final $Res Function(AuthState) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? registerSt = null,Object? logOutSt = null,Object? verifyPhoneSt = null,Object? loginSt = null,Object? resendSt = null,Object? errorText = freezed,Object? validateError = freezed,Object? type = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,registerSt: null == registerSt ? _self.registerSt : registerSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,logOutSt: null == logOutSt ? _self.logOutSt : logOutSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,verifyPhoneSt: null == verifyPhoneSt ? _self.verifyPhoneSt : verifyPhoneSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,loginSt: null == loginSt ? _self.loginSt : loginSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,resendSt: null == resendSt ? _self.resendSt : resendSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,errorText: freezed == errorText ? _self.errorText : errorText // ignore: cast_nullable_to_non_nullable
as String?,validateError: freezed == validateError ? _self.validateError : validateError // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AuthState].
extension AuthStatePatterns on AuthState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthState value)  $default,){
final _that = this;
switch (_that) {
case _AuthState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthState value)?  $default,){
final _that = this;
switch (_that) {
case _AuthState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestStatus status,  RequestStatus registerSt,  RequestStatus logOutSt,  RequestStatus verifyPhoneSt,  RequestStatus loginSt,  RequestStatus resendSt,  String? errorText,  String? validateError,  String? type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthState() when $default != null:
return $default(_that.status,_that.registerSt,_that.logOutSt,_that.verifyPhoneSt,_that.loginSt,_that.resendSt,_that.errorText,_that.validateError,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestStatus status,  RequestStatus registerSt,  RequestStatus logOutSt,  RequestStatus verifyPhoneSt,  RequestStatus loginSt,  RequestStatus resendSt,  String? errorText,  String? validateError,  String? type)  $default,) {final _that = this;
switch (_that) {
case _AuthState():
return $default(_that.status,_that.registerSt,_that.logOutSt,_that.verifyPhoneSt,_that.loginSt,_that.resendSt,_that.errorText,_that.validateError,_that.type);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestStatus status,  RequestStatus registerSt,  RequestStatus logOutSt,  RequestStatus verifyPhoneSt,  RequestStatus loginSt,  RequestStatus resendSt,  String? errorText,  String? validateError,  String? type)?  $default,) {final _that = this;
switch (_that) {
case _AuthState() when $default != null:
return $default(_that.status,_that.registerSt,_that.logOutSt,_that.verifyPhoneSt,_that.loginSt,_that.resendSt,_that.errorText,_that.validateError,_that.type);case _:
  return null;

}
}

}

/// @nodoc


class _AuthState implements AuthState {
  const _AuthState({this.status = RequestStatus.initial, this.registerSt = RequestStatus.initial, this.logOutSt = RequestStatus.initial, this.verifyPhoneSt = RequestStatus.initial, this.loginSt = RequestStatus.initial, this.resendSt = RequestStatus.initial, this.errorText = null, this.validateError = null, this.type = null});
  

@override@JsonKey() final  RequestStatus status;
@override@JsonKey() final  RequestStatus registerSt;
@override@JsonKey() final  RequestStatus logOutSt;
@override@JsonKey() final  RequestStatus verifyPhoneSt;
@override@JsonKey() final  RequestStatus loginSt;
@override@JsonKey() final  RequestStatus resendSt;
@override@JsonKey() final  String? errorText;
@override@JsonKey() final  String? validateError;
@override@JsonKey() final  String? type;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthStateCopyWith<_AuthState> get copyWith => __$AuthStateCopyWithImpl<_AuthState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthState&&(identical(other.status, status) || other.status == status)&&(identical(other.registerSt, registerSt) || other.registerSt == registerSt)&&(identical(other.logOutSt, logOutSt) || other.logOutSt == logOutSt)&&(identical(other.verifyPhoneSt, verifyPhoneSt) || other.verifyPhoneSt == verifyPhoneSt)&&(identical(other.loginSt, loginSt) || other.loginSt == loginSt)&&(identical(other.resendSt, resendSt) || other.resendSt == resendSt)&&(identical(other.errorText, errorText) || other.errorText == errorText)&&(identical(other.validateError, validateError) || other.validateError == validateError)&&(identical(other.type, type) || other.type == type));
}


@override
int get hashCode => Object.hash(runtimeType,status,registerSt,logOutSt,verifyPhoneSt,loginSt,resendSt,errorText,validateError,type);

@override
String toString() {
  return 'AuthState(status: $status, registerSt: $registerSt, logOutSt: $logOutSt, verifyPhoneSt: $verifyPhoneSt, loginSt: $loginSt, resendSt: $resendSt, errorText: $errorText, validateError: $validateError, type: $type)';
}


}

/// @nodoc
abstract mixin class _$AuthStateCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$AuthStateCopyWith(_AuthState value, $Res Function(_AuthState) _then) = __$AuthStateCopyWithImpl;
@override @useResult
$Res call({
 RequestStatus status, RequestStatus registerSt, RequestStatus logOutSt, RequestStatus verifyPhoneSt, RequestStatus loginSt, RequestStatus resendSt, String? errorText, String? validateError, String? type
});




}
/// @nodoc
class __$AuthStateCopyWithImpl<$Res>
    implements _$AuthStateCopyWith<$Res> {
  __$AuthStateCopyWithImpl(this._self, this._then);

  final _AuthState _self;
  final $Res Function(_AuthState) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? registerSt = null,Object? logOutSt = null,Object? verifyPhoneSt = null,Object? loginSt = null,Object? resendSt = null,Object? errorText = freezed,Object? validateError = freezed,Object? type = freezed,}) {
  return _then(_AuthState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,registerSt: null == registerSt ? _self.registerSt : registerSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,logOutSt: null == logOutSt ? _self.logOutSt : logOutSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,verifyPhoneSt: null == verifyPhoneSt ? _self.verifyPhoneSt : verifyPhoneSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,loginSt: null == loginSt ? _self.loginSt : loginSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,resendSt: null == resendSt ? _self.resendSt : resendSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,errorText: freezed == errorText ? _self.errorText : errorText // ignore: cast_nullable_to_non_nullable
as String?,validateError: freezed == validateError ? _self.validateError : validateError // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
