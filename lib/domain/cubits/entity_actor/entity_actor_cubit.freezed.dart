// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'entity_actor_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$EntityActorStateTearOff {
  const _$EntityActorStateTearOff();

  _EntityActorState<T> call<T extends Entity<dynamic>>(
      {required KtList<T> selectedEntities,
      required bool isLoading,
      required bool isEditing,
      required bool isSorting,
      required Either<CrudFailure, Unit>? failureOrSuccess}) {
    return _EntityActorState<T>(
      selectedEntities: selectedEntities,
      isLoading: isLoading,
      isEditing: isEditing,
      isSorting: isSorting,
      failureOrSuccess: failureOrSuccess,
    );
  }
}

/// @nodoc
const $EntityActorState = _$EntityActorStateTearOff();

/// @nodoc
mixin _$EntityActorState<T extends Entity<dynamic>> {
  KtList<T> get selectedEntities => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isEditing => throw _privateConstructorUsedError;
  bool get isSorting => throw _privateConstructorUsedError;
  Either<CrudFailure, Unit>? get failureOrSuccess =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EntityActorStateCopyWith<T, EntityActorState<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EntityActorStateCopyWith<T extends Entity<dynamic>, $Res> {
  factory $EntityActorStateCopyWith(
          EntityActorState<T> value, $Res Function(EntityActorState<T>) then) =
      _$EntityActorStateCopyWithImpl<T, $Res>;
  $Res call(
      {KtList<T> selectedEntities,
      bool isLoading,
      bool isEditing,
      bool isSorting,
      Either<CrudFailure, Unit>? failureOrSuccess});
}

/// @nodoc
class _$EntityActorStateCopyWithImpl<T extends Entity<dynamic>, $Res>
    implements $EntityActorStateCopyWith<T, $Res> {
  _$EntityActorStateCopyWithImpl(this._value, this._then);

  final EntityActorState<T> _value;
  // ignore: unused_field
  final $Res Function(EntityActorState<T>) _then;

  @override
  $Res call({
    Object? selectedEntities = freezed,
    Object? isLoading = freezed,
    Object? isEditing = freezed,
    Object? isSorting = freezed,
    Object? failureOrSuccess = freezed,
  }) {
    return _then(_value.copyWith(
      selectedEntities: selectedEntities == freezed
          ? _value.selectedEntities
          : selectedEntities // ignore: cast_nullable_to_non_nullable
              as KtList<T>,
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isEditing: isEditing == freezed
          ? _value.isEditing
          : isEditing // ignore: cast_nullable_to_non_nullable
              as bool,
      isSorting: isSorting == freezed
          ? _value.isSorting
          : isSorting // ignore: cast_nullable_to_non_nullable
              as bool,
      failureOrSuccess: failureOrSuccess == freezed
          ? _value.failureOrSuccess
          : failureOrSuccess // ignore: cast_nullable_to_non_nullable
              as Either<CrudFailure, Unit>?,
    ));
  }
}

/// @nodoc
abstract class _$EntityActorStateCopyWith<T extends Entity<dynamic>, $Res>
    implements $EntityActorStateCopyWith<T, $Res> {
  factory _$EntityActorStateCopyWith(_EntityActorState<T> value,
          $Res Function(_EntityActorState<T>) then) =
      __$EntityActorStateCopyWithImpl<T, $Res>;
  @override
  $Res call(
      {KtList<T> selectedEntities,
      bool isLoading,
      bool isEditing,
      bool isSorting,
      Either<CrudFailure, Unit>? failureOrSuccess});
}

/// @nodoc
class __$EntityActorStateCopyWithImpl<T extends Entity<dynamic>, $Res>
    extends _$EntityActorStateCopyWithImpl<T, $Res>
    implements _$EntityActorStateCopyWith<T, $Res> {
  __$EntityActorStateCopyWithImpl(
      _EntityActorState<T> _value, $Res Function(_EntityActorState<T>) _then)
      : super(_value, (v) => _then(v as _EntityActorState<T>));

  @override
  _EntityActorState<T> get _value => super._value as _EntityActorState<T>;

  @override
  $Res call({
    Object? selectedEntities = freezed,
    Object? isLoading = freezed,
    Object? isEditing = freezed,
    Object? isSorting = freezed,
    Object? failureOrSuccess = freezed,
  }) {
    return _then(_EntityActorState<T>(
      selectedEntities: selectedEntities == freezed
          ? _value.selectedEntities
          : selectedEntities // ignore: cast_nullable_to_non_nullable
              as KtList<T>,
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isEditing: isEditing == freezed
          ? _value.isEditing
          : isEditing // ignore: cast_nullable_to_non_nullable
              as bool,
      isSorting: isSorting == freezed
          ? _value.isSorting
          : isSorting // ignore: cast_nullable_to_non_nullable
              as bool,
      failureOrSuccess: failureOrSuccess == freezed
          ? _value.failureOrSuccess
          : failureOrSuccess // ignore: cast_nullable_to_non_nullable
              as Either<CrudFailure, Unit>?,
    ));
  }
}

/// @nodoc

class _$_EntityActorState<T extends Entity<dynamic>>
    implements _EntityActorState<T> {
  const _$_EntityActorState(
      {required this.selectedEntities,
      required this.isLoading,
      required this.isEditing,
      required this.isSorting,
      required this.failureOrSuccess});

  @override
  final KtList<T> selectedEntities;
  @override
  final bool isLoading;
  @override
  final bool isEditing;
  @override
  final bool isSorting;
  @override
  final Either<CrudFailure, Unit>? failureOrSuccess;

  @override
  String toString() {
    return 'EntityActorState<$T>(selectedEntities: $selectedEntities, isLoading: $isLoading, isEditing: $isEditing, isSorting: $isSorting, failureOrSuccess: $failureOrSuccess)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _EntityActorState<T> &&
            (identical(other.selectedEntities, selectedEntities) ||
                const DeepCollectionEquality()
                    .equals(other.selectedEntities, selectedEntities)) &&
            (identical(other.isLoading, isLoading) ||
                const DeepCollectionEquality()
                    .equals(other.isLoading, isLoading)) &&
            (identical(other.isEditing, isEditing) ||
                const DeepCollectionEquality()
                    .equals(other.isEditing, isEditing)) &&
            (identical(other.isSorting, isSorting) ||
                const DeepCollectionEquality()
                    .equals(other.isSorting, isSorting)) &&
            (identical(other.failureOrSuccess, failureOrSuccess) ||
                const DeepCollectionEquality()
                    .equals(other.failureOrSuccess, failureOrSuccess)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(selectedEntities) ^
      const DeepCollectionEquality().hash(isLoading) ^
      const DeepCollectionEquality().hash(isEditing) ^
      const DeepCollectionEquality().hash(isSorting) ^
      const DeepCollectionEquality().hash(failureOrSuccess);

  @JsonKey(ignore: true)
  @override
  _$EntityActorStateCopyWith<T, _EntityActorState<T>> get copyWith =>
      __$EntityActorStateCopyWithImpl<T, _EntityActorState<T>>(
          this, _$identity);
}

abstract class _EntityActorState<T extends Entity<dynamic>>
    implements EntityActorState<T> {
  const factory _EntityActorState(
          {required KtList<T> selectedEntities,
          required bool isLoading,
          required bool isEditing,
          required bool isSorting,
          required Either<CrudFailure, Unit>? failureOrSuccess}) =
      _$_EntityActorState<T>;

  @override
  KtList<T> get selectedEntities => throw _privateConstructorUsedError;
  @override
  bool get isLoading => throw _privateConstructorUsedError;
  @override
  bool get isEditing => throw _privateConstructorUsedError;
  @override
  bool get isSorting => throw _privateConstructorUsedError;
  @override
  Either<CrudFailure, Unit>? get failureOrSuccess =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$EntityActorStateCopyWith<T, _EntityActorState<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
