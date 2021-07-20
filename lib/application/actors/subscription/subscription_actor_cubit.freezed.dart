// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'subscription_actor_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$SubscriptionActorStateTearOff {
  const _$SubscriptionActorStateTearOff();

  _SubscriptionActorState call(
      {required Either<CrudFailure, Unit>? failureOrSuccess,
      required bool isLoading}) {
    return _SubscriptionActorState(
      failureOrSuccess: failureOrSuccess,
      isLoading: isLoading,
    );
  }
}

/// @nodoc
const $SubscriptionActorState = _$SubscriptionActorStateTearOff();

/// @nodoc
mixin _$SubscriptionActorState {
  Either<CrudFailure, Unit>? get failureOrSuccess =>
      throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SubscriptionActorStateCopyWith<SubscriptionActorState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscriptionActorStateCopyWith<$Res> {
  factory $SubscriptionActorStateCopyWith(SubscriptionActorState value,
          $Res Function(SubscriptionActorState) then) =
      _$SubscriptionActorStateCopyWithImpl<$Res>;
  $Res call({Either<CrudFailure, Unit>? failureOrSuccess, bool isLoading});
}

/// @nodoc
class _$SubscriptionActorStateCopyWithImpl<$Res>
    implements $SubscriptionActorStateCopyWith<$Res> {
  _$SubscriptionActorStateCopyWithImpl(this._value, this._then);

  final SubscriptionActorState _value;
  // ignore: unused_field
  final $Res Function(SubscriptionActorState) _then;

  @override
  $Res call({
    Object? failureOrSuccess = freezed,
    Object? isLoading = freezed,
  }) {
    return _then(_value.copyWith(
      failureOrSuccess: failureOrSuccess == freezed
          ? _value.failureOrSuccess
          : failureOrSuccess // ignore: cast_nullable_to_non_nullable
              as Either<CrudFailure, Unit>?,
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$SubscriptionActorStateCopyWith<$Res>
    implements $SubscriptionActorStateCopyWith<$Res> {
  factory _$SubscriptionActorStateCopyWith(_SubscriptionActorState value,
          $Res Function(_SubscriptionActorState) then) =
      __$SubscriptionActorStateCopyWithImpl<$Res>;
  @override
  $Res call({Either<CrudFailure, Unit>? failureOrSuccess, bool isLoading});
}

/// @nodoc
class __$SubscriptionActorStateCopyWithImpl<$Res>
    extends _$SubscriptionActorStateCopyWithImpl<$Res>
    implements _$SubscriptionActorStateCopyWith<$Res> {
  __$SubscriptionActorStateCopyWithImpl(_SubscriptionActorState _value,
      $Res Function(_SubscriptionActorState) _then)
      : super(_value, (v) => _then(v as _SubscriptionActorState));

  @override
  _SubscriptionActorState get _value => super._value as _SubscriptionActorState;

  @override
  $Res call({
    Object? failureOrSuccess = freezed,
    Object? isLoading = freezed,
  }) {
    return _then(_SubscriptionActorState(
      failureOrSuccess: failureOrSuccess == freezed
          ? _value.failureOrSuccess
          : failureOrSuccess // ignore: cast_nullable_to_non_nullable
              as Either<CrudFailure, Unit>?,
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_SubscriptionActorState implements _SubscriptionActorState {
  const _$_SubscriptionActorState(
      {required this.failureOrSuccess, required this.isLoading});

  @override
  final Either<CrudFailure, Unit>? failureOrSuccess;
  @override
  final bool isLoading;

  @override
  String toString() {
    return 'SubscriptionActorState(failureOrSuccess: $failureOrSuccess, isLoading: $isLoading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SubscriptionActorState &&
            (identical(other.failureOrSuccess, failureOrSuccess) ||
                const DeepCollectionEquality()
                    .equals(other.failureOrSuccess, failureOrSuccess)) &&
            (identical(other.isLoading, isLoading) ||
                const DeepCollectionEquality()
                    .equals(other.isLoading, isLoading)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(failureOrSuccess) ^
      const DeepCollectionEquality().hash(isLoading);

  @JsonKey(ignore: true)
  @override
  _$SubscriptionActorStateCopyWith<_SubscriptionActorState> get copyWith =>
      __$SubscriptionActorStateCopyWithImpl<_SubscriptionActorState>(
          this, _$identity);
}

abstract class _SubscriptionActorState implements SubscriptionActorState {
  const factory _SubscriptionActorState(
      {required Either<CrudFailure, Unit>? failureOrSuccess,
      required bool isLoading}) = _$_SubscriptionActorState;

  @override
  Either<CrudFailure, Unit>? get failureOrSuccess =>
      throw _privateConstructorUsedError;
  @override
  bool get isLoading => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$SubscriptionActorStateCopyWith<_SubscriptionActorState> get copyWith =>
      throw _privateConstructorUsedError;
}
