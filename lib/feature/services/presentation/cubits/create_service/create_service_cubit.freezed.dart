// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_service_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreateServiceState {

 RequestStatus get status; String? get errorText; ServiceModel? get service; bool get isNegotiable; bool get isUZS; List<File> get images; int get category; GeocodeResponse? get location;
/// Create a copy of CreateServiceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateServiceStateCopyWith<CreateServiceState> get copyWith => _$CreateServiceStateCopyWithImpl<CreateServiceState>(this as CreateServiceState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateServiceState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorText, errorText) || other.errorText == errorText)&&(identical(other.service, service) || other.service == service)&&(identical(other.isNegotiable, isNegotiable) || other.isNegotiable == isNegotiable)&&(identical(other.isUZS, isUZS) || other.isUZS == isUZS)&&const DeepCollectionEquality().equals(other.images, images)&&(identical(other.category, category) || other.category == category)&&(identical(other.location, location) || other.location == location));
}


@override
int get hashCode => Object.hash(runtimeType,status,errorText,service,isNegotiable,isUZS,const DeepCollectionEquality().hash(images),category,location);

@override
String toString() {
  return 'CreateServiceState(status: $status, errorText: $errorText, service: $service, isNegotiable: $isNegotiable, isUZS: $isUZS, images: $images, category: $category, location: $location)';
}


}

/// @nodoc
abstract mixin class $CreateServiceStateCopyWith<$Res>  {
  factory $CreateServiceStateCopyWith(CreateServiceState value, $Res Function(CreateServiceState) _then) = _$CreateServiceStateCopyWithImpl;
@useResult
$Res call({
 RequestStatus status, String? errorText, ServiceModel? service, bool isNegotiable, bool isUZS, List<File> images, int category, GeocodeResponse? location
});




}
/// @nodoc
class _$CreateServiceStateCopyWithImpl<$Res>
    implements $CreateServiceStateCopyWith<$Res> {
  _$CreateServiceStateCopyWithImpl(this._self, this._then);

  final CreateServiceState _self;
  final $Res Function(CreateServiceState) _then;

/// Create a copy of CreateServiceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? errorText = freezed,Object? service = freezed,Object? isNegotiable = null,Object? isUZS = null,Object? images = null,Object? category = null,Object? location = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,errorText: freezed == errorText ? _self.errorText : errorText // ignore: cast_nullable_to_non_nullable
as String?,service: freezed == service ? _self.service : service // ignore: cast_nullable_to_non_nullable
as ServiceModel?,isNegotiable: null == isNegotiable ? _self.isNegotiable : isNegotiable // ignore: cast_nullable_to_non_nullable
as bool,isUZS: null == isUZS ? _self.isUZS : isUZS // ignore: cast_nullable_to_non_nullable
as bool,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<File>,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as int,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GeocodeResponse?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateServiceState].
extension CreateServiceStatePatterns on CreateServiceState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateServiceState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateServiceState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateServiceState value)  $default,){
final _that = this;
switch (_that) {
case _CreateServiceState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateServiceState value)?  $default,){
final _that = this;
switch (_that) {
case _CreateServiceState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestStatus status,  String? errorText,  ServiceModel? service,  bool isNegotiable,  bool isUZS,  List<File> images,  int category,  GeocodeResponse? location)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateServiceState() when $default != null:
return $default(_that.status,_that.errorText,_that.service,_that.isNegotiable,_that.isUZS,_that.images,_that.category,_that.location);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestStatus status,  String? errorText,  ServiceModel? service,  bool isNegotiable,  bool isUZS,  List<File> images,  int category,  GeocodeResponse? location)  $default,) {final _that = this;
switch (_that) {
case _CreateServiceState():
return $default(_that.status,_that.errorText,_that.service,_that.isNegotiable,_that.isUZS,_that.images,_that.category,_that.location);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestStatus status,  String? errorText,  ServiceModel? service,  bool isNegotiable,  bool isUZS,  List<File> images,  int category,  GeocodeResponse? location)?  $default,) {final _that = this;
switch (_that) {
case _CreateServiceState() when $default != null:
return $default(_that.status,_that.errorText,_that.service,_that.isNegotiable,_that.isUZS,_that.images,_that.category,_that.location);case _:
  return null;

}
}

}

/// @nodoc


class _CreateServiceState implements CreateServiceState {
  const _CreateServiceState({this.status = RequestStatus.initial, this.errorText = null, this.service = null, this.isNegotiable = false, this.isUZS = false, final  List<File> images = const [], this.category = 0, this.location = null}): _images = images;
  

@override@JsonKey() final  RequestStatus status;
@override@JsonKey() final  String? errorText;
@override@JsonKey() final  ServiceModel? service;
@override@JsonKey() final  bool isNegotiable;
@override@JsonKey() final  bool isUZS;
 final  List<File> _images;
@override@JsonKey() List<File> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}

@override@JsonKey() final  int category;
@override@JsonKey() final  GeocodeResponse? location;

/// Create a copy of CreateServiceState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateServiceStateCopyWith<_CreateServiceState> get copyWith => __$CreateServiceStateCopyWithImpl<_CreateServiceState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateServiceState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorText, errorText) || other.errorText == errorText)&&(identical(other.service, service) || other.service == service)&&(identical(other.isNegotiable, isNegotiable) || other.isNegotiable == isNegotiable)&&(identical(other.isUZS, isUZS) || other.isUZS == isUZS)&&const DeepCollectionEquality().equals(other._images, _images)&&(identical(other.category, category) || other.category == category)&&(identical(other.location, location) || other.location == location));
}


@override
int get hashCode => Object.hash(runtimeType,status,errorText,service,isNegotiable,isUZS,const DeepCollectionEquality().hash(_images),category,location);

@override
String toString() {
  return 'CreateServiceState(status: $status, errorText: $errorText, service: $service, isNegotiable: $isNegotiable, isUZS: $isUZS, images: $images, category: $category, location: $location)';
}


}

/// @nodoc
abstract mixin class _$CreateServiceStateCopyWith<$Res> implements $CreateServiceStateCopyWith<$Res> {
  factory _$CreateServiceStateCopyWith(_CreateServiceState value, $Res Function(_CreateServiceState) _then) = __$CreateServiceStateCopyWithImpl;
@override @useResult
$Res call({
 RequestStatus status, String? errorText, ServiceModel? service, bool isNegotiable, bool isUZS, List<File> images, int category, GeocodeResponse? location
});




}
/// @nodoc
class __$CreateServiceStateCopyWithImpl<$Res>
    implements _$CreateServiceStateCopyWith<$Res> {
  __$CreateServiceStateCopyWithImpl(this._self, this._then);

  final _CreateServiceState _self;
  final $Res Function(_CreateServiceState) _then;

/// Create a copy of CreateServiceState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? errorText = freezed,Object? service = freezed,Object? isNegotiable = null,Object? isUZS = null,Object? images = null,Object? category = null,Object? location = freezed,}) {
  return _then(_CreateServiceState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,errorText: freezed == errorText ? _self.errorText : errorText // ignore: cast_nullable_to_non_nullable
as String?,service: freezed == service ? _self.service : service // ignore: cast_nullable_to_non_nullable
as ServiceModel?,isNegotiable: null == isNegotiable ? _self.isNegotiable : isNegotiable // ignore: cast_nullable_to_non_nullable
as bool,isUZS: null == isUZS ? _self.isUZS : isUZS // ignore: cast_nullable_to_non_nullable
as bool,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<File>,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as int,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GeocodeResponse?,
  ));
}


}

// dart format on
