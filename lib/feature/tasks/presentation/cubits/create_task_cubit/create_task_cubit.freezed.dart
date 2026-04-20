// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_task_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreateTaskState {

 RequestStatus get status; TaskModel? get task; String? get errorText; String? get paymentMethod; List<File> get images; bool get isNegotiable; bool get isRemote; bool get isUSD; int? get categoryId; bool get isStartDateNow; String? get startDate; String? get expireDate; GeocodeResponse? get location;
/// Create a copy of CreateTaskState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateTaskStateCopyWith<CreateTaskState> get copyWith => _$CreateTaskStateCopyWithImpl<CreateTaskState>(this as CreateTaskState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateTaskState&&(identical(other.status, status) || other.status == status)&&(identical(other.task, task) || other.task == task)&&(identical(other.errorText, errorText) || other.errorText == errorText)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&const DeepCollectionEquality().equals(other.images, images)&&(identical(other.isNegotiable, isNegotiable) || other.isNegotiable == isNegotiable)&&(identical(other.isRemote, isRemote) || other.isRemote == isRemote)&&(identical(other.isUSD, isUSD) || other.isUSD == isUSD)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.isStartDateNow, isStartDateNow) || other.isStartDateNow == isStartDateNow)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.expireDate, expireDate) || other.expireDate == expireDate)&&(identical(other.location, location) || other.location == location));
}


@override
int get hashCode => Object.hash(runtimeType,status,task,errorText,paymentMethod,const DeepCollectionEquality().hash(images),isNegotiable,isRemote,isUSD,categoryId,isStartDateNow,startDate,expireDate,location);

@override
String toString() {
  return 'CreateTaskState(status: $status, task: $task, errorText: $errorText, paymentMethod: $paymentMethod, images: $images, isNegotiable: $isNegotiable, isRemote: $isRemote, isUSD: $isUSD, categoryId: $categoryId, isStartDateNow: $isStartDateNow, startDate: $startDate, expireDate: $expireDate, location: $location)';
}


}

/// @nodoc
abstract mixin class $CreateTaskStateCopyWith<$Res>  {
  factory $CreateTaskStateCopyWith(CreateTaskState value, $Res Function(CreateTaskState) _then) = _$CreateTaskStateCopyWithImpl;
@useResult
$Res call({
 RequestStatus status, TaskModel? task, String? errorText, String? paymentMethod, List<File> images, bool isNegotiable, bool isRemote, bool isUSD, int? categoryId, bool isStartDateNow, String? startDate, String? expireDate, GeocodeResponse? location
});




}
/// @nodoc
class _$CreateTaskStateCopyWithImpl<$Res>
    implements $CreateTaskStateCopyWith<$Res> {
  _$CreateTaskStateCopyWithImpl(this._self, this._then);

  final CreateTaskState _self;
  final $Res Function(CreateTaskState) _then;

/// Create a copy of CreateTaskState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? task = freezed,Object? errorText = freezed,Object? paymentMethod = freezed,Object? images = null,Object? isNegotiable = null,Object? isRemote = null,Object? isUSD = null,Object? categoryId = freezed,Object? isStartDateNow = null,Object? startDate = freezed,Object? expireDate = freezed,Object? location = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,task: freezed == task ? _self.task : task // ignore: cast_nullable_to_non_nullable
as TaskModel?,errorText: freezed == errorText ? _self.errorText : errorText // ignore: cast_nullable_to_non_nullable
as String?,paymentMethod: freezed == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String?,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<File>,isNegotiable: null == isNegotiable ? _self.isNegotiable : isNegotiable // ignore: cast_nullable_to_non_nullable
as bool,isRemote: null == isRemote ? _self.isRemote : isRemote // ignore: cast_nullable_to_non_nullable
as bool,isUSD: null == isUSD ? _self.isUSD : isUSD // ignore: cast_nullable_to_non_nullable
as bool,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int?,isStartDateNow: null == isStartDateNow ? _self.isStartDateNow : isStartDateNow // ignore: cast_nullable_to_non_nullable
as bool,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String?,expireDate: freezed == expireDate ? _self.expireDate : expireDate // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GeocodeResponse?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateTaskState].
extension CreateTaskStatePatterns on CreateTaskState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateTaskState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateTaskState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateTaskState value)  $default,){
final _that = this;
switch (_that) {
case _CreateTaskState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateTaskState value)?  $default,){
final _that = this;
switch (_that) {
case _CreateTaskState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestStatus status,  TaskModel? task,  String? errorText,  String? paymentMethod,  List<File> images,  bool isNegotiable,  bool isRemote,  bool isUSD,  int? categoryId,  bool isStartDateNow,  String? startDate,  String? expireDate,  GeocodeResponse? location)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateTaskState() when $default != null:
return $default(_that.status,_that.task,_that.errorText,_that.paymentMethod,_that.images,_that.isNegotiable,_that.isRemote,_that.isUSD,_that.categoryId,_that.isStartDateNow,_that.startDate,_that.expireDate,_that.location);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestStatus status,  TaskModel? task,  String? errorText,  String? paymentMethod,  List<File> images,  bool isNegotiable,  bool isRemote,  bool isUSD,  int? categoryId,  bool isStartDateNow,  String? startDate,  String? expireDate,  GeocodeResponse? location)  $default,) {final _that = this;
switch (_that) {
case _CreateTaskState():
return $default(_that.status,_that.task,_that.errorText,_that.paymentMethod,_that.images,_that.isNegotiable,_that.isRemote,_that.isUSD,_that.categoryId,_that.isStartDateNow,_that.startDate,_that.expireDate,_that.location);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestStatus status,  TaskModel? task,  String? errorText,  String? paymentMethod,  List<File> images,  bool isNegotiable,  bool isRemote,  bool isUSD,  int? categoryId,  bool isStartDateNow,  String? startDate,  String? expireDate,  GeocodeResponse? location)?  $default,) {final _that = this;
switch (_that) {
case _CreateTaskState() when $default != null:
return $default(_that.status,_that.task,_that.errorText,_that.paymentMethod,_that.images,_that.isNegotiable,_that.isRemote,_that.isUSD,_that.categoryId,_that.isStartDateNow,_that.startDate,_that.expireDate,_that.location);case _:
  return null;

}
}

}

/// @nodoc


class _CreateTaskState implements CreateTaskState {
  const _CreateTaskState({this.status = RequestStatus.initial, this.task = null, this.errorText = null, this.paymentMethod = null, final  List<File> images = const [], this.isNegotiable = false, this.isRemote = false, this.isUSD = false, this.categoryId = null, this.isStartDateNow = true, this.startDate = null, this.expireDate = null, this.location = null}): _images = images;
  

@override@JsonKey() final  RequestStatus status;
@override@JsonKey() final  TaskModel? task;
@override@JsonKey() final  String? errorText;
@override@JsonKey() final  String? paymentMethod;
 final  List<File> _images;
@override@JsonKey() List<File> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}

@override@JsonKey() final  bool isNegotiable;
@override@JsonKey() final  bool isRemote;
@override@JsonKey() final  bool isUSD;
@override@JsonKey() final  int? categoryId;
@override@JsonKey() final  bool isStartDateNow;
@override@JsonKey() final  String? startDate;
@override@JsonKey() final  String? expireDate;
@override@JsonKey() final  GeocodeResponse? location;

/// Create a copy of CreateTaskState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateTaskStateCopyWith<_CreateTaskState> get copyWith => __$CreateTaskStateCopyWithImpl<_CreateTaskState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateTaskState&&(identical(other.status, status) || other.status == status)&&(identical(other.task, task) || other.task == task)&&(identical(other.errorText, errorText) || other.errorText == errorText)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&const DeepCollectionEquality().equals(other._images, _images)&&(identical(other.isNegotiable, isNegotiable) || other.isNegotiable == isNegotiable)&&(identical(other.isRemote, isRemote) || other.isRemote == isRemote)&&(identical(other.isUSD, isUSD) || other.isUSD == isUSD)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.isStartDateNow, isStartDateNow) || other.isStartDateNow == isStartDateNow)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.expireDate, expireDate) || other.expireDate == expireDate)&&(identical(other.location, location) || other.location == location));
}


@override
int get hashCode => Object.hash(runtimeType,status,task,errorText,paymentMethod,const DeepCollectionEquality().hash(_images),isNegotiable,isRemote,isUSD,categoryId,isStartDateNow,startDate,expireDate,location);

@override
String toString() {
  return 'CreateTaskState(status: $status, task: $task, errorText: $errorText, paymentMethod: $paymentMethod, images: $images, isNegotiable: $isNegotiable, isRemote: $isRemote, isUSD: $isUSD, categoryId: $categoryId, isStartDateNow: $isStartDateNow, startDate: $startDate, expireDate: $expireDate, location: $location)';
}


}

/// @nodoc
abstract mixin class _$CreateTaskStateCopyWith<$Res> implements $CreateTaskStateCopyWith<$Res> {
  factory _$CreateTaskStateCopyWith(_CreateTaskState value, $Res Function(_CreateTaskState) _then) = __$CreateTaskStateCopyWithImpl;
@override @useResult
$Res call({
 RequestStatus status, TaskModel? task, String? errorText, String? paymentMethod, List<File> images, bool isNegotiable, bool isRemote, bool isUSD, int? categoryId, bool isStartDateNow, String? startDate, String? expireDate, GeocodeResponse? location
});




}
/// @nodoc
class __$CreateTaskStateCopyWithImpl<$Res>
    implements _$CreateTaskStateCopyWith<$Res> {
  __$CreateTaskStateCopyWithImpl(this._self, this._then);

  final _CreateTaskState _self;
  final $Res Function(_CreateTaskState) _then;

/// Create a copy of CreateTaskState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? task = freezed,Object? errorText = freezed,Object? paymentMethod = freezed,Object? images = null,Object? isNegotiable = null,Object? isRemote = null,Object? isUSD = null,Object? categoryId = freezed,Object? isStartDateNow = null,Object? startDate = freezed,Object? expireDate = freezed,Object? location = freezed,}) {
  return _then(_CreateTaskState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,task: freezed == task ? _self.task : task // ignore: cast_nullable_to_non_nullable
as TaskModel?,errorText: freezed == errorText ? _self.errorText : errorText // ignore: cast_nullable_to_non_nullable
as String?,paymentMethod: freezed == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String?,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<File>,isNegotiable: null == isNegotiable ? _self.isNegotiable : isNegotiable // ignore: cast_nullable_to_non_nullable
as bool,isRemote: null == isRemote ? _self.isRemote : isRemote // ignore: cast_nullable_to_non_nullable
as bool,isUSD: null == isUSD ? _self.isUSD : isUSD // ignore: cast_nullable_to_non_nullable
as bool,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int?,isStartDateNow: null == isStartDateNow ? _self.isStartDateNow : isStartDateNow // ignore: cast_nullable_to_non_nullable
as bool,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String?,expireDate: freezed == expireDate ? _self.expireDate : expireDate // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GeocodeResponse?,
  ));
}


}

// dart format on
