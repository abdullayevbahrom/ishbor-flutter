// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_requests_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TaskRequestsState {

 RequestStatus get status; RequestStatus get choosePerformerSt; RequestStatus get cancelPerformerSt; RequestStatus get finishTaskSt; PaginatedTaskRequestList? get listTaskRequest; TaskModel? get task; TaskRequest? get taskRequest;
/// Create a copy of TaskRequestsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskRequestsStateCopyWith<TaskRequestsState> get copyWith => _$TaskRequestsStateCopyWithImpl<TaskRequestsState>(this as TaskRequestsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskRequestsState&&(identical(other.status, status) || other.status == status)&&(identical(other.choosePerformerSt, choosePerformerSt) || other.choosePerformerSt == choosePerformerSt)&&(identical(other.cancelPerformerSt, cancelPerformerSt) || other.cancelPerformerSt == cancelPerformerSt)&&(identical(other.finishTaskSt, finishTaskSt) || other.finishTaskSt == finishTaskSt)&&(identical(other.listTaskRequest, listTaskRequest) || other.listTaskRequest == listTaskRequest)&&(identical(other.task, task) || other.task == task)&&(identical(other.taskRequest, taskRequest) || other.taskRequest == taskRequest));
}


@override
int get hashCode => Object.hash(runtimeType,status,choosePerformerSt,cancelPerformerSt,finishTaskSt,listTaskRequest,task,taskRequest);

@override
String toString() {
  return 'TaskRequestsState(status: $status, choosePerformerSt: $choosePerformerSt, cancelPerformerSt: $cancelPerformerSt, finishTaskSt: $finishTaskSt, listTaskRequest: $listTaskRequest, task: $task, taskRequest: $taskRequest)';
}


}

/// @nodoc
abstract mixin class $TaskRequestsStateCopyWith<$Res>  {
  factory $TaskRequestsStateCopyWith(TaskRequestsState value, $Res Function(TaskRequestsState) _then) = _$TaskRequestsStateCopyWithImpl;
@useResult
$Res call({
 RequestStatus status, RequestStatus choosePerformerSt, RequestStatus cancelPerformerSt, RequestStatus finishTaskSt, PaginatedTaskRequestList? listTaskRequest, TaskModel? task, TaskRequest? taskRequest
});




}
/// @nodoc
class _$TaskRequestsStateCopyWithImpl<$Res>
    implements $TaskRequestsStateCopyWith<$Res> {
  _$TaskRequestsStateCopyWithImpl(this._self, this._then);

  final TaskRequestsState _self;
  final $Res Function(TaskRequestsState) _then;

/// Create a copy of TaskRequestsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? choosePerformerSt = null,Object? cancelPerformerSt = null,Object? finishTaskSt = null,Object? listTaskRequest = freezed,Object? task = freezed,Object? taskRequest = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,choosePerformerSt: null == choosePerformerSt ? _self.choosePerformerSt : choosePerformerSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,cancelPerformerSt: null == cancelPerformerSt ? _self.cancelPerformerSt : cancelPerformerSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,finishTaskSt: null == finishTaskSt ? _self.finishTaskSt : finishTaskSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,listTaskRequest: freezed == listTaskRequest ? _self.listTaskRequest : listTaskRequest // ignore: cast_nullable_to_non_nullable
as PaginatedTaskRequestList?,task: freezed == task ? _self.task : task // ignore: cast_nullable_to_non_nullable
as TaskModel?,taskRequest: freezed == taskRequest ? _self.taskRequest : taskRequest // ignore: cast_nullable_to_non_nullable
as TaskRequest?,
  ));
}

}


/// Adds pattern-matching-related methods to [TaskRequestsState].
extension TaskRequestsStatePatterns on TaskRequestsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskRequestsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskRequestsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskRequestsState value)  $default,){
final _that = this;
switch (_that) {
case _TaskRequestsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskRequestsState value)?  $default,){
final _that = this;
switch (_that) {
case _TaskRequestsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestStatus status,  RequestStatus choosePerformerSt,  RequestStatus cancelPerformerSt,  RequestStatus finishTaskSt,  PaginatedTaskRequestList? listTaskRequest,  TaskModel? task,  TaskRequest? taskRequest)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskRequestsState() when $default != null:
return $default(_that.status,_that.choosePerformerSt,_that.cancelPerformerSt,_that.finishTaskSt,_that.listTaskRequest,_that.task,_that.taskRequest);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestStatus status,  RequestStatus choosePerformerSt,  RequestStatus cancelPerformerSt,  RequestStatus finishTaskSt,  PaginatedTaskRequestList? listTaskRequest,  TaskModel? task,  TaskRequest? taskRequest)  $default,) {final _that = this;
switch (_that) {
case _TaskRequestsState():
return $default(_that.status,_that.choosePerformerSt,_that.cancelPerformerSt,_that.finishTaskSt,_that.listTaskRequest,_that.task,_that.taskRequest);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestStatus status,  RequestStatus choosePerformerSt,  RequestStatus cancelPerformerSt,  RequestStatus finishTaskSt,  PaginatedTaskRequestList? listTaskRequest,  TaskModel? task,  TaskRequest? taskRequest)?  $default,) {final _that = this;
switch (_that) {
case _TaskRequestsState() when $default != null:
return $default(_that.status,_that.choosePerformerSt,_that.cancelPerformerSt,_that.finishTaskSt,_that.listTaskRequest,_that.task,_that.taskRequest);case _:
  return null;

}
}

}

/// @nodoc


class _TaskRequestsState implements TaskRequestsState {
  const _TaskRequestsState({this.status = RequestStatus.initial, this.choosePerformerSt = RequestStatus.initial, this.cancelPerformerSt = RequestStatus.initial, this.finishTaskSt = RequestStatus.initial, this.listTaskRequest = null, this.task = null, this.taskRequest = null});
  

@override@JsonKey() final  RequestStatus status;
@override@JsonKey() final  RequestStatus choosePerformerSt;
@override@JsonKey() final  RequestStatus cancelPerformerSt;
@override@JsonKey() final  RequestStatus finishTaskSt;
@override@JsonKey() final  PaginatedTaskRequestList? listTaskRequest;
@override@JsonKey() final  TaskModel? task;
@override@JsonKey() final  TaskRequest? taskRequest;

/// Create a copy of TaskRequestsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskRequestsStateCopyWith<_TaskRequestsState> get copyWith => __$TaskRequestsStateCopyWithImpl<_TaskRequestsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskRequestsState&&(identical(other.status, status) || other.status == status)&&(identical(other.choosePerformerSt, choosePerformerSt) || other.choosePerformerSt == choosePerformerSt)&&(identical(other.cancelPerformerSt, cancelPerformerSt) || other.cancelPerformerSt == cancelPerformerSt)&&(identical(other.finishTaskSt, finishTaskSt) || other.finishTaskSt == finishTaskSt)&&(identical(other.listTaskRequest, listTaskRequest) || other.listTaskRequest == listTaskRequest)&&(identical(other.task, task) || other.task == task)&&(identical(other.taskRequest, taskRequest) || other.taskRequest == taskRequest));
}


@override
int get hashCode => Object.hash(runtimeType,status,choosePerformerSt,cancelPerformerSt,finishTaskSt,listTaskRequest,task,taskRequest);

@override
String toString() {
  return 'TaskRequestsState(status: $status, choosePerformerSt: $choosePerformerSt, cancelPerformerSt: $cancelPerformerSt, finishTaskSt: $finishTaskSt, listTaskRequest: $listTaskRequest, task: $task, taskRequest: $taskRequest)';
}


}

/// @nodoc
abstract mixin class _$TaskRequestsStateCopyWith<$Res> implements $TaskRequestsStateCopyWith<$Res> {
  factory _$TaskRequestsStateCopyWith(_TaskRequestsState value, $Res Function(_TaskRequestsState) _then) = __$TaskRequestsStateCopyWithImpl;
@override @useResult
$Res call({
 RequestStatus status, RequestStatus choosePerformerSt, RequestStatus cancelPerformerSt, RequestStatus finishTaskSt, PaginatedTaskRequestList? listTaskRequest, TaskModel? task, TaskRequest? taskRequest
});




}
/// @nodoc
class __$TaskRequestsStateCopyWithImpl<$Res>
    implements _$TaskRequestsStateCopyWith<$Res> {
  __$TaskRequestsStateCopyWithImpl(this._self, this._then);

  final _TaskRequestsState _self;
  final $Res Function(_TaskRequestsState) _then;

/// Create a copy of TaskRequestsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? choosePerformerSt = null,Object? cancelPerformerSt = null,Object? finishTaskSt = null,Object? listTaskRequest = freezed,Object? task = freezed,Object? taskRequest = freezed,}) {
  return _then(_TaskRequestsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,choosePerformerSt: null == choosePerformerSt ? _self.choosePerformerSt : choosePerformerSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,cancelPerformerSt: null == cancelPerformerSt ? _self.cancelPerformerSt : cancelPerformerSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,finishTaskSt: null == finishTaskSt ? _self.finishTaskSt : finishTaskSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,listTaskRequest: freezed == listTaskRequest ? _self.listTaskRequest : listTaskRequest // ignore: cast_nullable_to_non_nullable
as PaginatedTaskRequestList?,task: freezed == task ? _self.task : task // ignore: cast_nullable_to_non_nullable
as TaskModel?,taskRequest: freezed == taskRequest ? _self.taskRequest : taskRequest // ignore: cast_nullable_to_non_nullable
as TaskRequest?,
  ));
}


}

// dart format on
