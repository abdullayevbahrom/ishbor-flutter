// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_details_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotificationDetailsState {

 RequestStatus get status; String? get errorText; Vacancy? get vacancy; ServiceModel? get service; TaskModel? get task; Message? get message;
/// Create a copy of NotificationDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationDetailsStateCopyWith<NotificationDetailsState> get copyWith => _$NotificationDetailsStateCopyWithImpl<NotificationDetailsState>(this as NotificationDetailsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationDetailsState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorText, errorText) || other.errorText == errorText)&&(identical(other.vacancy, vacancy) || other.vacancy == vacancy)&&(identical(other.service, service) || other.service == service)&&(identical(other.task, task) || other.task == task)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,status,errorText,vacancy,service,task,message);

@override
String toString() {
  return 'NotificationDetailsState(status: $status, errorText: $errorText, vacancy: $vacancy, service: $service, task: $task, message: $message)';
}


}

/// @nodoc
abstract mixin class $NotificationDetailsStateCopyWith<$Res>  {
  factory $NotificationDetailsStateCopyWith(NotificationDetailsState value, $Res Function(NotificationDetailsState) _then) = _$NotificationDetailsStateCopyWithImpl;
@useResult
$Res call({
 RequestStatus status, String? errorText, Vacancy? vacancy, ServiceModel? service, TaskModel? task, Message? message
});




}
/// @nodoc
class _$NotificationDetailsStateCopyWithImpl<$Res>
    implements $NotificationDetailsStateCopyWith<$Res> {
  _$NotificationDetailsStateCopyWithImpl(this._self, this._then);

  final NotificationDetailsState _self;
  final $Res Function(NotificationDetailsState) _then;

/// Create a copy of NotificationDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? errorText = freezed,Object? vacancy = freezed,Object? service = freezed,Object? task = freezed,Object? message = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,errorText: freezed == errorText ? _self.errorText : errorText // ignore: cast_nullable_to_non_nullable
as String?,vacancy: freezed == vacancy ? _self.vacancy : vacancy // ignore: cast_nullable_to_non_nullable
as Vacancy?,service: freezed == service ? _self.service : service // ignore: cast_nullable_to_non_nullable
as ServiceModel?,task: freezed == task ? _self.task : task // ignore: cast_nullable_to_non_nullable
as TaskModel?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as Message?,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationDetailsState].
extension NotificationDetailsStatePatterns on NotificationDetailsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationDetailsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationDetailsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationDetailsState value)  $default,){
final _that = this;
switch (_that) {
case _NotificationDetailsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationDetailsState value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationDetailsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestStatus status,  String? errorText,  Vacancy? vacancy,  ServiceModel? service,  TaskModel? task,  Message? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationDetailsState() when $default != null:
return $default(_that.status,_that.errorText,_that.vacancy,_that.service,_that.task,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestStatus status,  String? errorText,  Vacancy? vacancy,  ServiceModel? service,  TaskModel? task,  Message? message)  $default,) {final _that = this;
switch (_that) {
case _NotificationDetailsState():
return $default(_that.status,_that.errorText,_that.vacancy,_that.service,_that.task,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestStatus status,  String? errorText,  Vacancy? vacancy,  ServiceModel? service,  TaskModel? task,  Message? message)?  $default,) {final _that = this;
switch (_that) {
case _NotificationDetailsState() when $default != null:
return $default(_that.status,_that.errorText,_that.vacancy,_that.service,_that.task,_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _NotificationDetailsState implements NotificationDetailsState {
  const _NotificationDetailsState({this.status = RequestStatus.initial, this.errorText = null, this.vacancy = null, this.service = null, this.task = null, this.message = null});
  

@override@JsonKey() final  RequestStatus status;
@override@JsonKey() final  String? errorText;
@override@JsonKey() final  Vacancy? vacancy;
@override@JsonKey() final  ServiceModel? service;
@override@JsonKey() final  TaskModel? task;
@override@JsonKey() final  Message? message;

/// Create a copy of NotificationDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationDetailsStateCopyWith<_NotificationDetailsState> get copyWith => __$NotificationDetailsStateCopyWithImpl<_NotificationDetailsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationDetailsState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorText, errorText) || other.errorText == errorText)&&(identical(other.vacancy, vacancy) || other.vacancy == vacancy)&&(identical(other.service, service) || other.service == service)&&(identical(other.task, task) || other.task == task)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,status,errorText,vacancy,service,task,message);

@override
String toString() {
  return 'NotificationDetailsState(status: $status, errorText: $errorText, vacancy: $vacancy, service: $service, task: $task, message: $message)';
}


}

/// @nodoc
abstract mixin class _$NotificationDetailsStateCopyWith<$Res> implements $NotificationDetailsStateCopyWith<$Res> {
  factory _$NotificationDetailsStateCopyWith(_NotificationDetailsState value, $Res Function(_NotificationDetailsState) _then) = __$NotificationDetailsStateCopyWithImpl;
@override @useResult
$Res call({
 RequestStatus status, String? errorText, Vacancy? vacancy, ServiceModel? service, TaskModel? task, Message? message
});




}
/// @nodoc
class __$NotificationDetailsStateCopyWithImpl<$Res>
    implements _$NotificationDetailsStateCopyWith<$Res> {
  __$NotificationDetailsStateCopyWithImpl(this._self, this._then);

  final _NotificationDetailsState _self;
  final $Res Function(_NotificationDetailsState) _then;

/// Create a copy of NotificationDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? errorText = freezed,Object? vacancy = freezed,Object? service = freezed,Object? task = freezed,Object? message = freezed,}) {
  return _then(_NotificationDetailsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,errorText: freezed == errorText ? _self.errorText : errorText // ignore: cast_nullable_to_non_nullable
as String?,vacancy: freezed == vacancy ? _self.vacancy : vacancy // ignore: cast_nullable_to_non_nullable
as Vacancy?,service: freezed == service ? _self.service : service // ignore: cast_nullable_to_non_nullable
as ServiceModel?,task: freezed == task ? _self.task : task // ignore: cast_nullable_to_non_nullable
as TaskModel?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as Message?,
  ));
}


}

// dart format on
