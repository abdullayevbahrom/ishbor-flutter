// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'yandex_map_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$YandexMapState {

 RequestStatus get status; RequestStatus get searchSt; List<String> get suggestions; dynamic get response; Point get userPoint; bool get enableFindMe; bool get isLoading; String get addressName; String? get error;
/// Create a copy of YandexMapState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$YandexMapStateCopyWith<YandexMapState> get copyWith => _$YandexMapStateCopyWithImpl<YandexMapState>(this as YandexMapState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is YandexMapState&&(identical(other.status, status) || other.status == status)&&(identical(other.searchSt, searchSt) || other.searchSt == searchSt)&&const DeepCollectionEquality().equals(other.suggestions, suggestions)&&const DeepCollectionEquality().equals(other.response, response)&&(identical(other.userPoint, userPoint) || other.userPoint == userPoint)&&(identical(other.enableFindMe, enableFindMe) || other.enableFindMe == enableFindMe)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.addressName, addressName) || other.addressName == addressName)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,status,searchSt,const DeepCollectionEquality().hash(suggestions),const DeepCollectionEquality().hash(response),userPoint,enableFindMe,isLoading,addressName,error);

@override
String toString() {
  return 'YandexMapState(status: $status, searchSt: $searchSt, suggestions: $suggestions, response: $response, userPoint: $userPoint, enableFindMe: $enableFindMe, isLoading: $isLoading, addressName: $addressName, error: $error)';
}


}

/// @nodoc
abstract mixin class $YandexMapStateCopyWith<$Res>  {
  factory $YandexMapStateCopyWith(YandexMapState value, $Res Function(YandexMapState) _then) = _$YandexMapStateCopyWithImpl;
@useResult
$Res call({
 RequestStatus status, RequestStatus searchSt, List<String> suggestions, dynamic response, Point userPoint, bool enableFindMe, bool isLoading, String addressName, String? error
});




}
/// @nodoc
class _$YandexMapStateCopyWithImpl<$Res>
    implements $YandexMapStateCopyWith<$Res> {
  _$YandexMapStateCopyWithImpl(this._self, this._then);

  final YandexMapState _self;
  final $Res Function(YandexMapState) _then;

/// Create a copy of YandexMapState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? searchSt = null,Object? suggestions = null,Object? response = freezed,Object? userPoint = null,Object? enableFindMe = null,Object? isLoading = null,Object? addressName = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,searchSt: null == searchSt ? _self.searchSt : searchSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,suggestions: null == suggestions ? _self.suggestions : suggestions // ignore: cast_nullable_to_non_nullable
as List<String>,response: freezed == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as dynamic,userPoint: null == userPoint ? _self.userPoint : userPoint // ignore: cast_nullable_to_non_nullable
as Point,enableFindMe: null == enableFindMe ? _self.enableFindMe : enableFindMe // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,addressName: null == addressName ? _self.addressName : addressName // ignore: cast_nullable_to_non_nullable
as String,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [YandexMapState].
extension YandexMapStatePatterns on YandexMapState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _YandexMapState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _YandexMapState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _YandexMapState value)  $default,){
final _that = this;
switch (_that) {
case _YandexMapState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _YandexMapState value)?  $default,){
final _that = this;
switch (_that) {
case _YandexMapState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestStatus status,  RequestStatus searchSt,  List<String> suggestions,  dynamic response,  Point userPoint,  bool enableFindMe,  bool isLoading,  String addressName,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _YandexMapState() when $default != null:
return $default(_that.status,_that.searchSt,_that.suggestions,_that.response,_that.userPoint,_that.enableFindMe,_that.isLoading,_that.addressName,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestStatus status,  RequestStatus searchSt,  List<String> suggestions,  dynamic response,  Point userPoint,  bool enableFindMe,  bool isLoading,  String addressName,  String? error)  $default,) {final _that = this;
switch (_that) {
case _YandexMapState():
return $default(_that.status,_that.searchSt,_that.suggestions,_that.response,_that.userPoint,_that.enableFindMe,_that.isLoading,_that.addressName,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestStatus status,  RequestStatus searchSt,  List<String> suggestions,  dynamic response,  Point userPoint,  bool enableFindMe,  bool isLoading,  String addressName,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _YandexMapState() when $default != null:
return $default(_that.status,_that.searchSt,_that.suggestions,_that.response,_that.userPoint,_that.enableFindMe,_that.isLoading,_that.addressName,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _YandexMapState implements YandexMapState {
  const _YandexMapState({this.status = RequestStatus.initial, this.searchSt = RequestStatus.initial, final  List<String> suggestions = const [], this.response = null, this.userPoint = const Point(latitude: 41.311081, longitude: 69.240562), this.enableFindMe = false, this.isLoading = false, this.addressName = "Chilonzor tumani, Bunyodkor shoh ko'chasi", this.error}): _suggestions = suggestions;
  

@override@JsonKey() final  RequestStatus status;
@override@JsonKey() final  RequestStatus searchSt;
 final  List<String> _suggestions;
@override@JsonKey() List<String> get suggestions {
  if (_suggestions is EqualUnmodifiableListView) return _suggestions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_suggestions);
}

@override@JsonKey() final  dynamic response;
@override@JsonKey() final  Point userPoint;
@override@JsonKey() final  bool enableFindMe;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  String addressName;
@override final  String? error;

/// Create a copy of YandexMapState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$YandexMapStateCopyWith<_YandexMapState> get copyWith => __$YandexMapStateCopyWithImpl<_YandexMapState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _YandexMapState&&(identical(other.status, status) || other.status == status)&&(identical(other.searchSt, searchSt) || other.searchSt == searchSt)&&const DeepCollectionEquality().equals(other._suggestions, _suggestions)&&const DeepCollectionEquality().equals(other.response, response)&&(identical(other.userPoint, userPoint) || other.userPoint == userPoint)&&(identical(other.enableFindMe, enableFindMe) || other.enableFindMe == enableFindMe)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.addressName, addressName) || other.addressName == addressName)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,status,searchSt,const DeepCollectionEquality().hash(_suggestions),const DeepCollectionEquality().hash(response),userPoint,enableFindMe,isLoading,addressName,error);

@override
String toString() {
  return 'YandexMapState(status: $status, searchSt: $searchSt, suggestions: $suggestions, response: $response, userPoint: $userPoint, enableFindMe: $enableFindMe, isLoading: $isLoading, addressName: $addressName, error: $error)';
}


}

/// @nodoc
abstract mixin class _$YandexMapStateCopyWith<$Res> implements $YandexMapStateCopyWith<$Res> {
  factory _$YandexMapStateCopyWith(_YandexMapState value, $Res Function(_YandexMapState) _then) = __$YandexMapStateCopyWithImpl;
@override @useResult
$Res call({
 RequestStatus status, RequestStatus searchSt, List<String> suggestions, dynamic response, Point userPoint, bool enableFindMe, bool isLoading, String addressName, String? error
});




}
/// @nodoc
class __$YandexMapStateCopyWithImpl<$Res>
    implements _$YandexMapStateCopyWith<$Res> {
  __$YandexMapStateCopyWithImpl(this._self, this._then);

  final _YandexMapState _self;
  final $Res Function(_YandexMapState) _then;

/// Create a copy of YandexMapState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? searchSt = null,Object? suggestions = null,Object? response = freezed,Object? userPoint = null,Object? enableFindMe = null,Object? isLoading = null,Object? addressName = null,Object? error = freezed,}) {
  return _then(_YandexMapState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,searchSt: null == searchSt ? _self.searchSt : searchSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,suggestions: null == suggestions ? _self._suggestions : suggestions // ignore: cast_nullable_to_non_nullable
as List<String>,response: freezed == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as dynamic,userPoint: null == userPoint ? _self.userPoint : userPoint // ignore: cast_nullable_to_non_nullable
as Point,enableFindMe: null == enableFindMe ? _self.enableFindMe : enableFindMe // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,addressName: null == addressName ? _self.addressName : addressName // ignore: cast_nullable_to_non_nullable
as String,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
