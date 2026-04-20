// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'suggestions_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SuggestionsState {

 RequestStatus get status; List<String> get suggestions; String? get errorText;
/// Create a copy of SuggestionsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SuggestionsStateCopyWith<SuggestionsState> get copyWith => _$SuggestionsStateCopyWithImpl<SuggestionsState>(this as SuggestionsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SuggestionsState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.suggestions, suggestions)&&(identical(other.errorText, errorText) || other.errorText == errorText));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(suggestions),errorText);

@override
String toString() {
  return 'SuggestionsState(status: $status, suggestions: $suggestions, errorText: $errorText)';
}


}

/// @nodoc
abstract mixin class $SuggestionsStateCopyWith<$Res>  {
  factory $SuggestionsStateCopyWith(SuggestionsState value, $Res Function(SuggestionsState) _then) = _$SuggestionsStateCopyWithImpl;
@useResult
$Res call({
 RequestStatus status, List<String> suggestions, String? errorText
});




}
/// @nodoc
class _$SuggestionsStateCopyWithImpl<$Res>
    implements $SuggestionsStateCopyWith<$Res> {
  _$SuggestionsStateCopyWithImpl(this._self, this._then);

  final SuggestionsState _self;
  final $Res Function(SuggestionsState) _then;

/// Create a copy of SuggestionsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? suggestions = null,Object? errorText = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,suggestions: null == suggestions ? _self.suggestions : suggestions // ignore: cast_nullable_to_non_nullable
as List<String>,errorText: freezed == errorText ? _self.errorText : errorText // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SuggestionsState].
extension SuggestionsStatePatterns on SuggestionsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SuggestionsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SuggestionsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SuggestionsState value)  $default,){
final _that = this;
switch (_that) {
case _SuggestionsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SuggestionsState value)?  $default,){
final _that = this;
switch (_that) {
case _SuggestionsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestStatus status,  List<String> suggestions,  String? errorText)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SuggestionsState() when $default != null:
return $default(_that.status,_that.suggestions,_that.errorText);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestStatus status,  List<String> suggestions,  String? errorText)  $default,) {final _that = this;
switch (_that) {
case _SuggestionsState():
return $default(_that.status,_that.suggestions,_that.errorText);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestStatus status,  List<String> suggestions,  String? errorText)?  $default,) {final _that = this;
switch (_that) {
case _SuggestionsState() when $default != null:
return $default(_that.status,_that.suggestions,_that.errorText);case _:
  return null;

}
}

}

/// @nodoc


class _SuggestionsState implements SuggestionsState {
  const _SuggestionsState({this.status = RequestStatus.initial, final  List<String> suggestions = const [], this.errorText = null}): _suggestions = suggestions;
  

@override@JsonKey() final  RequestStatus status;
 final  List<String> _suggestions;
@override@JsonKey() List<String> get suggestions {
  if (_suggestions is EqualUnmodifiableListView) return _suggestions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_suggestions);
}

@override@JsonKey() final  String? errorText;

/// Create a copy of SuggestionsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuggestionsStateCopyWith<_SuggestionsState> get copyWith => __$SuggestionsStateCopyWithImpl<_SuggestionsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SuggestionsState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._suggestions, _suggestions)&&(identical(other.errorText, errorText) || other.errorText == errorText));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_suggestions),errorText);

@override
String toString() {
  return 'SuggestionsState(status: $status, suggestions: $suggestions, errorText: $errorText)';
}


}

/// @nodoc
abstract mixin class _$SuggestionsStateCopyWith<$Res> implements $SuggestionsStateCopyWith<$Res> {
  factory _$SuggestionsStateCopyWith(_SuggestionsState value, $Res Function(_SuggestionsState) _then) = __$SuggestionsStateCopyWithImpl;
@override @useResult
$Res call({
 RequestStatus status, List<String> suggestions, String? errorText
});




}
/// @nodoc
class __$SuggestionsStateCopyWithImpl<$Res>
    implements _$SuggestionsStateCopyWith<$Res> {
  __$SuggestionsStateCopyWithImpl(this._self, this._then);

  final _SuggestionsState _self;
  final $Res Function(_SuggestionsState) _then;

/// Create a copy of SuggestionsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? suggestions = null,Object? errorText = freezed,}) {
  return _then(_SuggestionsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,suggestions: null == suggestions ? _self._suggestions : suggestions // ignore: cast_nullable_to_non_nullable
as List<String>,errorText: freezed == errorText ? _self.errorText : errorText // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
