// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserState {

 RequestStatus get status; RequestStatus get editSt; RequestStatus get portfolioSt; RequestStatus get verificationDocSt; RequestStatus get profileAvatarSt; bool get hasToken; User? get user; String? get errorText;
/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserStateCopyWith<UserState> get copyWith => _$UserStateCopyWithImpl<UserState>(this as UserState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserState&&(identical(other.status, status) || other.status == status)&&(identical(other.editSt, editSt) || other.editSt == editSt)&&(identical(other.portfolioSt, portfolioSt) || other.portfolioSt == portfolioSt)&&(identical(other.verificationDocSt, verificationDocSt) || other.verificationDocSt == verificationDocSt)&&(identical(other.profileAvatarSt, profileAvatarSt) || other.profileAvatarSt == profileAvatarSt)&&(identical(other.hasToken, hasToken) || other.hasToken == hasToken)&&(identical(other.user, user) || other.user == user)&&(identical(other.errorText, errorText) || other.errorText == errorText));
}


@override
int get hashCode => Object.hash(runtimeType,status,editSt,portfolioSt,verificationDocSt,profileAvatarSt,hasToken,user,errorText);

@override
String toString() {
  return 'UserState(status: $status, editSt: $editSt, portfolioSt: $portfolioSt, verificationDocSt: $verificationDocSt, profileAvatarSt: $profileAvatarSt, hasToken: $hasToken, user: $user, errorText: $errorText)';
}


}

/// @nodoc
abstract mixin class $UserStateCopyWith<$Res>  {
  factory $UserStateCopyWith(UserState value, $Res Function(UserState) _then) = _$UserStateCopyWithImpl;
@useResult
$Res call({
 RequestStatus status, RequestStatus editSt, RequestStatus portfolioSt, RequestStatus verificationDocSt, RequestStatus profileAvatarSt, bool hasToken, User? user, String? errorText
});




}
/// @nodoc
class _$UserStateCopyWithImpl<$Res>
    implements $UserStateCopyWith<$Res> {
  _$UserStateCopyWithImpl(this._self, this._then);

  final UserState _self;
  final $Res Function(UserState) _then;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? editSt = null,Object? portfolioSt = null,Object? verificationDocSt = null,Object? profileAvatarSt = null,Object? hasToken = null,Object? user = freezed,Object? errorText = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,editSt: null == editSt ? _self.editSt : editSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,portfolioSt: null == portfolioSt ? _self.portfolioSt : portfolioSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,verificationDocSt: null == verificationDocSt ? _self.verificationDocSt : verificationDocSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,profileAvatarSt: null == profileAvatarSt ? _self.profileAvatarSt : profileAvatarSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,hasToken: null == hasToken ? _self.hasToken : hasToken // ignore: cast_nullable_to_non_nullable
as bool,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User?,errorText: freezed == errorText ? _self.errorText : errorText // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserState].
extension UserStatePatterns on UserState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserState value)  $default,){
final _that = this;
switch (_that) {
case _UserState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserState value)?  $default,){
final _that = this;
switch (_that) {
case _UserState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestStatus status,  RequestStatus editSt,  RequestStatus portfolioSt,  RequestStatus verificationDocSt,  RequestStatus profileAvatarSt,  bool hasToken,  User? user,  String? errorText)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserState() when $default != null:
return $default(_that.status,_that.editSt,_that.portfolioSt,_that.verificationDocSt,_that.profileAvatarSt,_that.hasToken,_that.user,_that.errorText);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestStatus status,  RequestStatus editSt,  RequestStatus portfolioSt,  RequestStatus verificationDocSt,  RequestStatus profileAvatarSt,  bool hasToken,  User? user,  String? errorText)  $default,) {final _that = this;
switch (_that) {
case _UserState():
return $default(_that.status,_that.editSt,_that.portfolioSt,_that.verificationDocSt,_that.profileAvatarSt,_that.hasToken,_that.user,_that.errorText);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestStatus status,  RequestStatus editSt,  RequestStatus portfolioSt,  RequestStatus verificationDocSt,  RequestStatus profileAvatarSt,  bool hasToken,  User? user,  String? errorText)?  $default,) {final _that = this;
switch (_that) {
case _UserState() when $default != null:
return $default(_that.status,_that.editSt,_that.portfolioSt,_that.verificationDocSt,_that.profileAvatarSt,_that.hasToken,_that.user,_that.errorText);case _:
  return null;

}
}

}

/// @nodoc


class _UserState implements UserState {
  const _UserState({this.status = RequestStatus.initial, this.editSt = RequestStatus.initial, this.portfolioSt = RequestStatus.initial, this.verificationDocSt = RequestStatus.initial, this.profileAvatarSt = RequestStatus.initial, this.hasToken = false, this.user = null, this.errorText = null});
  

@override@JsonKey() final  RequestStatus status;
@override@JsonKey() final  RequestStatus editSt;
@override@JsonKey() final  RequestStatus portfolioSt;
@override@JsonKey() final  RequestStatus verificationDocSt;
@override@JsonKey() final  RequestStatus profileAvatarSt;
@override@JsonKey() final  bool hasToken;
@override@JsonKey() final  User? user;
@override@JsonKey() final  String? errorText;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserStateCopyWith<_UserState> get copyWith => __$UserStateCopyWithImpl<_UserState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserState&&(identical(other.status, status) || other.status == status)&&(identical(other.editSt, editSt) || other.editSt == editSt)&&(identical(other.portfolioSt, portfolioSt) || other.portfolioSt == portfolioSt)&&(identical(other.verificationDocSt, verificationDocSt) || other.verificationDocSt == verificationDocSt)&&(identical(other.profileAvatarSt, profileAvatarSt) || other.profileAvatarSt == profileAvatarSt)&&(identical(other.hasToken, hasToken) || other.hasToken == hasToken)&&(identical(other.user, user) || other.user == user)&&(identical(other.errorText, errorText) || other.errorText == errorText));
}


@override
int get hashCode => Object.hash(runtimeType,status,editSt,portfolioSt,verificationDocSt,profileAvatarSt,hasToken,user,errorText);

@override
String toString() {
  return 'UserState(status: $status, editSt: $editSt, portfolioSt: $portfolioSt, verificationDocSt: $verificationDocSt, profileAvatarSt: $profileAvatarSt, hasToken: $hasToken, user: $user, errorText: $errorText)';
}


}

/// @nodoc
abstract mixin class _$UserStateCopyWith<$Res> implements $UserStateCopyWith<$Res> {
  factory _$UserStateCopyWith(_UserState value, $Res Function(_UserState) _then) = __$UserStateCopyWithImpl;
@override @useResult
$Res call({
 RequestStatus status, RequestStatus editSt, RequestStatus portfolioSt, RequestStatus verificationDocSt, RequestStatus profileAvatarSt, bool hasToken, User? user, String? errorText
});




}
/// @nodoc
class __$UserStateCopyWithImpl<$Res>
    implements _$UserStateCopyWith<$Res> {
  __$UserStateCopyWithImpl(this._self, this._then);

  final _UserState _self;
  final $Res Function(_UserState) _then;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? editSt = null,Object? portfolioSt = null,Object? verificationDocSt = null,Object? profileAvatarSt = null,Object? hasToken = null,Object? user = freezed,Object? errorText = freezed,}) {
  return _then(_UserState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,editSt: null == editSt ? _self.editSt : editSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,portfolioSt: null == portfolioSt ? _self.portfolioSt : portfolioSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,verificationDocSt: null == verificationDocSt ? _self.verificationDocSt : verificationDocSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,profileAvatarSt: null == profileAvatarSt ? _self.profileAvatarSt : profileAvatarSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,hasToken: null == hasToken ? _self.hasToken : hasToken // ignore: cast_nullable_to_non_nullable
as bool,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User?,errorText: freezed == errorText ? _self.errorText : errorText // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
