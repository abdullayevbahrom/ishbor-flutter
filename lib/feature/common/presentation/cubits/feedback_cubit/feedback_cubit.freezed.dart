// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feedback_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FeedbackState {

 RequestStatus get countSt; RequestStatus get listSt; RequestStatus get addReviewSt; PaginatedFeedbackResponse? get listFeedBack; String? get errorText; int get countFeedback;
/// Create a copy of FeedbackState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedbackStateCopyWith<FeedbackState> get copyWith => _$FeedbackStateCopyWithImpl<FeedbackState>(this as FeedbackState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedbackState&&(identical(other.countSt, countSt) || other.countSt == countSt)&&(identical(other.listSt, listSt) || other.listSt == listSt)&&(identical(other.addReviewSt, addReviewSt) || other.addReviewSt == addReviewSt)&&(identical(other.listFeedBack, listFeedBack) || other.listFeedBack == listFeedBack)&&(identical(other.errorText, errorText) || other.errorText == errorText)&&(identical(other.countFeedback, countFeedback) || other.countFeedback == countFeedback));
}


@override
int get hashCode => Object.hash(runtimeType,countSt,listSt,addReviewSt,listFeedBack,errorText,countFeedback);

@override
String toString() {
  return 'FeedbackState(countSt: $countSt, listSt: $listSt, addReviewSt: $addReviewSt, listFeedBack: $listFeedBack, errorText: $errorText, countFeedback: $countFeedback)';
}


}

/// @nodoc
abstract mixin class $FeedbackStateCopyWith<$Res>  {
  factory $FeedbackStateCopyWith(FeedbackState value, $Res Function(FeedbackState) _then) = _$FeedbackStateCopyWithImpl;
@useResult
$Res call({
 RequestStatus countSt, RequestStatus listSt, RequestStatus addReviewSt, PaginatedFeedbackResponse? listFeedBack, String? errorText, int countFeedback
});




}
/// @nodoc
class _$FeedbackStateCopyWithImpl<$Res>
    implements $FeedbackStateCopyWith<$Res> {
  _$FeedbackStateCopyWithImpl(this._self, this._then);

  final FeedbackState _self;
  final $Res Function(FeedbackState) _then;

/// Create a copy of FeedbackState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? countSt = null,Object? listSt = null,Object? addReviewSt = null,Object? listFeedBack = freezed,Object? errorText = freezed,Object? countFeedback = null,}) {
  return _then(_self.copyWith(
countSt: null == countSt ? _self.countSt : countSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,listSt: null == listSt ? _self.listSt : listSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,addReviewSt: null == addReviewSt ? _self.addReviewSt : addReviewSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,listFeedBack: freezed == listFeedBack ? _self.listFeedBack : listFeedBack // ignore: cast_nullable_to_non_nullable
as PaginatedFeedbackResponse?,errorText: freezed == errorText ? _self.errorText : errorText // ignore: cast_nullable_to_non_nullable
as String?,countFeedback: null == countFeedback ? _self.countFeedback : countFeedback // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedbackState].
extension FeedbackStatePatterns on FeedbackState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedbackState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedbackState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedbackState value)  $default,){
final _that = this;
switch (_that) {
case _FeedbackState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedbackState value)?  $default,){
final _that = this;
switch (_that) {
case _FeedbackState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestStatus countSt,  RequestStatus listSt,  RequestStatus addReviewSt,  PaginatedFeedbackResponse? listFeedBack,  String? errorText,  int countFeedback)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedbackState() when $default != null:
return $default(_that.countSt,_that.listSt,_that.addReviewSt,_that.listFeedBack,_that.errorText,_that.countFeedback);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestStatus countSt,  RequestStatus listSt,  RequestStatus addReviewSt,  PaginatedFeedbackResponse? listFeedBack,  String? errorText,  int countFeedback)  $default,) {final _that = this;
switch (_that) {
case _FeedbackState():
return $default(_that.countSt,_that.listSt,_that.addReviewSt,_that.listFeedBack,_that.errorText,_that.countFeedback);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestStatus countSt,  RequestStatus listSt,  RequestStatus addReviewSt,  PaginatedFeedbackResponse? listFeedBack,  String? errorText,  int countFeedback)?  $default,) {final _that = this;
switch (_that) {
case _FeedbackState() when $default != null:
return $default(_that.countSt,_that.listSt,_that.addReviewSt,_that.listFeedBack,_that.errorText,_that.countFeedback);case _:
  return null;

}
}

}

/// @nodoc


class _FeedbackState implements FeedbackState {
  const _FeedbackState({this.countSt = RequestStatus.initial, this.listSt = RequestStatus.initial, this.addReviewSt = RequestStatus.initial, this.listFeedBack = null, this.errorText = null, this.countFeedback = 0});
  

@override@JsonKey() final  RequestStatus countSt;
@override@JsonKey() final  RequestStatus listSt;
@override@JsonKey() final  RequestStatus addReviewSt;
@override@JsonKey() final  PaginatedFeedbackResponse? listFeedBack;
@override@JsonKey() final  String? errorText;
@override@JsonKey() final  int countFeedback;

/// Create a copy of FeedbackState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedbackStateCopyWith<_FeedbackState> get copyWith => __$FeedbackStateCopyWithImpl<_FeedbackState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedbackState&&(identical(other.countSt, countSt) || other.countSt == countSt)&&(identical(other.listSt, listSt) || other.listSt == listSt)&&(identical(other.addReviewSt, addReviewSt) || other.addReviewSt == addReviewSt)&&(identical(other.listFeedBack, listFeedBack) || other.listFeedBack == listFeedBack)&&(identical(other.errorText, errorText) || other.errorText == errorText)&&(identical(other.countFeedback, countFeedback) || other.countFeedback == countFeedback));
}


@override
int get hashCode => Object.hash(runtimeType,countSt,listSt,addReviewSt,listFeedBack,errorText,countFeedback);

@override
String toString() {
  return 'FeedbackState(countSt: $countSt, listSt: $listSt, addReviewSt: $addReviewSt, listFeedBack: $listFeedBack, errorText: $errorText, countFeedback: $countFeedback)';
}


}

/// @nodoc
abstract mixin class _$FeedbackStateCopyWith<$Res> implements $FeedbackStateCopyWith<$Res> {
  factory _$FeedbackStateCopyWith(_FeedbackState value, $Res Function(_FeedbackState) _then) = __$FeedbackStateCopyWithImpl;
@override @useResult
$Res call({
 RequestStatus countSt, RequestStatus listSt, RequestStatus addReviewSt, PaginatedFeedbackResponse? listFeedBack, String? errorText, int countFeedback
});




}
/// @nodoc
class __$FeedbackStateCopyWithImpl<$Res>
    implements _$FeedbackStateCopyWith<$Res> {
  __$FeedbackStateCopyWithImpl(this._self, this._then);

  final _FeedbackState _self;
  final $Res Function(_FeedbackState) _then;

/// Create a copy of FeedbackState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? countSt = null,Object? listSt = null,Object? addReviewSt = null,Object? listFeedBack = freezed,Object? errorText = freezed,Object? countFeedback = null,}) {
  return _then(_FeedbackState(
countSt: null == countSt ? _self.countSt : countSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,listSt: null == listSt ? _self.listSt : listSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,addReviewSt: null == addReviewSt ? _self.addReviewSt : addReviewSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,listFeedBack: freezed == listFeedBack ? _self.listFeedBack : listFeedBack // ignore: cast_nullable_to_non_nullable
as PaginatedFeedbackResponse?,errorText: freezed == errorText ? _self.errorText : errorText // ignore: cast_nullable_to_non_nullable
as String?,countFeedback: null == countFeedback ? _self.countFeedback : countFeedback // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
