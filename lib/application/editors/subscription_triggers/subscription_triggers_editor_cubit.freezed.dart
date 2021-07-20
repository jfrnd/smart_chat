// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'subscription_triggers_editor_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$SubscriptionTriggersEditorStateTearOff {
  const _$SubscriptionTriggersEditorStateTearOff();

  _SubscriptionTriggersEditorState call(
      {required KtList<SubscriptionTrigger> triggers,
      required SubscriptionTime tempTime}) {
    return _SubscriptionTriggersEditorState(
      triggers: triggers,
      tempTime: tempTime,
    );
  }
}

/// @nodoc
const $SubscriptionTriggersEditorState =
    _$SubscriptionTriggersEditorStateTearOff();

/// @nodoc
mixin _$SubscriptionTriggersEditorState {
  KtList<SubscriptionTrigger> get triggers =>
      throw _privateConstructorUsedError;
  SubscriptionTime get tempTime => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SubscriptionTriggersEditorStateCopyWith<SubscriptionTriggersEditorState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscriptionTriggersEditorStateCopyWith<$Res> {
  factory $SubscriptionTriggersEditorStateCopyWith(
          SubscriptionTriggersEditorState value,
          $Res Function(SubscriptionTriggersEditorState) then) =
      _$SubscriptionTriggersEditorStateCopyWithImpl<$Res>;
  $Res call({KtList<SubscriptionTrigger> triggers, SubscriptionTime tempTime});
}

/// @nodoc
class _$SubscriptionTriggersEditorStateCopyWithImpl<$Res>
    implements $SubscriptionTriggersEditorStateCopyWith<$Res> {
  _$SubscriptionTriggersEditorStateCopyWithImpl(this._value, this._then);

  final SubscriptionTriggersEditorState _value;
  // ignore: unused_field
  final $Res Function(SubscriptionTriggersEditorState) _then;

  @override
  $Res call({
    Object? triggers = freezed,
    Object? tempTime = freezed,
  }) {
    return _then(_value.copyWith(
      triggers: triggers == freezed
          ? _value.triggers
          : triggers // ignore: cast_nullable_to_non_nullable
              as KtList<SubscriptionTrigger>,
      tempTime: tempTime == freezed
          ? _value.tempTime
          : tempTime // ignore: cast_nullable_to_non_nullable
              as SubscriptionTime,
    ));
  }
}

/// @nodoc
abstract class _$SubscriptionTriggersEditorStateCopyWith<$Res>
    implements $SubscriptionTriggersEditorStateCopyWith<$Res> {
  factory _$SubscriptionTriggersEditorStateCopyWith(
          _SubscriptionTriggersEditorState value,
          $Res Function(_SubscriptionTriggersEditorState) then) =
      __$SubscriptionTriggersEditorStateCopyWithImpl<$Res>;
  @override
  $Res call({KtList<SubscriptionTrigger> triggers, SubscriptionTime tempTime});
}

/// @nodoc
class __$SubscriptionTriggersEditorStateCopyWithImpl<$Res>
    extends _$SubscriptionTriggersEditorStateCopyWithImpl<$Res>
    implements _$SubscriptionTriggersEditorStateCopyWith<$Res> {
  __$SubscriptionTriggersEditorStateCopyWithImpl(
      _SubscriptionTriggersEditorState _value,
      $Res Function(_SubscriptionTriggersEditorState) _then)
      : super(_value, (v) => _then(v as _SubscriptionTriggersEditorState));

  @override
  _SubscriptionTriggersEditorState get _value =>
      super._value as _SubscriptionTriggersEditorState;

  @override
  $Res call({
    Object? triggers = freezed,
    Object? tempTime = freezed,
  }) {
    return _then(_SubscriptionTriggersEditorState(
      triggers: triggers == freezed
          ? _value.triggers
          : triggers // ignore: cast_nullable_to_non_nullable
              as KtList<SubscriptionTrigger>,
      tempTime: tempTime == freezed
          ? _value.tempTime
          : tempTime // ignore: cast_nullable_to_non_nullable
              as SubscriptionTime,
    ));
  }
}

/// @nodoc

class _$_SubscriptionTriggersEditorState
    implements _SubscriptionTriggersEditorState {
  const _$_SubscriptionTriggersEditorState(
      {required this.triggers, required this.tempTime});

  @override
  final KtList<SubscriptionTrigger> triggers;
  @override
  final SubscriptionTime tempTime;

  @override
  String toString() {
    return 'SubscriptionTriggersEditorState(triggers: $triggers, tempTime: $tempTime)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SubscriptionTriggersEditorState &&
            (identical(other.triggers, triggers) ||
                const DeepCollectionEquality()
                    .equals(other.triggers, triggers)) &&
            (identical(other.tempTime, tempTime) ||
                const DeepCollectionEquality()
                    .equals(other.tempTime, tempTime)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(triggers) ^
      const DeepCollectionEquality().hash(tempTime);

  @JsonKey(ignore: true)
  @override
  _$SubscriptionTriggersEditorStateCopyWith<_SubscriptionTriggersEditorState>
      get copyWith => __$SubscriptionTriggersEditorStateCopyWithImpl<
          _SubscriptionTriggersEditorState>(this, _$identity);
}

abstract class _SubscriptionTriggersEditorState
    implements SubscriptionTriggersEditorState {
  const factory _SubscriptionTriggersEditorState(
      {required KtList<SubscriptionTrigger> triggers,
      required SubscriptionTime tempTime}) = _$_SubscriptionTriggersEditorState;

  @override
  KtList<SubscriptionTrigger> get triggers =>
      throw _privateConstructorUsedError;
  @override
  SubscriptionTime get tempTime => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$SubscriptionTriggersEditorStateCopyWith<_SubscriptionTriggersEditorState>
      get copyWith => throw _privateConstructorUsedError;
}
