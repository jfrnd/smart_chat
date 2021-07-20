// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'chat_actor_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ChatActorEventTearOff {
  const _$ChatActorEventTearOff();

  _AnswerItemsDeleted answerItemDeleted({required UniqueId answerItemId}) {
    return _AnswerItemsDeleted(
      answerItemId: answerItemId,
    );
  }

  _AnswerItemsAdded answerItemsCreated(
      {required KtList<AnswerItemValue> itemValues, required Qar qar}) {
    return _AnswerItemsAdded(
      itemValues: itemValues,
      qar: qar,
    );
  }

  _AnswerOptionCreatedStarted answerOptionCreatedStarted() {
    return const _AnswerOptionCreatedStarted();
  }

  _AnswerOptionCreatedFinished answerOptionCreatedFinished(
      {CrudFailure? failure}) {
    return _AnswerOptionCreatedFinished(
      failure: failure,
    );
  }
}

/// @nodoc
const $ChatActorEvent = _$ChatActorEventTearOff();

/// @nodoc
mixin _$ChatActorEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UniqueId answerItemId) answerItemDeleted,
    required TResult Function(KtList<AnswerItemValue> itemValues, Qar qar)
        answerItemsCreated,
    required TResult Function() answerOptionCreatedStarted,
    required TResult Function(CrudFailure? failure) answerOptionCreatedFinished,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UniqueId answerItemId)? answerItemDeleted,
    TResult Function(KtList<AnswerItemValue> itemValues, Qar qar)?
        answerItemsCreated,
    TResult Function()? answerOptionCreatedStarted,
    TResult Function(CrudFailure? failure)? answerOptionCreatedFinished,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AnswerItemsDeleted value) answerItemDeleted,
    required TResult Function(_AnswerItemsAdded value) answerItemsCreated,
    required TResult Function(_AnswerOptionCreatedStarted value)
        answerOptionCreatedStarted,
    required TResult Function(_AnswerOptionCreatedFinished value)
        answerOptionCreatedFinished,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AnswerItemsDeleted value)? answerItemDeleted,
    TResult Function(_AnswerItemsAdded value)? answerItemsCreated,
    TResult Function(_AnswerOptionCreatedStarted value)?
        answerOptionCreatedStarted,
    TResult Function(_AnswerOptionCreatedFinished value)?
        answerOptionCreatedFinished,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatActorEventCopyWith<$Res> {
  factory $ChatActorEventCopyWith(
          ChatActorEvent value, $Res Function(ChatActorEvent) then) =
      _$ChatActorEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$ChatActorEventCopyWithImpl<$Res>
    implements $ChatActorEventCopyWith<$Res> {
  _$ChatActorEventCopyWithImpl(this._value, this._then);

  final ChatActorEvent _value;
  // ignore: unused_field
  final $Res Function(ChatActorEvent) _then;
}

/// @nodoc
abstract class _$AnswerItemsDeletedCopyWith<$Res> {
  factory _$AnswerItemsDeletedCopyWith(
          _AnswerItemsDeleted value, $Res Function(_AnswerItemsDeleted) then) =
      __$AnswerItemsDeletedCopyWithImpl<$Res>;
  $Res call({UniqueId answerItemId});
}

/// @nodoc
class __$AnswerItemsDeletedCopyWithImpl<$Res>
    extends _$ChatActorEventCopyWithImpl<$Res>
    implements _$AnswerItemsDeletedCopyWith<$Res> {
  __$AnswerItemsDeletedCopyWithImpl(
      _AnswerItemsDeleted _value, $Res Function(_AnswerItemsDeleted) _then)
      : super(_value, (v) => _then(v as _AnswerItemsDeleted));

  @override
  _AnswerItemsDeleted get _value => super._value as _AnswerItemsDeleted;

  @override
  $Res call({
    Object? answerItemId = freezed,
  }) {
    return _then(_AnswerItemsDeleted(
      answerItemId: answerItemId == freezed
          ? _value.answerItemId
          : answerItemId // ignore: cast_nullable_to_non_nullable
              as UniqueId,
    ));
  }
}

/// @nodoc

class _$_AnswerItemsDeleted implements _AnswerItemsDeleted {
  const _$_AnswerItemsDeleted({required this.answerItemId});

  @override
  final UniqueId answerItemId;

  @override
  String toString() {
    return 'ChatActorEvent.answerItemDeleted(answerItemId: $answerItemId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AnswerItemsDeleted &&
            (identical(other.answerItemId, answerItemId) ||
                const DeepCollectionEquality()
                    .equals(other.answerItemId, answerItemId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(answerItemId);

  @JsonKey(ignore: true)
  @override
  _$AnswerItemsDeletedCopyWith<_AnswerItemsDeleted> get copyWith =>
      __$AnswerItemsDeletedCopyWithImpl<_AnswerItemsDeleted>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UniqueId answerItemId) answerItemDeleted,
    required TResult Function(KtList<AnswerItemValue> itemValues, Qar qar)
        answerItemsCreated,
    required TResult Function() answerOptionCreatedStarted,
    required TResult Function(CrudFailure? failure) answerOptionCreatedFinished,
  }) {
    return answerItemDeleted(answerItemId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UniqueId answerItemId)? answerItemDeleted,
    TResult Function(KtList<AnswerItemValue> itemValues, Qar qar)?
        answerItemsCreated,
    TResult Function()? answerOptionCreatedStarted,
    TResult Function(CrudFailure? failure)? answerOptionCreatedFinished,
    required TResult orElse(),
  }) {
    if (answerItemDeleted != null) {
      return answerItemDeleted(answerItemId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AnswerItemsDeleted value) answerItemDeleted,
    required TResult Function(_AnswerItemsAdded value) answerItemsCreated,
    required TResult Function(_AnswerOptionCreatedStarted value)
        answerOptionCreatedStarted,
    required TResult Function(_AnswerOptionCreatedFinished value)
        answerOptionCreatedFinished,
  }) {
    return answerItemDeleted(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AnswerItemsDeleted value)? answerItemDeleted,
    TResult Function(_AnswerItemsAdded value)? answerItemsCreated,
    TResult Function(_AnswerOptionCreatedStarted value)?
        answerOptionCreatedStarted,
    TResult Function(_AnswerOptionCreatedFinished value)?
        answerOptionCreatedFinished,
    required TResult orElse(),
  }) {
    if (answerItemDeleted != null) {
      return answerItemDeleted(this);
    }
    return orElse();
  }
}

abstract class _AnswerItemsDeleted implements ChatActorEvent {
  const factory _AnswerItemsDeleted({required UniqueId answerItemId}) =
      _$_AnswerItemsDeleted;

  UniqueId get answerItemId => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$AnswerItemsDeletedCopyWith<_AnswerItemsDeleted> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$AnswerItemsAddedCopyWith<$Res> {
  factory _$AnswerItemsAddedCopyWith(
          _AnswerItemsAdded value, $Res Function(_AnswerItemsAdded) then) =
      __$AnswerItemsAddedCopyWithImpl<$Res>;
  $Res call({KtList<AnswerItemValue> itemValues, Qar qar});
}

/// @nodoc
class __$AnswerItemsAddedCopyWithImpl<$Res>
    extends _$ChatActorEventCopyWithImpl<$Res>
    implements _$AnswerItemsAddedCopyWith<$Res> {
  __$AnswerItemsAddedCopyWithImpl(
      _AnswerItemsAdded _value, $Res Function(_AnswerItemsAdded) _then)
      : super(_value, (v) => _then(v as _AnswerItemsAdded));

  @override
  _AnswerItemsAdded get _value => super._value as _AnswerItemsAdded;

  @override
  $Res call({
    Object? itemValues = freezed,
    Object? qar = freezed,
  }) {
    return _then(_AnswerItemsAdded(
      itemValues: itemValues == freezed
          ? _value.itemValues
          : itemValues // ignore: cast_nullable_to_non_nullable
              as KtList<AnswerItemValue>,
      qar: qar == freezed
          ? _value.qar
          : qar // ignore: cast_nullable_to_non_nullable
              as Qar,
    ));
  }
}

/// @nodoc

class _$_AnswerItemsAdded implements _AnswerItemsAdded {
  const _$_AnswerItemsAdded({required this.itemValues, required this.qar});

  @override
  final KtList<AnswerItemValue> itemValues;
  @override
  final Qar qar;

  @override
  String toString() {
    return 'ChatActorEvent.answerItemsCreated(itemValues: $itemValues, qar: $qar)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AnswerItemsAdded &&
            (identical(other.itemValues, itemValues) ||
                const DeepCollectionEquality()
                    .equals(other.itemValues, itemValues)) &&
            (identical(other.qar, qar) ||
                const DeepCollectionEquality().equals(other.qar, qar)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(itemValues) ^
      const DeepCollectionEquality().hash(qar);

  @JsonKey(ignore: true)
  @override
  _$AnswerItemsAddedCopyWith<_AnswerItemsAdded> get copyWith =>
      __$AnswerItemsAddedCopyWithImpl<_AnswerItemsAdded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UniqueId answerItemId) answerItemDeleted,
    required TResult Function(KtList<AnswerItemValue> itemValues, Qar qar)
        answerItemsCreated,
    required TResult Function() answerOptionCreatedStarted,
    required TResult Function(CrudFailure? failure) answerOptionCreatedFinished,
  }) {
    return answerItemsCreated(itemValues, qar);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UniqueId answerItemId)? answerItemDeleted,
    TResult Function(KtList<AnswerItemValue> itemValues, Qar qar)?
        answerItemsCreated,
    TResult Function()? answerOptionCreatedStarted,
    TResult Function(CrudFailure? failure)? answerOptionCreatedFinished,
    required TResult orElse(),
  }) {
    if (answerItemsCreated != null) {
      return answerItemsCreated(itemValues, qar);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AnswerItemsDeleted value) answerItemDeleted,
    required TResult Function(_AnswerItemsAdded value) answerItemsCreated,
    required TResult Function(_AnswerOptionCreatedStarted value)
        answerOptionCreatedStarted,
    required TResult Function(_AnswerOptionCreatedFinished value)
        answerOptionCreatedFinished,
  }) {
    return answerItemsCreated(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AnswerItemsDeleted value)? answerItemDeleted,
    TResult Function(_AnswerItemsAdded value)? answerItemsCreated,
    TResult Function(_AnswerOptionCreatedStarted value)?
        answerOptionCreatedStarted,
    TResult Function(_AnswerOptionCreatedFinished value)?
        answerOptionCreatedFinished,
    required TResult orElse(),
  }) {
    if (answerItemsCreated != null) {
      return answerItemsCreated(this);
    }
    return orElse();
  }
}

abstract class _AnswerItemsAdded implements ChatActorEvent {
  const factory _AnswerItemsAdded(
      {required KtList<AnswerItemValue> itemValues,
      required Qar qar}) = _$_AnswerItemsAdded;

  KtList<AnswerItemValue> get itemValues => throw _privateConstructorUsedError;
  Qar get qar => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$AnswerItemsAddedCopyWith<_AnswerItemsAdded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$AnswerOptionCreatedStartedCopyWith<$Res> {
  factory _$AnswerOptionCreatedStartedCopyWith(
          _AnswerOptionCreatedStarted value,
          $Res Function(_AnswerOptionCreatedStarted) then) =
      __$AnswerOptionCreatedStartedCopyWithImpl<$Res>;
}

/// @nodoc
class __$AnswerOptionCreatedStartedCopyWithImpl<$Res>
    extends _$ChatActorEventCopyWithImpl<$Res>
    implements _$AnswerOptionCreatedStartedCopyWith<$Res> {
  __$AnswerOptionCreatedStartedCopyWithImpl(_AnswerOptionCreatedStarted _value,
      $Res Function(_AnswerOptionCreatedStarted) _then)
      : super(_value, (v) => _then(v as _AnswerOptionCreatedStarted));

  @override
  _AnswerOptionCreatedStarted get _value =>
      super._value as _AnswerOptionCreatedStarted;
}

/// @nodoc

class _$_AnswerOptionCreatedStarted implements _AnswerOptionCreatedStarted {
  const _$_AnswerOptionCreatedStarted();

  @override
  String toString() {
    return 'ChatActorEvent.answerOptionCreatedStarted()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _AnswerOptionCreatedStarted);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UniqueId answerItemId) answerItemDeleted,
    required TResult Function(KtList<AnswerItemValue> itemValues, Qar qar)
        answerItemsCreated,
    required TResult Function() answerOptionCreatedStarted,
    required TResult Function(CrudFailure? failure) answerOptionCreatedFinished,
  }) {
    return answerOptionCreatedStarted();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UniqueId answerItemId)? answerItemDeleted,
    TResult Function(KtList<AnswerItemValue> itemValues, Qar qar)?
        answerItemsCreated,
    TResult Function()? answerOptionCreatedStarted,
    TResult Function(CrudFailure? failure)? answerOptionCreatedFinished,
    required TResult orElse(),
  }) {
    if (answerOptionCreatedStarted != null) {
      return answerOptionCreatedStarted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AnswerItemsDeleted value) answerItemDeleted,
    required TResult Function(_AnswerItemsAdded value) answerItemsCreated,
    required TResult Function(_AnswerOptionCreatedStarted value)
        answerOptionCreatedStarted,
    required TResult Function(_AnswerOptionCreatedFinished value)
        answerOptionCreatedFinished,
  }) {
    return answerOptionCreatedStarted(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AnswerItemsDeleted value)? answerItemDeleted,
    TResult Function(_AnswerItemsAdded value)? answerItemsCreated,
    TResult Function(_AnswerOptionCreatedStarted value)?
        answerOptionCreatedStarted,
    TResult Function(_AnswerOptionCreatedFinished value)?
        answerOptionCreatedFinished,
    required TResult orElse(),
  }) {
    if (answerOptionCreatedStarted != null) {
      return answerOptionCreatedStarted(this);
    }
    return orElse();
  }
}

abstract class _AnswerOptionCreatedStarted implements ChatActorEvent {
  const factory _AnswerOptionCreatedStarted() = _$_AnswerOptionCreatedStarted;
}

/// @nodoc
abstract class _$AnswerOptionCreatedFinishedCopyWith<$Res> {
  factory _$AnswerOptionCreatedFinishedCopyWith(
          _AnswerOptionCreatedFinished value,
          $Res Function(_AnswerOptionCreatedFinished) then) =
      __$AnswerOptionCreatedFinishedCopyWithImpl<$Res>;
  $Res call({CrudFailure? failure});

  $CrudFailureCopyWith<$Res>? get failure;
}

/// @nodoc
class __$AnswerOptionCreatedFinishedCopyWithImpl<$Res>
    extends _$ChatActorEventCopyWithImpl<$Res>
    implements _$AnswerOptionCreatedFinishedCopyWith<$Res> {
  __$AnswerOptionCreatedFinishedCopyWithImpl(
      _AnswerOptionCreatedFinished _value,
      $Res Function(_AnswerOptionCreatedFinished) _then)
      : super(_value, (v) => _then(v as _AnswerOptionCreatedFinished));

  @override
  _AnswerOptionCreatedFinished get _value =>
      super._value as _AnswerOptionCreatedFinished;

  @override
  $Res call({
    Object? failure = freezed,
  }) {
    return _then(_AnswerOptionCreatedFinished(
      failure: failure == freezed
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as CrudFailure?,
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

class _$_AnswerOptionCreatedFinished implements _AnswerOptionCreatedFinished {
  const _$_AnswerOptionCreatedFinished({this.failure});

  @override
  final CrudFailure? failure;

  @override
  String toString() {
    return 'ChatActorEvent.answerOptionCreatedFinished(failure: $failure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AnswerOptionCreatedFinished &&
            (identical(other.failure, failure) ||
                const DeepCollectionEquality().equals(other.failure, failure)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(failure);

  @JsonKey(ignore: true)
  @override
  _$AnswerOptionCreatedFinishedCopyWith<_AnswerOptionCreatedFinished>
      get copyWith => __$AnswerOptionCreatedFinishedCopyWithImpl<
          _AnswerOptionCreatedFinished>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UniqueId answerItemId) answerItemDeleted,
    required TResult Function(KtList<AnswerItemValue> itemValues, Qar qar)
        answerItemsCreated,
    required TResult Function() answerOptionCreatedStarted,
    required TResult Function(CrudFailure? failure) answerOptionCreatedFinished,
  }) {
    return answerOptionCreatedFinished(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UniqueId answerItemId)? answerItemDeleted,
    TResult Function(KtList<AnswerItemValue> itemValues, Qar qar)?
        answerItemsCreated,
    TResult Function()? answerOptionCreatedStarted,
    TResult Function(CrudFailure? failure)? answerOptionCreatedFinished,
    required TResult orElse(),
  }) {
    if (answerOptionCreatedFinished != null) {
      return answerOptionCreatedFinished(failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AnswerItemsDeleted value) answerItemDeleted,
    required TResult Function(_AnswerItemsAdded value) answerItemsCreated,
    required TResult Function(_AnswerOptionCreatedStarted value)
        answerOptionCreatedStarted,
    required TResult Function(_AnswerOptionCreatedFinished value)
        answerOptionCreatedFinished,
  }) {
    return answerOptionCreatedFinished(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AnswerItemsDeleted value)? answerItemDeleted,
    TResult Function(_AnswerItemsAdded value)? answerItemsCreated,
    TResult Function(_AnswerOptionCreatedStarted value)?
        answerOptionCreatedStarted,
    TResult Function(_AnswerOptionCreatedFinished value)?
        answerOptionCreatedFinished,
    required TResult orElse(),
  }) {
    if (answerOptionCreatedFinished != null) {
      return answerOptionCreatedFinished(this);
    }
    return orElse();
  }
}

abstract class _AnswerOptionCreatedFinished implements ChatActorEvent {
  const factory _AnswerOptionCreatedFinished({CrudFailure? failure}) =
      _$_AnswerOptionCreatedFinished;

  CrudFailure? get failure => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$AnswerOptionCreatedFinishedCopyWith<_AnswerOptionCreatedFinished>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
class _$ChatActorStateTearOff {
  const _$ChatActorStateTearOff();

  _ChatActorState call(
      {required bool isSaving, required CrudFailure? failure}) {
    return _ChatActorState(
      isSaving: isSaving,
      failure: failure,
    );
  }
}

/// @nodoc
const $ChatActorState = _$ChatActorStateTearOff();

/// @nodoc
mixin _$ChatActorState {
  bool get isSaving => throw _privateConstructorUsedError;
  CrudFailure? get failure => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChatActorStateCopyWith<ChatActorState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatActorStateCopyWith<$Res> {
  factory $ChatActorStateCopyWith(
          ChatActorState value, $Res Function(ChatActorState) then) =
      _$ChatActorStateCopyWithImpl<$Res>;
  $Res call({bool isSaving, CrudFailure? failure});

  $CrudFailureCopyWith<$Res>? get failure;
}

/// @nodoc
class _$ChatActorStateCopyWithImpl<$Res>
    implements $ChatActorStateCopyWith<$Res> {
  _$ChatActorStateCopyWithImpl(this._value, this._then);

  final ChatActorState _value;
  // ignore: unused_field
  final $Res Function(ChatActorState) _then;

  @override
  $Res call({
    Object? isSaving = freezed,
    Object? failure = freezed,
  }) {
    return _then(_value.copyWith(
      isSaving: isSaving == freezed
          ? _value.isSaving
          : isSaving // ignore: cast_nullable_to_non_nullable
              as bool,
      failure: failure == freezed
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as CrudFailure?,
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
abstract class _$ChatActorStateCopyWith<$Res>
    implements $ChatActorStateCopyWith<$Res> {
  factory _$ChatActorStateCopyWith(
          _ChatActorState value, $Res Function(_ChatActorState) then) =
      __$ChatActorStateCopyWithImpl<$Res>;
  @override
  $Res call({bool isSaving, CrudFailure? failure});

  @override
  $CrudFailureCopyWith<$Res>? get failure;
}

/// @nodoc
class __$ChatActorStateCopyWithImpl<$Res>
    extends _$ChatActorStateCopyWithImpl<$Res>
    implements _$ChatActorStateCopyWith<$Res> {
  __$ChatActorStateCopyWithImpl(
      _ChatActorState _value, $Res Function(_ChatActorState) _then)
      : super(_value, (v) => _then(v as _ChatActorState));

  @override
  _ChatActorState get _value => super._value as _ChatActorState;

  @override
  $Res call({
    Object? isSaving = freezed,
    Object? failure = freezed,
  }) {
    return _then(_ChatActorState(
      isSaving: isSaving == freezed
          ? _value.isSaving
          : isSaving // ignore: cast_nullable_to_non_nullable
              as bool,
      failure: failure == freezed
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as CrudFailure?,
    ));
  }
}

/// @nodoc

class _$_ChatActorState implements _ChatActorState {
  const _$_ChatActorState({required this.isSaving, required this.failure});

  @override
  final bool isSaving;
  @override
  final CrudFailure? failure;

  @override
  String toString() {
    return 'ChatActorState(isSaving: $isSaving, failure: $failure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ChatActorState &&
            (identical(other.isSaving, isSaving) ||
                const DeepCollectionEquality()
                    .equals(other.isSaving, isSaving)) &&
            (identical(other.failure, failure) ||
                const DeepCollectionEquality().equals(other.failure, failure)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(isSaving) ^
      const DeepCollectionEquality().hash(failure);

  @JsonKey(ignore: true)
  @override
  _$ChatActorStateCopyWith<_ChatActorState> get copyWith =>
      __$ChatActorStateCopyWithImpl<_ChatActorState>(this, _$identity);
}

abstract class _ChatActorState implements ChatActorState {
  const factory _ChatActorState(
      {required bool isSaving,
      required CrudFailure? failure}) = _$_ChatActorState;

  @override
  bool get isSaving => throw _privateConstructorUsedError;
  @override
  CrudFailure? get failure => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ChatActorStateCopyWith<_ChatActorState> get copyWith =>
      throw _privateConstructorUsedError;
}
