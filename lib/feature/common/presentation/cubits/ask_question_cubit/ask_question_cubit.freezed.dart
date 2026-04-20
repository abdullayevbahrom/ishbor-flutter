// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ask_question_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AskQuestionState {

 RequestStatus get status; RequestStatus get reportSt; String? get errorText;
/// Create a copy of AskQuestionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AskQuestionStateCopyWith<AskQuestionState> get copyWith => _$AskQuestionStateCopyWithImpl<AskQuestionState>(this as AskQuestionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AskQuestionState&&(identical(other.status, status) || other.status == status)&&(identical(other.reportSt, reportSt) || other.reportSt == reportSt)&&(identical(other.errorText, errorText) || other.errorText == errorText));
}


@override
int get hashCode => Object.hash(runtimeType,status,reportSt,errorText);

@override
String toString() {
  return 'AskQuestionState(status: $status, reportSt: $reportSt, errorText: $errorText)';
}


}

/// @nodoc
abstract mixin class $AskQuestionStateCopyWith<$Res>  {
  factory $AskQuestionStateCopyWith(AskQuestionState value, $Res Function(AskQuestionState) _then) = _$AskQuestionStateCopyWithImpl;
@useResult
$Res call({
 RequestStatus status, RequestStatus reportSt, String? errorText
});




}
/// @nodoc
class _$AskQuestionStateCopyWithImpl<$Res>
    implements $AskQuestionStateCopyWith<$Res> {
  _$AskQuestionStateCopyWithImpl(this._self, this._then);

  final AskQuestionState _self;
  final $Res Function(AskQuestionState) _then;

/// Create a copy of AskQuestionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? reportSt = null,Object? errorText = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,reportSt: null == reportSt ? _self.reportSt : reportSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,errorText: freezed == errorText ? _self.errorText : errorText // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AskQuestionState].
extension AskQuestionStatePatterns on AskQuestionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AskQuestionState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AskQuestionState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AskQuestionState value)  $default,){
final _that = this;
switch (_that) {
case _AskQuestionState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AskQuestionState value)?  $default,){
final _that = this;
switch (_that) {
case _AskQuestionState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestStatus status,  RequestStatus reportSt,  String? errorText)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AskQuestionState() when $default != null:
return $default(_that.status,_that.reportSt,_that.errorText);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestStatus status,  RequestStatus reportSt,  String? errorText)  $default,) {final _that = this;
switch (_that) {
case _AskQuestionState():
return $default(_that.status,_that.reportSt,_that.errorText);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestStatus status,  RequestStatus reportSt,  String? errorText)?  $default,) {final _that = this;
switch (_that) {
case _AskQuestionState() when $default != null:
return $default(_that.status,_that.reportSt,_that.errorText);case _:
  return null;

}
}

}

/// @nodoc


class _AskQuestionState implements AskQuestionState {
  const _AskQuestionState({this.status = RequestStatus.initial, this.reportSt = RequestStatus.initial, this.errorText = null});
  

@override@JsonKey() final  RequestStatus status;
@override@JsonKey() final  RequestStatus reportSt;
@override@JsonKey() final  String? errorText;

/// Create a copy of AskQuestionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AskQuestionStateCopyWith<_AskQuestionState> get copyWith => __$AskQuestionStateCopyWithImpl<_AskQuestionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AskQuestionState&&(identical(other.status, status) || other.status == status)&&(identical(other.reportSt, reportSt) || other.reportSt == reportSt)&&(identical(other.errorText, errorText) || other.errorText == errorText));
}


@override
int get hashCode => Object.hash(runtimeType,status,reportSt,errorText);

@override
String toString() {
  return 'AskQuestionState(status: $status, reportSt: $reportSt, errorText: $errorText)';
}


}

/// @nodoc
abstract mixin class _$AskQuestionStateCopyWith<$Res> implements $AskQuestionStateCopyWith<$Res> {
  factory _$AskQuestionStateCopyWith(_AskQuestionState value, $Res Function(_AskQuestionState) _then) = __$AskQuestionStateCopyWithImpl;
@override @useResult
$Res call({
 RequestStatus status, RequestStatus reportSt, String? errorText
});




}
/// @nodoc
class __$AskQuestionStateCopyWithImpl<$Res>
    implements _$AskQuestionStateCopyWith<$Res> {
  __$AskQuestionStateCopyWithImpl(this._self, this._then);

  final _AskQuestionState _self;
  final $Res Function(_AskQuestionState) _then;

/// Create a copy of AskQuestionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? reportSt = null,Object? errorText = freezed,}) {
  return _then(_AskQuestionState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,reportSt: null == reportSt ? _self.reportSt : reportSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,errorText: freezed == errorText ? _self.errorText : errorText // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
