// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ServiceState {

 RequestStatus get status; RequestStatus get similarServiceSt; String? get errorText; PaginatedServiceResponse? get listService; PaginatedServiceResponse? get listSimilarService; bool get isLoadingMore;
/// Create a copy of ServiceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceStateCopyWith<ServiceState> get copyWith => _$ServiceStateCopyWithImpl<ServiceState>(this as ServiceState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceState&&(identical(other.status, status) || other.status == status)&&(identical(other.similarServiceSt, similarServiceSt) || other.similarServiceSt == similarServiceSt)&&(identical(other.errorText, errorText) || other.errorText == errorText)&&(identical(other.listService, listService) || other.listService == listService)&&(identical(other.listSimilarService, listSimilarService) || other.listSimilarService == listSimilarService)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore));
}


@override
int get hashCode => Object.hash(runtimeType,status,similarServiceSt,errorText,listService,listSimilarService,isLoadingMore);

@override
String toString() {
  return 'ServiceState(status: $status, similarServiceSt: $similarServiceSt, errorText: $errorText, listService: $listService, listSimilarService: $listSimilarService, isLoadingMore: $isLoadingMore)';
}


}

/// @nodoc
abstract mixin class $ServiceStateCopyWith<$Res>  {
  factory $ServiceStateCopyWith(ServiceState value, $Res Function(ServiceState) _then) = _$ServiceStateCopyWithImpl;
@useResult
$Res call({
 RequestStatus status, RequestStatus similarServiceSt, String? errorText, PaginatedServiceResponse? listService, PaginatedServiceResponse? listSimilarService, bool isLoadingMore
});




}
/// @nodoc
class _$ServiceStateCopyWithImpl<$Res>
    implements $ServiceStateCopyWith<$Res> {
  _$ServiceStateCopyWithImpl(this._self, this._then);

  final ServiceState _self;
  final $Res Function(ServiceState) _then;

/// Create a copy of ServiceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? similarServiceSt = null,Object? errorText = freezed,Object? listService = freezed,Object? listSimilarService = freezed,Object? isLoadingMore = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,similarServiceSt: null == similarServiceSt ? _self.similarServiceSt : similarServiceSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,errorText: freezed == errorText ? _self.errorText : errorText // ignore: cast_nullable_to_non_nullable
as String?,listService: freezed == listService ? _self.listService : listService // ignore: cast_nullable_to_non_nullable
as PaginatedServiceResponse?,listSimilarService: freezed == listSimilarService ? _self.listSimilarService : listSimilarService // ignore: cast_nullable_to_non_nullable
as PaginatedServiceResponse?,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ServiceState].
extension ServiceStatePatterns on ServiceState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServiceState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServiceState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServiceState value)  $default,){
final _that = this;
switch (_that) {
case _ServiceState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServiceState value)?  $default,){
final _that = this;
switch (_that) {
case _ServiceState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestStatus status,  RequestStatus similarServiceSt,  String? errorText,  PaginatedServiceResponse? listService,  PaginatedServiceResponse? listSimilarService,  bool isLoadingMore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServiceState() when $default != null:
return $default(_that.status,_that.similarServiceSt,_that.errorText,_that.listService,_that.listSimilarService,_that.isLoadingMore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestStatus status,  RequestStatus similarServiceSt,  String? errorText,  PaginatedServiceResponse? listService,  PaginatedServiceResponse? listSimilarService,  bool isLoadingMore)  $default,) {final _that = this;
switch (_that) {
case _ServiceState():
return $default(_that.status,_that.similarServiceSt,_that.errorText,_that.listService,_that.listSimilarService,_that.isLoadingMore);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestStatus status,  RequestStatus similarServiceSt,  String? errorText,  PaginatedServiceResponse? listService,  PaginatedServiceResponse? listSimilarService,  bool isLoadingMore)?  $default,) {final _that = this;
switch (_that) {
case _ServiceState() when $default != null:
return $default(_that.status,_that.similarServiceSt,_that.errorText,_that.listService,_that.listSimilarService,_that.isLoadingMore);case _:
  return null;

}
}

}

/// @nodoc


class _ServiceState implements ServiceState {
  const _ServiceState({this.status = RequestStatus.initial, this.similarServiceSt = RequestStatus.initial, this.errorText = null, this.listService = null, this.listSimilarService = null, this.isLoadingMore = false});
  

@override@JsonKey() final  RequestStatus status;
@override@JsonKey() final  RequestStatus similarServiceSt;
@override@JsonKey() final  String? errorText;
@override@JsonKey() final  PaginatedServiceResponse? listService;
@override@JsonKey() final  PaginatedServiceResponse? listSimilarService;
@override@JsonKey() final  bool isLoadingMore;

/// Create a copy of ServiceState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceStateCopyWith<_ServiceState> get copyWith => __$ServiceStateCopyWithImpl<_ServiceState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceState&&(identical(other.status, status) || other.status == status)&&(identical(other.similarServiceSt, similarServiceSt) || other.similarServiceSt == similarServiceSt)&&(identical(other.errorText, errorText) || other.errorText == errorText)&&(identical(other.listService, listService) || other.listService == listService)&&(identical(other.listSimilarService, listSimilarService) || other.listSimilarService == listSimilarService)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore));
}


@override
int get hashCode => Object.hash(runtimeType,status,similarServiceSt,errorText,listService,listSimilarService,isLoadingMore);

@override
String toString() {
  return 'ServiceState(status: $status, similarServiceSt: $similarServiceSt, errorText: $errorText, listService: $listService, listSimilarService: $listSimilarService, isLoadingMore: $isLoadingMore)';
}


}

/// @nodoc
abstract mixin class _$ServiceStateCopyWith<$Res> implements $ServiceStateCopyWith<$Res> {
  factory _$ServiceStateCopyWith(_ServiceState value, $Res Function(_ServiceState) _then) = __$ServiceStateCopyWithImpl;
@override @useResult
$Res call({
 RequestStatus status, RequestStatus similarServiceSt, String? errorText, PaginatedServiceResponse? listService, PaginatedServiceResponse? listSimilarService, bool isLoadingMore
});




}
/// @nodoc
class __$ServiceStateCopyWithImpl<$Res>
    implements _$ServiceStateCopyWith<$Res> {
  __$ServiceStateCopyWithImpl(this._self, this._then);

  final _ServiceState _self;
  final $Res Function(_ServiceState) _then;

/// Create a copy of ServiceState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? similarServiceSt = null,Object? errorText = freezed,Object? listService = freezed,Object? listSimilarService = freezed,Object? isLoadingMore = null,}) {
  return _then(_ServiceState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,similarServiceSt: null == similarServiceSt ? _self.similarServiceSt : similarServiceSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,errorText: freezed == errorText ? _self.errorText : errorText // ignore: cast_nullable_to_non_nullable
as String?,listService: freezed == listService ? _self.listService : listService // ignore: cast_nullable_to_non_nullable
as PaginatedServiceResponse?,listSimilarService: freezed == listSimilarService ? _self.listSimilarService : listSimilarService // ignore: cast_nullable_to_non_nullable
as PaginatedServiceResponse?,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
