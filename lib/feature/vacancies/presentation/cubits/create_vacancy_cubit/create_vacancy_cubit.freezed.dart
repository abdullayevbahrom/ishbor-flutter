// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_vacancy_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreateVacancyState {

 RequestStatus get status; RequestStatus get createVacSt; RequestStatus get generateVacancyDes; String? get errorText; Set get operatingMode; int get employmentType; bool get withOutResume; bool get temporaryEmployee; bool get buttonEnable; bool get salaryInInterview; bool get uzsCurrency; Vacancy? get vacancy; bool get isEnable; GeocodeResponse? get location; List<File> get images; int? get category;
/// Create a copy of CreateVacancyState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateVacancyStateCopyWith<CreateVacancyState> get copyWith => _$CreateVacancyStateCopyWithImpl<CreateVacancyState>(this as CreateVacancyState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateVacancyState&&(identical(other.status, status) || other.status == status)&&(identical(other.createVacSt, createVacSt) || other.createVacSt == createVacSt)&&(identical(other.generateVacancyDes, generateVacancyDes) || other.generateVacancyDes == generateVacancyDes)&&(identical(other.errorText, errorText) || other.errorText == errorText)&&const DeepCollectionEquality().equals(other.operatingMode, operatingMode)&&(identical(other.employmentType, employmentType) || other.employmentType == employmentType)&&(identical(other.withOutResume, withOutResume) || other.withOutResume == withOutResume)&&(identical(other.temporaryEmployee, temporaryEmployee) || other.temporaryEmployee == temporaryEmployee)&&(identical(other.buttonEnable, buttonEnable) || other.buttonEnable == buttonEnable)&&(identical(other.salaryInInterview, salaryInInterview) || other.salaryInInterview == salaryInInterview)&&(identical(other.uzsCurrency, uzsCurrency) || other.uzsCurrency == uzsCurrency)&&(identical(other.vacancy, vacancy) || other.vacancy == vacancy)&&(identical(other.isEnable, isEnable) || other.isEnable == isEnable)&&(identical(other.location, location) || other.location == location)&&const DeepCollectionEquality().equals(other.images, images)&&(identical(other.category, category) || other.category == category));
}


@override
int get hashCode => Object.hash(runtimeType,status,createVacSt,generateVacancyDes,errorText,const DeepCollectionEquality().hash(operatingMode),employmentType,withOutResume,temporaryEmployee,buttonEnable,salaryInInterview,uzsCurrency,vacancy,isEnable,location,const DeepCollectionEquality().hash(images),category);

@override
String toString() {
  return 'CreateVacancyState(status: $status, createVacSt: $createVacSt, generateVacancyDes: $generateVacancyDes, errorText: $errorText, operatingMode: $operatingMode, employmentType: $employmentType, withOutResume: $withOutResume, temporaryEmployee: $temporaryEmployee, buttonEnable: $buttonEnable, salaryInInterview: $salaryInInterview, uzsCurrency: $uzsCurrency, vacancy: $vacancy, isEnable: $isEnable, location: $location, images: $images, category: $category)';
}


}

/// @nodoc
abstract mixin class $CreateVacancyStateCopyWith<$Res>  {
  factory $CreateVacancyStateCopyWith(CreateVacancyState value, $Res Function(CreateVacancyState) _then) = _$CreateVacancyStateCopyWithImpl;
@useResult
$Res call({
 RequestStatus status, RequestStatus createVacSt, RequestStatus generateVacancyDes, String? errorText, Set operatingMode, int employmentType, bool withOutResume, bool temporaryEmployee, bool buttonEnable, bool salaryInInterview, bool uzsCurrency, Vacancy? vacancy, bool isEnable, GeocodeResponse? location, List<File> images, int? category
});




}
/// @nodoc
class _$CreateVacancyStateCopyWithImpl<$Res>
    implements $CreateVacancyStateCopyWith<$Res> {
  _$CreateVacancyStateCopyWithImpl(this._self, this._then);

  final CreateVacancyState _self;
  final $Res Function(CreateVacancyState) _then;

/// Create a copy of CreateVacancyState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? createVacSt = null,Object? generateVacancyDes = null,Object? errorText = freezed,Object? operatingMode = null,Object? employmentType = null,Object? withOutResume = null,Object? temporaryEmployee = null,Object? buttonEnable = null,Object? salaryInInterview = null,Object? uzsCurrency = null,Object? vacancy = freezed,Object? isEnable = null,Object? location = freezed,Object? images = null,Object? category = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,createVacSt: null == createVacSt ? _self.createVacSt : createVacSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,generateVacancyDes: null == generateVacancyDes ? _self.generateVacancyDes : generateVacancyDes // ignore: cast_nullable_to_non_nullable
as RequestStatus,errorText: freezed == errorText ? _self.errorText : errorText // ignore: cast_nullable_to_non_nullable
as String?,operatingMode: null == operatingMode ? _self.operatingMode : operatingMode // ignore: cast_nullable_to_non_nullable
as Set,employmentType: null == employmentType ? _self.employmentType : employmentType // ignore: cast_nullable_to_non_nullable
as int,withOutResume: null == withOutResume ? _self.withOutResume : withOutResume // ignore: cast_nullable_to_non_nullable
as bool,temporaryEmployee: null == temporaryEmployee ? _self.temporaryEmployee : temporaryEmployee // ignore: cast_nullable_to_non_nullable
as bool,buttonEnable: null == buttonEnable ? _self.buttonEnable : buttonEnable // ignore: cast_nullable_to_non_nullable
as bool,salaryInInterview: null == salaryInInterview ? _self.salaryInInterview : salaryInInterview // ignore: cast_nullable_to_non_nullable
as bool,uzsCurrency: null == uzsCurrency ? _self.uzsCurrency : uzsCurrency // ignore: cast_nullable_to_non_nullable
as bool,vacancy: freezed == vacancy ? _self.vacancy : vacancy // ignore: cast_nullable_to_non_nullable
as Vacancy?,isEnable: null == isEnable ? _self.isEnable : isEnable // ignore: cast_nullable_to_non_nullable
as bool,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GeocodeResponse?,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<File>,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateVacancyState].
extension CreateVacancyStatePatterns on CreateVacancyState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateVacancyState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateVacancyState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateVacancyState value)  $default,){
final _that = this;
switch (_that) {
case _CreateVacancyState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateVacancyState value)?  $default,){
final _that = this;
switch (_that) {
case _CreateVacancyState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestStatus status,  RequestStatus createVacSt,  RequestStatus generateVacancyDes,  String? errorText,  Set operatingMode,  int employmentType,  bool withOutResume,  bool temporaryEmployee,  bool buttonEnable,  bool salaryInInterview,  bool uzsCurrency,  Vacancy? vacancy,  bool isEnable,  GeocodeResponse? location,  List<File> images,  int? category)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateVacancyState() when $default != null:
return $default(_that.status,_that.createVacSt,_that.generateVacancyDes,_that.errorText,_that.operatingMode,_that.employmentType,_that.withOutResume,_that.temporaryEmployee,_that.buttonEnable,_that.salaryInInterview,_that.uzsCurrency,_that.vacancy,_that.isEnable,_that.location,_that.images,_that.category);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestStatus status,  RequestStatus createVacSt,  RequestStatus generateVacancyDes,  String? errorText,  Set operatingMode,  int employmentType,  bool withOutResume,  bool temporaryEmployee,  bool buttonEnable,  bool salaryInInterview,  bool uzsCurrency,  Vacancy? vacancy,  bool isEnable,  GeocodeResponse? location,  List<File> images,  int? category)  $default,) {final _that = this;
switch (_that) {
case _CreateVacancyState():
return $default(_that.status,_that.createVacSt,_that.generateVacancyDes,_that.errorText,_that.operatingMode,_that.employmentType,_that.withOutResume,_that.temporaryEmployee,_that.buttonEnable,_that.salaryInInterview,_that.uzsCurrency,_that.vacancy,_that.isEnable,_that.location,_that.images,_that.category);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestStatus status,  RequestStatus createVacSt,  RequestStatus generateVacancyDes,  String? errorText,  Set operatingMode,  int employmentType,  bool withOutResume,  bool temporaryEmployee,  bool buttonEnable,  bool salaryInInterview,  bool uzsCurrency,  Vacancy? vacancy,  bool isEnable,  GeocodeResponse? location,  List<File> images,  int? category)?  $default,) {final _that = this;
switch (_that) {
case _CreateVacancyState() when $default != null:
return $default(_that.status,_that.createVacSt,_that.generateVacancyDes,_that.errorText,_that.operatingMode,_that.employmentType,_that.withOutResume,_that.temporaryEmployee,_that.buttonEnable,_that.salaryInInterview,_that.uzsCurrency,_that.vacancy,_that.isEnable,_that.location,_that.images,_that.category);case _:
  return null;

}
}

}

/// @nodoc


class _CreateVacancyState implements CreateVacancyState {
  const _CreateVacancyState({this.status = RequestStatus.initial, this.createVacSt = RequestStatus.initial, this.generateVacancyDes = RequestStatus.initial, this.errorText = null, final  Set operatingMode = const {}, this.employmentType = 3, this.withOutResume = true, this.temporaryEmployee = false, this.buttonEnable = false, this.salaryInInterview = false, this.uzsCurrency = false, this.vacancy = null, this.isEnable = false, this.location = null, final  List<File> images = const [], this.category = null}): _operatingMode = operatingMode,_images = images;
  

@override@JsonKey() final  RequestStatus status;
@override@JsonKey() final  RequestStatus createVacSt;
@override@JsonKey() final  RequestStatus generateVacancyDes;
@override@JsonKey() final  String? errorText;
 final  Set _operatingMode;
@override@JsonKey() Set get operatingMode {
  if (_operatingMode is EqualUnmodifiableSetView) return _operatingMode;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_operatingMode);
}

@override@JsonKey() final  int employmentType;
@override@JsonKey() final  bool withOutResume;
@override@JsonKey() final  bool temporaryEmployee;
@override@JsonKey() final  bool buttonEnable;
@override@JsonKey() final  bool salaryInInterview;
@override@JsonKey() final  bool uzsCurrency;
@override@JsonKey() final  Vacancy? vacancy;
@override@JsonKey() final  bool isEnable;
@override@JsonKey() final  GeocodeResponse? location;
 final  List<File> _images;
@override@JsonKey() List<File> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}

@override@JsonKey() final  int? category;

/// Create a copy of CreateVacancyState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateVacancyStateCopyWith<_CreateVacancyState> get copyWith => __$CreateVacancyStateCopyWithImpl<_CreateVacancyState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateVacancyState&&(identical(other.status, status) || other.status == status)&&(identical(other.createVacSt, createVacSt) || other.createVacSt == createVacSt)&&(identical(other.generateVacancyDes, generateVacancyDes) || other.generateVacancyDes == generateVacancyDes)&&(identical(other.errorText, errorText) || other.errorText == errorText)&&const DeepCollectionEquality().equals(other._operatingMode, _operatingMode)&&(identical(other.employmentType, employmentType) || other.employmentType == employmentType)&&(identical(other.withOutResume, withOutResume) || other.withOutResume == withOutResume)&&(identical(other.temporaryEmployee, temporaryEmployee) || other.temporaryEmployee == temporaryEmployee)&&(identical(other.buttonEnable, buttonEnable) || other.buttonEnable == buttonEnable)&&(identical(other.salaryInInterview, salaryInInterview) || other.salaryInInterview == salaryInInterview)&&(identical(other.uzsCurrency, uzsCurrency) || other.uzsCurrency == uzsCurrency)&&(identical(other.vacancy, vacancy) || other.vacancy == vacancy)&&(identical(other.isEnable, isEnable) || other.isEnable == isEnable)&&(identical(other.location, location) || other.location == location)&&const DeepCollectionEquality().equals(other._images, _images)&&(identical(other.category, category) || other.category == category));
}


@override
int get hashCode => Object.hash(runtimeType,status,createVacSt,generateVacancyDes,errorText,const DeepCollectionEquality().hash(_operatingMode),employmentType,withOutResume,temporaryEmployee,buttonEnable,salaryInInterview,uzsCurrency,vacancy,isEnable,location,const DeepCollectionEquality().hash(_images),category);

@override
String toString() {
  return 'CreateVacancyState(status: $status, createVacSt: $createVacSt, generateVacancyDes: $generateVacancyDes, errorText: $errorText, operatingMode: $operatingMode, employmentType: $employmentType, withOutResume: $withOutResume, temporaryEmployee: $temporaryEmployee, buttonEnable: $buttonEnable, salaryInInterview: $salaryInInterview, uzsCurrency: $uzsCurrency, vacancy: $vacancy, isEnable: $isEnable, location: $location, images: $images, category: $category)';
}


}

/// @nodoc
abstract mixin class _$CreateVacancyStateCopyWith<$Res> implements $CreateVacancyStateCopyWith<$Res> {
  factory _$CreateVacancyStateCopyWith(_CreateVacancyState value, $Res Function(_CreateVacancyState) _then) = __$CreateVacancyStateCopyWithImpl;
@override @useResult
$Res call({
 RequestStatus status, RequestStatus createVacSt, RequestStatus generateVacancyDes, String? errorText, Set operatingMode, int employmentType, bool withOutResume, bool temporaryEmployee, bool buttonEnable, bool salaryInInterview, bool uzsCurrency, Vacancy? vacancy, bool isEnable, GeocodeResponse? location, List<File> images, int? category
});




}
/// @nodoc
class __$CreateVacancyStateCopyWithImpl<$Res>
    implements _$CreateVacancyStateCopyWith<$Res> {
  __$CreateVacancyStateCopyWithImpl(this._self, this._then);

  final _CreateVacancyState _self;
  final $Res Function(_CreateVacancyState) _then;

/// Create a copy of CreateVacancyState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? createVacSt = null,Object? generateVacancyDes = null,Object? errorText = freezed,Object? operatingMode = null,Object? employmentType = null,Object? withOutResume = null,Object? temporaryEmployee = null,Object? buttonEnable = null,Object? salaryInInterview = null,Object? uzsCurrency = null,Object? vacancy = freezed,Object? isEnable = null,Object? location = freezed,Object? images = null,Object? category = freezed,}) {
  return _then(_CreateVacancyState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,createVacSt: null == createVacSt ? _self.createVacSt : createVacSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,generateVacancyDes: null == generateVacancyDes ? _self.generateVacancyDes : generateVacancyDes // ignore: cast_nullable_to_non_nullable
as RequestStatus,errorText: freezed == errorText ? _self.errorText : errorText // ignore: cast_nullable_to_non_nullable
as String?,operatingMode: null == operatingMode ? _self._operatingMode : operatingMode // ignore: cast_nullable_to_non_nullable
as Set,employmentType: null == employmentType ? _self.employmentType : employmentType // ignore: cast_nullable_to_non_nullable
as int,withOutResume: null == withOutResume ? _self.withOutResume : withOutResume // ignore: cast_nullable_to_non_nullable
as bool,temporaryEmployee: null == temporaryEmployee ? _self.temporaryEmployee : temporaryEmployee // ignore: cast_nullable_to_non_nullable
as bool,buttonEnable: null == buttonEnable ? _self.buttonEnable : buttonEnable // ignore: cast_nullable_to_non_nullable
as bool,salaryInInterview: null == salaryInInterview ? _self.salaryInInterview : salaryInInterview // ignore: cast_nullable_to_non_nullable
as bool,uzsCurrency: null == uzsCurrency ? _self.uzsCurrency : uzsCurrency // ignore: cast_nullable_to_non_nullable
as bool,vacancy: freezed == vacancy ? _self.vacancy : vacancy // ignore: cast_nullable_to_non_nullable
as Vacancy?,isEnable: null == isEnable ? _self.isEnable : isEnable // ignore: cast_nullable_to_non_nullable
as bool,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GeocodeResponse?,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<File>,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
