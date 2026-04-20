// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cities_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CitiesState {

 RequestStatus get status; String? get errorText; CitiesList? get listCities;
/// Create a copy of CitiesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CitiesStateCopyWith<CitiesState> get copyWith => _$CitiesStateCopyWithImpl<CitiesState>(this as CitiesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CitiesState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorText, errorText) || other.errorText == errorText)&&(identical(other.listCities, listCities) || other.listCities == listCities));
}


@override
int get hashCode => Object.hash(runtimeType,status,errorText,listCities);

@override
String toString() {
  return 'CitiesState(status: $status, errorText: $errorText, listCities: $listCities)';
}


}

/// @nodoc
abstract mixin class $CitiesStateCopyWith<$Res>  {
  factory $CitiesStateCopyWith(CitiesState value, $Res Function(CitiesState) _then) = _$CitiesStateCopyWithImpl;
@useResult
$Res call({
 RequestStatus status, String? errorText, CitiesList? listCities
});




}
/// @nodoc
class _$CitiesStateCopyWithImpl<$Res>
    implements $CitiesStateCopyWith<$Res> {
  _$CitiesStateCopyWithImpl(this._self, this._then);

  final CitiesState _self;
  final $Res Function(CitiesState) _then;

/// Create a copy of CitiesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? errorText = freezed,Object? listCities = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,errorText: freezed == errorText ? _self.errorText : errorText // ignore: cast_nullable_to_non_nullable
as String?,listCities: freezed == listCities ? _self.listCities : listCities // ignore: cast_nullable_to_non_nullable
as CitiesList?,
  ));
}

}


/// Adds pattern-matching-related methods to [CitiesState].
extension CitiesStatePatterns on CitiesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CitiesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CitiesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CitiesState value)  $default,){
final _that = this;
switch (_that) {
case _CitiesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CitiesState value)?  $default,){
final _that = this;
switch (_that) {
case _CitiesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestStatus status,  String? errorText,  CitiesList? listCities)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CitiesState() when $default != null:
return $default(_that.status,_that.errorText,_that.listCities);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestStatus status,  String? errorText,  CitiesList? listCities)  $default,) {final _that = this;
switch (_that) {
case _CitiesState():
return $default(_that.status,_that.errorText,_that.listCities);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestStatus status,  String? errorText,  CitiesList? listCities)?  $default,) {final _that = this;
switch (_that) {
case _CitiesState() when $default != null:
return $default(_that.status,_that.errorText,_that.listCities);case _:
  return null;

}
}

}

/// @nodoc


class _CitiesState implements CitiesState {
  const _CitiesState({this.status = RequestStatus.initial, this.errorText = null, this.listCities = null});
  

@override@JsonKey() final  RequestStatus status;
@override@JsonKey() final  String? errorText;
@override@JsonKey() final  CitiesList? listCities;

/// Create a copy of CitiesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CitiesStateCopyWith<_CitiesState> get copyWith => __$CitiesStateCopyWithImpl<_CitiesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CitiesState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorText, errorText) || other.errorText == errorText)&&(identical(other.listCities, listCities) || other.listCities == listCities));
}


@override
int get hashCode => Object.hash(runtimeType,status,errorText,listCities);

@override
String toString() {
  return 'CitiesState(status: $status, errorText: $errorText, listCities: $listCities)';
}


}

/// @nodoc
abstract mixin class _$CitiesStateCopyWith<$Res> implements $CitiesStateCopyWith<$Res> {
  factory _$CitiesStateCopyWith(_CitiesState value, $Res Function(_CitiesState) _then) = __$CitiesStateCopyWithImpl;
@override @useResult
$Res call({
 RequestStatus status, String? errorText, CitiesList? listCities
});




}
/// @nodoc
class __$CitiesStateCopyWithImpl<$Res>
    implements _$CitiesStateCopyWith<$Res> {
  __$CitiesStateCopyWithImpl(this._self, this._then);

  final _CitiesState _self;
  final $Res Function(_CitiesState) _then;

/// Create a copy of CitiesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? errorText = freezed,Object? listCities = freezed,}) {
  return _then(_CitiesState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,errorText: freezed == errorText ? _self.errorText : errorText // ignore: cast_nullable_to_non_nullable
as String?,listCities: freezed == listCities ? _self.listCities : listCities // ignore: cast_nullable_to_non_nullable
as CitiesList?,
  ));
}


}

// dart format on
