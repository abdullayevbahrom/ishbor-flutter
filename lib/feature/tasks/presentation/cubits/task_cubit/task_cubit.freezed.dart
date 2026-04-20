// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TaskState {

 RequestStatus get status; RequestStatus get similarTasSt; String? get errorText; PaginatedTaskListResponse? get listTask; PaginatedTaskListResponse? get listSimilarTask; bool get isLoadingMore;
/// Create a copy of TaskState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskStateCopyWith<TaskState> get copyWith => _$TaskStateCopyWithImpl<TaskState>(this as TaskState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskState&&(identical(other.status, status) || other.status == status)&&(identical(other.similarTasSt, similarTasSt) || other.similarTasSt == similarTasSt)&&(identical(other.errorText, errorText) || other.errorText == errorText)&&(identical(other.listTask, listTask) || other.listTask == listTask)&&(identical(other.listSimilarTask, listSimilarTask) || other.listSimilarTask == listSimilarTask)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore));
}


@override
int get hashCode => Object.hash(runtimeType,status,similarTasSt,errorText,listTask,listSimilarTask,isLoadingMore);

@override
String toString() {
  return 'TaskState(status: $status, similarTasSt: $similarTasSt, errorText: $errorText, listTask: $listTask, listSimilarTask: $listSimilarTask, isLoadingMore: $isLoadingMore)';
}


}

/// @nodoc
abstract mixin class $TaskStateCopyWith<$Res>  {
  factory $TaskStateCopyWith(TaskState value, $Res Function(TaskState) _then) = _$TaskStateCopyWithImpl;
@useResult
$Res call({
 RequestStatus status, RequestStatus similarTasSt, String? errorText, PaginatedTaskListResponse? listTask, PaginatedTaskListResponse? listSimilarTask, bool isLoadingMore
});




}
/// @nodoc
class _$TaskStateCopyWithImpl<$Res>
    implements $TaskStateCopyWith<$Res> {
  _$TaskStateCopyWithImpl(this._self, this._then);

  final TaskState _self;
  final $Res Function(TaskState) _then;

/// Create a copy of TaskState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? similarTasSt = null,Object? errorText = freezed,Object? listTask = freezed,Object? listSimilarTask = freezed,Object? isLoadingMore = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,similarTasSt: null == similarTasSt ? _self.similarTasSt : similarTasSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,errorText: freezed == errorText ? _self.errorText : errorText // ignore: cast_nullable_to_non_nullable
as String?,listTask: freezed == listTask ? _self.listTask : listTask // ignore: cast_nullable_to_non_nullable
as PaginatedTaskListResponse?,listSimilarTask: freezed == listSimilarTask ? _self.listSimilarTask : listSimilarTask // ignore: cast_nullable_to_non_nullable
as PaginatedTaskListResponse?,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TaskState].
extension TaskStatePatterns on TaskState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskState value)  $default,){
final _that = this;
switch (_that) {
case _TaskState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskState value)?  $default,){
final _that = this;
switch (_that) {
case _TaskState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestStatus status,  RequestStatus similarTasSt,  String? errorText,  PaginatedTaskListResponse? listTask,  PaginatedTaskListResponse? listSimilarTask,  bool isLoadingMore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskState() when $default != null:
return $default(_that.status,_that.similarTasSt,_that.errorText,_that.listTask,_that.listSimilarTask,_that.isLoadingMore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestStatus status,  RequestStatus similarTasSt,  String? errorText,  PaginatedTaskListResponse? listTask,  PaginatedTaskListResponse? listSimilarTask,  bool isLoadingMore)  $default,) {final _that = this;
switch (_that) {
case _TaskState():
return $default(_that.status,_that.similarTasSt,_that.errorText,_that.listTask,_that.listSimilarTask,_that.isLoadingMore);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestStatus status,  RequestStatus similarTasSt,  String? errorText,  PaginatedTaskListResponse? listTask,  PaginatedTaskListResponse? listSimilarTask,  bool isLoadingMore)?  $default,) {final _that = this;
switch (_that) {
case _TaskState() when $default != null:
return $default(_that.status,_that.similarTasSt,_that.errorText,_that.listTask,_that.listSimilarTask,_that.isLoadingMore);case _:
  return null;

}
}

}

/// @nodoc


class _TaskState implements TaskState {
  const _TaskState({this.status = RequestStatus.initial, this.similarTasSt = RequestStatus.initial, this.errorText = null, this.listTask = null, this.listSimilarTask = null, this.isLoadingMore = false});
  

@override@JsonKey() final  RequestStatus status;
@override@JsonKey() final  RequestStatus similarTasSt;
@override@JsonKey() final  String? errorText;
@override@JsonKey() final  PaginatedTaskListResponse? listTask;
@override@JsonKey() final  PaginatedTaskListResponse? listSimilarTask;
@override@JsonKey() final  bool isLoadingMore;

/// Create a copy of TaskState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskStateCopyWith<_TaskState> get copyWith => __$TaskStateCopyWithImpl<_TaskState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskState&&(identical(other.status, status) || other.status == status)&&(identical(other.similarTasSt, similarTasSt) || other.similarTasSt == similarTasSt)&&(identical(other.errorText, errorText) || other.errorText == errorText)&&(identical(other.listTask, listTask) || other.listTask == listTask)&&(identical(other.listSimilarTask, listSimilarTask) || other.listSimilarTask == listSimilarTask)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore));
}


@override
int get hashCode => Object.hash(runtimeType,status,similarTasSt,errorText,listTask,listSimilarTask,isLoadingMore);

@override
String toString() {
  return 'TaskState(status: $status, similarTasSt: $similarTasSt, errorText: $errorText, listTask: $listTask, listSimilarTask: $listSimilarTask, isLoadingMore: $isLoadingMore)';
}


}

/// @nodoc
abstract mixin class _$TaskStateCopyWith<$Res> implements $TaskStateCopyWith<$Res> {
  factory _$TaskStateCopyWith(_TaskState value, $Res Function(_TaskState) _then) = __$TaskStateCopyWithImpl;
@override @useResult
$Res call({
 RequestStatus status, RequestStatus similarTasSt, String? errorText, PaginatedTaskListResponse? listTask, PaginatedTaskListResponse? listSimilarTask, bool isLoadingMore
});




}
/// @nodoc
class __$TaskStateCopyWithImpl<$Res>
    implements _$TaskStateCopyWith<$Res> {
  __$TaskStateCopyWithImpl(this._self, this._then);

  final _TaskState _self;
  final $Res Function(_TaskState) _then;

/// Create a copy of TaskState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? similarTasSt = null,Object? errorText = freezed,Object? listTask = freezed,Object? listSimilarTask = freezed,Object? isLoadingMore = null,}) {
  return _then(_TaskState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,similarTasSt: null == similarTasSt ? _self.similarTasSt : similarTasSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,errorText: freezed == errorText ? _self.errorText : errorText // ignore: cast_nullable_to_non_nullable
as String?,listTask: freezed == listTask ? _self.listTask : listTask // ignore: cast_nullable_to_non_nullable
as PaginatedTaskListResponse?,listSimilarTask: freezed == listSimilarTask ? _self.listSimilarTask : listSimilarTask // ignore: cast_nullable_to_non_nullable
as PaginatedTaskListResponse?,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
