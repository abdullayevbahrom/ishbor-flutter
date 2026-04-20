// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_tasks_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MyTasksState {

 RequestStatus get myTaskSt; RequestStatus get myTaskAppliesSt; RequestStatus get liftUpTaskSt; RequestStatus get deactivateTaskSt; RequestStatus get deleteTaskSt; bool get isLoadingMore1; bool get isLoadingMore2; PaginatedTaskListResponse? get myTasks; PaginatedTaskResponse? get myTaskApplies; String? get errorText;
/// Create a copy of MyTasksState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MyTasksStateCopyWith<MyTasksState> get copyWith => _$MyTasksStateCopyWithImpl<MyTasksState>(this as MyTasksState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyTasksState&&(identical(other.myTaskSt, myTaskSt) || other.myTaskSt == myTaskSt)&&(identical(other.myTaskAppliesSt, myTaskAppliesSt) || other.myTaskAppliesSt == myTaskAppliesSt)&&(identical(other.liftUpTaskSt, liftUpTaskSt) || other.liftUpTaskSt == liftUpTaskSt)&&(identical(other.deactivateTaskSt, deactivateTaskSt) || other.deactivateTaskSt == deactivateTaskSt)&&(identical(other.deleteTaskSt, deleteTaskSt) || other.deleteTaskSt == deleteTaskSt)&&(identical(other.isLoadingMore1, isLoadingMore1) || other.isLoadingMore1 == isLoadingMore1)&&(identical(other.isLoadingMore2, isLoadingMore2) || other.isLoadingMore2 == isLoadingMore2)&&(identical(other.myTasks, myTasks) || other.myTasks == myTasks)&&(identical(other.myTaskApplies, myTaskApplies) || other.myTaskApplies == myTaskApplies)&&(identical(other.errorText, errorText) || other.errorText == errorText));
}


@override
int get hashCode => Object.hash(runtimeType,myTaskSt,myTaskAppliesSt,liftUpTaskSt,deactivateTaskSt,deleteTaskSt,isLoadingMore1,isLoadingMore2,myTasks,myTaskApplies,errorText);

@override
String toString() {
  return 'MyTasksState(myTaskSt: $myTaskSt, myTaskAppliesSt: $myTaskAppliesSt, liftUpTaskSt: $liftUpTaskSt, deactivateTaskSt: $deactivateTaskSt, deleteTaskSt: $deleteTaskSt, isLoadingMore1: $isLoadingMore1, isLoadingMore2: $isLoadingMore2, myTasks: $myTasks, myTaskApplies: $myTaskApplies, errorText: $errorText)';
}


}

/// @nodoc
abstract mixin class $MyTasksStateCopyWith<$Res>  {
  factory $MyTasksStateCopyWith(MyTasksState value, $Res Function(MyTasksState) _then) = _$MyTasksStateCopyWithImpl;
@useResult
$Res call({
 RequestStatus myTaskSt, RequestStatus myTaskAppliesSt, RequestStatus liftUpTaskSt, RequestStatus deactivateTaskSt, RequestStatus deleteTaskSt, bool isLoadingMore1, bool isLoadingMore2, PaginatedTaskListResponse? myTasks, PaginatedTaskResponse? myTaskApplies, String? errorText
});




}
/// @nodoc
class _$MyTasksStateCopyWithImpl<$Res>
    implements $MyTasksStateCopyWith<$Res> {
  _$MyTasksStateCopyWithImpl(this._self, this._then);

  final MyTasksState _self;
  final $Res Function(MyTasksState) _then;

/// Create a copy of MyTasksState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? myTaskSt = null,Object? myTaskAppliesSt = null,Object? liftUpTaskSt = null,Object? deactivateTaskSt = null,Object? deleteTaskSt = null,Object? isLoadingMore1 = null,Object? isLoadingMore2 = null,Object? myTasks = freezed,Object? myTaskApplies = freezed,Object? errorText = freezed,}) {
  return _then(_self.copyWith(
myTaskSt: null == myTaskSt ? _self.myTaskSt : myTaskSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,myTaskAppliesSt: null == myTaskAppliesSt ? _self.myTaskAppliesSt : myTaskAppliesSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,liftUpTaskSt: null == liftUpTaskSt ? _self.liftUpTaskSt : liftUpTaskSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,deactivateTaskSt: null == deactivateTaskSt ? _self.deactivateTaskSt : deactivateTaskSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,deleteTaskSt: null == deleteTaskSt ? _self.deleteTaskSt : deleteTaskSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,isLoadingMore1: null == isLoadingMore1 ? _self.isLoadingMore1 : isLoadingMore1 // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore2: null == isLoadingMore2 ? _self.isLoadingMore2 : isLoadingMore2 // ignore: cast_nullable_to_non_nullable
as bool,myTasks: freezed == myTasks ? _self.myTasks : myTasks // ignore: cast_nullable_to_non_nullable
as PaginatedTaskListResponse?,myTaskApplies: freezed == myTaskApplies ? _self.myTaskApplies : myTaskApplies // ignore: cast_nullable_to_non_nullable
as PaginatedTaskResponse?,errorText: freezed == errorText ? _self.errorText : errorText // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MyTasksState].
extension MyTasksStatePatterns on MyTasksState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MyTasksState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MyTasksState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MyTasksState value)  $default,){
final _that = this;
switch (_that) {
case _MyTasksState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MyTasksState value)?  $default,){
final _that = this;
switch (_that) {
case _MyTasksState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestStatus myTaskSt,  RequestStatus myTaskAppliesSt,  RequestStatus liftUpTaskSt,  RequestStatus deactivateTaskSt,  RequestStatus deleteTaskSt,  bool isLoadingMore1,  bool isLoadingMore2,  PaginatedTaskListResponse? myTasks,  PaginatedTaskResponse? myTaskApplies,  String? errorText)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MyTasksState() when $default != null:
return $default(_that.myTaskSt,_that.myTaskAppliesSt,_that.liftUpTaskSt,_that.deactivateTaskSt,_that.deleteTaskSt,_that.isLoadingMore1,_that.isLoadingMore2,_that.myTasks,_that.myTaskApplies,_that.errorText);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestStatus myTaskSt,  RequestStatus myTaskAppliesSt,  RequestStatus liftUpTaskSt,  RequestStatus deactivateTaskSt,  RequestStatus deleteTaskSt,  bool isLoadingMore1,  bool isLoadingMore2,  PaginatedTaskListResponse? myTasks,  PaginatedTaskResponse? myTaskApplies,  String? errorText)  $default,) {final _that = this;
switch (_that) {
case _MyTasksState():
return $default(_that.myTaskSt,_that.myTaskAppliesSt,_that.liftUpTaskSt,_that.deactivateTaskSt,_that.deleteTaskSt,_that.isLoadingMore1,_that.isLoadingMore2,_that.myTasks,_that.myTaskApplies,_that.errorText);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestStatus myTaskSt,  RequestStatus myTaskAppliesSt,  RequestStatus liftUpTaskSt,  RequestStatus deactivateTaskSt,  RequestStatus deleteTaskSt,  bool isLoadingMore1,  bool isLoadingMore2,  PaginatedTaskListResponse? myTasks,  PaginatedTaskResponse? myTaskApplies,  String? errorText)?  $default,) {final _that = this;
switch (_that) {
case _MyTasksState() when $default != null:
return $default(_that.myTaskSt,_that.myTaskAppliesSt,_that.liftUpTaskSt,_that.deactivateTaskSt,_that.deleteTaskSt,_that.isLoadingMore1,_that.isLoadingMore2,_that.myTasks,_that.myTaskApplies,_that.errorText);case _:
  return null;

}
}

}

/// @nodoc


class _MyTasksState implements MyTasksState {
  const _MyTasksState({this.myTaskSt = RequestStatus.initial, this.myTaskAppliesSt = RequestStatus.initial, this.liftUpTaskSt = RequestStatus.initial, this.deactivateTaskSt = RequestStatus.initial, this.deleteTaskSt = RequestStatus.initial, this.isLoadingMore1 = false, this.isLoadingMore2 = false, this.myTasks = null, this.myTaskApplies = null, this.errorText = null});
  

@override@JsonKey() final  RequestStatus myTaskSt;
@override@JsonKey() final  RequestStatus myTaskAppliesSt;
@override@JsonKey() final  RequestStatus liftUpTaskSt;
@override@JsonKey() final  RequestStatus deactivateTaskSt;
@override@JsonKey() final  RequestStatus deleteTaskSt;
@override@JsonKey() final  bool isLoadingMore1;
@override@JsonKey() final  bool isLoadingMore2;
@override@JsonKey() final  PaginatedTaskListResponse? myTasks;
@override@JsonKey() final  PaginatedTaskResponse? myTaskApplies;
@override@JsonKey() final  String? errorText;

/// Create a copy of MyTasksState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MyTasksStateCopyWith<_MyTasksState> get copyWith => __$MyTasksStateCopyWithImpl<_MyTasksState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MyTasksState&&(identical(other.myTaskSt, myTaskSt) || other.myTaskSt == myTaskSt)&&(identical(other.myTaskAppliesSt, myTaskAppliesSt) || other.myTaskAppliesSt == myTaskAppliesSt)&&(identical(other.liftUpTaskSt, liftUpTaskSt) || other.liftUpTaskSt == liftUpTaskSt)&&(identical(other.deactivateTaskSt, deactivateTaskSt) || other.deactivateTaskSt == deactivateTaskSt)&&(identical(other.deleteTaskSt, deleteTaskSt) || other.deleteTaskSt == deleteTaskSt)&&(identical(other.isLoadingMore1, isLoadingMore1) || other.isLoadingMore1 == isLoadingMore1)&&(identical(other.isLoadingMore2, isLoadingMore2) || other.isLoadingMore2 == isLoadingMore2)&&(identical(other.myTasks, myTasks) || other.myTasks == myTasks)&&(identical(other.myTaskApplies, myTaskApplies) || other.myTaskApplies == myTaskApplies)&&(identical(other.errorText, errorText) || other.errorText == errorText));
}


@override
int get hashCode => Object.hash(runtimeType,myTaskSt,myTaskAppliesSt,liftUpTaskSt,deactivateTaskSt,deleteTaskSt,isLoadingMore1,isLoadingMore2,myTasks,myTaskApplies,errorText);

@override
String toString() {
  return 'MyTasksState(myTaskSt: $myTaskSt, myTaskAppliesSt: $myTaskAppliesSt, liftUpTaskSt: $liftUpTaskSt, deactivateTaskSt: $deactivateTaskSt, deleteTaskSt: $deleteTaskSt, isLoadingMore1: $isLoadingMore1, isLoadingMore2: $isLoadingMore2, myTasks: $myTasks, myTaskApplies: $myTaskApplies, errorText: $errorText)';
}


}

/// @nodoc
abstract mixin class _$MyTasksStateCopyWith<$Res> implements $MyTasksStateCopyWith<$Res> {
  factory _$MyTasksStateCopyWith(_MyTasksState value, $Res Function(_MyTasksState) _then) = __$MyTasksStateCopyWithImpl;
@override @useResult
$Res call({
 RequestStatus myTaskSt, RequestStatus myTaskAppliesSt, RequestStatus liftUpTaskSt, RequestStatus deactivateTaskSt, RequestStatus deleteTaskSt, bool isLoadingMore1, bool isLoadingMore2, PaginatedTaskListResponse? myTasks, PaginatedTaskResponse? myTaskApplies, String? errorText
});




}
/// @nodoc
class __$MyTasksStateCopyWithImpl<$Res>
    implements _$MyTasksStateCopyWith<$Res> {
  __$MyTasksStateCopyWithImpl(this._self, this._then);

  final _MyTasksState _self;
  final $Res Function(_MyTasksState) _then;

/// Create a copy of MyTasksState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? myTaskSt = null,Object? myTaskAppliesSt = null,Object? liftUpTaskSt = null,Object? deactivateTaskSt = null,Object? deleteTaskSt = null,Object? isLoadingMore1 = null,Object? isLoadingMore2 = null,Object? myTasks = freezed,Object? myTaskApplies = freezed,Object? errorText = freezed,}) {
  return _then(_MyTasksState(
myTaskSt: null == myTaskSt ? _self.myTaskSt : myTaskSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,myTaskAppliesSt: null == myTaskAppliesSt ? _self.myTaskAppliesSt : myTaskAppliesSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,liftUpTaskSt: null == liftUpTaskSt ? _self.liftUpTaskSt : liftUpTaskSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,deactivateTaskSt: null == deactivateTaskSt ? _self.deactivateTaskSt : deactivateTaskSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,deleteTaskSt: null == deleteTaskSt ? _self.deleteTaskSt : deleteTaskSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,isLoadingMore1: null == isLoadingMore1 ? _self.isLoadingMore1 : isLoadingMore1 // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore2: null == isLoadingMore2 ? _self.isLoadingMore2 : isLoadingMore2 // ignore: cast_nullable_to_non_nullable
as bool,myTasks: freezed == myTasks ? _self.myTasks : myTasks // ignore: cast_nullable_to_non_nullable
as PaginatedTaskListResponse?,myTaskApplies: freezed == myTaskApplies ? _self.myTaskApplies : myTaskApplies // ignore: cast_nullable_to_non_nullable
as PaginatedTaskResponse?,errorText: freezed == errorText ? _self.errorText : errorText // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
