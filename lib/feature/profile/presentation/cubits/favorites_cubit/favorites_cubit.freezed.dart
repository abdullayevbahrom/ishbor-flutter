// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorites_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FavoritesState {

 RequestStatus get vacancyStatus; RequestStatus get serviceStatus; RequestStatus get taskStatus; List<Vacancy> get listVacancy; List<ServiceModel> get listService; List<TaskModel> get listTAsk;
/// Create a copy of FavoritesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavoritesStateCopyWith<FavoritesState> get copyWith => _$FavoritesStateCopyWithImpl<FavoritesState>(this as FavoritesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoritesState&&(identical(other.vacancyStatus, vacancyStatus) || other.vacancyStatus == vacancyStatus)&&(identical(other.serviceStatus, serviceStatus) || other.serviceStatus == serviceStatus)&&(identical(other.taskStatus, taskStatus) || other.taskStatus == taskStatus)&&const DeepCollectionEquality().equals(other.listVacancy, listVacancy)&&const DeepCollectionEquality().equals(other.listService, listService)&&const DeepCollectionEquality().equals(other.listTAsk, listTAsk));
}


@override
int get hashCode => Object.hash(runtimeType,vacancyStatus,serviceStatus,taskStatus,const DeepCollectionEquality().hash(listVacancy),const DeepCollectionEquality().hash(listService),const DeepCollectionEquality().hash(listTAsk));

@override
String toString() {
  return 'FavoritesState(vacancyStatus: $vacancyStatus, serviceStatus: $serviceStatus, taskStatus: $taskStatus, listVacancy: $listVacancy, listService: $listService, listTAsk: $listTAsk)';
}


}

/// @nodoc
abstract mixin class $FavoritesStateCopyWith<$Res>  {
  factory $FavoritesStateCopyWith(FavoritesState value, $Res Function(FavoritesState) _then) = _$FavoritesStateCopyWithImpl;
@useResult
$Res call({
 RequestStatus vacancyStatus, RequestStatus serviceStatus, RequestStatus taskStatus, List<Vacancy> listVacancy, List<ServiceModel> listService, List<TaskModel> listTAsk
});




}
/// @nodoc
class _$FavoritesStateCopyWithImpl<$Res>
    implements $FavoritesStateCopyWith<$Res> {
  _$FavoritesStateCopyWithImpl(this._self, this._then);

  final FavoritesState _self;
  final $Res Function(FavoritesState) _then;

/// Create a copy of FavoritesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? vacancyStatus = null,Object? serviceStatus = null,Object? taskStatus = null,Object? listVacancy = null,Object? listService = null,Object? listTAsk = null,}) {
  return _then(_self.copyWith(
vacancyStatus: null == vacancyStatus ? _self.vacancyStatus : vacancyStatus // ignore: cast_nullable_to_non_nullable
as RequestStatus,serviceStatus: null == serviceStatus ? _self.serviceStatus : serviceStatus // ignore: cast_nullable_to_non_nullable
as RequestStatus,taskStatus: null == taskStatus ? _self.taskStatus : taskStatus // ignore: cast_nullable_to_non_nullable
as RequestStatus,listVacancy: null == listVacancy ? _self.listVacancy : listVacancy // ignore: cast_nullable_to_non_nullable
as List<Vacancy>,listService: null == listService ? _self.listService : listService // ignore: cast_nullable_to_non_nullable
as List<ServiceModel>,listTAsk: null == listTAsk ? _self.listTAsk : listTAsk // ignore: cast_nullable_to_non_nullable
as List<TaskModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [FavoritesState].
extension FavoritesStatePatterns on FavoritesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FavoritesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FavoritesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FavoritesState value)  $default,){
final _that = this;
switch (_that) {
case _FavoritesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FavoritesState value)?  $default,){
final _that = this;
switch (_that) {
case _FavoritesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestStatus vacancyStatus,  RequestStatus serviceStatus,  RequestStatus taskStatus,  List<Vacancy> listVacancy,  List<ServiceModel> listService,  List<TaskModel> listTAsk)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FavoritesState() when $default != null:
return $default(_that.vacancyStatus,_that.serviceStatus,_that.taskStatus,_that.listVacancy,_that.listService,_that.listTAsk);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestStatus vacancyStatus,  RequestStatus serviceStatus,  RequestStatus taskStatus,  List<Vacancy> listVacancy,  List<ServiceModel> listService,  List<TaskModel> listTAsk)  $default,) {final _that = this;
switch (_that) {
case _FavoritesState():
return $default(_that.vacancyStatus,_that.serviceStatus,_that.taskStatus,_that.listVacancy,_that.listService,_that.listTAsk);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestStatus vacancyStatus,  RequestStatus serviceStatus,  RequestStatus taskStatus,  List<Vacancy> listVacancy,  List<ServiceModel> listService,  List<TaskModel> listTAsk)?  $default,) {final _that = this;
switch (_that) {
case _FavoritesState() when $default != null:
return $default(_that.vacancyStatus,_that.serviceStatus,_that.taskStatus,_that.listVacancy,_that.listService,_that.listTAsk);case _:
  return null;

}
}

}

/// @nodoc


class _FavoritesState implements FavoritesState {
  const _FavoritesState({this.vacancyStatus = RequestStatus.initial, this.serviceStatus = RequestStatus.initial, this.taskStatus = RequestStatus.initial, final  List<Vacancy> listVacancy = const [], final  List<ServiceModel> listService = const [], final  List<TaskModel> listTAsk = const []}): _listVacancy = listVacancy,_listService = listService,_listTAsk = listTAsk;
  

@override@JsonKey() final  RequestStatus vacancyStatus;
@override@JsonKey() final  RequestStatus serviceStatus;
@override@JsonKey() final  RequestStatus taskStatus;
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

 final  List<TaskModel> _listTAsk;
@override@JsonKey() List<TaskModel> get listTAsk {
  if (_listTAsk is EqualUnmodifiableListView) return _listTAsk;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_listTAsk);
}


/// Create a copy of FavoritesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FavoritesStateCopyWith<_FavoritesState> get copyWith => __$FavoritesStateCopyWithImpl<_FavoritesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FavoritesState&&(identical(other.vacancyStatus, vacancyStatus) || other.vacancyStatus == vacancyStatus)&&(identical(other.serviceStatus, serviceStatus) || other.serviceStatus == serviceStatus)&&(identical(other.taskStatus, taskStatus) || other.taskStatus == taskStatus)&&const DeepCollectionEquality().equals(other._listVacancy, _listVacancy)&&const DeepCollectionEquality().equals(other._listService, _listService)&&const DeepCollectionEquality().equals(other._listTAsk, _listTAsk));
}


@override
int get hashCode => Object.hash(runtimeType,vacancyStatus,serviceStatus,taskStatus,const DeepCollectionEquality().hash(_listVacancy),const DeepCollectionEquality().hash(_listService),const DeepCollectionEquality().hash(_listTAsk));

@override
String toString() {
  return 'FavoritesState(vacancyStatus: $vacancyStatus, serviceStatus: $serviceStatus, taskStatus: $taskStatus, listVacancy: $listVacancy, listService: $listService, listTAsk: $listTAsk)';
}


}

/// @nodoc
abstract mixin class _$FavoritesStateCopyWith<$Res> implements $FavoritesStateCopyWith<$Res> {
  factory _$FavoritesStateCopyWith(_FavoritesState value, $Res Function(_FavoritesState) _then) = __$FavoritesStateCopyWithImpl;
@override @useResult
$Res call({
 RequestStatus vacancyStatus, RequestStatus serviceStatus, RequestStatus taskStatus, List<Vacancy> listVacancy, List<ServiceModel> listService, List<TaskModel> listTAsk
});




}
/// @nodoc
class __$FavoritesStateCopyWithImpl<$Res>
    implements _$FavoritesStateCopyWith<$Res> {
  __$FavoritesStateCopyWithImpl(this._self, this._then);

  final _FavoritesState _self;
  final $Res Function(_FavoritesState) _then;

/// Create a copy of FavoritesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? vacancyStatus = null,Object? serviceStatus = null,Object? taskStatus = null,Object? listVacancy = null,Object? listService = null,Object? listTAsk = null,}) {
  return _then(_FavoritesState(
vacancyStatus: null == vacancyStatus ? _self.vacancyStatus : vacancyStatus // ignore: cast_nullable_to_non_nullable
as RequestStatus,serviceStatus: null == serviceStatus ? _self.serviceStatus : serviceStatus // ignore: cast_nullable_to_non_nullable
as RequestStatus,taskStatus: null == taskStatus ? _self.taskStatus : taskStatus // ignore: cast_nullable_to_non_nullable
as RequestStatus,listVacancy: null == listVacancy ? _self._listVacancy : listVacancy // ignore: cast_nullable_to_non_nullable
as List<Vacancy>,listService: null == listService ? _self._listService : listService // ignore: cast_nullable_to_non_nullable
as List<ServiceModel>,listTAsk: null == listTAsk ? _self._listTAsk : listTAsk // ignore: cast_nullable_to_non_nullable
as List<TaskModel>,
  ));
}


}

// dart format on
