// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'entity_editor_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$EntityEditorStateTearOff {
  const _$EntityEditorStateTearOff();

  _EntityEditorState<T> call<T>(
      {required T? entity,
      required Either<ValueFailure, Unit> inputError,
      required bool isEditing,
      required bool isSaving,
      required Either<CrudFailure, T>? saveFailureOrSuccess}) {
    return _EntityEditorState<T>(
      entity: entity,
      inputError: inputError,
      isEditing: isEditing,
      isSaving: isSaving,
      saveFailureOrSuccess: saveFailureOrSuccess,
    );
  }
}

/// @nodoc
const $EntityEditorState = _$EntityEditorStateTearOff();

/// @nodoc
mixin _$EntityEditorState<T> {
  T? get entity => throw _privateConstructorUsedError;
  Either<ValueFailure, Unit> get inputError =>
      throw _privateConstructorUsedError;
  bool get isEditing => throw _privateConstructorUsedError;
  bool get isSaving => throw _privateConstructorUsedError;
  Either<CrudFailure, T>? get saveFailureOrSuccess =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EntityEditorStateCopyWith<T, EntityEditorState<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EntityEditorStateCopyWith<T, $Res> {
  factory $EntityEditorStateCopyWith(EntityEditorState<T> value,
          $Res Function(EntityEditorState<T>) then) =
      _$EntityEditorStateCopyWithImpl<T, $Res>;
  $Res call(
      {T? entity,
      Either<ValueFailure, Unit> inputError,
      bool isEditing,
      bool isSaving,
      Either<CrudFailure, T>? saveFailureOrSuccess});
}

/// @nodoc
class _$EntityEditorStateCopyWithImpl<T, $Res>
    implements $EntityEditorStateCopyWith<T, $Res> {
  _$EntityEditorStateCopyWithImpl(this._value, this._then);

  final EntityEditorState<T> _value;
  // ignore: unused_field
  final $Res Function(EntityEditorState<T>) _then;

  @override
  $Res call({
    Object? entity = freezed,
    Object? inputError = freezed,
    Object? isEditing = freezed,
    Object? isSaving = freezed,
    Object? saveFailureOrSuccess = freezed,
  }) {
    return _then(_value.copyWith(
      entity: entity == freezed
          ? _value.entity
          : entity // ignore: cast_nullable_to_non_nullable
              as T?,
      inputError: inputError == freezed
          ? _value.inputError
          : inputError // ignore: cast_nullable_to_non_nullable
              as Either<ValueFailure, Unit>,
      isEditing: isEditing == freezed
          ? _value.isEditing
          : isEditing // ignore: cast_nullable_to_non_nullable
              as bool,
      isSaving: isSaving == freezed
          ? _value.isSaving
          : isSaving // ignore: cast_nullable_to_non_nullable
              as bool,
      saveFailureOrSuccess: saveFailureOrSuccess == freezed
          ? _value.saveFailureOrSuccess
          : saveFailureOrSuccess // ignore: cast_nullable_to_non_nullable
              as Either<CrudFailure, T>?,
    ));
  }
}

/// @nodoc
abstract class _$EntityEditorStateCopyWith<T, $Res>
    implements $EntityEditorStateCopyWith<T, $Res> {
  factory _$EntityEditorStateCopyWith(_EntityEditorState<T> value,
          $Res Function(_EntityEditorState<T>) then) =
      __$EntityEditorStateCopyWithImpl<T, $Res>;
  @override
  $Res call(
      {T? entity,
      Either<ValueFailure, Unit> inputError,
      bool isEditing,
      bool isSaving,
      Either<CrudFailure, T>? saveFailureOrSuccess});
}

/// @nodoc
class __$EntityEditorStateCopyWithImpl<T, $Res>
    extends _$EntityEditorStateCopyWithImpl<T, $Res>
    implements _$EntityEditorStateCopyWith<T, $Res> {
  __$EntityEditorStateCopyWithImpl(
      _EntityEditorState<T> _value, $Res Function(_EntityEditorState<T>) _then)
      : super(_value, (v) => _then(v as _EntityEditorState<T>));

  @override
  _EntityEditorState<T> get _value => super._value as _EntityEditorState<T>;

  @override
  $Res call({
    Object? entity = freezed,
    Object? inputError = freezed,
    Object? isEditing = freezed,
    Object? isSaving = freezed,
    Object? saveFailureOrSuccess = freezed,
  }) {
    return _then(_EntityEditorState<T>(
      entity: entity == freezed
          ? _value.entity
          : entity // ignore: cast_nullable_to_non_nullable
              as T?,
      inputError: inputError == freezed
          ? _value.inputError
          : inputError // ignore: cast_nullable_to_non_nullable
              as Either<ValueFailure, Unit>,
      isEditing: isEditing == freezed
          ? _value.isEditing
          : isEditing // ignore: cast_nullable_to_non_nullable
              as bool,
      isSaving: isSaving == freezed
          ? _value.isSaving
          : isSaving // ignore: cast_nullable_to_non_nullable
              as bool,
      saveFailureOrSuccess: saveFailureOrSuccess == freezed
          ? _value.saveFailureOrSuccess
          : saveFailureOrSuccess // ignore: cast_nullable_to_non_nullable
              as Either<CrudFailure, T>?,
    ));
  }
}

/// @nodoc

class _$_EntityEditorState<T> implements _EntityEditorState<T> {
  const _$_EntityEditorState(
      {required this.entity,
      required this.inputError,
      required this.isEditing,
      required this.isSaving,
      required this.saveFailureOrSuccess});

  @override
  final T? entity;
  @override
  final Either<ValueFailure, Unit> inputError;
  @override
  final bool isEditing;
  @override
  final bool isSaving;
  @override
  final Either<CrudFailure, T>? saveFailureOrSuccess;

  @override
  String toString() {
    return 'EntityEditorState<$T>(entity: $entity, inputError: $inputError, isEditing: $isEditing, isSaving: $isSaving, saveFailureOrSuccess: $saveFailureOrSuccess)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _EntityEditorState<T> &&
            (identical(other.entity, entity) ||
                const DeepCollectionEquality().equals(other.entity, entity)) &&
            (identical(other.inputError, inputError) ||
                const DeepCollectionEquality()
                    .equals(other.inputError, inputError)) &&
            (identical(other.isEditing, isEditing) ||
                const DeepCollectionEquality()
                    .equals(other.isEditing, isEditing)) &&
            (identical(other.isSaving, isSaving) ||
                const DeepCollectionEquality()
                    .equals(other.isSaving, isSaving)) &&
            (identical(other.saveFailureOrSuccess, saveFailureOrSuccess) ||
                const DeepCollectionEquality()
                    .equals(other.saveFailureOrSuccess, saveFailureOrSuccess)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(entity) ^
      const DeepCollectionEquality().hash(inputError) ^
      const DeepCollectionEquality().hash(isEditing) ^
      const DeepCollectionEquality().hash(isSaving) ^
      const DeepCollectionEquality().hash(saveFailureOrSuccess);

  @JsonKey(ignore: true)
  @override
  _$EntityEditorStateCopyWith<T, _EntityEditorState<T>> get copyWith =>
      __$EntityEditorStateCopyWithImpl<T, _EntityEditorState<T>>(
          this, _$identity);
}

abstract class _EntityEditorState<T> implements EntityEditorState<T> {
  const factory _EntityEditorState(
          {required T? entity,
          required Either<ValueFailure, Unit> inputError,
          required bool isEditing,
          required bool isSaving,
          required Either<CrudFailure, T>? saveFailureOrSuccess}) =
      _$_EntityEditorState<T>;

  @override
  T? get entity => throw _privateConstructorUsedError;
  @override
  Either<ValueFailure, Unit> get inputError =>
      throw _privateConstructorUsedError;
  @override
  bool get isEditing => throw _privateConstructorUsedError;
  @override
  bool get isSaving => throw _privateConstructorUsedError;
  @override
  Either<CrudFailure, T>? get saveFailureOrSuccess =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$EntityEditorStateCopyWith<T, _EntityEditorState<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
