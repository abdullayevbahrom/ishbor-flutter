// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MessageState {

 RequestStatus get status; bool get isLoading; PaginatedChatMessageResponse? get messages; bool get hasUnreadMessage;
/// Create a copy of MessageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageStateCopyWith<MessageState> get copyWith => _$MessageStateCopyWithImpl<MessageState>(this as MessageState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessageState&&(identical(other.status, status) || other.status == status)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.messages, messages) || other.messages == messages)&&(identical(other.hasUnreadMessage, hasUnreadMessage) || other.hasUnreadMessage == hasUnreadMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,isLoading,messages,hasUnreadMessage);

@override
String toString() {
  return 'MessageState(status: $status, isLoading: $isLoading, messages: $messages, hasUnreadMessage: $hasUnreadMessage)';
}


}

/// @nodoc
abstract mixin class $MessageStateCopyWith<$Res>  {
  factory $MessageStateCopyWith(MessageState value, $Res Function(MessageState) _then) = _$MessageStateCopyWithImpl;
@useResult
$Res call({
 RequestStatus status, bool isLoading, PaginatedChatMessageResponse? messages, bool hasUnreadMessage
});




}
/// @nodoc
class _$MessageStateCopyWithImpl<$Res>
    implements $MessageStateCopyWith<$Res> {
  _$MessageStateCopyWithImpl(this._self, this._then);

  final MessageState _self;
  final $Res Function(MessageState) _then;

/// Create a copy of MessageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? isLoading = null,Object? messages = freezed,Object? hasUnreadMessage = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,messages: freezed == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as PaginatedChatMessageResponse?,hasUnreadMessage: null == hasUnreadMessage ? _self.hasUnreadMessage : hasUnreadMessage // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [MessageState].
extension MessageStatePatterns on MessageState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MessageState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MessageState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MessageState value)  $default,){
final _that = this;
switch (_that) {
case _MessageState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MessageState value)?  $default,){
final _that = this;
switch (_that) {
case _MessageState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestStatus status,  bool isLoading,  PaginatedChatMessageResponse? messages,  bool hasUnreadMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MessageState() when $default != null:
return $default(_that.status,_that.isLoading,_that.messages,_that.hasUnreadMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestStatus status,  bool isLoading,  PaginatedChatMessageResponse? messages,  bool hasUnreadMessage)  $default,) {final _that = this;
switch (_that) {
case _MessageState():
return $default(_that.status,_that.isLoading,_that.messages,_that.hasUnreadMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestStatus status,  bool isLoading,  PaginatedChatMessageResponse? messages,  bool hasUnreadMessage)?  $default,) {final _that = this;
switch (_that) {
case _MessageState() when $default != null:
return $default(_that.status,_that.isLoading,_that.messages,_that.hasUnreadMessage);case _:
  return null;

}
}

}

/// @nodoc


class _MessageState implements MessageState {
  const _MessageState({this.status = RequestStatus.initial, this.isLoading = false, this.messages = null, this.hasUnreadMessage = false});
  

@override@JsonKey() final  RequestStatus status;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  PaginatedChatMessageResponse? messages;
@override@JsonKey() final  bool hasUnreadMessage;

/// Create a copy of MessageState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessageStateCopyWith<_MessageState> get copyWith => __$MessageStateCopyWithImpl<_MessageState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessageState&&(identical(other.status, status) || other.status == status)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.messages, messages) || other.messages == messages)&&(identical(other.hasUnreadMessage, hasUnreadMessage) || other.hasUnreadMessage == hasUnreadMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,isLoading,messages,hasUnreadMessage);

@override
String toString() {
  return 'MessageState(status: $status, isLoading: $isLoading, messages: $messages, hasUnreadMessage: $hasUnreadMessage)';
}


}

/// @nodoc
abstract mixin class _$MessageStateCopyWith<$Res> implements $MessageStateCopyWith<$Res> {
  factory _$MessageStateCopyWith(_MessageState value, $Res Function(_MessageState) _then) = __$MessageStateCopyWithImpl;
@override @useResult
$Res call({
 RequestStatus status, bool isLoading, PaginatedChatMessageResponse? messages, bool hasUnreadMessage
});




}
/// @nodoc
class __$MessageStateCopyWithImpl<$Res>
    implements _$MessageStateCopyWith<$Res> {
  __$MessageStateCopyWithImpl(this._self, this._then);

  final _MessageState _self;
  final $Res Function(_MessageState) _then;

/// Create a copy of MessageState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? isLoading = null,Object? messages = freezed,Object? hasUnreadMessage = null,}) {
  return _then(_MessageState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,messages: freezed == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as PaginatedChatMessageResponse?,hasUnreadMessage: null == hasUnreadMessage ? _self.hasUnreadMessage : hasUnreadMessage // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
