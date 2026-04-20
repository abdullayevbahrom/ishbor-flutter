// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_info_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LocationInfoState {

 RequestStatus get status; RequestStatus get suggestionStatus; String? get errorText; LocationInfo? get locationInfo; LatLng get defaultCenter; List<SuggestedLocation> get suggestions;
/// Create a copy of LocationInfoState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocationInfoStateCopyWith<LocationInfoState> get copyWith => _$LocationInfoStateCopyWithImpl<LocationInfoState>(this as LocationInfoState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationInfoState&&(identical(other.status, status) || other.status == status)&&(identical(other.suggestionStatus, suggestionStatus) || other.suggestionStatus == suggestionStatus)&&(identical(other.errorText, errorText) || other.errorText == errorText)&&(identical(other.locationInfo, locationInfo) || other.locationInfo == locationInfo)&&(identical(other.defaultCenter, defaultCenter) || other.defaultCenter == defaultCenter)&&const DeepCollectionEquality().equals(other.suggestions, suggestions));
}


@override
int get hashCode => Object.hash(runtimeType,status,suggestionStatus,errorText,locationInfo,defaultCenter,const DeepCollectionEquality().hash(suggestions));

@override
String toString() {
  return 'LocationInfoState(status: $status, suggestionStatus: $suggestionStatus, errorText: $errorText, locationInfo: $locationInfo, defaultCenter: $defaultCenter, suggestions: $suggestions)';
}


}

/// @nodoc
abstract mixin class $LocationInfoStateCopyWith<$Res>  {
  factory $LocationInfoStateCopyWith(LocationInfoState value, $Res Function(LocationInfoState) _then) = _$LocationInfoStateCopyWithImpl;
@useResult
$Res call({
 RequestStatus status, RequestStatus suggestionStatus, String? errorText, LocationInfo? locationInfo, LatLng defaultCenter, List<SuggestedLocation> suggestions
});




}
/// @nodoc
class _$LocationInfoStateCopyWithImpl<$Res>
    implements $LocationInfoStateCopyWith<$Res> {
  _$LocationInfoStateCopyWithImpl(this._self, this._then);

  final LocationInfoState _self;
  final $Res Function(LocationInfoState) _then;

/// Create a copy of LocationInfoState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? suggestionStatus = null,Object? errorText = freezed,Object? locationInfo = freezed,Object? defaultCenter = null,Object? suggestions = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,suggestionStatus: null == suggestionStatus ? _self.suggestionStatus : suggestionStatus // ignore: cast_nullable_to_non_nullable
as RequestStatus,errorText: freezed == errorText ? _self.errorText : errorText // ignore: cast_nullable_to_non_nullable
as String?,locationInfo: freezed == locationInfo ? _self.locationInfo : locationInfo // ignore: cast_nullable_to_non_nullable
as LocationInfo?,defaultCenter: null == defaultCenter ? _self.defaultCenter : defaultCenter // ignore: cast_nullable_to_non_nullable
as LatLng,suggestions: null == suggestions ? _self.suggestions : suggestions // ignore: cast_nullable_to_non_nullable
as List<SuggestedLocation>,
  ));
}

}


/// Adds pattern-matching-related methods to [LocationInfoState].
extension LocationInfoStatePatterns on LocationInfoState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocationInfoState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocationInfoState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocationInfoState value)  $default,){
final _that = this;
switch (_that) {
case _LocationInfoState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocationInfoState value)?  $default,){
final _that = this;
switch (_that) {
case _LocationInfoState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestStatus status,  RequestStatus suggestionStatus,  String? errorText,  LocationInfo? locationInfo,  LatLng defaultCenter,  List<SuggestedLocation> suggestions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocationInfoState() when $default != null:
return $default(_that.status,_that.suggestionStatus,_that.errorText,_that.locationInfo,_that.defaultCenter,_that.suggestions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestStatus status,  RequestStatus suggestionStatus,  String? errorText,  LocationInfo? locationInfo,  LatLng defaultCenter,  List<SuggestedLocation> suggestions)  $default,) {final _that = this;
switch (_that) {
case _LocationInfoState():
return $default(_that.status,_that.suggestionStatus,_that.errorText,_that.locationInfo,_that.defaultCenter,_that.suggestions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestStatus status,  RequestStatus suggestionStatus,  String? errorText,  LocationInfo? locationInfo,  LatLng defaultCenter,  List<SuggestedLocation> suggestions)?  $default,) {final _that = this;
switch (_that) {
case _LocationInfoState() when $default != null:
return $default(_that.status,_that.suggestionStatus,_that.errorText,_that.locationInfo,_that.defaultCenter,_that.suggestions);case _:
  return null;

}
}

}

/// @nodoc


class _LocationInfoState implements LocationInfoState {
  const _LocationInfoState({this.status = RequestStatus.initial, this.suggestionStatus = RequestStatus.initial, this.errorText = null, this.locationInfo = null, this.defaultCenter = const LatLng(41.311081, 69.230562), final  List<SuggestedLocation> suggestions = const []}): _suggestions = suggestions;
  

@override@JsonKey() final  RequestStatus status;
@override@JsonKey() final  RequestStatus suggestionStatus;
@override@JsonKey() final  String? errorText;
@override@JsonKey() final  LocationInfo? locationInfo;
@override@JsonKey() final  LatLng defaultCenter;
 final  List<SuggestedLocation> _suggestions;
@override@JsonKey() List<SuggestedLocation> get suggestions {
  if (_suggestions is EqualUnmodifiableListView) return _suggestions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_suggestions);
}


/// Create a copy of LocationInfoState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocationInfoStateCopyWith<_LocationInfoState> get copyWith => __$LocationInfoStateCopyWithImpl<_LocationInfoState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocationInfoState&&(identical(other.status, status) || other.status == status)&&(identical(other.suggestionStatus, suggestionStatus) || other.suggestionStatus == suggestionStatus)&&(identical(other.errorText, errorText) || other.errorText == errorText)&&(identical(other.locationInfo, locationInfo) || other.locationInfo == locationInfo)&&(identical(other.defaultCenter, defaultCenter) || other.defaultCenter == defaultCenter)&&const DeepCollectionEquality().equals(other._suggestions, _suggestions));
}


@override
int get hashCode => Object.hash(runtimeType,status,suggestionStatus,errorText,locationInfo,defaultCenter,const DeepCollectionEquality().hash(_suggestions));

@override
String toString() {
  return 'LocationInfoState(status: $status, suggestionStatus: $suggestionStatus, errorText: $errorText, locationInfo: $locationInfo, defaultCenter: $defaultCenter, suggestions: $suggestions)';
}


}

/// @nodoc
abstract mixin class _$LocationInfoStateCopyWith<$Res> implements $LocationInfoStateCopyWith<$Res> {
  factory _$LocationInfoStateCopyWith(_LocationInfoState value, $Res Function(_LocationInfoState) _then) = __$LocationInfoStateCopyWithImpl;
@override @useResult
$Res call({
 RequestStatus status, RequestStatus suggestionStatus, String? errorText, LocationInfo? locationInfo, LatLng defaultCenter, List<SuggestedLocation> suggestions
});




}
/// @nodoc
class __$LocationInfoStateCopyWithImpl<$Res>
    implements _$LocationInfoStateCopyWith<$Res> {
  __$LocationInfoStateCopyWithImpl(this._self, this._then);

  final _LocationInfoState _self;
  final $Res Function(_LocationInfoState) _then;

/// Create a copy of LocationInfoState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? suggestionStatus = null,Object? errorText = freezed,Object? locationInfo = freezed,Object? defaultCenter = null,Object? suggestions = null,}) {
  return _then(_LocationInfoState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,suggestionStatus: null == suggestionStatus ? _self.suggestionStatus : suggestionStatus // ignore: cast_nullable_to_non_nullable
as RequestStatus,errorText: freezed == errorText ? _self.errorText : errorText // ignore: cast_nullable_to_non_nullable
as String?,locationInfo: freezed == locationInfo ? _self.locationInfo : locationInfo // ignore: cast_nullable_to_non_nullable
as LocationInfo?,defaultCenter: null == defaultCenter ? _self.defaultCenter : defaultCenter // ignore: cast_nullable_to_non_nullable
as LatLng,suggestions: null == suggestions ? _self._suggestions : suggestions // ignore: cast_nullable_to_non_nullable
as List<SuggestedLocation>,
  ));
}


}

// dart format on
