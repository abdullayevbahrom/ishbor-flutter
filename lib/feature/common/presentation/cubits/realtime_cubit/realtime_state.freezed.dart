// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'realtime_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RealtimeState {

 RequestStatus get status; Map<String, dynamic> get userStatuses;
/// Create a copy of RealtimeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RealtimeStateCopyWith<RealtimeState> get copyWith => _$RealtimeStateCopyWithImpl<RealtimeState>(this as RealtimeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimeState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.userStatuses, userStatuses));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(userStatuses));

@override
String toString() {
  return 'RealtimeState(status: $status, userStatuses: $userStatuses)';
}


}

/// @nodoc
abstract mixin class $RealtimeStateCopyWith<$Res>  {
  factory $RealtimeStateCopyWith(RealtimeState value, $Res Function(RealtimeState) _then) = _$RealtimeStateCopyWithImpl;
@useResult
$Res call({
 RequestStatus status, Map<String, dynamic> userStatuses
});




}
/// @nodoc
class _$RealtimeStateCopyWithImpl<$Res>
    implements $RealtimeStateCopyWith<$Res> {
  _$RealtimeStateCopyWithImpl(this._self, this._then);

  final RealtimeState _self;
  final $Res Function(RealtimeState) _then;

/// Create a copy of RealtimeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? userStatuses = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,userStatuses: null == userStatuses ? _self.userStatuses : userStatuses // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [RealtimeState].
extension RealtimeStatePatterns on RealtimeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RealtimeState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RealtimeState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RealtimeState value)  $default,){
final _that = this;
switch (_that) {
case _RealtimeState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RealtimeState value)?  $default,){
final _that = this;
switch (_that) {
case _RealtimeState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestStatus status,  Map<String, dynamic> userStatuses)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RealtimeState() when $default != null:
return $default(_that.status,_that.userStatuses);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestStatus status,  Map<String, dynamic> userStatuses)  $default,) {final _that = this;
switch (_that) {
case _RealtimeState():
return $default(_that.status,_that.userStatuses);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestStatus status,  Map<String, dynamic> userStatuses)?  $default,) {final _that = this;
switch (_that) {
case _RealtimeState() when $default != null:
return $default(_that.status,_that.userStatuses);case _:
  return null;

}
}

}

/// @nodoc


class _RealtimeState implements RealtimeState {
  const _RealtimeState({this.status = RequestStatus.initial, final  Map<String, dynamic> userStatuses = const {}}): _userStatuses = userStatuses;
  

@override@JsonKey() final  RequestStatus status;
 final  Map<String, dynamic> _userStatuses;
@override@JsonKey() Map<String, dynamic> get userStatuses {
  if (_userStatuses is EqualUnmodifiableMapView) return _userStatuses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_userStatuses);
}


/// Create a copy of RealtimeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RealtimeStateCopyWith<_RealtimeState> get copyWith => __$RealtimeStateCopyWithImpl<_RealtimeState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RealtimeState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._userStatuses, _userStatuses));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_userStatuses));

@override
String toString() {
  return 'RealtimeState(status: $status, userStatuses: $userStatuses)';
}


}

/// @nodoc
abstract mixin class _$RealtimeStateCopyWith<$Res> implements $RealtimeStateCopyWith<$Res> {
  factory _$RealtimeStateCopyWith(_RealtimeState value, $Res Function(_RealtimeState) _then) = __$RealtimeStateCopyWithImpl;
@override @useResult
$Res call({
 RequestStatus status, Map<String, dynamic> userStatuses
});




}
/// @nodoc
class __$RealtimeStateCopyWithImpl<$Res>
    implements _$RealtimeStateCopyWith<$Res> {
  __$RealtimeStateCopyWithImpl(this._self, this._then);

  final _RealtimeState _self;
  final $Res Function(_RealtimeState) _then;

/// Create a copy of RealtimeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? userStatuses = null,}) {
  return _then(_RealtimeState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,userStatuses: null == userStatuses ? _self._userStatuses : userStatuses // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
