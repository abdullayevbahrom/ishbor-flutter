// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChatState {

 int? get messageId; RequestStatus get messageSt; RequestStatus get fetchSt; RequestStatus get sendSt; PaginatedMessageRecordResponse? get messageRecords; Message? get message; String? get errorText; bool get needToDownload; bool get isDownloading; bool get isLoadingMore; bool get enableDownIcon; List<dynamic> get sendingMessages;
/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatStateCopyWith<ChatState> get copyWith => _$ChatStateCopyWithImpl<ChatState>(this as ChatState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatState&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.messageSt, messageSt) || other.messageSt == messageSt)&&(identical(other.fetchSt, fetchSt) || other.fetchSt == fetchSt)&&(identical(other.sendSt, sendSt) || other.sendSt == sendSt)&&(identical(other.messageRecords, messageRecords) || other.messageRecords == messageRecords)&&(identical(other.message, message) || other.message == message)&&(identical(other.errorText, errorText) || other.errorText == errorText)&&(identical(other.needToDownload, needToDownload) || other.needToDownload == needToDownload)&&(identical(other.isDownloading, isDownloading) || other.isDownloading == isDownloading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.enableDownIcon, enableDownIcon) || other.enableDownIcon == enableDownIcon)&&const DeepCollectionEquality().equals(other.sendingMessages, sendingMessages));
}


@override
int get hashCode => Object.hash(runtimeType,messageId,messageSt,fetchSt,sendSt,messageRecords,message,errorText,needToDownload,isDownloading,isLoadingMore,enableDownIcon,const DeepCollectionEquality().hash(sendingMessages));

@override
String toString() {
  return 'ChatState(messageId: $messageId, messageSt: $messageSt, fetchSt: $fetchSt, sendSt: $sendSt, messageRecords: $messageRecords, message: $message, errorText: $errorText, needToDownload: $needToDownload, isDownloading: $isDownloading, isLoadingMore: $isLoadingMore, enableDownIcon: $enableDownIcon, sendingMessages: $sendingMessages)';
}


}

/// @nodoc
abstract mixin class $ChatStateCopyWith<$Res>  {
  factory $ChatStateCopyWith(ChatState value, $Res Function(ChatState) _then) = _$ChatStateCopyWithImpl;
@useResult
$Res call({
 int? messageId, RequestStatus messageSt, RequestStatus fetchSt, RequestStatus sendSt, PaginatedMessageRecordResponse? messageRecords, Message? message, String? errorText, bool needToDownload, bool isDownloading, bool isLoadingMore, bool enableDownIcon, List<dynamic> sendingMessages
});




}
/// @nodoc
class _$ChatStateCopyWithImpl<$Res>
    implements $ChatStateCopyWith<$Res> {
  _$ChatStateCopyWithImpl(this._self, this._then);

  final ChatState _self;
  final $Res Function(ChatState) _then;

/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? messageId = freezed,Object? messageSt = null,Object? fetchSt = null,Object? sendSt = null,Object? messageRecords = freezed,Object? message = freezed,Object? errorText = freezed,Object? needToDownload = null,Object? isDownloading = null,Object? isLoadingMore = null,Object? enableDownIcon = null,Object? sendingMessages = null,}) {
  return _then(_self.copyWith(
messageId: freezed == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as int?,messageSt: null == messageSt ? _self.messageSt : messageSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,fetchSt: null == fetchSt ? _self.fetchSt : fetchSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,sendSt: null == sendSt ? _self.sendSt : sendSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,messageRecords: freezed == messageRecords ? _self.messageRecords : messageRecords // ignore: cast_nullable_to_non_nullable
as PaginatedMessageRecordResponse?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as Message?,errorText: freezed == errorText ? _self.errorText : errorText // ignore: cast_nullable_to_non_nullable
as String?,needToDownload: null == needToDownload ? _self.needToDownload : needToDownload // ignore: cast_nullable_to_non_nullable
as bool,isDownloading: null == isDownloading ? _self.isDownloading : isDownloading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,enableDownIcon: null == enableDownIcon ? _self.enableDownIcon : enableDownIcon // ignore: cast_nullable_to_non_nullable
as bool,sendingMessages: null == sendingMessages ? _self.sendingMessages : sendingMessages // ignore: cast_nullable_to_non_nullable
as List<dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatState].
extension ChatStatePatterns on ChatState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatState value)  $default,){
final _that = this;
switch (_that) {
case _ChatState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatState value)?  $default,){
final _that = this;
switch (_that) {
case _ChatState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? messageId,  RequestStatus messageSt,  RequestStatus fetchSt,  RequestStatus sendSt,  PaginatedMessageRecordResponse? messageRecords,  Message? message,  String? errorText,  bool needToDownload,  bool isDownloading,  bool isLoadingMore,  bool enableDownIcon,  List<dynamic> sendingMessages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatState() when $default != null:
return $default(_that.messageId,_that.messageSt,_that.fetchSt,_that.sendSt,_that.messageRecords,_that.message,_that.errorText,_that.needToDownload,_that.isDownloading,_that.isLoadingMore,_that.enableDownIcon,_that.sendingMessages);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? messageId,  RequestStatus messageSt,  RequestStatus fetchSt,  RequestStatus sendSt,  PaginatedMessageRecordResponse? messageRecords,  Message? message,  String? errorText,  bool needToDownload,  bool isDownloading,  bool isLoadingMore,  bool enableDownIcon,  List<dynamic> sendingMessages)  $default,) {final _that = this;
switch (_that) {
case _ChatState():
return $default(_that.messageId,_that.messageSt,_that.fetchSt,_that.sendSt,_that.messageRecords,_that.message,_that.errorText,_that.needToDownload,_that.isDownloading,_that.isLoadingMore,_that.enableDownIcon,_that.sendingMessages);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? messageId,  RequestStatus messageSt,  RequestStatus fetchSt,  RequestStatus sendSt,  PaginatedMessageRecordResponse? messageRecords,  Message? message,  String? errorText,  bool needToDownload,  bool isDownloading,  bool isLoadingMore,  bool enableDownIcon,  List<dynamic> sendingMessages)?  $default,) {final _that = this;
switch (_that) {
case _ChatState() when $default != null:
return $default(_that.messageId,_that.messageSt,_that.fetchSt,_that.sendSt,_that.messageRecords,_that.message,_that.errorText,_that.needToDownload,_that.isDownloading,_that.isLoadingMore,_that.enableDownIcon,_that.sendingMessages);case _:
  return null;

}
}

}

/// @nodoc


class _ChatState implements ChatState {
  const _ChatState({this.messageId = null, this.messageSt = RequestStatus.initial, this.fetchSt = RequestStatus.initial, this.sendSt = RequestStatus.initial, this.messageRecords = null, this.message = null, this.errorText = null, this.needToDownload = false, this.isDownloading = false, this.isLoadingMore = false, this.enableDownIcon = false, final  List<dynamic> sendingMessages = const []}): _sendingMessages = sendingMessages;
  

@override@JsonKey() final  int? messageId;
@override@JsonKey() final  RequestStatus messageSt;
@override@JsonKey() final  RequestStatus fetchSt;
@override@JsonKey() final  RequestStatus sendSt;
@override@JsonKey() final  PaginatedMessageRecordResponse? messageRecords;
@override@JsonKey() final  Message? message;
@override@JsonKey() final  String? errorText;
@override@JsonKey() final  bool needToDownload;
@override@JsonKey() final  bool isDownloading;
@override@JsonKey() final  bool isLoadingMore;
@override@JsonKey() final  bool enableDownIcon;
 final  List<dynamic> _sendingMessages;
@override@JsonKey() List<dynamic> get sendingMessages {
  if (_sendingMessages is EqualUnmodifiableListView) return _sendingMessages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sendingMessages);
}


/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatStateCopyWith<_ChatState> get copyWith => __$ChatStateCopyWithImpl<_ChatState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatState&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.messageSt, messageSt) || other.messageSt == messageSt)&&(identical(other.fetchSt, fetchSt) || other.fetchSt == fetchSt)&&(identical(other.sendSt, sendSt) || other.sendSt == sendSt)&&(identical(other.messageRecords, messageRecords) || other.messageRecords == messageRecords)&&(identical(other.message, message) || other.message == message)&&(identical(other.errorText, errorText) || other.errorText == errorText)&&(identical(other.needToDownload, needToDownload) || other.needToDownload == needToDownload)&&(identical(other.isDownloading, isDownloading) || other.isDownloading == isDownloading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.enableDownIcon, enableDownIcon) || other.enableDownIcon == enableDownIcon)&&const DeepCollectionEquality().equals(other._sendingMessages, _sendingMessages));
}


@override
int get hashCode => Object.hash(runtimeType,messageId,messageSt,fetchSt,sendSt,messageRecords,message,errorText,needToDownload,isDownloading,isLoadingMore,enableDownIcon,const DeepCollectionEquality().hash(_sendingMessages));

@override
String toString() {
  return 'ChatState(messageId: $messageId, messageSt: $messageSt, fetchSt: $fetchSt, sendSt: $sendSt, messageRecords: $messageRecords, message: $message, errorText: $errorText, needToDownload: $needToDownload, isDownloading: $isDownloading, isLoadingMore: $isLoadingMore, enableDownIcon: $enableDownIcon, sendingMessages: $sendingMessages)';
}


}

/// @nodoc
abstract mixin class _$ChatStateCopyWith<$Res> implements $ChatStateCopyWith<$Res> {
  factory _$ChatStateCopyWith(_ChatState value, $Res Function(_ChatState) _then) = __$ChatStateCopyWithImpl;
@override @useResult
$Res call({
 int? messageId, RequestStatus messageSt, RequestStatus fetchSt, RequestStatus sendSt, PaginatedMessageRecordResponse? messageRecords, Message? message, String? errorText, bool needToDownload, bool isDownloading, bool isLoadingMore, bool enableDownIcon, List<dynamic> sendingMessages
});




}
/// @nodoc
class __$ChatStateCopyWithImpl<$Res>
    implements _$ChatStateCopyWith<$Res> {
  __$ChatStateCopyWithImpl(this._self, this._then);

  final _ChatState _self;
  final $Res Function(_ChatState) _then;

/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? messageId = freezed,Object? messageSt = null,Object? fetchSt = null,Object? sendSt = null,Object? messageRecords = freezed,Object? message = freezed,Object? errorText = freezed,Object? needToDownload = null,Object? isDownloading = null,Object? isLoadingMore = null,Object? enableDownIcon = null,Object? sendingMessages = null,}) {
  return _then(_ChatState(
messageId: freezed == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as int?,messageSt: null == messageSt ? _self.messageSt : messageSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,fetchSt: null == fetchSt ? _self.fetchSt : fetchSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,sendSt: null == sendSt ? _self.sendSt : sendSt // ignore: cast_nullable_to_non_nullable
as RequestStatus,messageRecords: freezed == messageRecords ? _self.messageRecords : messageRecords // ignore: cast_nullable_to_non_nullable
as PaginatedMessageRecordResponse?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as Message?,errorText: freezed == errorText ? _self.errorText : errorText // ignore: cast_nullable_to_non_nullable
as String?,needToDownload: null == needToDownload ? _self.needToDownload : needToDownload // ignore: cast_nullable_to_non_nullable
as bool,isDownloading: null == isDownloading ? _self.isDownloading : isDownloading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,enableDownIcon: null == enableDownIcon ? _self.enableDownIcon : enableDownIcon // ignore: cast_nullable_to_non_nullable
as bool,sendingMessages: null == sendingMessages ? _self._sendingMessages : sendingMessages // ignore: cast_nullable_to_non_nullable
as List<dynamic>,
  ));
}


}

// dart format on
