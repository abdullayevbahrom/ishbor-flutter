// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service_view_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ServiceViewState {

 RequestStatus get status; RequestStatus get similarServiceSt; bool get isLoadingMore; ServiceModel? get service; PaginatedServiceResponse? get listService; int? get serviceId;
/// Create a copy of ServiceViewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceViewStateCopyWith<ServiceViewState> get copyWith => _$ServiceViewStateCopyWithImpl<ServiceViewState>(this as ServiceViewState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceViewState&&(identical(other.status, status) || other.status == status)&&(identical(other.similarServiceSt, similarServiceSt) || other.similarServiceSt == similarServiceSt)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.service, service) || other.service == service)&&(identical(other.listService, listService) || other.listService == listService)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId));
}


@override
int get hashCode => Object.hash(runtimeType,status,similarServiceSt,isLoadingMore,service,listService,serviceId);

@override
String toString() {
  return 'ServiceViewState(status: $status, similarServiceSt: $similarServiceSt, isLoadingMore: $isLoadingMore, service: $service, listService: $listService, serviceId: $serviceId)';
}


}

/// @nodoc
abstract mixin class $ServiceViewStateCopyWith<$Res>  {
  factory $ServiceViewStateCopyWith(ServiceViewState value, $Res Function(ServiceViewState) _then) = _$ServiceViewStateCopyWithImpl;
@useResult
$Res call({
 RequestStatus status, RequestStatus similarServiceSt, bool isLoadingMore, ServiceModel? service, PaginatedServiceResponse? listService, int? serviceId
});




}
/// @nodoc
class _$ServiceViewStateCopyWithImpl<$Res>
    implements $ServiceViewStateCopyWith<$Res> {
  _$ServiceViewStateCopyWithImpl(this._self, this._then);

  final ServiceViewState _self;
  final $Res Function(ServiceViewState) _then;

/// Create a copy of ServiceViewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? similarServiceSt = null,Object? isLoadingMore = null,Object? service = freezed,Object? listService = freezed,Object? serviceId = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,similarServiceSt: null == similarServiceSt ? _self.similarServiceSt : similarServiceSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,service: freezed == service ? _self.service : service // ignore: cast_nullable_to_non_nullable
as ServiceModel?,listService: freezed == listService ? _self.listService : listService // ignore: cast_nullable_to_non_nullable
as PaginatedServiceResponse?,serviceId: freezed == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ServiceViewState].
extension ServiceViewStatePatterns on ServiceViewState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServiceViewState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServiceViewState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServiceViewState value)  $default,){
final _that = this;
switch (_that) {
case _ServiceViewState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServiceViewState value)?  $default,){
final _that = this;
switch (_that) {
case _ServiceViewState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestStatus status,  RequestStatus similarServiceSt,  bool isLoadingMore,  ServiceModel? service,  PaginatedServiceResponse? listService,  int? serviceId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServiceViewState() when $default != null:
return $default(_that.status,_that.similarServiceSt,_that.isLoadingMore,_that.service,_that.listService,_that.serviceId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestStatus status,  RequestStatus similarServiceSt,  bool isLoadingMore,  ServiceModel? service,  PaginatedServiceResponse? listService,  int? serviceId)  $default,) {final _that = this;
switch (_that) {
case _ServiceViewState():
return $default(_that.status,_that.similarServiceSt,_that.isLoadingMore,_that.service,_that.listService,_that.serviceId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestStatus status,  RequestStatus similarServiceSt,  bool isLoadingMore,  ServiceModel? service,  PaginatedServiceResponse? listService,  int? serviceId)?  $default,) {final _that = this;
switch (_that) {
case _ServiceViewState() when $default != null:
return $default(_that.status,_that.similarServiceSt,_that.isLoadingMore,_that.service,_that.listService,_that.serviceId);case _:
  return null;

}
}

}

/// @nodoc


class _ServiceViewState implements ServiceViewState {
  const _ServiceViewState({this.status = RequestStatus.initial, this.similarServiceSt = RequestStatus.initial, this.isLoadingMore = false, this.service = null, this.listService = null, this.serviceId = null});
  

@override@JsonKey() final  RequestStatus status;
@override@JsonKey() final  RequestStatus similarServiceSt;
@override@JsonKey() final  bool isLoadingMore;
@override@JsonKey() final  ServiceModel? service;
@override@JsonKey() final  PaginatedServiceResponse? listService;
@override@JsonKey() final  int? serviceId;

/// Create a copy of ServiceViewState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceViewStateCopyWith<_ServiceViewState> get copyWith => __$ServiceViewStateCopyWithImpl<_ServiceViewState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceViewState&&(identical(other.status, status) || other.status == status)&&(identical(other.similarServiceSt, similarServiceSt) || other.similarServiceSt == similarServiceSt)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.service, service) || other.service == service)&&(identical(other.listService, listService) || other.listService == listService)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId));
}


@override
int get hashCode => Object.hash(runtimeType,status,similarServiceSt,isLoadingMore,service,listService,serviceId);

@override
String toString() {
  return 'ServiceViewState(status: $status, similarServiceSt: $similarServiceSt, isLoadingMore: $isLoadingMore, service: $service, listService: $listService, serviceId: $serviceId)';
}


}

/// @nodoc
abstract mixin class _$ServiceViewStateCopyWith<$Res> implements $ServiceViewStateCopyWith<$Res> {
  factory _$ServiceViewStateCopyWith(_ServiceViewState value, $Res Function(_ServiceViewState) _then) = __$ServiceViewStateCopyWithImpl;
@override @useResult
$Res call({
 RequestStatus status, RequestStatus similarServiceSt, bool isLoadingMore, ServiceModel? service, PaginatedServiceResponse? listService, int? serviceId
});




}
/// @nodoc
class __$ServiceViewStateCopyWithImpl<$Res>
    implements _$ServiceViewStateCopyWith<$Res> {
  __$ServiceViewStateCopyWithImpl(this._self, this._then);

  final _ServiceViewState _self;
  final $Res Function(_ServiceViewState) _then;

/// Create a copy of ServiceViewState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? similarServiceSt = null,Object? isLoadingMore = null,Object? service = freezed,Object? listService = freezed,Object? serviceId = freezed,}) {
  return _then(_ServiceViewState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,similarServiceSt: null == similarServiceSt ? _self.similarServiceSt : similarServiceSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,service: freezed == service ? _self.service : service // ignore: cast_nullable_to_non_nullable
as ServiceModel?,listService: freezed == listService ? _self.listService : listService // ignore: cast_nullable_to_non_nullable
as PaginatedServiceResponse?,serviceId: freezed == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
