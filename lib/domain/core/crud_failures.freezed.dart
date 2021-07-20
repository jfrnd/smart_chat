// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'crud_failures.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$CrudFailureTearOff {
  const _$CrudFailureTearOff();

  NotSignedIn notSignedIn() {
    return const NotSignedIn();
  }

  DataSchemaError dataSchemaError() {
    return const DataSchemaError();
  }

  Unexpected unexpected({String? info}) {
    return Unexpected(
      info: info,
    );
  }

  ImageFailure imageFailure() {
    return const ImageFailure();
  }

  InsufficientPermission insufficientPermission() {
    return const InsufficientPermission();
  }

  UnableToUpdate unableToUpdate({String? info}) {
    return UnableToUpdate(
      info: info,
    );
  }

  DoesNotExist doesNotExist() {
    return const DoesNotExist();
  }

  _DataBaseNotSynchonWarnning dataBaseNotSynchonWarning({String? info}) {
    return _DataBaseNotSynchonWarnning(
      info: info,
    );
  }
}

/// @nodoc
const $CrudFailure = _$CrudFailureTearOff();

/// @nodoc
mixin _$CrudFailure {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() notSignedIn,
    required TResult Function() dataSchemaError,
    required TResult Function(String? info) unexpected,
    required TResult Function() imageFailure,
    required TResult Function() insufficientPermission,
    required TResult Function(String? info) unableToUpdate,
    required TResult Function() doesNotExist,
    required TResult Function(String? info) dataBaseNotSynchonWarning,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? notSignedIn,
    TResult Function()? dataSchemaError,
    TResult Function(String? info)? unexpected,
    TResult Function()? imageFailure,
    TResult Function()? insufficientPermission,
    TResult Function(String? info)? unableToUpdate,
    TResult Function()? doesNotExist,
    TResult Function(String? info)? dataBaseNotSynchonWarning,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NotSignedIn value) notSignedIn,
    required TResult Function(DataSchemaError value) dataSchemaError,
    required TResult Function(Unexpected value) unexpected,
    required TResult Function(ImageFailure value) imageFailure,
    required TResult Function(InsufficientPermission value)
        insufficientPermission,
    required TResult Function(UnableToUpdate value) unableToUpdate,
    required TResult Function(DoesNotExist value) doesNotExist,
    required TResult Function(_DataBaseNotSynchonWarnning value)
        dataBaseNotSynchonWarning,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NotSignedIn value)? notSignedIn,
    TResult Function(DataSchemaError value)? dataSchemaError,
    TResult Function(Unexpected value)? unexpected,
    TResult Function(ImageFailure value)? imageFailure,
    TResult Function(InsufficientPermission value)? insufficientPermission,
    TResult Function(UnableToUpdate value)? unableToUpdate,
    TResult Function(DoesNotExist value)? doesNotExist,
    TResult Function(_DataBaseNotSynchonWarnning value)?
        dataBaseNotSynchonWarning,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CrudFailureCopyWith<$Res> {
  factory $CrudFailureCopyWith(
          CrudFailure value, $Res Function(CrudFailure) then) =
      _$CrudFailureCopyWithImpl<$Res>;
}

/// @nodoc
class _$CrudFailureCopyWithImpl<$Res> implements $CrudFailureCopyWith<$Res> {
  _$CrudFailureCopyWithImpl(this._value, this._then);

  final CrudFailure _value;
  // ignore: unused_field
  final $Res Function(CrudFailure) _then;
}

/// @nodoc
abstract class $NotSignedInCopyWith<$Res> {
  factory $NotSignedInCopyWith(
          NotSignedIn value, $Res Function(NotSignedIn) then) =
      _$NotSignedInCopyWithImpl<$Res>;
}

/// @nodoc
class _$NotSignedInCopyWithImpl<$Res> extends _$CrudFailureCopyWithImpl<$Res>
    implements $NotSignedInCopyWith<$Res> {
  _$NotSignedInCopyWithImpl(
      NotSignedIn _value, $Res Function(NotSignedIn) _then)
      : super(_value, (v) => _then(v as NotSignedIn));

  @override
  NotSignedIn get _value => super._value as NotSignedIn;
}

/// @nodoc

class _$NotSignedIn implements NotSignedIn {
  const _$NotSignedIn();

  @override
  String toString() {
    return 'CrudFailure.notSignedIn()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is NotSignedIn);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() notSignedIn,
    required TResult Function() dataSchemaError,
    required TResult Function(String? info) unexpected,
    required TResult Function() imageFailure,
    required TResult Function() insufficientPermission,
    required TResult Function(String? info) unableToUpdate,
    required TResult Function() doesNotExist,
    required TResult Function(String? info) dataBaseNotSynchonWarning,
  }) {
    return notSignedIn();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? notSignedIn,
    TResult Function()? dataSchemaError,
    TResult Function(String? info)? unexpected,
    TResult Function()? imageFailure,
    TResult Function()? insufficientPermission,
    TResult Function(String? info)? unableToUpdate,
    TResult Function()? doesNotExist,
    TResult Function(String? info)? dataBaseNotSynchonWarning,
    required TResult orElse(),
  }) {
    if (notSignedIn != null) {
      return notSignedIn();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NotSignedIn value) notSignedIn,
    required TResult Function(DataSchemaError value) dataSchemaError,
    required TResult Function(Unexpected value) unexpected,
    required TResult Function(ImageFailure value) imageFailure,
    required TResult Function(InsufficientPermission value)
        insufficientPermission,
    required TResult Function(UnableToUpdate value) unableToUpdate,
    required TResult Function(DoesNotExist value) doesNotExist,
    required TResult Function(_DataBaseNotSynchonWarnning value)
        dataBaseNotSynchonWarning,
  }) {
    return notSignedIn(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NotSignedIn value)? notSignedIn,
    TResult Function(DataSchemaError value)? dataSchemaError,
    TResult Function(Unexpected value)? unexpected,
    TResult Function(ImageFailure value)? imageFailure,
    TResult Function(InsufficientPermission value)? insufficientPermission,
    TResult Function(UnableToUpdate value)? unableToUpdate,
    TResult Function(DoesNotExist value)? doesNotExist,
    TResult Function(_DataBaseNotSynchonWarnning value)?
        dataBaseNotSynchonWarning,
    required TResult orElse(),
  }) {
    if (notSignedIn != null) {
      return notSignedIn(this);
    }
    return orElse();
  }
}

abstract class NotSignedIn implements CrudFailure {
  const factory NotSignedIn() = _$NotSignedIn;
}

/// @nodoc
abstract class $DataSchemaErrorCopyWith<$Res> {
  factory $DataSchemaErrorCopyWith(
          DataSchemaError value, $Res Function(DataSchemaError) then) =
      _$DataSchemaErrorCopyWithImpl<$Res>;
}

/// @nodoc
class _$DataSchemaErrorCopyWithImpl<$Res>
    extends _$CrudFailureCopyWithImpl<$Res>
    implements $DataSchemaErrorCopyWith<$Res> {
  _$DataSchemaErrorCopyWithImpl(
      DataSchemaError _value, $Res Function(DataSchemaError) _then)
      : super(_value, (v) => _then(v as DataSchemaError));

  @override
  DataSchemaError get _value => super._value as DataSchemaError;
}

/// @nodoc

class _$DataSchemaError implements DataSchemaError {
  const _$DataSchemaError();

  @override
  String toString() {
    return 'CrudFailure.dataSchemaError()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is DataSchemaError);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() notSignedIn,
    required TResult Function() dataSchemaError,
    required TResult Function(String? info) unexpected,
    required TResult Function() imageFailure,
    required TResult Function() insufficientPermission,
    required TResult Function(String? info) unableToUpdate,
    required TResult Function() doesNotExist,
    required TResult Function(String? info) dataBaseNotSynchonWarning,
  }) {
    return dataSchemaError();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? notSignedIn,
    TResult Function()? dataSchemaError,
    TResult Function(String? info)? unexpected,
    TResult Function()? imageFailure,
    TResult Function()? insufficientPermission,
    TResult Function(String? info)? unableToUpdate,
    TResult Function()? doesNotExist,
    TResult Function(String? info)? dataBaseNotSynchonWarning,
    required TResult orElse(),
  }) {
    if (dataSchemaError != null) {
      return dataSchemaError();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NotSignedIn value) notSignedIn,
    required TResult Function(DataSchemaError value) dataSchemaError,
    required TResult Function(Unexpected value) unexpected,
    required TResult Function(ImageFailure value) imageFailure,
    required TResult Function(InsufficientPermission value)
        insufficientPermission,
    required TResult Function(UnableToUpdate value) unableToUpdate,
    required TResult Function(DoesNotExist value) doesNotExist,
    required TResult Function(_DataBaseNotSynchonWarnning value)
        dataBaseNotSynchonWarning,
  }) {
    return dataSchemaError(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NotSignedIn value)? notSignedIn,
    TResult Function(DataSchemaError value)? dataSchemaError,
    TResult Function(Unexpected value)? unexpected,
    TResult Function(ImageFailure value)? imageFailure,
    TResult Function(InsufficientPermission value)? insufficientPermission,
    TResult Function(UnableToUpdate value)? unableToUpdate,
    TResult Function(DoesNotExist value)? doesNotExist,
    TResult Function(_DataBaseNotSynchonWarnning value)?
        dataBaseNotSynchonWarning,
    required TResult orElse(),
  }) {
    if (dataSchemaError != null) {
      return dataSchemaError(this);
    }
    return orElse();
  }
}

abstract class DataSchemaError implements CrudFailure {
  const factory DataSchemaError() = _$DataSchemaError;
}

/// @nodoc
abstract class $UnexpectedCopyWith<$Res> {
  factory $UnexpectedCopyWith(
          Unexpected value, $Res Function(Unexpected) then) =
      _$UnexpectedCopyWithImpl<$Res>;
  $Res call({String? info});
}

/// @nodoc
class _$UnexpectedCopyWithImpl<$Res> extends _$CrudFailureCopyWithImpl<$Res>
    implements $UnexpectedCopyWith<$Res> {
  _$UnexpectedCopyWithImpl(Unexpected _value, $Res Function(Unexpected) _then)
      : super(_value, (v) => _then(v as Unexpected));

  @override
  Unexpected get _value => super._value as Unexpected;

  @override
  $Res call({
    Object? info = freezed,
  }) {
    return _then(Unexpected(
      info: info == freezed
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$Unexpected implements Unexpected {
  const _$Unexpected({this.info});

  @override
  final String? info;

  @override
  String toString() {
    return 'CrudFailure.unexpected(info: $info)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Unexpected &&
            (identical(other.info, info) ||
                const DeepCollectionEquality().equals(other.info, info)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(info);

  @JsonKey(ignore: true)
  @override
  $UnexpectedCopyWith<Unexpected> get copyWith =>
      _$UnexpectedCopyWithImpl<Unexpected>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() notSignedIn,
    required TResult Function() dataSchemaError,
    required TResult Function(String? info) unexpected,
    required TResult Function() imageFailure,
    required TResult Function() insufficientPermission,
    required TResult Function(String? info) unableToUpdate,
    required TResult Function() doesNotExist,
    required TResult Function(String? info) dataBaseNotSynchonWarning,
  }) {
    return unexpected(info);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? notSignedIn,
    TResult Function()? dataSchemaError,
    TResult Function(String? info)? unexpected,
    TResult Function()? imageFailure,
    TResult Function()? insufficientPermission,
    TResult Function(String? info)? unableToUpdate,
    TResult Function()? doesNotExist,
    TResult Function(String? info)? dataBaseNotSynchonWarning,
    required TResult orElse(),
  }) {
    if (unexpected != null) {
      return unexpected(info);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NotSignedIn value) notSignedIn,
    required TResult Function(DataSchemaError value) dataSchemaError,
    required TResult Function(Unexpected value) unexpected,
    required TResult Function(ImageFailure value) imageFailure,
    required TResult Function(InsufficientPermission value)
        insufficientPermission,
    required TResult Function(UnableToUpdate value) unableToUpdate,
    required TResult Function(DoesNotExist value) doesNotExist,
    required TResult Function(_DataBaseNotSynchonWarnning value)
        dataBaseNotSynchonWarning,
  }) {
    return unexpected(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NotSignedIn value)? notSignedIn,
    TResult Function(DataSchemaError value)? dataSchemaError,
    TResult Function(Unexpected value)? unexpected,
    TResult Function(ImageFailure value)? imageFailure,
    TResult Function(InsufficientPermission value)? insufficientPermission,
    TResult Function(UnableToUpdate value)? unableToUpdate,
    TResult Function(DoesNotExist value)? doesNotExist,
    TResult Function(_DataBaseNotSynchonWarnning value)?
        dataBaseNotSynchonWarning,
    required TResult orElse(),
  }) {
    if (unexpected != null) {
      return unexpected(this);
    }
    return orElse();
  }
}

abstract class Unexpected implements CrudFailure {
  const factory Unexpected({String? info}) = _$Unexpected;

  String? get info => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UnexpectedCopyWith<Unexpected> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageFailureCopyWith<$Res> {
  factory $ImageFailureCopyWith(
          ImageFailure value, $Res Function(ImageFailure) then) =
      _$ImageFailureCopyWithImpl<$Res>;
}

/// @nodoc
class _$ImageFailureCopyWithImpl<$Res> extends _$CrudFailureCopyWithImpl<$Res>
    implements $ImageFailureCopyWith<$Res> {
  _$ImageFailureCopyWithImpl(
      ImageFailure _value, $Res Function(ImageFailure) _then)
      : super(_value, (v) => _then(v as ImageFailure));

  @override
  ImageFailure get _value => super._value as ImageFailure;
}

/// @nodoc

class _$ImageFailure implements ImageFailure {
  const _$ImageFailure();

  @override
  String toString() {
    return 'CrudFailure.imageFailure()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is ImageFailure);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() notSignedIn,
    required TResult Function() dataSchemaError,
    required TResult Function(String? info) unexpected,
    required TResult Function() imageFailure,
    required TResult Function() insufficientPermission,
    required TResult Function(String? info) unableToUpdate,
    required TResult Function() doesNotExist,
    required TResult Function(String? info) dataBaseNotSynchonWarning,
  }) {
    return imageFailure();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? notSignedIn,
    TResult Function()? dataSchemaError,
    TResult Function(String? info)? unexpected,
    TResult Function()? imageFailure,
    TResult Function()? insufficientPermission,
    TResult Function(String? info)? unableToUpdate,
    TResult Function()? doesNotExist,
    TResult Function(String? info)? dataBaseNotSynchonWarning,
    required TResult orElse(),
  }) {
    if (imageFailure != null) {
      return imageFailure();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NotSignedIn value) notSignedIn,
    required TResult Function(DataSchemaError value) dataSchemaError,
    required TResult Function(Unexpected value) unexpected,
    required TResult Function(ImageFailure value) imageFailure,
    required TResult Function(InsufficientPermission value)
        insufficientPermission,
    required TResult Function(UnableToUpdate value) unableToUpdate,
    required TResult Function(DoesNotExist value) doesNotExist,
    required TResult Function(_DataBaseNotSynchonWarnning value)
        dataBaseNotSynchonWarning,
  }) {
    return imageFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NotSignedIn value)? notSignedIn,
    TResult Function(DataSchemaError value)? dataSchemaError,
    TResult Function(Unexpected value)? unexpected,
    TResult Function(ImageFailure value)? imageFailure,
    TResult Function(InsufficientPermission value)? insufficientPermission,
    TResult Function(UnableToUpdate value)? unableToUpdate,
    TResult Function(DoesNotExist value)? doesNotExist,
    TResult Function(_DataBaseNotSynchonWarnning value)?
        dataBaseNotSynchonWarning,
    required TResult orElse(),
  }) {
    if (imageFailure != null) {
      return imageFailure(this);
    }
    return orElse();
  }
}

abstract class ImageFailure implements CrudFailure {
  const factory ImageFailure() = _$ImageFailure;
}

/// @nodoc
abstract class $InsufficientPermissionCopyWith<$Res> {
  factory $InsufficientPermissionCopyWith(InsufficientPermission value,
          $Res Function(InsufficientPermission) then) =
      _$InsufficientPermissionCopyWithImpl<$Res>;
}

/// @nodoc
class _$InsufficientPermissionCopyWithImpl<$Res>
    extends _$CrudFailureCopyWithImpl<$Res>
    implements $InsufficientPermissionCopyWith<$Res> {
  _$InsufficientPermissionCopyWithImpl(InsufficientPermission _value,
      $Res Function(InsufficientPermission) _then)
      : super(_value, (v) => _then(v as InsufficientPermission));

  @override
  InsufficientPermission get _value => super._value as InsufficientPermission;
}

/// @nodoc

class _$InsufficientPermission implements InsufficientPermission {
  const _$InsufficientPermission();

  @override
  String toString() {
    return 'CrudFailure.insufficientPermission()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is InsufficientPermission);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() notSignedIn,
    required TResult Function() dataSchemaError,
    required TResult Function(String? info) unexpected,
    required TResult Function() imageFailure,
    required TResult Function() insufficientPermission,
    required TResult Function(String? info) unableToUpdate,
    required TResult Function() doesNotExist,
    required TResult Function(String? info) dataBaseNotSynchonWarning,
  }) {
    return insufficientPermission();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? notSignedIn,
    TResult Function()? dataSchemaError,
    TResult Function(String? info)? unexpected,
    TResult Function()? imageFailure,
    TResult Function()? insufficientPermission,
    TResult Function(String? info)? unableToUpdate,
    TResult Function()? doesNotExist,
    TResult Function(String? info)? dataBaseNotSynchonWarning,
    required TResult orElse(),
  }) {
    if (insufficientPermission != null) {
      return insufficientPermission();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NotSignedIn value) notSignedIn,
    required TResult Function(DataSchemaError value) dataSchemaError,
    required TResult Function(Unexpected value) unexpected,
    required TResult Function(ImageFailure value) imageFailure,
    required TResult Function(InsufficientPermission value)
        insufficientPermission,
    required TResult Function(UnableToUpdate value) unableToUpdate,
    required TResult Function(DoesNotExist value) doesNotExist,
    required TResult Function(_DataBaseNotSynchonWarnning value)
        dataBaseNotSynchonWarning,
  }) {
    return insufficientPermission(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NotSignedIn value)? notSignedIn,
    TResult Function(DataSchemaError value)? dataSchemaError,
    TResult Function(Unexpected value)? unexpected,
    TResult Function(ImageFailure value)? imageFailure,
    TResult Function(InsufficientPermission value)? insufficientPermission,
    TResult Function(UnableToUpdate value)? unableToUpdate,
    TResult Function(DoesNotExist value)? doesNotExist,
    TResult Function(_DataBaseNotSynchonWarnning value)?
        dataBaseNotSynchonWarning,
    required TResult orElse(),
  }) {
    if (insufficientPermission != null) {
      return insufficientPermission(this);
    }
    return orElse();
  }
}

abstract class InsufficientPermission implements CrudFailure {
  const factory InsufficientPermission() = _$InsufficientPermission;
}

/// @nodoc
abstract class $UnableToUpdateCopyWith<$Res> {
  factory $UnableToUpdateCopyWith(
          UnableToUpdate value, $Res Function(UnableToUpdate) then) =
      _$UnableToUpdateCopyWithImpl<$Res>;
  $Res call({String? info});
}

/// @nodoc
class _$UnableToUpdateCopyWithImpl<$Res> extends _$CrudFailureCopyWithImpl<$Res>
    implements $UnableToUpdateCopyWith<$Res> {
  _$UnableToUpdateCopyWithImpl(
      UnableToUpdate _value, $Res Function(UnableToUpdate) _then)
      : super(_value, (v) => _then(v as UnableToUpdate));

  @override
  UnableToUpdate get _value => super._value as UnableToUpdate;

  @override
  $Res call({
    Object? info = freezed,
  }) {
    return _then(UnableToUpdate(
      info: info == freezed
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$UnableToUpdate implements UnableToUpdate {
  const _$UnableToUpdate({this.info});

  @override
  final String? info;

  @override
  String toString() {
    return 'CrudFailure.unableToUpdate(info: $info)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UnableToUpdate &&
            (identical(other.info, info) ||
                const DeepCollectionEquality().equals(other.info, info)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(info);

  @JsonKey(ignore: true)
  @override
  $UnableToUpdateCopyWith<UnableToUpdate> get copyWith =>
      _$UnableToUpdateCopyWithImpl<UnableToUpdate>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() notSignedIn,
    required TResult Function() dataSchemaError,
    required TResult Function(String? info) unexpected,
    required TResult Function() imageFailure,
    required TResult Function() insufficientPermission,
    required TResult Function(String? info) unableToUpdate,
    required TResult Function() doesNotExist,
    required TResult Function(String? info) dataBaseNotSynchonWarning,
  }) {
    return unableToUpdate(info);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? notSignedIn,
    TResult Function()? dataSchemaError,
    TResult Function(String? info)? unexpected,
    TResult Function()? imageFailure,
    TResult Function()? insufficientPermission,
    TResult Function(String? info)? unableToUpdate,
    TResult Function()? doesNotExist,
    TResult Function(String? info)? dataBaseNotSynchonWarning,
    required TResult orElse(),
  }) {
    if (unableToUpdate != null) {
      return unableToUpdate(info);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NotSignedIn value) notSignedIn,
    required TResult Function(DataSchemaError value) dataSchemaError,
    required TResult Function(Unexpected value) unexpected,
    required TResult Function(ImageFailure value) imageFailure,
    required TResult Function(InsufficientPermission value)
        insufficientPermission,
    required TResult Function(UnableToUpdate value) unableToUpdate,
    required TResult Function(DoesNotExist value) doesNotExist,
    required TResult Function(_DataBaseNotSynchonWarnning value)
        dataBaseNotSynchonWarning,
  }) {
    return unableToUpdate(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NotSignedIn value)? notSignedIn,
    TResult Function(DataSchemaError value)? dataSchemaError,
    TResult Function(Unexpected value)? unexpected,
    TResult Function(ImageFailure value)? imageFailure,
    TResult Function(InsufficientPermission value)? insufficientPermission,
    TResult Function(UnableToUpdate value)? unableToUpdate,
    TResult Function(DoesNotExist value)? doesNotExist,
    TResult Function(_DataBaseNotSynchonWarnning value)?
        dataBaseNotSynchonWarning,
    required TResult orElse(),
  }) {
    if (unableToUpdate != null) {
      return unableToUpdate(this);
    }
    return orElse();
  }
}

abstract class UnableToUpdate implements CrudFailure {
  const factory UnableToUpdate({String? info}) = _$UnableToUpdate;

  String? get info => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UnableToUpdateCopyWith<UnableToUpdate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DoesNotExistCopyWith<$Res> {
  factory $DoesNotExistCopyWith(
          DoesNotExist value, $Res Function(DoesNotExist) then) =
      _$DoesNotExistCopyWithImpl<$Res>;
}

/// @nodoc
class _$DoesNotExistCopyWithImpl<$Res> extends _$CrudFailureCopyWithImpl<$Res>
    implements $DoesNotExistCopyWith<$Res> {
  _$DoesNotExistCopyWithImpl(
      DoesNotExist _value, $Res Function(DoesNotExist) _then)
      : super(_value, (v) => _then(v as DoesNotExist));

  @override
  DoesNotExist get _value => super._value as DoesNotExist;
}

/// @nodoc

class _$DoesNotExist implements DoesNotExist {
  const _$DoesNotExist();

  @override
  String toString() {
    return 'CrudFailure.doesNotExist()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is DoesNotExist);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() notSignedIn,
    required TResult Function() dataSchemaError,
    required TResult Function(String? info) unexpected,
    required TResult Function() imageFailure,
    required TResult Function() insufficientPermission,
    required TResult Function(String? info) unableToUpdate,
    required TResult Function() doesNotExist,
    required TResult Function(String? info) dataBaseNotSynchonWarning,
  }) {
    return doesNotExist();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? notSignedIn,
    TResult Function()? dataSchemaError,
    TResult Function(String? info)? unexpected,
    TResult Function()? imageFailure,
    TResult Function()? insufficientPermission,
    TResult Function(String? info)? unableToUpdate,
    TResult Function()? doesNotExist,
    TResult Function(String? info)? dataBaseNotSynchonWarning,
    required TResult orElse(),
  }) {
    if (doesNotExist != null) {
      return doesNotExist();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NotSignedIn value) notSignedIn,
    required TResult Function(DataSchemaError value) dataSchemaError,
    required TResult Function(Unexpected value) unexpected,
    required TResult Function(ImageFailure value) imageFailure,
    required TResult Function(InsufficientPermission value)
        insufficientPermission,
    required TResult Function(UnableToUpdate value) unableToUpdate,
    required TResult Function(DoesNotExist value) doesNotExist,
    required TResult Function(_DataBaseNotSynchonWarnning value)
        dataBaseNotSynchonWarning,
  }) {
    return doesNotExist(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NotSignedIn value)? notSignedIn,
    TResult Function(DataSchemaError value)? dataSchemaError,
    TResult Function(Unexpected value)? unexpected,
    TResult Function(ImageFailure value)? imageFailure,
    TResult Function(InsufficientPermission value)? insufficientPermission,
    TResult Function(UnableToUpdate value)? unableToUpdate,
    TResult Function(DoesNotExist value)? doesNotExist,
    TResult Function(_DataBaseNotSynchonWarnning value)?
        dataBaseNotSynchonWarning,
    required TResult orElse(),
  }) {
    if (doesNotExist != null) {
      return doesNotExist(this);
    }
    return orElse();
  }
}

abstract class DoesNotExist implements CrudFailure {
  const factory DoesNotExist() = _$DoesNotExist;
}

/// @nodoc
abstract class _$DataBaseNotSynchonWarnningCopyWith<$Res> {
  factory _$DataBaseNotSynchonWarnningCopyWith(
          _DataBaseNotSynchonWarnning value,
          $Res Function(_DataBaseNotSynchonWarnning) then) =
      __$DataBaseNotSynchonWarnningCopyWithImpl<$Res>;
  $Res call({String? info});
}

/// @nodoc
class __$DataBaseNotSynchonWarnningCopyWithImpl<$Res>
    extends _$CrudFailureCopyWithImpl<$Res>
    implements _$DataBaseNotSynchonWarnningCopyWith<$Res> {
  __$DataBaseNotSynchonWarnningCopyWithImpl(_DataBaseNotSynchonWarnning _value,
      $Res Function(_DataBaseNotSynchonWarnning) _then)
      : super(_value, (v) => _then(v as _DataBaseNotSynchonWarnning));

  @override
  _DataBaseNotSynchonWarnning get _value =>
      super._value as _DataBaseNotSynchonWarnning;

  @override
  $Res call({
    Object? info = freezed,
  }) {
    return _then(_DataBaseNotSynchonWarnning(
      info: info == freezed
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_DataBaseNotSynchonWarnning implements _DataBaseNotSynchonWarnning {
  const _$_DataBaseNotSynchonWarnning({this.info});

  @override
  final String? info;

  @override
  String toString() {
    return 'CrudFailure.dataBaseNotSynchonWarning(info: $info)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _DataBaseNotSynchonWarnning &&
            (identical(other.info, info) ||
                const DeepCollectionEquality().equals(other.info, info)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(info);

  @JsonKey(ignore: true)
  @override
  _$DataBaseNotSynchonWarnningCopyWith<_DataBaseNotSynchonWarnning>
      get copyWith => __$DataBaseNotSynchonWarnningCopyWithImpl<
          _DataBaseNotSynchonWarnning>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() notSignedIn,
    required TResult Function() dataSchemaError,
    required TResult Function(String? info) unexpected,
    required TResult Function() imageFailure,
    required TResult Function() insufficientPermission,
    required TResult Function(String? info) unableToUpdate,
    required TResult Function() doesNotExist,
    required TResult Function(String? info) dataBaseNotSynchonWarning,
  }) {
    return dataBaseNotSynchonWarning(info);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? notSignedIn,
    TResult Function()? dataSchemaError,
    TResult Function(String? info)? unexpected,
    TResult Function()? imageFailure,
    TResult Function()? insufficientPermission,
    TResult Function(String? info)? unableToUpdate,
    TResult Function()? doesNotExist,
    TResult Function(String? info)? dataBaseNotSynchonWarning,
    required TResult orElse(),
  }) {
    if (dataBaseNotSynchonWarning != null) {
      return dataBaseNotSynchonWarning(info);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NotSignedIn value) notSignedIn,
    required TResult Function(DataSchemaError value) dataSchemaError,
    required TResult Function(Unexpected value) unexpected,
    required TResult Function(ImageFailure value) imageFailure,
    required TResult Function(InsufficientPermission value)
        insufficientPermission,
    required TResult Function(UnableToUpdate value) unableToUpdate,
    required TResult Function(DoesNotExist value) doesNotExist,
    required TResult Function(_DataBaseNotSynchonWarnning value)
        dataBaseNotSynchonWarning,
  }) {
    return dataBaseNotSynchonWarning(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NotSignedIn value)? notSignedIn,
    TResult Function(DataSchemaError value)? dataSchemaError,
    TResult Function(Unexpected value)? unexpected,
    TResult Function(ImageFailure value)? imageFailure,
    TResult Function(InsufficientPermission value)? insufficientPermission,
    TResult Function(UnableToUpdate value)? unableToUpdate,
    TResult Function(DoesNotExist value)? doesNotExist,
    TResult Function(_DataBaseNotSynchonWarnning value)?
        dataBaseNotSynchonWarning,
    required TResult orElse(),
  }) {
    if (dataBaseNotSynchonWarning != null) {
      return dataBaseNotSynchonWarning(this);
    }
    return orElse();
  }
}

abstract class _DataBaseNotSynchonWarnning implements CrudFailure {
  const factory _DataBaseNotSynchonWarnning({String? info}) =
      _$_DataBaseNotSynchonWarnning;

  String? get info => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$DataBaseNotSynchonWarnningCopyWith<_DataBaseNotSynchonWarnning>
      get copyWith => throw _privateConstructorUsedError;
}
