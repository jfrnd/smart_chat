// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'chats_overview_watcher_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ChatsOverviewWatcherEventTearOff {
  const _$ChatsOverviewWatcherEventTearOff();

  _WatchStarted watchStarted() {
    return const _WatchStarted();
  }

  _FailureReceived failureReceived(CrudFailure failure) {
    return _FailureReceived(
      failure,
    );
  }

  _ChatBotsReceived chatBotsReceived(KtList<ChatBot> chatBots) {
    return _ChatBotsReceived(
      chatBots,
    );
  }

  _QarsReceived qarsReceived(
      KtMap<UniqueId, Either<CrudFailure, Qar?>> idsToQars) {
    return _QarsReceived(
      idsToQars,
    );
  }
}

/// @nodoc
const $ChatsOverviewWatcherEvent = _$ChatsOverviewWatcherEventTearOff();

/// @nodoc
mixin _$ChatsOverviewWatcherEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() watchStarted,
    required TResult Function(CrudFailure failure) failureReceived,
    required TResult Function(KtList<ChatBot> chatBots) chatBotsReceived,
    required TResult Function(
            KtMap<UniqueId, Either<CrudFailure, Qar?>> idsToQars)
        qarsReceived,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? watchStarted,
    TResult Function(CrudFailure failure)? failureReceived,
    TResult Function(KtList<ChatBot> chatBots)? chatBotsReceived,
    TResult Function(KtMap<UniqueId, Either<CrudFailure, Qar?>> idsToQars)?
        qarsReceived,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WatchStarted value) watchStarted,
    required TResult Function(_FailureReceived value) failureReceived,
    required TResult Function(_ChatBotsReceived value) chatBotsReceived,
    required TResult Function(_QarsReceived value) qarsReceived,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchStarted value)? watchStarted,
    TResult Function(_FailureReceived value)? failureReceived,
    TResult Function(_ChatBotsReceived value)? chatBotsReceived,
    TResult Function(_QarsReceived value)? qarsReceived,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatsOverviewWatcherEventCopyWith<$Res> {
  factory $ChatsOverviewWatcherEventCopyWith(ChatsOverviewWatcherEvent value,
          $Res Function(ChatsOverviewWatcherEvent) then) =
      _$ChatsOverviewWatcherEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$ChatsOverviewWatcherEventCopyWithImpl<$Res>
    implements $ChatsOverviewWatcherEventCopyWith<$Res> {
  _$ChatsOverviewWatcherEventCopyWithImpl(this._value, this._then);

  final ChatsOverviewWatcherEvent _value;
  // ignore: unused_field
  final $Res Function(ChatsOverviewWatcherEvent) _then;
}

/// @nodoc
abstract class _$WatchStartedCopyWith<$Res> {
  factory _$WatchStartedCopyWith(
          _WatchStarted value, $Res Function(_WatchStarted) then) =
      __$WatchStartedCopyWithImpl<$Res>;
}

/// @nodoc
class __$WatchStartedCopyWithImpl<$Res>
    extends _$ChatsOverviewWatcherEventCopyWithImpl<$Res>
    implements _$WatchStartedCopyWith<$Res> {
  __$WatchStartedCopyWithImpl(
      _WatchStarted _value, $Res Function(_WatchStarted) _then)
      : super(_value, (v) => _then(v as _WatchStarted));

  @override
  _WatchStarted get _value => super._value as _WatchStarted;
}

/// @nodoc

class _$_WatchStarted implements _WatchStarted {
  const _$_WatchStarted();

  @override
  String toString() {
    return 'ChatsOverviewWatcherEvent.watchStarted()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _WatchStarted);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() watchStarted,
    required TResult Function(CrudFailure failure) failureReceived,
    required TResult Function(KtList<ChatBot> chatBots) chatBotsReceived,
    required TResult Function(
            KtMap<UniqueId, Either<CrudFailure, Qar?>> idsToQars)
        qarsReceived,
  }) {
    return watchStarted();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? watchStarted,
    TResult Function(CrudFailure failure)? failureReceived,
    TResult Function(KtList<ChatBot> chatBots)? chatBotsReceived,
    TResult Function(KtMap<UniqueId, Either<CrudFailure, Qar?>> idsToQars)?
        qarsReceived,
    required TResult orElse(),
  }) {
    if (watchStarted != null) {
      return watchStarted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WatchStarted value) watchStarted,
    required TResult Function(_FailureReceived value) failureReceived,
    required TResult Function(_ChatBotsReceived value) chatBotsReceived,
    required TResult Function(_QarsReceived value) qarsReceived,
  }) {
    return watchStarted(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchStarted value)? watchStarted,
    TResult Function(_FailureReceived value)? failureReceived,
    TResult Function(_ChatBotsReceived value)? chatBotsReceived,
    TResult Function(_QarsReceived value)? qarsReceived,
    required TResult orElse(),
  }) {
    if (watchStarted != null) {
      return watchStarted(this);
    }
    return orElse();
  }
}

abstract class _WatchStarted implements ChatsOverviewWatcherEvent {
  const factory _WatchStarted() = _$_WatchStarted;
}

/// @nodoc
abstract class _$FailureReceivedCopyWith<$Res> {
  factory _$FailureReceivedCopyWith(
          _FailureReceived value, $Res Function(_FailureReceived) then) =
      __$FailureReceivedCopyWithImpl<$Res>;
  $Res call({CrudFailure failure});

  $CrudFailureCopyWith<$Res> get failure;
}

/// @nodoc
class __$FailureReceivedCopyWithImpl<$Res>
    extends _$ChatsOverviewWatcherEventCopyWithImpl<$Res>
    implements _$FailureReceivedCopyWith<$Res> {
  __$FailureReceivedCopyWithImpl(
      _FailureReceived _value, $Res Function(_FailureReceived) _then)
      : super(_value, (v) => _then(v as _FailureReceived));

  @override
  _FailureReceived get _value => super._value as _FailureReceived;

  @override
  $Res call({
    Object? failure = freezed,
  }) {
    return _then(_FailureReceived(
      failure == freezed
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as CrudFailure,
    ));
  }

  @override
  $CrudFailureCopyWith<$Res> get failure {
    return $CrudFailureCopyWith<$Res>(_value.failure, (value) {
      return _then(_value.copyWith(failure: value));
    });
  }
}

/// @nodoc

class _$_FailureReceived implements _FailureReceived {
  const _$_FailureReceived(this.failure);

  @override
  final CrudFailure failure;

  @override
  String toString() {
    return 'ChatsOverviewWatcherEvent.failureReceived(failure: $failure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _FailureReceived &&
            (identical(other.failure, failure) ||
                const DeepCollectionEquality().equals(other.failure, failure)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(failure);

  @JsonKey(ignore: true)
  @override
  _$FailureReceivedCopyWith<_FailureReceived> get copyWith =>
      __$FailureReceivedCopyWithImpl<_FailureReceived>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() watchStarted,
    required TResult Function(CrudFailure failure) failureReceived,
    required TResult Function(KtList<ChatBot> chatBots) chatBotsReceived,
    required TResult Function(
            KtMap<UniqueId, Either<CrudFailure, Qar?>> idsToQars)
        qarsReceived,
  }) {
    return failureReceived(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? watchStarted,
    TResult Function(CrudFailure failure)? failureReceived,
    TResult Function(KtList<ChatBot> chatBots)? chatBotsReceived,
    TResult Function(KtMap<UniqueId, Either<CrudFailure, Qar?>> idsToQars)?
        qarsReceived,
    required TResult orElse(),
  }) {
    if (failureReceived != null) {
      return failureReceived(failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WatchStarted value) watchStarted,
    required TResult Function(_FailureReceived value) failureReceived,
    required TResult Function(_ChatBotsReceived value) chatBotsReceived,
    required TResult Function(_QarsReceived value) qarsReceived,
  }) {
    return failureReceived(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchStarted value)? watchStarted,
    TResult Function(_FailureReceived value)? failureReceived,
    TResult Function(_ChatBotsReceived value)? chatBotsReceived,
    TResult Function(_QarsReceived value)? qarsReceived,
    required TResult orElse(),
  }) {
    if (failureReceived != null) {
      return failureReceived(this);
    }
    return orElse();
  }
}

abstract class _FailureReceived implements ChatsOverviewWatcherEvent {
  const factory _FailureReceived(CrudFailure failure) = _$_FailureReceived;

  CrudFailure get failure => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$FailureReceivedCopyWith<_FailureReceived> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$ChatBotsReceivedCopyWith<$Res> {
  factory _$ChatBotsReceivedCopyWith(
          _ChatBotsReceived value, $Res Function(_ChatBotsReceived) then) =
      __$ChatBotsReceivedCopyWithImpl<$Res>;
  $Res call({KtList<ChatBot> chatBots});
}

/// @nodoc
class __$ChatBotsReceivedCopyWithImpl<$Res>
    extends _$ChatsOverviewWatcherEventCopyWithImpl<$Res>
    implements _$ChatBotsReceivedCopyWith<$Res> {
  __$ChatBotsReceivedCopyWithImpl(
      _ChatBotsReceived _value, $Res Function(_ChatBotsReceived) _then)
      : super(_value, (v) => _then(v as _ChatBotsReceived));

  @override
  _ChatBotsReceived get _value => super._value as _ChatBotsReceived;

  @override
  $Res call({
    Object? chatBots = freezed,
  }) {
    return _then(_ChatBotsReceived(
      chatBots == freezed
          ? _value.chatBots
          : chatBots // ignore: cast_nullable_to_non_nullable
              as KtList<ChatBot>,
    ));
  }
}

/// @nodoc

class _$_ChatBotsReceived implements _ChatBotsReceived {
  const _$_ChatBotsReceived(this.chatBots);

  @override
  final KtList<ChatBot> chatBots;

  @override
  String toString() {
    return 'ChatsOverviewWatcherEvent.chatBotsReceived(chatBots: $chatBots)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ChatBotsReceived &&
            (identical(other.chatBots, chatBots) ||
                const DeepCollectionEquality()
                    .equals(other.chatBots, chatBots)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(chatBots);

  @JsonKey(ignore: true)
  @override
  _$ChatBotsReceivedCopyWith<_ChatBotsReceived> get copyWith =>
      __$ChatBotsReceivedCopyWithImpl<_ChatBotsReceived>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() watchStarted,
    required TResult Function(CrudFailure failure) failureReceived,
    required TResult Function(KtList<ChatBot> chatBots) chatBotsReceived,
    required TResult Function(
            KtMap<UniqueId, Either<CrudFailure, Qar?>> idsToQars)
        qarsReceived,
  }) {
    return chatBotsReceived(chatBots);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? watchStarted,
    TResult Function(CrudFailure failure)? failureReceived,
    TResult Function(KtList<ChatBot> chatBots)? chatBotsReceived,
    TResult Function(KtMap<UniqueId, Either<CrudFailure, Qar?>> idsToQars)?
        qarsReceived,
    required TResult orElse(),
  }) {
    if (chatBotsReceived != null) {
      return chatBotsReceived(chatBots);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WatchStarted value) watchStarted,
    required TResult Function(_FailureReceived value) failureReceived,
    required TResult Function(_ChatBotsReceived value) chatBotsReceived,
    required TResult Function(_QarsReceived value) qarsReceived,
  }) {
    return chatBotsReceived(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchStarted value)? watchStarted,
    TResult Function(_FailureReceived value)? failureReceived,
    TResult Function(_ChatBotsReceived value)? chatBotsReceived,
    TResult Function(_QarsReceived value)? qarsReceived,
    required TResult orElse(),
  }) {
    if (chatBotsReceived != null) {
      return chatBotsReceived(this);
    }
    return orElse();
  }
}

abstract class _ChatBotsReceived implements ChatsOverviewWatcherEvent {
  const factory _ChatBotsReceived(KtList<ChatBot> chatBots) =
      _$_ChatBotsReceived;

  KtList<ChatBot> get chatBots => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$ChatBotsReceivedCopyWith<_ChatBotsReceived> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$QarsReceivedCopyWith<$Res> {
  factory _$QarsReceivedCopyWith(
          _QarsReceived value, $Res Function(_QarsReceived) then) =
      __$QarsReceivedCopyWithImpl<$Res>;
  $Res call({KtMap<UniqueId, Either<CrudFailure, Qar?>> idsToQars});
}

/// @nodoc
class __$QarsReceivedCopyWithImpl<$Res>
    extends _$ChatsOverviewWatcherEventCopyWithImpl<$Res>
    implements _$QarsReceivedCopyWith<$Res> {
  __$QarsReceivedCopyWithImpl(
      _QarsReceived _value, $Res Function(_QarsReceived) _then)
      : super(_value, (v) => _then(v as _QarsReceived));

  @override
  _QarsReceived get _value => super._value as _QarsReceived;

  @override
  $Res call({
    Object? idsToQars = freezed,
  }) {
    return _then(_QarsReceived(
      idsToQars == freezed
          ? _value.idsToQars
          : idsToQars // ignore: cast_nullable_to_non_nullable
              as KtMap<UniqueId, Either<CrudFailure, Qar?>>,
    ));
  }
}

/// @nodoc

class _$_QarsReceived implements _QarsReceived {
  const _$_QarsReceived(this.idsToQars);

  @override
  final KtMap<UniqueId, Either<CrudFailure, Qar?>> idsToQars;

  @override
  String toString() {
    return 'ChatsOverviewWatcherEvent.qarsReceived(idsToQars: $idsToQars)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _QarsReceived &&
            (identical(other.idsToQars, idsToQars) ||
                const DeepCollectionEquality()
                    .equals(other.idsToQars, idsToQars)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(idsToQars);

  @JsonKey(ignore: true)
  @override
  _$QarsReceivedCopyWith<_QarsReceived> get copyWith =>
      __$QarsReceivedCopyWithImpl<_QarsReceived>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() watchStarted,
    required TResult Function(CrudFailure failure) failureReceived,
    required TResult Function(KtList<ChatBot> chatBots) chatBotsReceived,
    required TResult Function(
            KtMap<UniqueId, Either<CrudFailure, Qar?>> idsToQars)
        qarsReceived,
  }) {
    return qarsReceived(idsToQars);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? watchStarted,
    TResult Function(CrudFailure failure)? failureReceived,
    TResult Function(KtList<ChatBot> chatBots)? chatBotsReceived,
    TResult Function(KtMap<UniqueId, Either<CrudFailure, Qar?>> idsToQars)?
        qarsReceived,
    required TResult orElse(),
  }) {
    if (qarsReceived != null) {
      return qarsReceived(idsToQars);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WatchStarted value) watchStarted,
    required TResult Function(_FailureReceived value) failureReceived,
    required TResult Function(_ChatBotsReceived value) chatBotsReceived,
    required TResult Function(_QarsReceived value) qarsReceived,
  }) {
    return qarsReceived(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchStarted value)? watchStarted,
    TResult Function(_FailureReceived value)? failureReceived,
    TResult Function(_ChatBotsReceived value)? chatBotsReceived,
    TResult Function(_QarsReceived value)? qarsReceived,
    required TResult orElse(),
  }) {
    if (qarsReceived != null) {
      return qarsReceived(this);
    }
    return orElse();
  }
}

abstract class _QarsReceived implements ChatsOverviewWatcherEvent {
  const factory _QarsReceived(
      KtMap<UniqueId, Either<CrudFailure, Qar?>> idsToQars) = _$_QarsReceived;

  KtMap<UniqueId, Either<CrudFailure, Qar?>> get idsToQars =>
      throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$QarsReceivedCopyWith<_QarsReceived> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$ChatsOverviewWatcherStateTearOff {
  const _$ChatsOverviewWatcherStateTearOff();

  _ChatsOverviewWatcherState call(
      {required bool isLoading,
      required CrudFailure? failure,
      required KtList<ChatBot> chatBots,
      required KtMap<UniqueId, String?> lastMessages,
      required KtMap<UniqueId, bool?> isAnswered,
      required KtMap<UniqueId, DateTime?> dateTime}) {
    return _ChatsOverviewWatcherState(
      isLoading: isLoading,
      failure: failure,
      chatBots: chatBots,
      lastMessages: lastMessages,
      isAnswered: isAnswered,
      dateTime: dateTime,
    );
  }
}

/// @nodoc
const $ChatsOverviewWatcherState = _$ChatsOverviewWatcherStateTearOff();

/// @nodoc
mixin _$ChatsOverviewWatcherState {
  bool get isLoading => throw _privateConstructorUsedError;
  CrudFailure? get failure => throw _privateConstructorUsedError;
  KtList<ChatBot> get chatBots => throw _privateConstructorUsedError;
  KtMap<UniqueId, String?> get lastMessages =>
      throw _privateConstructorUsedError;
  KtMap<UniqueId, bool?> get isAnswered => throw _privateConstructorUsedError;
  KtMap<UniqueId, DateTime?> get dateTime => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChatsOverviewWatcherStateCopyWith<ChatsOverviewWatcherState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatsOverviewWatcherStateCopyWith<$Res> {
  factory $ChatsOverviewWatcherStateCopyWith(ChatsOverviewWatcherState value,
          $Res Function(ChatsOverviewWatcherState) then) =
      _$ChatsOverviewWatcherStateCopyWithImpl<$Res>;
  $Res call(
      {bool isLoading,
      CrudFailure? failure,
      KtList<ChatBot> chatBots,
      KtMap<UniqueId, String?> lastMessages,
      KtMap<UniqueId, bool?> isAnswered,
      KtMap<UniqueId, DateTime?> dateTime});

  $CrudFailureCopyWith<$Res>? get failure;
}

/// @nodoc
class _$ChatsOverviewWatcherStateCopyWithImpl<$Res>
    implements $ChatsOverviewWatcherStateCopyWith<$Res> {
  _$ChatsOverviewWatcherStateCopyWithImpl(this._value, this._then);

  final ChatsOverviewWatcherState _value;
  // ignore: unused_field
  final $Res Function(ChatsOverviewWatcherState) _then;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? failure = freezed,
    Object? chatBots = freezed,
    Object? lastMessages = freezed,
    Object? isAnswered = freezed,
    Object? dateTime = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      failure: failure == freezed
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as CrudFailure?,
      chatBots: chatBots == freezed
          ? _value.chatBots
          : chatBots // ignore: cast_nullable_to_non_nullable
              as KtList<ChatBot>,
      lastMessages: lastMessages == freezed
          ? _value.lastMessages
          : lastMessages // ignore: cast_nullable_to_non_nullable
              as KtMap<UniqueId, String?>,
      isAnswered: isAnswered == freezed
          ? _value.isAnswered
          : isAnswered // ignore: cast_nullable_to_non_nullable
              as KtMap<UniqueId, bool?>,
      dateTime: dateTime == freezed
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as KtMap<UniqueId, DateTime?>,
    ));
  }

  @override
  $CrudFailureCopyWith<$Res>? get failure {
    if (_value.failure == null) {
      return null;
    }

    return $CrudFailureCopyWith<$Res>(_value.failure!, (value) {
      return _then(_value.copyWith(failure: value));
    });
  }
}

/// @nodoc
abstract class _$ChatsOverviewWatcherStateCopyWith<$Res>
    implements $ChatsOverviewWatcherStateCopyWith<$Res> {
  factory _$ChatsOverviewWatcherStateCopyWith(_ChatsOverviewWatcherState value,
          $Res Function(_ChatsOverviewWatcherState) then) =
      __$ChatsOverviewWatcherStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool isLoading,
      CrudFailure? failure,
      KtList<ChatBot> chatBots,
      KtMap<UniqueId, String?> lastMessages,
      KtMap<UniqueId, bool?> isAnswered,
      KtMap<UniqueId, DateTime?> dateTime});

  @override
  $CrudFailureCopyWith<$Res>? get failure;
}

/// @nodoc
class __$ChatsOverviewWatcherStateCopyWithImpl<$Res>
    extends _$ChatsOverviewWatcherStateCopyWithImpl<$Res>
    implements _$ChatsOverviewWatcherStateCopyWith<$Res> {
  __$ChatsOverviewWatcherStateCopyWithImpl(_ChatsOverviewWatcherState _value,
      $Res Function(_ChatsOverviewWatcherState) _then)
      : super(_value, (v) => _then(v as _ChatsOverviewWatcherState));

  @override
  _ChatsOverviewWatcherState get _value =>
      super._value as _ChatsOverviewWatcherState;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? failure = freezed,
    Object? chatBots = freezed,
    Object? lastMessages = freezed,
    Object? isAnswered = freezed,
    Object? dateTime = freezed,
  }) {
    return _then(_ChatsOverviewWatcherState(
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      failure: failure == freezed
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as CrudFailure?,
      chatBots: chatBots == freezed
          ? _value.chatBots
          : chatBots // ignore: cast_nullable_to_non_nullable
              as KtList<ChatBot>,
      lastMessages: lastMessages == freezed
          ? _value.lastMessages
          : lastMessages // ignore: cast_nullable_to_non_nullable
              as KtMap<UniqueId, String?>,
      isAnswered: isAnswered == freezed
          ? _value.isAnswered
          : isAnswered // ignore: cast_nullable_to_non_nullable
              as KtMap<UniqueId, bool?>,
      dateTime: dateTime == freezed
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as KtMap<UniqueId, DateTime?>,
    ));
  }
}

/// @nodoc

class _$_ChatsOverviewWatcherState implements _ChatsOverviewWatcherState {
  const _$_ChatsOverviewWatcherState(
      {required this.isLoading,
      required this.failure,
      required this.chatBots,
      required this.lastMessages,
      required this.isAnswered,
      required this.dateTime});

  @override
  final bool isLoading;
  @override
  final CrudFailure? failure;
  @override
  final KtList<ChatBot> chatBots;
  @override
  final KtMap<UniqueId, String?> lastMessages;
  @override
  final KtMap<UniqueId, bool?> isAnswered;
  @override
  final KtMap<UniqueId, DateTime?> dateTime;

  @override
  String toString() {
    return 'ChatsOverviewWatcherState(isLoading: $isLoading, failure: $failure, chatBots: $chatBots, lastMessages: $lastMessages, isAnswered: $isAnswered, dateTime: $dateTime)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ChatsOverviewWatcherState &&
            (identical(other.isLoading, isLoading) ||
                const DeepCollectionEquality()
                    .equals(other.isLoading, isLoading)) &&
            (identical(other.failure, failure) ||
                const DeepCollectionEquality()
                    .equals(other.failure, failure)) &&
            (identical(other.chatBots, chatBots) ||
                const DeepCollectionEquality()
                    .equals(other.chatBots, chatBots)) &&
            (identical(other.lastMessages, lastMessages) ||
                const DeepCollectionEquality()
                    .equals(other.lastMessages, lastMessages)) &&
            (identical(other.isAnswered, isAnswered) ||
                const DeepCollectionEquality()
                    .equals(other.isAnswered, isAnswered)) &&
            (identical(other.dateTime, dateTime) ||
                const DeepCollectionEquality()
                    .equals(other.dateTime, dateTime)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(isLoading) ^
      const DeepCollectionEquality().hash(failure) ^
      const DeepCollectionEquality().hash(chatBots) ^
      const DeepCollectionEquality().hash(lastMessages) ^
      const DeepCollectionEquality().hash(isAnswered) ^
      const DeepCollectionEquality().hash(dateTime);

  @JsonKey(ignore: true)
  @override
  _$ChatsOverviewWatcherStateCopyWith<_ChatsOverviewWatcherState>
      get copyWith =>
          __$ChatsOverviewWatcherStateCopyWithImpl<_ChatsOverviewWatcherState>(
              this, _$identity);
}

abstract class _ChatsOverviewWatcherState implements ChatsOverviewWatcherState {
  const factory _ChatsOverviewWatcherState(
          {required bool isLoading,
          required CrudFailure? failure,
          required KtList<ChatBot> chatBots,
          required KtMap<UniqueId, String?> lastMessages,
          required KtMap<UniqueId, bool?> isAnswered,
          required KtMap<UniqueId, DateTime?> dateTime}) =
      _$_ChatsOverviewWatcherState;

  @override
  bool get isLoading => throw _privateConstructorUsedError;
  @override
  CrudFailure? get failure => throw _privateConstructorUsedError;
  @override
  KtList<ChatBot> get chatBots => throw _privateConstructorUsedError;
  @override
  KtMap<UniqueId, String?> get lastMessages =>
      throw _privateConstructorUsedError;
  @override
  KtMap<UniqueId, bool?> get isAnswered => throw _privateConstructorUsedError;
  @override
  KtMap<UniqueId, DateTime?> get dateTime => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ChatsOverviewWatcherStateCopyWith<_ChatsOverviewWatcherState>
      get copyWith => throw _privateConstructorUsedError;
}
