// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expanded_view_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ExpandedViewState {

 List<Vacancy> get vacancyList; List<ServiceModel> get serviceList; List<TaskModel> get taskList;
/// Create a copy of ExpandedViewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpandedViewStateCopyWith<ExpandedViewState> get copyWith => _$ExpandedViewStateCopyWithImpl<ExpandedViewState>(this as ExpandedViewState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpandedViewState&&const DeepCollectionEquality().equals(other.vacancyList, vacancyList)&&const DeepCollectionEquality().equals(other.serviceList, serviceList)&&const DeepCollectionEquality().equals(other.taskList, taskList));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(vacancyList),const DeepCollectionEquality().hash(serviceList),const DeepCollectionEquality().hash(taskList));

@override
String toString() {
  return 'ExpandedViewState(vacancyList: $vacancyList, serviceList: $serviceList, taskList: $taskList)';
}


}

/// @nodoc
abstract mixin class $ExpandedViewStateCopyWith<$Res>  {
  factory $ExpandedViewStateCopyWith(ExpandedViewState value, $Res Function(ExpandedViewState) _then) = _$ExpandedViewStateCopyWithImpl;
@useResult
$Res call({
 List<Vacancy> vacancyList, List<ServiceModel> serviceList, List<TaskModel> taskList
});




}
/// @nodoc
class _$ExpandedViewStateCopyWithImpl<$Res>
    implements $ExpandedViewStateCopyWith<$Res> {
  _$ExpandedViewStateCopyWithImpl(this._self, this._then);

  final ExpandedViewState _self;
  final $Res Function(ExpandedViewState) _then;

/// Create a copy of ExpandedViewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? vacancyList = null,Object? serviceList = null,Object? taskList = null,}) {
  return _then(_self.copyWith(
vacancyList: null == vacancyList ? _self.vacancyList : vacancyList // ignore: cast_nullable_to_non_nullable
as List<Vacancy>,serviceList: null == serviceList ? _self.serviceList : serviceList // ignore: cast_nullable_to_non_nullable
as List<ServiceModel>,taskList: null == taskList ? _self.taskList : taskList // ignore: cast_nullable_to_non_nullable
as List<TaskModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [ExpandedViewState].
extension ExpandedViewStatePatterns on ExpandedViewState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExpandedViewState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExpandedViewState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExpandedViewState value)  $default,){
final _that = this;
switch (_that) {
case _ExpandedViewState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExpandedViewState value)?  $default,){
final _that = this;
switch (_that) {
case _ExpandedViewState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Vacancy> vacancyList,  List<ServiceModel> serviceList,  List<TaskModel> taskList)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExpandedViewState() when $default != null:
return $default(_that.vacancyList,_that.serviceList,_that.taskList);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Vacancy> vacancyList,  List<ServiceModel> serviceList,  List<TaskModel> taskList)  $default,) {final _that = this;
switch (_that) {
case _ExpandedViewState():
return $default(_that.vacancyList,_that.serviceList,_that.taskList);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Vacancy> vacancyList,  List<ServiceModel> serviceList,  List<TaskModel> taskList)?  $default,) {final _that = this;
switch (_that) {
case _ExpandedViewState() when $default != null:
return $default(_that.vacancyList,_that.serviceList,_that.taskList);case _:
  return null;

}
}

}

/// @nodoc


class _ExpandedViewState implements ExpandedViewState {
  const _ExpandedViewState({final  List<Vacancy> vacancyList = const [], final  List<ServiceModel> serviceList = const [], final  List<TaskModel> taskList = const []}): _vacancyList = vacancyList,_serviceList = serviceList,_taskList = taskList;
  

 final  List<Vacancy> _vacancyList;
@override@JsonKey() List<Vacancy> get vacancyList {
  if (_vacancyList is EqualUnmodifiableListView) return _vacancyList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_vacancyList);
}

 final  List<ServiceModel> _serviceList;
@override@JsonKey() List<ServiceModel> get serviceList {
  if (_serviceList is EqualUnmodifiableListView) return _serviceList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_serviceList);
}

 final  List<TaskModel> _taskList;
@override@JsonKey() List<TaskModel> get taskList {
  if (_taskList is EqualUnmodifiableListView) return _taskList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_taskList);
}


/// Create a copy of ExpandedViewState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExpandedViewStateCopyWith<_ExpandedViewState> get copyWith => __$ExpandedViewStateCopyWithImpl<_ExpandedViewState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExpandedViewState&&const DeepCollectionEquality().equals(other._vacancyList, _vacancyList)&&const DeepCollectionEquality().equals(other._serviceList, _serviceList)&&const DeepCollectionEquality().equals(other._taskList, _taskList));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_vacancyList),const DeepCollectionEquality().hash(_serviceList),const DeepCollectionEquality().hash(_taskList));

@override
String toString() {
  return 'ExpandedViewState(vacancyList: $vacancyList, serviceList: $serviceList, taskList: $taskList)';
}


}

/// @nodoc
abstract mixin class _$ExpandedViewStateCopyWith<$Res> implements $ExpandedViewStateCopyWith<$Res> {
  factory _$ExpandedViewStateCopyWith(_ExpandedViewState value, $Res Function(_ExpandedViewState) _then) = __$ExpandedViewStateCopyWithImpl;
@override @useResult
$Res call({
 List<Vacancy> vacancyList, List<ServiceModel> serviceList, List<TaskModel> taskList
});




}
/// @nodoc
class __$ExpandedViewStateCopyWithImpl<$Res>
    implements _$ExpandedViewStateCopyWith<$Res> {
  __$ExpandedViewStateCopyWithImpl(this._self, this._then);

  final _ExpandedViewState _self;
  final $Res Function(_ExpandedViewState) _then;

/// Create a copy of ExpandedViewState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? vacancyList = null,Object? serviceList = null,Object? taskList = null,}) {
  return _then(_ExpandedViewState(
vacancyList: null == vacancyList ? _self._vacancyList : vacancyList // ignore: cast_nullable_to_non_nullable
as List<Vacancy>,serviceList: null == serviceList ? _self._serviceList : serviceList // ignore: cast_nullable_to_non_nullable
as List<ServiceModel>,taskList: null == taskList ? _self._taskList : taskList // ignore: cast_nullable_to_non_nullable
as List<TaskModel>,
  ));
}


}

// dart format on
