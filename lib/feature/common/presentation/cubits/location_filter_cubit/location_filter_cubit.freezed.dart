// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_filter_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LocationFilterState {

 RequestStatus get status; String? get errorText; List<Vacancy> get listVacancy; List<ServiceModel> get listService; List<TaskModel> get listTask;
/// Create a copy of LocationFilterState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocationFilterStateCopyWith<LocationFilterState> get copyWith => _$LocationFilterStateCopyWithImpl<LocationFilterState>(this as LocationFilterState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationFilterState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorText, errorText) || other.errorText == errorText)&&const DeepCollectionEquality().equals(other.listVacancy, listVacancy)&&const DeepCollectionEquality().equals(other.listService, listService)&&const DeepCollectionEquality().equals(other.listTask, listTask));
}


@override
int get hashCode => Object.hash(runtimeType,status,errorText,const DeepCollectionEquality().hash(listVacancy),const DeepCollectionEquality().hash(listService),const DeepCollectionEquality().hash(listTask));

@override
String toString() {
  return 'LocationFilterState(status: $status, errorText: $errorText, listVacancy: $listVacancy, listService: $listService, listTask: $listTask)';
}


}

/// @nodoc
abstract mixin class $LocationFilterStateCopyWith<$Res>  {
  factory $LocationFilterStateCopyWith(LocationFilterState value, $Res Function(LocationFilterState) _then) = _$LocationFilterStateCopyWithImpl;
@useResult
$Res call({
 RequestStatus status, String? errorText, List<Vacancy> listVacancy, List<ServiceModel> listService, List<TaskModel> listTask
});




}
/// @nodoc
class _$LocationFilterStateCopyWithImpl<$Res>
    implements $LocationFilterStateCopyWith<$Res> {
  _$LocationFilterStateCopyWithImpl(this._self, this._then);

  final LocationFilterState _self;
  final $Res Function(LocationFilterState) _then;

/// Create a copy of LocationFilterState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? errorText = freezed,Object? listVacancy = null,Object? listService = null,Object? listTask = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,errorText: freezed == errorText ? _self.errorText : errorText // ignore: cast_nullable_to_non_nullable
as String?,listVacancy: null == listVacancy ? _self.listVacancy : listVacancy // ignore: cast_nullable_to_non_nullable
as List<Vacancy>,listService: null == listService ? _self.listService : listService // ignore: cast_nullable_to_non_nullable
as List<ServiceModel>,listTask: null == listTask ? _self.listTask : listTask // ignore: cast_nullable_to_non_nullable
as List<TaskModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [LocationFilterState].
extension LocationFilterStatePatterns on LocationFilterState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocationFilterState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocationFilterState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocationFilterState value)  $default,){
final _that = this;
switch (_that) {
case _LocationFilterState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocationFilterState value)?  $default,){
final _that = this;
switch (_that) {
case _LocationFilterState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestStatus status,  String? errorText,  List<Vacancy> listVacancy,  List<ServiceModel> listService,  List<TaskModel> listTask)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocationFilterState() when $default != null:
return $default(_that.status,_that.errorText,_that.listVacancy,_that.listService,_that.listTask);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestStatus status,  String? errorText,  List<Vacancy> listVacancy,  List<ServiceModel> listService,  List<TaskModel> listTask)  $default,) {final _that = this;
switch (_that) {
case _LocationFilterState():
return $default(_that.status,_that.errorText,_that.listVacancy,_that.listService,_that.listTask);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestStatus status,  String? errorText,  List<Vacancy> listVacancy,  List<ServiceModel> listService,  List<TaskModel> listTask)?  $default,) {final _that = this;
switch (_that) {
case _LocationFilterState() when $default != null:
return $default(_that.status,_that.errorText,_that.listVacancy,_that.listService,_that.listTask);case _:
  return null;

}
}

}

/// @nodoc


class _LocationFilterState implements LocationFilterState {
  const _LocationFilterState({this.status = RequestStatus.initial, this.errorText = null, final  List<Vacancy> listVacancy = const [], final  List<ServiceModel> listService = const [], final  List<TaskModel> listTask = const []}): _listVacancy = listVacancy,_listService = listService,_listTask = listTask;
  

@override@JsonKey() final  RequestStatus status;
@override@JsonKey() final  String? errorText;
 final  List<Vacancy> _listVacancy;
@override@JsonKey() List<Vacancy> get listVacancy {
  if (_listVacancy is EqualUnmodifiableListView) return _listVacancy;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_listVacancy);
}

 final  List<ServiceModel> _listService;
@override@JsonKey() List<ServiceModel> get listService {
  if (_listService is EqualUnmodifiableListView) return _listService;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_listService);
}

 final  List<TaskModel> _listTask;
@override@JsonKey() List<TaskModel> get listTask {
  if (_listTask is EqualUnmodifiableListView) return _listTask;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_listTask);
}


/// Create a copy of LocationFilterState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocationFilterStateCopyWith<_LocationFilterState> get copyWith => __$LocationFilterStateCopyWithImpl<_LocationFilterState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocationFilterState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorText, errorText) || other.errorText == errorText)&&const DeepCollectionEquality().equals(other._listVacancy, _listVacancy)&&const DeepCollectionEquality().equals(other._listService, _listService)&&const DeepCollectionEquality().equals(other._listTask, _listTask));
}


@override
int get hashCode => Object.hash(runtimeType,status,errorText,const DeepCollectionEquality().hash(_listVacancy),const DeepCollectionEquality().hash(_listService),const DeepCollectionEquality().hash(_listTask));

@override
String toString() {
  return 'LocationFilterState(status: $status, errorText: $errorText, listVacancy: $listVacancy, listService: $listService, listTask: $listTask)';
}


}

/// @nodoc
abstract mixin class _$LocationFilterStateCopyWith<$Res> implements $LocationFilterStateCopyWith<$Res> {
  factory _$LocationFilterStateCopyWith(_LocationFilterState value, $Res Function(_LocationFilterState) _then) = __$LocationFilterStateCopyWithImpl;
@override @useResult
$Res call({
 RequestStatus status, String? errorText, List<Vacancy> listVacancy, List<ServiceModel> listService, List<TaskModel> listTask
});




}
/// @nodoc
class __$LocationFilterStateCopyWithImpl<$Res>
    implements _$LocationFilterStateCopyWith<$Res> {
  __$LocationFilterStateCopyWithImpl(this._self, this._then);

  final _LocationFilterState _self;
  final $Res Function(_LocationFilterState) _then;

/// Create a copy of LocationFilterState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? errorText = freezed,Object? listVacancy = null,Object? listService = null,Object? listTask = null,}) {
  return _then(_LocationFilterState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,errorText: freezed == errorText ? _self.errorText : errorText // ignore: cast_nullable_to_non_nullable
as String?,listVacancy: null == listVacancy ? _self._listVacancy : listVacancy // ignore: cast_nullable_to_non_nullable
as List<Vacancy>,listService: null == listService ? _self._listService : listService // ignore: cast_nullable_to_non_nullable
as List<ServiceModel>,listTask: null == listTask ? _self._listTask : listTask // ignore: cast_nullable_to_non_nullable
as List<TaskModel>,
  ));
}


}

// dart format on
