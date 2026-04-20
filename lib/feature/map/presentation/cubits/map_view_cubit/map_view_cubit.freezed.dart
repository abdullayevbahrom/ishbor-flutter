// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_view_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MapViewState {

 RequestStatus get status; bool get enableCurrentLoc; Point get userPoint; List<Vacancy> get listVacancy; List<ServiceModel> get listService; List<TaskModel> get listTask; List<CategoryModel> get categories; Point? get point; String? get type; MapObjectId? get selectedMapObjects; List<Vacancy> get selectedVacancies; List<ServiceModel> get selectedServices; List<TaskModel> get selectedTasks;
/// Create a copy of MapViewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MapViewStateCopyWith<MapViewState> get copyWith => _$MapViewStateCopyWithImpl<MapViewState>(this as MapViewState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MapViewState&&(identical(other.status, status) || other.status == status)&&(identical(other.enableCurrentLoc, enableCurrentLoc) || other.enableCurrentLoc == enableCurrentLoc)&&(identical(other.userPoint, userPoint) || other.userPoint == userPoint)&&const DeepCollectionEquality().equals(other.listVacancy, listVacancy)&&const DeepCollectionEquality().equals(other.listService, listService)&&const DeepCollectionEquality().equals(other.listTask, listTask)&&const DeepCollectionEquality().equals(other.categories, categories)&&(identical(other.point, point) || other.point == point)&&(identical(other.type, type) || other.type == type)&&(identical(other.selectedMapObjects, selectedMapObjects) || other.selectedMapObjects == selectedMapObjects)&&const DeepCollectionEquality().equals(other.selectedVacancies, selectedVacancies)&&const DeepCollectionEquality().equals(other.selectedServices, selectedServices)&&const DeepCollectionEquality().equals(other.selectedTasks, selectedTasks));
}


@override
int get hashCode => Object.hash(runtimeType,status,enableCurrentLoc,userPoint,const DeepCollectionEquality().hash(listVacancy),const DeepCollectionEquality().hash(listService),const DeepCollectionEquality().hash(listTask),const DeepCollectionEquality().hash(categories),point,type,selectedMapObjects,const DeepCollectionEquality().hash(selectedVacancies),const DeepCollectionEquality().hash(selectedServices),const DeepCollectionEquality().hash(selectedTasks));

@override
String toString() {
  return 'MapViewState(status: $status, enableCurrentLoc: $enableCurrentLoc, userPoint: $userPoint, listVacancy: $listVacancy, listService: $listService, listTask: $listTask, categories: $categories, point: $point, type: $type, selectedMapObjects: $selectedMapObjects, selectedVacancies: $selectedVacancies, selectedServices: $selectedServices, selectedTasks: $selectedTasks)';
}


}

/// @nodoc
abstract mixin class $MapViewStateCopyWith<$Res>  {
  factory $MapViewStateCopyWith(MapViewState value, $Res Function(MapViewState) _then) = _$MapViewStateCopyWithImpl;
@useResult
$Res call({
 RequestStatus status, bool enableCurrentLoc, Point userPoint, List<Vacancy> listVacancy, List<ServiceModel> listService, List<TaskModel> listTask, List<CategoryModel> categories, Point? point, String? type, MapObjectId? selectedMapObjects, List<Vacancy> selectedVacancies, List<ServiceModel> selectedServices, List<TaskModel> selectedTasks
});




}
/// @nodoc
class _$MapViewStateCopyWithImpl<$Res>
    implements $MapViewStateCopyWith<$Res> {
  _$MapViewStateCopyWithImpl(this._self, this._then);

  final MapViewState _self;
  final $Res Function(MapViewState) _then;

/// Create a copy of MapViewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? enableCurrentLoc = null,Object? userPoint = null,Object? listVacancy = null,Object? listService = null,Object? listTask = null,Object? categories = null,Object? point = freezed,Object? type = freezed,Object? selectedMapObjects = freezed,Object? selectedVacancies = null,Object? selectedServices = null,Object? selectedTasks = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,enableCurrentLoc: null == enableCurrentLoc ? _self.enableCurrentLoc : enableCurrentLoc // ignore: cast_nullable_to_non_nullable
as bool,userPoint: null == userPoint ? _self.userPoint : userPoint // ignore: cast_nullable_to_non_nullable
as Point,listVacancy: null == listVacancy ? _self.listVacancy : listVacancy // ignore: cast_nullable_to_non_nullable
as List<Vacancy>,listService: null == listService ? _self.listService : listService // ignore: cast_nullable_to_non_nullable
as List<ServiceModel>,listTask: null == listTask ? _self.listTask : listTask // ignore: cast_nullable_to_non_nullable
as List<TaskModel>,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<CategoryModel>,point: freezed == point ? _self.point : point // ignore: cast_nullable_to_non_nullable
as Point?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,selectedMapObjects: freezed == selectedMapObjects ? _self.selectedMapObjects : selectedMapObjects // ignore: cast_nullable_to_non_nullable
as MapObjectId?,selectedVacancies: null == selectedVacancies ? _self.selectedVacancies : selectedVacancies // ignore: cast_nullable_to_non_nullable
as List<Vacancy>,selectedServices: null == selectedServices ? _self.selectedServices : selectedServices // ignore: cast_nullable_to_non_nullable
as List<ServiceModel>,selectedTasks: null == selectedTasks ? _self.selectedTasks : selectedTasks // ignore: cast_nullable_to_non_nullable
as List<TaskModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [MapViewState].
extension MapViewStatePatterns on MapViewState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MapViewState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MapViewState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MapViewState value)  $default,){
final _that = this;
switch (_that) {
case _MapViewState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MapViewState value)?  $default,){
final _that = this;
switch (_that) {
case _MapViewState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestStatus status,  bool enableCurrentLoc,  Point userPoint,  List<Vacancy> listVacancy,  List<ServiceModel> listService,  List<TaskModel> listTask,  List<CategoryModel> categories,  Point? point,  String? type,  MapObjectId? selectedMapObjects,  List<Vacancy> selectedVacancies,  List<ServiceModel> selectedServices,  List<TaskModel> selectedTasks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MapViewState() when $default != null:
return $default(_that.status,_that.enableCurrentLoc,_that.userPoint,_that.listVacancy,_that.listService,_that.listTask,_that.categories,_that.point,_that.type,_that.selectedMapObjects,_that.selectedVacancies,_that.selectedServices,_that.selectedTasks);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestStatus status,  bool enableCurrentLoc,  Point userPoint,  List<Vacancy> listVacancy,  List<ServiceModel> listService,  List<TaskModel> listTask,  List<CategoryModel> categories,  Point? point,  String? type,  MapObjectId? selectedMapObjects,  List<Vacancy> selectedVacancies,  List<ServiceModel> selectedServices,  List<TaskModel> selectedTasks)  $default,) {final _that = this;
switch (_that) {
case _MapViewState():
return $default(_that.status,_that.enableCurrentLoc,_that.userPoint,_that.listVacancy,_that.listService,_that.listTask,_that.categories,_that.point,_that.type,_that.selectedMapObjects,_that.selectedVacancies,_that.selectedServices,_that.selectedTasks);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestStatus status,  bool enableCurrentLoc,  Point userPoint,  List<Vacancy> listVacancy,  List<ServiceModel> listService,  List<TaskModel> listTask,  List<CategoryModel> categories,  Point? point,  String? type,  MapObjectId? selectedMapObjects,  List<Vacancy> selectedVacancies,  List<ServiceModel> selectedServices,  List<TaskModel> selectedTasks)?  $default,) {final _that = this;
switch (_that) {
case _MapViewState() when $default != null:
return $default(_that.status,_that.enableCurrentLoc,_that.userPoint,_that.listVacancy,_that.listService,_that.listTask,_that.categories,_that.point,_that.type,_that.selectedMapObjects,_that.selectedVacancies,_that.selectedServices,_that.selectedTasks);case _:
  return null;

}
}

}

/// @nodoc


class _MapViewState implements MapViewState {
  const _MapViewState({this.status = RequestStatus.initial, this.enableCurrentLoc = false, this.userPoint = const Point(latitude: 41.311081, longitude: 69.240562), final  List<Vacancy> listVacancy = const [], final  List<ServiceModel> listService = const [], final  List<TaskModel> listTask = const [], final  List<CategoryModel> categories = const [], this.point = null, this.type = null, this.selectedMapObjects = null, final  List<Vacancy> selectedVacancies = const [], final  List<ServiceModel> selectedServices = const [], final  List<TaskModel> selectedTasks = const []}): _listVacancy = listVacancy,_listService = listService,_listTask = listTask,_categories = categories,_selectedVacancies = selectedVacancies,_selectedServices = selectedServices,_selectedTasks = selectedTasks;
  

@override@JsonKey() final  RequestStatus status;
@override@JsonKey() final  bool enableCurrentLoc;
@override@JsonKey() final  Point userPoint;
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

 final  List<CategoryModel> _categories;
@override@JsonKey() List<CategoryModel> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

@override@JsonKey() final  Point? point;
@override@JsonKey() final  String? type;
@override@JsonKey() final  MapObjectId? selectedMapObjects;
 final  List<Vacancy> _selectedVacancies;
@override@JsonKey() List<Vacancy> get selectedVacancies {
  if (_selectedVacancies is EqualUnmodifiableListView) return _selectedVacancies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedVacancies);
}

 final  List<ServiceModel> _selectedServices;
@override@JsonKey() List<ServiceModel> get selectedServices {
  if (_selectedServices is EqualUnmodifiableListView) return _selectedServices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedServices);
}

 final  List<TaskModel> _selectedTasks;
@override@JsonKey() List<TaskModel> get selectedTasks {
  if (_selectedTasks is EqualUnmodifiableListView) return _selectedTasks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedTasks);
}


/// Create a copy of MapViewState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MapViewStateCopyWith<_MapViewState> get copyWith => __$MapViewStateCopyWithImpl<_MapViewState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MapViewState&&(identical(other.status, status) || other.status == status)&&(identical(other.enableCurrentLoc, enableCurrentLoc) || other.enableCurrentLoc == enableCurrentLoc)&&(identical(other.userPoint, userPoint) || other.userPoint == userPoint)&&const DeepCollectionEquality().equals(other._listVacancy, _listVacancy)&&const DeepCollectionEquality().equals(other._listService, _listService)&&const DeepCollectionEquality().equals(other._listTask, _listTask)&&const DeepCollectionEquality().equals(other._categories, _categories)&&(identical(other.point, point) || other.point == point)&&(identical(other.type, type) || other.type == type)&&(identical(other.selectedMapObjects, selectedMapObjects) || other.selectedMapObjects == selectedMapObjects)&&const DeepCollectionEquality().equals(other._selectedVacancies, _selectedVacancies)&&const DeepCollectionEquality().equals(other._selectedServices, _selectedServices)&&const DeepCollectionEquality().equals(other._selectedTasks, _selectedTasks));
}


@override
int get hashCode => Object.hash(runtimeType,status,enableCurrentLoc,userPoint,const DeepCollectionEquality().hash(_listVacancy),const DeepCollectionEquality().hash(_listService),const DeepCollectionEquality().hash(_listTask),const DeepCollectionEquality().hash(_categories),point,type,selectedMapObjects,const DeepCollectionEquality().hash(_selectedVacancies),const DeepCollectionEquality().hash(_selectedServices),const DeepCollectionEquality().hash(_selectedTasks));

@override
String toString() {
  return 'MapViewState(status: $status, enableCurrentLoc: $enableCurrentLoc, userPoint: $userPoint, listVacancy: $listVacancy, listService: $listService, listTask: $listTask, categories: $categories, point: $point, type: $type, selectedMapObjects: $selectedMapObjects, selectedVacancies: $selectedVacancies, selectedServices: $selectedServices, selectedTasks: $selectedTasks)';
}


}

/// @nodoc
abstract mixin class _$MapViewStateCopyWith<$Res> implements $MapViewStateCopyWith<$Res> {
  factory _$MapViewStateCopyWith(_MapViewState value, $Res Function(_MapViewState) _then) = __$MapViewStateCopyWithImpl;
@override @useResult
$Res call({
 RequestStatus status, bool enableCurrentLoc, Point userPoint, List<Vacancy> listVacancy, List<ServiceModel> listService, List<TaskModel> listTask, List<CategoryModel> categories, Point? point, String? type, MapObjectId? selectedMapObjects, List<Vacancy> selectedVacancies, List<ServiceModel> selectedServices, List<TaskModel> selectedTasks
});




}
/// @nodoc
class __$MapViewStateCopyWithImpl<$Res>
    implements _$MapViewStateCopyWith<$Res> {
  __$MapViewStateCopyWithImpl(this._self, this._then);

  final _MapViewState _self;
  final $Res Function(_MapViewState) _then;

/// Create a copy of MapViewState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? enableCurrentLoc = null,Object? userPoint = null,Object? listVacancy = null,Object? listService = null,Object? listTask = null,Object? categories = null,Object? point = freezed,Object? type = freezed,Object? selectedMapObjects = freezed,Object? selectedVacancies = null,Object? selectedServices = null,Object? selectedTasks = null,}) {
  return _then(_MapViewState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,enableCurrentLoc: null == enableCurrentLoc ? _self.enableCurrentLoc : enableCurrentLoc // ignore: cast_nullable_to_non_nullable
as bool,userPoint: null == userPoint ? _self.userPoint : userPoint // ignore: cast_nullable_to_non_nullable
as Point,listVacancy: null == listVacancy ? _self._listVacancy : listVacancy // ignore: cast_nullable_to_non_nullable
as List<Vacancy>,listService: null == listService ? _self._listService : listService // ignore: cast_nullable_to_non_nullable
as List<ServiceModel>,listTask: null == listTask ? _self._listTask : listTask // ignore: cast_nullable_to_non_nullable
as List<TaskModel>,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<CategoryModel>,point: freezed == point ? _self.point : point // ignore: cast_nullable_to_non_nullable
as Point?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,selectedMapObjects: freezed == selectedMapObjects ? _self.selectedMapObjects : selectedMapObjects // ignore: cast_nullable_to_non_nullable
as MapObjectId?,selectedVacancies: null == selectedVacancies ? _self._selectedVacancies : selectedVacancies // ignore: cast_nullable_to_non_nullable
as List<Vacancy>,selectedServices: null == selectedServices ? _self._selectedServices : selectedServices // ignore: cast_nullable_to_non_nullable
as List<ServiceModel>,selectedTasks: null == selectedTasks ? _self._selectedTasks : selectedTasks // ignore: cast_nullable_to_non_nullable
as List<TaskModel>,
  ));
}


}

// dart format on
