// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vacancy_form_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VacancyFormState {

 RequestStatus get gptSt; RequestStatus get gptDesSt; RequestStatus get formSt; Vacancy? get vacancy; VacancyParams? get params; bool get enableForm; bool get hasUnpublishedAds; bool get continueUnpublishedAds; NewChatGptResponse? get vacancyBody; String? get vacancyDesc;
/// Create a copy of VacancyFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VacancyFormStateCopyWith<VacancyFormState> get copyWith => _$VacancyFormStateCopyWithImpl<VacancyFormState>(this as VacancyFormState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VacancyFormState&&(identical(other.gptSt, gptSt) || other.gptSt == gptSt)&&(identical(other.gptDesSt, gptDesSt) || other.gptDesSt == gptDesSt)&&(identical(other.formSt, formSt) || other.formSt == formSt)&&(identical(other.vacancy, vacancy) || other.vacancy == vacancy)&&(identical(other.params, params) || other.params == params)&&(identical(other.enableForm, enableForm) || other.enableForm == enableForm)&&(identical(other.hasUnpublishedAds, hasUnpublishedAds) || other.hasUnpublishedAds == hasUnpublishedAds)&&(identical(other.continueUnpublishedAds, continueUnpublishedAds) || other.continueUnpublishedAds == continueUnpublishedAds)&&(identical(other.vacancyBody, vacancyBody) || other.vacancyBody == vacancyBody)&&(identical(other.vacancyDesc, vacancyDesc) || other.vacancyDesc == vacancyDesc));
}


@override
int get hashCode => Object.hash(runtimeType,gptSt,gptDesSt,formSt,vacancy,params,enableForm,hasUnpublishedAds,continueUnpublishedAds,vacancyBody,vacancyDesc);

@override
String toString() {
  return 'VacancyFormState(gptSt: $gptSt, gptDesSt: $gptDesSt, formSt: $formSt, vacancy: $vacancy, params: $params, enableForm: $enableForm, hasUnpublishedAds: $hasUnpublishedAds, continueUnpublishedAds: $continueUnpublishedAds, vacancyBody: $vacancyBody, vacancyDesc: $vacancyDesc)';
}


}

/// @nodoc
abstract mixin class $VacancyFormStateCopyWith<$Res>  {
  factory $VacancyFormStateCopyWith(VacancyFormState value, $Res Function(VacancyFormState) _then) = _$VacancyFormStateCopyWithImpl;
@useResult
$Res call({
 RequestStatus gptSt, RequestStatus gptDesSt, RequestStatus formSt, Vacancy? vacancy, VacancyParams? params, bool enableForm, bool hasUnpublishedAds, bool continueUnpublishedAds, NewChatGptResponse? vacancyBody, String? vacancyDesc
});




}
/// @nodoc
class _$VacancyFormStateCopyWithImpl<$Res>
    implements $VacancyFormStateCopyWith<$Res> {
  _$VacancyFormStateCopyWithImpl(this._self, this._then);

  final VacancyFormState _self;
  final $Res Function(VacancyFormState) _then;

/// Create a copy of VacancyFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? gptSt = null,Object? gptDesSt = null,Object? formSt = null,Object? vacancy = freezed,Object? params = freezed,Object? enableForm = null,Object? hasUnpublishedAds = null,Object? continueUnpublishedAds = null,Object? vacancyBody = freezed,Object? vacancyDesc = freezed,}) {
  return _then(_self.copyWith(
gptSt: null == gptSt ? _self.gptSt : gptSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,gptDesSt: null == gptDesSt ? _self.gptDesSt : gptDesSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,formSt: null == formSt ? _self.formSt : formSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,vacancy: freezed == vacancy ? _self.vacancy : vacancy // ignore: cast_nullable_to_non_nullable
as Vacancy?,params: freezed == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as VacancyParams?,enableForm: null == enableForm ? _self.enableForm : enableForm // ignore: cast_nullable_to_non_nullable
as bool,hasUnpublishedAds: null == hasUnpublishedAds ? _self.hasUnpublishedAds : hasUnpublishedAds // ignore: cast_nullable_to_non_nullable
as bool,continueUnpublishedAds: null == continueUnpublishedAds ? _self.continueUnpublishedAds : continueUnpublishedAds // ignore: cast_nullable_to_non_nullable
as bool,vacancyBody: freezed == vacancyBody ? _self.vacancyBody : vacancyBody // ignore: cast_nullable_to_non_nullable
as NewChatGptResponse?,vacancyDesc: freezed == vacancyDesc ? _self.vacancyDesc : vacancyDesc // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [VacancyFormState].
extension VacancyFormStatePatterns on VacancyFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VacancyFormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VacancyFormState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VacancyFormState value)  $default,){
final _that = this;
switch (_that) {
case _VacancyFormState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VacancyFormState value)?  $default,){
final _that = this;
switch (_that) {
case _VacancyFormState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestStatus gptSt,  RequestStatus gptDesSt,  RequestStatus formSt,  Vacancy? vacancy,  VacancyParams? params,  bool enableForm,  bool hasUnpublishedAds,  bool continueUnpublishedAds,  NewChatGptResponse? vacancyBody,  String? vacancyDesc)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VacancyFormState() when $default != null:
return $default(_that.gptSt,_that.gptDesSt,_that.formSt,_that.vacancy,_that.params,_that.enableForm,_that.hasUnpublishedAds,_that.continueUnpublishedAds,_that.vacancyBody,_that.vacancyDesc);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestStatus gptSt,  RequestStatus gptDesSt,  RequestStatus formSt,  Vacancy? vacancy,  VacancyParams? params,  bool enableForm,  bool hasUnpublishedAds,  bool continueUnpublishedAds,  NewChatGptResponse? vacancyBody,  String? vacancyDesc)  $default,) {final _that = this;
switch (_that) {
case _VacancyFormState():
return $default(_that.gptSt,_that.gptDesSt,_that.formSt,_that.vacancy,_that.params,_that.enableForm,_that.hasUnpublishedAds,_that.continueUnpublishedAds,_that.vacancyBody,_that.vacancyDesc);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestStatus gptSt,  RequestStatus gptDesSt,  RequestStatus formSt,  Vacancy? vacancy,  VacancyParams? params,  bool enableForm,  bool hasUnpublishedAds,  bool continueUnpublishedAds,  NewChatGptResponse? vacancyBody,  String? vacancyDesc)?  $default,) {final _that = this;
switch (_that) {
case _VacancyFormState() when $default != null:
return $default(_that.gptSt,_that.gptDesSt,_that.formSt,_that.vacancy,_that.params,_that.enableForm,_that.hasUnpublishedAds,_that.continueUnpublishedAds,_that.vacancyBody,_that.vacancyDesc);case _:
  return null;

}
}

}

/// @nodoc


class _VacancyFormState implements VacancyFormState {
  const _VacancyFormState({this.gptSt = RequestStatus.initial, this.gptDesSt = RequestStatus.initial, this.formSt = RequestStatus.initial, this.vacancy = null, this.params = null, this.enableForm = false, this.hasUnpublishedAds = false, this.continueUnpublishedAds = false, this.vacancyBody = null, this.vacancyDesc = null});
  

@override@JsonKey() final  RequestStatus gptSt;
@override@JsonKey() final  RequestStatus gptDesSt;
@override@JsonKey() final  RequestStatus formSt;
@override@JsonKey() final  Vacancy? vacancy;
@override@JsonKey() final  VacancyParams? params;
@override@JsonKey() final  bool enableForm;
@override@JsonKey() final  bool hasUnpublishedAds;
@override@JsonKey() final  bool continueUnpublishedAds;
@override@JsonKey() final  NewChatGptResponse? vacancyBody;
@override@JsonKey() final  String? vacancyDesc;

/// Create a copy of VacancyFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VacancyFormStateCopyWith<_VacancyFormState> get copyWith => __$VacancyFormStateCopyWithImpl<_VacancyFormState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VacancyFormState&&(identical(other.gptSt, gptSt) || other.gptSt == gptSt)&&(identical(other.gptDesSt, gptDesSt) || other.gptDesSt == gptDesSt)&&(identical(other.formSt, formSt) || other.formSt == formSt)&&(identical(other.vacancy, vacancy) || other.vacancy == vacancy)&&(identical(other.params, params) || other.params == params)&&(identical(other.enableForm, enableForm) || other.enableForm == enableForm)&&(identical(other.hasUnpublishedAds, hasUnpublishedAds) || other.hasUnpublishedAds == hasUnpublishedAds)&&(identical(other.continueUnpublishedAds, continueUnpublishedAds) || other.continueUnpublishedAds == continueUnpublishedAds)&&(identical(other.vacancyBody, vacancyBody) || other.vacancyBody == vacancyBody)&&(identical(other.vacancyDesc, vacancyDesc) || other.vacancyDesc == vacancyDesc));
}


@override
int get hashCode => Object.hash(runtimeType,gptSt,gptDesSt,formSt,vacancy,params,enableForm,hasUnpublishedAds,continueUnpublishedAds,vacancyBody,vacancyDesc);

@override
String toString() {
  return 'VacancyFormState(gptSt: $gptSt, gptDesSt: $gptDesSt, formSt: $formSt, vacancy: $vacancy, params: $params, enableForm: $enableForm, hasUnpublishedAds: $hasUnpublishedAds, continueUnpublishedAds: $continueUnpublishedAds, vacancyBody: $vacancyBody, vacancyDesc: $vacancyDesc)';
}


}

/// @nodoc
abstract mixin class _$VacancyFormStateCopyWith<$Res> implements $VacancyFormStateCopyWith<$Res> {
  factory _$VacancyFormStateCopyWith(_VacancyFormState value, $Res Function(_VacancyFormState) _then) = __$VacancyFormStateCopyWithImpl;
@override @useResult
$Res call({
 RequestStatus gptSt, RequestStatus gptDesSt, RequestStatus formSt, Vacancy? vacancy, VacancyParams? params, bool enableForm, bool hasUnpublishedAds, bool continueUnpublishedAds, NewChatGptResponse? vacancyBody, String? vacancyDesc
});




}
/// @nodoc
class __$VacancyFormStateCopyWithImpl<$Res>
    implements _$VacancyFormStateCopyWith<$Res> {
  __$VacancyFormStateCopyWithImpl(this._self, this._then);

  final _VacancyFormState _self;
  final $Res Function(_VacancyFormState) _then;

/// Create a copy of VacancyFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? gptSt = null,Object? gptDesSt = null,Object? formSt = null,Object? vacancy = freezed,Object? params = freezed,Object? enableForm = null,Object? hasUnpublishedAds = null,Object? continueUnpublishedAds = null,Object? vacancyBody = freezed,Object? vacancyDesc = freezed,}) {
  return _then(_VacancyFormState(
gptSt: null == gptSt ? _self.gptSt : gptSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,gptDesSt: null == gptDesSt ? _self.gptDesSt : gptDesSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,formSt: null == formSt ? _self.formSt : formSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,vacancy: freezed == vacancy ? _self.vacancy : vacancy // ignore: cast_nullable_to_non_nullable
as Vacancy?,params: freezed == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as VacancyParams?,enableForm: null == enableForm ? _self.enableForm : enableForm // ignore: cast_nullable_to_non_nullable
as bool,hasUnpublishedAds: null == hasUnpublishedAds ? _self.hasUnpublishedAds : hasUnpublishedAds // ignore: cast_nullable_to_non_nullable
as bool,continueUnpublishedAds: null == continueUnpublishedAds ? _self.continueUnpublishedAds : continueUnpublishedAds // ignore: cast_nullable_to_non_nullable
as bool,vacancyBody: freezed == vacancyBody ? _self.vacancyBody : vacancyBody // ignore: cast_nullable_to_non_nullable
as NewChatGptResponse?,vacancyDesc: freezed == vacancyDesc ? _self.vacancyDesc : vacancyDesc // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
