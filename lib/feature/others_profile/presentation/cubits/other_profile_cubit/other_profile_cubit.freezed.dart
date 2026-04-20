// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'other_profile_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OtherProfileState {

 int? get userId; int get index; RequestStatus get vacancy; RequestStatus get service; RequestStatus get task; VacancyPaginationResponse? get listVacancy; PaginatedServiceResponse? get listService; PaginatedTaskListResponse? get listTask; String? get vacancyError; String? get serviceError; String? get taskError;
/// Create a copy of OtherProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OtherProfileStateCopyWith<OtherProfileState> get copyWith => _$OtherProfileStateCopyWithImpl<OtherProfileState>(this as OtherProfileState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtherProfileState&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.index, index) || other.index == index)&&(identical(other.vacancy, vacancy) || other.vacancy == vacancy)&&(identical(other.service, service) || other.service == service)&&(identical(other.task, task) || other.task == task)&&(identical(other.listVacancy, listVacancy) || other.listVacancy == listVacancy)&&(identical(other.listService, listService) || other.listService == listService)&&(identical(other.listTask, listTask) || other.listTask == listTask)&&(identical(other.vacancyError, vacancyError) || other.vacancyError == vacancyError)&&(identical(other.serviceError, serviceError) || other.serviceError == serviceError)&&(identical(other.taskError, taskError) || other.taskError == taskError));
}


@override
int get hashCode => Object.hash(runtimeType,userId,index,vacancy,service,task,listVacancy,listService,listTask,vacancyError,serviceError,taskError);

@override
String toString() {
  return 'OtherProfileState(userId: $userId, index: $index, vacancy: $vacancy, service: $service, task: $task, listVacancy: $listVacancy, listService: $listService, listTask: $listTask, vacancyError: $vacancyError, serviceError: $serviceError, taskError: $taskError)';
}


}

/// @nodoc
abstract mixin class $OtherProfileStateCopyWith<$Res>  {
  factory $OtherProfileStateCopyWith(OtherProfileState value, $Res Function(OtherProfileState) _then) = _$OtherProfileStateCopyWithImpl;
@useResult
$Res call({
 int? userId, int index, RequestStatus vacancy, RequestStatus service, RequestStatus task, VacancyPaginationResponse? listVacancy, PaginatedServiceResponse? listService, PaginatedTaskListResponse? listTask, String? vacancyError, String? serviceError, String? taskError
});




}
/// @nodoc
class _$OtherProfileStateCopyWithImpl<$Res>
    implements $OtherProfileStateCopyWith<$Res> {
  _$OtherProfileStateCopyWithImpl(this._self, this._then);

  final OtherProfileState _self;
  final $Res Function(OtherProfileState) _then;

/// Create a copy of OtherProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = freezed,Object? index = null,Object? vacancy = null,Object? service = null,Object? task = null,Object? listVacancy = freezed,Object? listService = freezed,Object? listTask = freezed,Object? vacancyError = freezed,Object? serviceError = freezed,Object? taskError = freezed,}) {
  return _then(_self.copyWith(
userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int?,index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,vacancy: null == vacancy ? _self.vacancy : vacancy // ignore: cast_nullable_to_non_nullable
as RequestStatus,service: null == service ? _self.service : service // ignore: cast_nullable_to_non_nullable
as RequestStatus,task: null == task ? _self.task : task // ignore: cast_nullable_to_non_nullable
as RequestStatus,listVacancy: freezed == listVacancy ? _self.listVacancy : listVacancy // ignore: cast_nullable_to_non_nullable
as VacancyPaginationResponse?,listService: freezed == listService ? _self.listService : listService // ignore: cast_nullable_to_non_nullable
as PaginatedServiceResponse?,listTask: freezed == listTask ? _self.listTask : listTask // ignore: cast_nullable_to_non_nullable
as PaginatedTaskListResponse?,vacancyError: freezed == vacancyError ? _self.vacancyError : vacancyError // ignore: cast_nullable_to_non_nullable
as String?,serviceError: freezed == serviceError ? _self.serviceError : serviceError // ignore: cast_nullable_to_non_nullable
as String?,taskError: freezed == taskError ? _self.taskError : taskError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OtherProfileState].
extension OtherProfileStatePatterns on OtherProfileState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OtherProfileState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OtherProfileState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OtherProfileState value)  $default,){
final _that = this;
switch (_that) {
case _OtherProfileState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OtherProfileState value)?  $default,){
final _that = this;
switch (_that) {
case _OtherProfileState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? userId,  int index,  RequestStatus vacancy,  RequestStatus service,  RequestStatus task,  VacancyPaginationResponse? listVacancy,  PaginatedServiceResponse? listService,  PaginatedTaskListResponse? listTask,  String? vacancyError,  String? serviceError,  String? taskError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OtherProfileState() when $default != null:
return $default(_that.userId,_that.index,_that.vacancy,_that.service,_that.task,_that.listVacancy,_that.listService,_that.listTask,_that.vacancyError,_that.serviceError,_that.taskError);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? userId,  int index,  RequestStatus vacancy,  RequestStatus service,  RequestStatus task,  VacancyPaginationResponse? listVacancy,  PaginatedServiceResponse? listService,  PaginatedTaskListResponse? listTask,  String? vacancyError,  String? serviceError,  String? taskError)  $default,) {final _that = this;
switch (_that) {
case _OtherProfileState():
return $default(_that.userId,_that.index,_that.vacancy,_that.service,_that.task,_that.listVacancy,_that.listService,_that.listTask,_that.vacancyError,_that.serviceError,_that.taskError);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? userId,  int index,  RequestStatus vacancy,  RequestStatus service,  RequestStatus task,  VacancyPaginationResponse? listVacancy,  PaginatedServiceResponse? listService,  PaginatedTaskListResponse? listTask,  String? vacancyError,  String? serviceError,  String? taskError)?  $default,) {final _that = this;
switch (_that) {
case _OtherProfileState() when $default != null:
return $default(_that.userId,_that.index,_that.vacancy,_that.service,_that.task,_that.listVacancy,_that.listService,_that.listTask,_that.vacancyError,_that.serviceError,_that.taskError);case _:
  return null;

}
}

}

/// @nodoc


class _OtherProfileState implements OtherProfileState {
  const _OtherProfileState({this.userId = null, this.index = 0, this.vacancy = RequestStatus.initial, this.service = RequestStatus.initial, this.task = RequestStatus.initial, this.listVacancy = null, this.listService = null, this.listTask = null, this.vacancyError = null, this.serviceError = null, this.taskError = null});
  

@override@JsonKey() final  int? userId;
@override@JsonKey() final  int index;
@override@JsonKey() final  RequestStatus vacancy;
@override@JsonKey() final  RequestStatus service;
@override@JsonKey() final  RequestStatus task;
@override@JsonKey() final  VacancyPaginationResponse? listVacancy;
@override@JsonKey() final  PaginatedServiceResponse? listService;
@override@JsonKey() final  PaginatedTaskListResponse? listTask;
@override@JsonKey() final  String? vacancyError;
@override@JsonKey() final  String? serviceError;
@override@JsonKey() final  String? taskError;

/// Create a copy of OtherProfileState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OtherProfileStateCopyWith<_OtherProfileState> get copyWith => __$OtherProfileStateCopyWithImpl<_OtherProfileState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OtherProfileState&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.index, index) || other.index == index)&&(identical(other.vacancy, vacancy) || other.vacancy == vacancy)&&(identical(other.service, service) || other.service == service)&&(identical(other.task, task) || other.task == task)&&(identical(other.listVacancy, listVacancy) || other.listVacancy == listVacancy)&&(identical(other.listService, listService) || other.listService == listService)&&(identical(other.listTask, listTask) || other.listTask == listTask)&&(identical(other.vacancyError, vacancyError) || other.vacancyError == vacancyError)&&(identical(other.serviceError, serviceError) || other.serviceError == serviceError)&&(identical(other.taskError, taskError) || other.taskError == taskError));
}


@override
int get hashCode => Object.hash(runtimeType,userId,index,vacancy,service,task,listVacancy,listService,listTask,vacancyError,serviceError,taskError);

@override
String toString() {
  return 'OtherProfileState(userId: $userId, index: $index, vacancy: $vacancy, service: $service, task: $task, listVacancy: $listVacancy, listService: $listService, listTask: $listTask, vacancyError: $vacancyError, serviceError: $serviceError, taskError: $taskError)';
}


}

/// @nodoc
abstract mixin class _$OtherProfileStateCopyWith<$Res> implements $OtherProfileStateCopyWith<$Res> {
  factory _$OtherProfileStateCopyWith(_OtherProfileState value, $Res Function(_OtherProfileState) _then) = __$OtherProfileStateCopyWithImpl;
@override @useResult
$Res call({
 int? userId, int index, RequestStatus vacancy, RequestStatus service, RequestStatus task, VacancyPaginationResponse? listVacancy, PaginatedServiceResponse? listService, PaginatedTaskListResponse? listTask, String? vacancyError, String? serviceError, String? taskError
});




}
/// @nodoc
class __$OtherProfileStateCopyWithImpl<$Res>
    implements _$OtherProfileStateCopyWith<$Res> {
  __$OtherProfileStateCopyWithImpl(this._self, this._then);

  final _OtherProfileState _self;
  final $Res Function(_OtherProfileState) _then;

/// Create a copy of OtherProfileState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = freezed,Object? index = null,Object? vacancy = null,Object? service = null,Object? task = null,Object? listVacancy = freezed,Object? listService = freezed,Object? listTask = freezed,Object? vacancyError = freezed,Object? serviceError = freezed,Object? taskError = freezed,}) {
  return _then(_OtherProfileState(
userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int?,index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,vacancy: null == vacancy ? _self.vacancy : vacancy // ignore: cast_nullable_to_non_nullable
as RequestStatus,service: null == service ? _self.service : service // ignore: cast_nullable_to_non_nullable
as RequestStatus,task: null == task ? _self.task : task // ignore: cast_nullable_to_non_nullable
as RequestStatus,listVacancy: freezed == listVacancy ? _self.listVacancy : listVacancy // ignore: cast_nullable_to_non_nullable
as VacancyPaginationResponse?,listService: freezed == listService ? _self.listService : listService // ignore: cast_nullable_to_non_nullable
as PaginatedServiceResponse?,listTask: freezed == listTask ? _self.listTask : listTask // ignore: cast_nullable_to_non_nullable
as PaginatedTaskListResponse?,vacancyError: freezed == vacancyError ? _self.vacancyError : vacancyError // ignore: cast_nullable_to_non_nullable
as String?,serviceError: freezed == serviceError ? _self.serviceError : serviceError // ignore: cast_nullable_to_non_nullable
as String?,taskError: freezed == taskError ? _self.taskError : taskError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
