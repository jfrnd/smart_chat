// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'chat_watcher_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ChatWatcherEventTearOff {
  const _$ChatWatcherEventTearOff();

  _WatchStarted watchStarted({required UniqueId chatBotId}) {
    return _WatchStarted(
      chatBotId: chatBotId,
    );
  }

  _FailureReceived failureReceived(CrudFailure failure) {
    return _FailureReceived(
      failure,
    );
  }

  _DataReveived dataReceived(
      ChatBot chatBot,
      KtList<Qar> qars,
      KtList<Question> questions,
      KtList<AnswerOption> answerOptions,
      KtList<AnswerItem> answerItems) {
    return _DataReveived(
      chatBot,
      qars,
      questions,
      answerOptions,
      answerItems,
    );
  }
}

/// @nodoc
const $ChatWatcherEvent = _$ChatWatcherEventTearOff();

/// @nodoc
mixin _$ChatWatcherEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UniqueId chatBotId) watchStarted,
    required TResult Function(CrudFailure failure) failureReceived,
    required TResult Function(
            ChatBot chatBot,
            KtList<Qar> qars,
            KtList<Question> questions,
            KtList<AnswerOption> answerOptions,
            KtList<AnswerItem> answerItems)
        dataReceived,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UniqueId chatBotId)? watchStarted,
    TResult Function(CrudFailure failure)? failureReceived,
    TResult Function(
            ChatBot chatBot,
            KtList<Qar> qars,
            KtList<Question> questions,
            KtList<AnswerOption> answerOptions,
            KtList<AnswerItem> answerItems)?
        dataReceived,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WatchStarted value) watchStarted,
    required TResult Function(_FailureReceived value) failureReceived,
    required TResult Function(_DataReveived value) dataReceived,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchStarted value)? watchStarted,
    TResult Function(_FailureReceived value)? failureReceived,
    TResult Function(_DataReveived value)? dataReceived,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatWatcherEventCopyWith<$Res> {
  factory $ChatWatcherEventCopyWith(
          ChatWatcherEvent value, $Res Function(ChatWatcherEvent) then) =
      _$ChatWatcherEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$ChatWatcherEventCopyWithImpl<$Res>
    implements $ChatWatcherEventCopyWith<$Res> {
  _$ChatWatcherEventCopyWithImpl(this._value, this._then);

  final ChatWatcherEvent _value;
  // ignore: unused_field
  final $Res Function(ChatWatcherEvent) _then;
}

/// @nodoc
abstract class _$WatchStartedCopyWith<$Res> {
  factory _$WatchStartedCopyWith(
          _WatchStarted value, $Res Function(_WatchStarted) then) =
      __$WatchStartedCopyWithImpl<$Res>;
  $Res call({UniqueId chatBotId});
}

/// @nodoc
class __$WatchStartedCopyWithImpl<$Res>
    extends _$ChatWatcherEventCopyWithImpl<$Res>
    implements _$WatchStartedCopyWith<$Res> {
  __$WatchStartedCopyWithImpl(
      _WatchStarted _value, $Res Function(_WatchStarted) _then)
      : super(_value, (v) => _then(v as _WatchStarted));

  @override
  _WatchStarted get _value => super._value as _WatchStarted;

  @override
  $Res call({
    Object? chatBotId = freezed,
  }) {
    return _then(_WatchStarted(
      chatBotId: chatBotId == freezed
          ? _value.chatBotId
          : chatBotId // ignore: cast_nullable_to_non_nullable
              as UniqueId,
    ));
  }
}

/// @nodoc

class _$_WatchStarted implements _WatchStarted {
  const _$_WatchStarted({required this.chatBotId});

  @override
  final UniqueId chatBotId;

  @override
  String toString() {
    return 'ChatWatcherEvent.watchStarted(chatBotId: $chatBotId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _WatchStarted &&
            (identical(other.chatBotId, chatBotId) ||
                const DeepCollectionEquality()
                    .equals(other.chatBotId, chatBotId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(chatBotId);

  @JsonKey(ignore: true)
  @override
  _$WatchStartedCopyWith<_WatchStarted> get copyWith =>
      __$WatchStartedCopyWithImpl<_WatchStarted>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UniqueId chatBotId) watchStarted,
    required TResult Function(CrudFailure failure) failureReceived,
    required TResult Function(
            ChatBot chatBot,
            KtList<Qar> qars,
            KtList<Question> questions,
            KtList<AnswerOption> answerOptions,
            KtList<AnswerItem> answerItems)
        dataReceived,
  }) {
    return watchStarted(chatBotId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UniqueId chatBotId)? watchStarted,
    TResult Function(CrudFailure failure)? failureReceived,
    TResult Function(
            ChatBot chatBot,
            KtList<Qar> qars,
            KtList<Question> questions,
            KtList<AnswerOption> answerOptions,
            KtList<AnswerItem> answerItems)?
        dataReceived,
    required TResult orElse(),
  }) {
    if (watchStarted != null) {
      return watchStarted(chatBotId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WatchStarted value) watchStarted,
    required TResult Function(_FailureReceived value) failureReceived,
    required TResult Function(_DataReveived value) dataReceived,
  }) {
    return watchStarted(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchStarted value)? watchStarted,
    TResult Function(_FailureReceived value)? failureReceived,
    TResult Function(_DataReveived value)? dataReceived,
    required TResult orElse(),
  }) {
    if (watchStarted != null) {
      return watchStarted(this);
    }
    return orElse();
  }
}

abstract class _WatchStarted implements ChatWatcherEvent {
  const factory _WatchStarted({required UniqueId chatBotId}) = _$_WatchStarted;

  UniqueId get chatBotId => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$WatchStartedCopyWith<_WatchStarted> get copyWith =>
      throw _privateConstructorUsedError;
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
    extends _$ChatWatcherEventCopyWithImpl<$Res>
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
    return 'ChatWatcherEvent.failureReceived(failure: $failure)';
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
    required TResult Function(UniqueId chatBotId) watchStarted,
    required TResult Function(CrudFailure failure) failureReceived,
    required TResult Function(
            ChatBot chatBot,
            KtList<Qar> qars,
            KtList<Question> questions,
            KtList<AnswerOption> answerOptions,
            KtList<AnswerItem> answerItems)
        dataReceived,
  }) {
    return failureReceived(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UniqueId chatBotId)? watchStarted,
    TResult Function(CrudFailure failure)? failureReceived,
    TResult Function(
            ChatBot chatBot,
            KtList<Qar> qars,
            KtList<Question> questions,
            KtList<AnswerOption> answerOptions,
            KtList<AnswerItem> answerItems)?
        dataReceived,
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
    required TResult Function(_DataReveived value) dataReceived,
  }) {
    return failureReceived(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchStarted value)? watchStarted,
    TResult Function(_FailureReceived value)? failureReceived,
    TResult Function(_DataReveived value)? dataReceived,
    required TResult orElse(),
  }) {
    if (failureReceived != null) {
      return failureReceived(this);
    }
    return orElse();
  }
}

abstract class _FailureReceived implements ChatWatcherEvent {
  const factory _FailureReceived(CrudFailure failure) = _$_FailureReceived;

  CrudFailure get failure => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$FailureReceivedCopyWith<_FailureReceived> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$DataReveivedCopyWith<$Res> {
  factory _$DataReveivedCopyWith(
          _DataReveived value, $Res Function(_DataReveived) then) =
      __$DataReveivedCopyWithImpl<$Res>;
  $Res call(
      {ChatBot chatBot,
      KtList<Qar> qars,
      KtList<Question> questions,
      KtList<AnswerOption> answerOptions,
      KtList<AnswerItem> answerItems});
}

/// @nodoc
class __$DataReveivedCopyWithImpl<$Res>
    extends _$ChatWatcherEventCopyWithImpl<$Res>
    implements _$DataReveivedCopyWith<$Res> {
  __$DataReveivedCopyWithImpl(
      _DataReveived _value, $Res Function(_DataReveived) _then)
      : super(_value, (v) => _then(v as _DataReveived));

  @override
  _DataReveived get _value => super._value as _DataReveived;

  @override
  $Res call({
    Object? chatBot = freezed,
    Object? qars = freezed,
    Object? questions = freezed,
    Object? answerOptions = freezed,
    Object? answerItems = freezed,
  }) {
    return _then(_DataReveived(
      chatBot == freezed
          ? _value.chatBot
          : chatBot // ignore: cast_nullable_to_non_nullable
              as ChatBot,
      qars == freezed
          ? _value.qars
          : qars // ignore: cast_nullable_to_non_nullable
              as KtList<Qar>,
      questions == freezed
          ? _value.questions
          : questions // ignore: cast_nullable_to_non_nullable
              as KtList<Question>,
      answerOptions == freezed
          ? _value.answerOptions
          : answerOptions // ignore: cast_nullable_to_non_nullable
              as KtList<AnswerOption>,
      answerItems == freezed
          ? _value.answerItems
          : answerItems // ignore: cast_nullable_to_non_nullable
              as KtList<AnswerItem>,
    ));
  }
}

/// @nodoc

class _$_DataReveived implements _DataReveived {
  const _$_DataReveived(this.chatBot, this.qars, this.questions,
      this.answerOptions, this.answerItems);

  @override
  final ChatBot chatBot;
  @override
  final KtList<Qar> qars;
  @override
  final KtList<Question> questions;
  @override
  final KtList<AnswerOption> answerOptions;
  @override
  final KtList<AnswerItem> answerItems;

  @override
  String toString() {
    return 'ChatWatcherEvent.dataReceived(chatBot: $chatBot, qars: $qars, questions: $questions, answerOptions: $answerOptions, answerItems: $answerItems)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _DataReveived &&
            (identical(other.chatBot, chatBot) ||
                const DeepCollectionEquality()
                    .equals(other.chatBot, chatBot)) &&
            (identical(other.qars, qars) ||
                const DeepCollectionEquality().equals(other.qars, qars)) &&
            (identical(other.questions, questions) ||
                const DeepCollectionEquality()
                    .equals(other.questions, questions)) &&
            (identical(other.answerOptions, answerOptions) ||
                const DeepCollectionEquality()
                    .equals(other.answerOptions, answerOptions)) &&
            (identical(other.answerItems, answerItems) ||
                const DeepCollectionEquality()
                    .equals(other.answerItems, answerItems)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(chatBot) ^
      const DeepCollectionEquality().hash(qars) ^
      const DeepCollectionEquality().hash(questions) ^
      const DeepCollectionEquality().hash(answerOptions) ^
      const DeepCollectionEquality().hash(answerItems);

  @JsonKey(ignore: true)
  @override
  _$DataReveivedCopyWith<_DataReveived> get copyWith =>
      __$DataReveivedCopyWithImpl<_DataReveived>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UniqueId chatBotId) watchStarted,
    required TResult Function(CrudFailure failure) failureReceived,
    required TResult Function(
            ChatBot chatBot,
            KtList<Qar> qars,
            KtList<Question> questions,
            KtList<AnswerOption> answerOptions,
            KtList<AnswerItem> answerItems)
        dataReceived,
  }) {
    return dataReceived(chatBot, qars, questions, answerOptions, answerItems);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UniqueId chatBotId)? watchStarted,
    TResult Function(CrudFailure failure)? failureReceived,
    TResult Function(
            ChatBot chatBot,
            KtList<Qar> qars,
            KtList<Question> questions,
            KtList<AnswerOption> answerOptions,
            KtList<AnswerItem> answerItems)?
        dataReceived,
    required TResult orElse(),
  }) {
    if (dataReceived != null) {
      return dataReceived(chatBot, qars, questions, answerOptions, answerItems);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WatchStarted value) watchStarted,
    required TResult Function(_FailureReceived value) failureReceived,
    required TResult Function(_DataReveived value) dataReceived,
  }) {
    return dataReceived(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WatchStarted value)? watchStarted,
    TResult Function(_FailureReceived value)? failureReceived,
    TResult Function(_DataReveived value)? dataReceived,
    required TResult orElse(),
  }) {
    if (dataReceived != null) {
      return dataReceived(this);
    }
    return orElse();
  }
}

abstract class _DataReveived implements ChatWatcherEvent {
  const factory _DataReveived(
      ChatBot chatBot,
      KtList<Qar> qars,
      KtList<Question> questions,
      KtList<AnswerOption> answerOptions,
      KtList<AnswerItem> answerItems) = _$_DataReveived;

  ChatBot get chatBot => throw _privateConstructorUsedError;
  KtList<Qar> get qars => throw _privateConstructorUsedError;
  KtList<Question> get questions => throw _privateConstructorUsedError;
  KtList<AnswerOption> get answerOptions => throw _privateConstructorUsedError;
  KtList<AnswerItem> get answerItems => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$DataReveivedCopyWith<_DataReveived> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$ChatWatcherStateTearOff {
  const _$ChatWatcherStateTearOff();

  _ChatWatcherState call(
      {required bool isLoading,
      required CrudFailure? failure,
      required ChatBot chatBot,
      required KtList<Question> questions,
      required KtList<Qar> qars,
      required KtList<AnswerItem> answerItems,
      required KtList<AnswerOption> answerOptions}) {
    return _ChatWatcherState(
      isLoading: isLoading,
      failure: failure,
      chatBot: chatBot,
      questions: questions,
      qars: qars,
      answerItems: answerItems,
      answerOptions: answerOptions,
    );
  }
}

/// @nodoc
const $ChatWatcherState = _$ChatWatcherStateTearOff();

/// @nodoc
mixin _$ChatWatcherState {
  bool get isLoading => throw _privateConstructorUsedError;
  CrudFailure? get failure => throw _privateConstructorUsedError;
  ChatBot get chatBot => throw _privateConstructorUsedError;
  KtList<Question> get questions => throw _privateConstructorUsedError;
  KtList<Qar> get qars => throw _privateConstructorUsedError;
  KtList<AnswerItem> get answerItems => throw _privateConstructorUsedError;
  KtList<AnswerOption> get answerOptions => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChatWatcherStateCopyWith<ChatWatcherState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatWatcherStateCopyWith<$Res> {
  factory $ChatWatcherStateCopyWith(
          ChatWatcherState value, $Res Function(ChatWatcherState) then) =
      _$ChatWatcherStateCopyWithImpl<$Res>;
  $Res call(
      {bool isLoading,
      CrudFailure? failure,
      ChatBot chatBot,
      KtList<Question> questions,
      KtList<Qar> qars,
      KtList<AnswerItem> answerItems,
      KtList<AnswerOption> answerOptions});

  $CrudFailureCopyWith<$Res>? get failure;
}

/// @nodoc
class _$ChatWatcherStateCopyWithImpl<$Res>
    implements $ChatWatcherStateCopyWith<$Res> {
  _$ChatWatcherStateCopyWithImpl(this._value, this._then);

  final ChatWatcherState _value;
  // ignore: unused_field
  final $Res Function(ChatWatcherState) _then;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? failure = freezed,
    Object? chatBot = freezed,
    Object? questions = freezed,
    Object? qars = freezed,
    Object? answerItems = freezed,
    Object? answerOptions = freezed,
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
      chatBot: chatBot == freezed
          ? _value.chatBot
          : chatBot // ignore: cast_nullable_to_non_nullable
              as ChatBot,
      questions: questions == freezed
          ? _value.questions
          : questions // ignore: cast_nullable_to_non_nullable
              as KtList<Question>,
      qars: qars == freezed
          ? _value.qars
          : qars // ignore: cast_nullable_to_non_nullable
              as KtList<Qar>,
      answerItems: answerItems == freezed
          ? _value.answerItems
          : answerItems // ignore: cast_nullable_to_non_nullable
              as KtList<AnswerItem>,
      answerOptions: answerOptions == freezed
          ? _value.answerOptions
          : answerOptions // ignore: cast_nullable_to_non_nullable
              as KtList<AnswerOption>,
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
abstract class _$ChatWatcherStateCopyWith<$Res>
    implements $ChatWatcherStateCopyWith<$Res> {
  factory _$ChatWatcherStateCopyWith(
          _ChatWatcherState value, $Res Function(_ChatWatcherState) then) =
      __$ChatWatcherStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool isLoading,
      CrudFailure? failure,
      ChatBot chatBot,
      KtList<Question> questions,
      KtList<Qar> qars,
      KtList<AnswerItem> answerItems,
      KtList<AnswerOption> answerOptions});

  @override
  $CrudFailureCopyWith<$Res>? get failure;
}

/// @nodoc
class __$ChatWatcherStateCopyWithImpl<$Res>
    extends _$ChatWatcherStateCopyWithImpl<$Res>
    implements _$ChatWatcherStateCopyWith<$Res> {
  __$ChatWatcherStateCopyWithImpl(
      _ChatWatcherState _value, $Res Function(_ChatWatcherState) _then)
      : super(_value, (v) => _then(v as _ChatWatcherState));

  @override
  _ChatWatcherState get _value => super._value as _ChatWatcherState;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? failure = freezed,
    Object? chatBot = freezed,
    Object? questions = freezed,
    Object? qars = freezed,
    Object? answerItems = freezed,
    Object? answerOptions = freezed,
  }) {
    return _then(_ChatWatcherState(
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      failure: failure == freezed
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as CrudFailure?,
      chatBot: chatBot == freezed
          ? _value.chatBot
          : chatBot // ignore: cast_nullable_to_non_nullable
              as ChatBot,
      questions: questions == freezed
          ? _value.questions
          : questions // ignore: cast_nullable_to_non_nullable
              as KtList<Question>,
      qars: qars == freezed
          ? _value.qars
          : qars // ignore: cast_nullable_to_non_nullable
              as KtList<Qar>,
      answerItems: answerItems == freezed
          ? _value.answerItems
          : answerItems // ignore: cast_nullable_to_non_nullable
              as KtList<AnswerItem>,
      answerOptions: answerOptions == freezed
          ? _value.answerOptions
          : answerOptions // ignore: cast_nullable_to_non_nullable
              as KtList<AnswerOption>,
    ));
  }
}

/// @nodoc

class _$_ChatWatcherState implements _ChatWatcherState {
  const _$_ChatWatcherState(
      {required this.isLoading,
      required this.failure,
      required this.chatBot,
      required this.questions,
      required this.qars,
      required this.answerItems,
      required this.answerOptions});

  @override
  final bool isLoading;
  @override
  final CrudFailure? failure;
  @override
  final ChatBot chatBot;
  @override
  final KtList<Question> questions;
  @override
  final KtList<Qar> qars;
  @override
  final KtList<AnswerItem> answerItems;
  @override
  final KtList<AnswerOption> answerOptions;

  @override
  String toString() {
    return 'ChatWatcherState(isLoading: $isLoading, failure: $failure, chatBot: $chatBot, questions: $questions, qars: $qars, answerItems: $answerItems, answerOptions: $answerOptions)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ChatWatcherState &&
            (identical(other.isLoading, isLoading) ||
                const DeepCollectionEquality()
                    .equals(other.isLoading, isLoading)) &&
            (identical(other.failure, failure) ||
                const DeepCollectionEquality()
                    .equals(other.failure, failure)) &&
            (identical(other.chatBot, chatBot) ||
                const DeepCollectionEquality()
                    .equals(other.chatBot, chatBot)) &&
            (identical(other.questions, questions) ||
                const DeepCollectionEquality()
                    .equals(other.questions, questions)) &&
            (identical(other.qars, qars) ||
                const DeepCollectionEquality().equals(other.qars, qars)) &&
            (identical(other.answerItems, answerItems) ||
                const DeepCollectionEquality()
                    .equals(other.answerItems, answerItems)) &&
            (identical(other.answerOptions, answerOptions) ||
                const DeepCollectionEquality()
                    .equals(other.answerOptions, answerOptions)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(isLoading) ^
      const DeepCollectionEquality().hash(failure) ^
      const DeepCollectionEquality().hash(chatBot) ^
      const DeepCollectionEquality().hash(questions) ^
      const DeepCollectionEquality().hash(qars) ^
      const DeepCollectionEquality().hash(answerItems) ^
      const DeepCollectionEquality().hash(answerOptions);

  @JsonKey(ignore: true)
  @override
  _$ChatWatcherStateCopyWith<_ChatWatcherState> get copyWith =>
      __$ChatWatcherStateCopyWithImpl<_ChatWatcherState>(this, _$identity);
}

abstract class _ChatWatcherState implements ChatWatcherState {
  const factory _ChatWatcherState(
      {required bool isLoading,
      required CrudFailure? failure,
      required ChatBot chatBot,
      required KtList<Question> questions,
      required KtList<Qar> qars,
      required KtList<AnswerItem> answerItems,
      required KtList<AnswerOption> answerOptions}) = _$_ChatWatcherState;

  @override
  bool get isLoading => throw _privateConstructorUsedError;
  @override
  CrudFailure? get failure => throw _privateConstructorUsedError;
  @override
  ChatBot get chatBot => throw _privateConstructorUsedError;
  @override
  KtList<Question> get questions => throw _privateConstructorUsedError;
  @override
  KtList<Qar> get qars => throw _privateConstructorUsedError;
  @override
  KtList<AnswerItem> get answerItems => throw _privateConstructorUsedError;
  @override
  KtList<AnswerOption> get answerOptions => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ChatWatcherStateCopyWith<_ChatWatcherState> get copyWith =>
      throw _privateConstructorUsedError;
}
