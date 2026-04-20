// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_view_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TaskViewState {

 RequestStatus get status; RequestStatus get similarTasksSt; RequestStatus get requestTasksSt; RequestStatus get ownTaskRequestSt; bool get isLoadingMore; TaskModel? get task; PaginatedTaskListResponse? get listTasks; TaskRequest? get myRequest; int? get taskId;
/// Create a copy of TaskViewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskViewStateCopyWith<TaskViewState> get copyWith => _$TaskViewStateCopyWithImpl<TaskViewState>(this as TaskViewState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskViewState&&(identical(other.status, status) || other.status == status)&&(identical(other.similarTasksSt, similarTasksSt) || other.similarTasksSt == similarTasksSt)&&(identical(other.requestTasksSt, requestTasksSt) || other.requestTasksSt == requestTasksSt)&&(identical(other.ownTaskRequestSt, ownTaskRequestSt) || other.ownTaskRequestSt == ownTaskRequestSt)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.task, task) || other.task == task)&&(identical(other.listTasks, listTasks) || other.listTasks == listTasks)&&(identical(other.myRequest, myRequest) || other.myRequest == myRequest)&&(identical(other.taskId, taskId) || other.taskId == taskId));
}


@override
int get hashCode => Object.hash(runtimeType,status,similarTasksSt,requestTasksSt,ownTaskRequestSt,isLoadingMore,task,listTasks,myRequest,taskId);

@override
String toString() {
  return 'TaskViewState(status: $status, similarTasksSt: $similarTasksSt, requestTasksSt: $requestTasksSt, ownTaskRequestSt: $ownTaskRequestSt, isLoadingMore: $isLoadingMore, task: $task, listTasks: $listTasks, myRequest: $myRequest, taskId: $taskId)';
}


}

/// @nodoc
abstract mixin class $TaskViewStateCopyWith<$Res>  {
  factory $TaskViewStateCopyWith(TaskViewState value, $Res Function(TaskViewState) _then) = _$TaskViewStateCopyWithImpl;
@useResult
$Res call({
 RequestStatus status, RequestStatus similarTasksSt, RequestStatus requestTasksSt, RequestStatus ownTaskRequestSt, bool isLoadingMore, TaskModel? task, PaginatedTaskListResponse? listTasks, TaskRequest? myRequest, int? taskId
});




}
/// @nodoc
class _$TaskViewStateCopyWithImpl<$Res>
    implements $TaskViewStateCopyWith<$Res> {
  _$TaskViewStateCopyWithImpl(this._self, this._then);

  final TaskViewState _self;
  final $Res Function(TaskViewState) _then;

/// Create a copy of TaskViewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? similarTasksSt = null,Object? requestTasksSt = null,Object? ownTaskRequestSt = null,Object? isLoadingMore = null,Object? task = freezed,Object? listTasks = freezed,Object? myRequest = freezed,Object? taskId = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,similarTasksSt: null == similarTasksSt ? _self.similarTasksSt : similarTasksSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,requestTasksSt: null == requestTasksSt ? _self.requestTasksSt : requestTasksSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,ownTaskRequestSt: null == ownTaskRequestSt ? _self.ownTaskRequestSt : ownTaskRequestSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,task: freezed == task ? _self.task : task // ignore: cast_nullable_to_non_nullable
as TaskModel?,listTasks: freezed == listTasks ? _self.listTasks : listTasks // ignore: cast_nullable_to_non_nullable
as PaginatedTaskListResponse?,myRequest: freezed == myRequest ? _self.myRequest : myRequest // ignore: cast_nullable_to_non_nullable
as TaskRequest?,taskId: freezed == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [TaskViewState].
extension TaskViewStatePatterns on TaskViewState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskViewState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskViewState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskViewState value)  $default,){
final _that = this;
switch (_that) {
case _TaskViewState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskViewState value)?  $default,){
final _that = this;
switch (_that) {
case _TaskViewState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestStatus status,  RequestStatus similarTasksSt,  RequestStatus requestTasksSt,  RequestStatus ownTaskRequestSt,  bool isLoadingMore,  TaskModel? task,  PaginatedTaskListResponse? listTasks,  TaskRequest? myRequest,  int? taskId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskViewState() when $default != null:
return $default(_that.status,_that.similarTasksSt,_that.requestTasksSt,_that.ownTaskRequestSt,_that.isLoadingMore,_that.task,_that.listTasks,_that.myRequest,_that.taskId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestStatus status,  RequestStatus similarTasksSt,  RequestStatus requestTasksSt,  RequestStatus ownTaskRequestSt,  bool isLoadingMore,  TaskModel? task,  PaginatedTaskListResponse? listTasks,  TaskRequest? myRequest,  int? taskId)  $default,) {final _that = this;
switch (_that) {
case _TaskViewState():
return $default(_that.status,_that.similarTasksSt,_that.requestTasksSt,_that.ownTaskRequestSt,_that.isLoadingMore,_that.task,_that.listTasks,_that.myRequest,_that.taskId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestStatus status,  RequestStatus similarTasksSt,  RequestStatus requestTasksSt,  RequestStatus ownTaskRequestSt,  bool isLoadingMore,  TaskModel? task,  PaginatedTaskListResponse? listTasks,  TaskRequest? myRequest,  int? taskId)?  $default,) {final _that = this;
switch (_that) {
case _TaskViewState() when $default != null:
return $default(_that.status,_that.similarTasksSt,_that.requestTasksSt,_that.ownTaskRequestSt,_that.isLoadingMore,_that.task,_that.listTasks,_that.myRequest,_that.taskId);case _:
  return null;

}
}

}

/// @nodoc


class _TaskViewState implements TaskViewState {
  const _TaskViewState({this.status = RequestStatus.initial, this.similarTasksSt = RequestStatus.initial, this.requestTasksSt = RequestStatus.initial, this.ownTaskRequestSt = RequestStatus.initial, this.isLoadingMore = false, this.task = null, this.listTasks = null, this.myRequest = null, this.taskId = null});
  

@override@JsonKey() final  RequestStatus status;
@override@JsonKey() final  RequestStatus similarTasksSt;
@override@JsonKey() final  RequestStatus requestTasksSt;
@override@JsonKey() final  RequestStatus ownTaskRequestSt;
@override@JsonKey() final  bool isLoadingMore;
@override@JsonKey() final  TaskModel? task;
@override@JsonKey() final  PaginatedTaskListResponse? listTasks;
@override@JsonKey() final  TaskRequest? myRequest;
@override@JsonKey() final  int? taskId;

/// Create a copy of TaskViewState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskViewStateCopyWith<_TaskViewState> get copyWith => __$TaskViewStateCopyWithImpl<_TaskViewState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskViewState&&(identical(other.status, status) || other.status == status)&&(identical(other.similarTasksSt, similarTasksSt) || other.similarTasksSt == similarTasksSt)&&(identical(other.requestTasksSt, requestTasksSt) || other.requestTasksSt == requestTasksSt)&&(identical(other.ownTaskRequestSt, ownTaskRequestSt) || other.ownTaskRequestSt == ownTaskRequestSt)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.task, task) || other.task == task)&&(identical(other.listTasks, listTasks) || other.listTasks == listTasks)&&(identical(other.myRequest, myRequest) || other.myRequest == myRequest)&&(identical(other.taskId, taskId) || other.taskId == taskId));
}


@override
int get hashCode => Object.hash(runtimeType,status,similarTasksSt,requestTasksSt,ownTaskRequestSt,isLoadingMore,task,listTasks,myRequest,taskId);

@override
String toString() {
  return 'TaskViewState(status: $status, similarTasksSt: $similarTasksSt, requestTasksSt: $requestTasksSt, ownTaskRequestSt: $ownTaskRequestSt, isLoadingMore: $isLoadingMore, task: $task, listTasks: $listTasks, myRequest: $myRequest, taskId: $taskId)';
}


}

/// @nodoc
abstract mixin class _$TaskViewStateCopyWith<$Res> implements $TaskViewStateCopyWith<$Res> {
  factory _$TaskViewStateCopyWith(_TaskViewState value, $Res Function(_TaskViewState) _then) = __$TaskViewStateCopyWithImpl;
@override @useResult
$Res call({
 RequestStatus status, RequestStatus similarTasksSt, RequestStatus requestTasksSt, RequestStatus ownTaskRequestSt, bool isLoadingMore, TaskModel? task, PaginatedTaskListResponse? listTasks, TaskRequest? myRequest, int? taskId
});




}
/// @nodoc
class __$TaskViewStateCopyWithImpl<$Res>
    implements _$TaskViewStateCopyWith<$Res> {
  __$TaskViewStateCopyWithImpl(this._self, this._then);

  final _TaskViewState _self;
  final $Res Function(_TaskViewState) _then;

/// Create a copy of TaskViewState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? similarTasksSt = null,Object? requestTasksSt = null,Object? ownTaskRequestSt = null,Object? isLoadingMore = null,Object? task = freezed,Object? listTasks = freezed,Object? myRequest = freezed,Object? taskId = freezed,}) {
  return _then(_TaskViewState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,similarTasksSt: null == similarTasksSt ? _self.similarTasksSt : similarTasksSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,requestTasksSt: null == requestTasksSt ? _self.requestTasksSt : requestTasksSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,ownTaskRequestSt: null == ownTaskRequestSt ? _self.ownTaskRequestSt : ownTaskRequestSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,task: freezed == task ? _self.task : task // ignore: cast_nullable_to_non_nullable
as TaskModel?,listTasks: freezed == listTasks ? _self.listTasks : listTasks // ignore: cast_nullable_to_non_nullable
as PaginatedTaskListResponse?,myRequest: freezed == myRequest ? _self.myRequest : myRequest // ignore: cast_nullable_to_non_nullable
as TaskRequest?,taskId: freezed == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
