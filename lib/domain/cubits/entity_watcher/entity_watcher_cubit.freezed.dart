// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'entity_watcher_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$EntityWatcherStateTearOff {
  const _$EntityWatcherStateTearOff();

  Initial<T> initial<T extends Entity<dynamic>>() {
    return Initial<T>();
  }

  LoadInProgress<T> loadInProgress<T extends Entity<dynamic>>() {
    return LoadInProgress<T>();
  }

  Deleted<T> deleted<T extends Entity<dynamic>>() {
    return Deleted<T>();
  }

  LoadSuccess<T> loadSuccess<T extends Entity<dynamic>>(KtList<T> entityList) {
    return LoadSuccess<T>(
      entityList,
    );
  }

  LoadFailure<T> loadFailure<T extends Entity<dynamic>>(CrudFailure failure) {
    return LoadFailure<T>(
      failure,
    );
  }
}

/// @nodoc
const $EntityWatcherState = _$EntityWatcherStateTearOff();

/// @nodoc
mixin _$EntityWatcherState<T extends Entity<dynamic>> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loadInProgress,
    required TResult Function() deleted,
    required TResult Function(KtList<T> entityList) loadSuccess,
    required TResult Function(CrudFailure failure) loadFailure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loadInProgress,
    TResult Function()? deleted,
    TResult Function(KtList<T> entityList)? loadSuccess,
    TResult Function(CrudFailure failure)? loadFailure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial<T> value) initial,
    required TResult Function(LoadInProgress<T> value) loadInProgress,
    required TResult Function(Deleted<T> value) deleted,
    required TResult Function(LoadSuccess<T> value) loadSuccess,
    required TResult Function(LoadFailure<T> value) loadFailure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial<T> value)? initial,
    TResult Function(LoadInProgress<T> value)? loadInProgress,
    TResult Function(Deleted<T> value)? deleted,
    TResult Function(LoadSuccess<T> value)? loadSuccess,
    TResult Function(LoadFailure<T> value)? loadFailure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EntityWatcherStateCopyWith<T extends Entity<dynamic>, $Res> {
  factory $EntityWatcherStateCopyWith(EntityWatcherState<T> value,
          $Res Function(EntityWatcherState<T>) then) =
      _$EntityWatcherStateCopyWithImpl<T, $Res>;
}

/// @nodoc
class _$EntityWatcherStateCopyWithImpl<T extends Entity<dynamic>, $Res>
    implements $EntityWatcherStateCopyWith<T, $Res> {
  _$EntityWatcherStateCopyWithImpl(this._value, this._then);

  final EntityWatcherState<T> _value;
  // ignore: unused_field
  final $Res Function(EntityWatcherState<T>) _then;
}

/// @nodoc
abstract class $InitialCopyWith<T extends Entity<dynamic>, $Res> {
  factory $InitialCopyWith(Initial<T> value, $Res Function(Initial<T>) then) =
      _$InitialCopyWithImpl<T, $Res>;
}

/// @nodoc
class _$InitialCopyWithImpl<T extends Entity<dynamic>, $Res>
    extends _$EntityWatcherStateCopyWithImpl<T, $Res>
    implements $InitialCopyWith<T, $Res> {
  _$InitialCopyWithImpl(Initial<T> _value, $Res Function(Initial<T>) _then)
      : super(_value, (v) => _then(v as Initial<T>));

  @override
  Initial<T> get _value => super._value as Initial<T>;
}

/// @nodoc

class _$Initial<T extends Entity<dynamic>> implements Initial<T> {
  const _$Initial();

  @override
  String toString() {
    return 'EntityWatcherState<$T>.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is Initial<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loadInProgress,
    required TResult Function() deleted,
    required TResult Function(KtList<T> entityList) loadSuccess,
    required TResult Function(CrudFailure failure) loadFailure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loadInProgress,
    TResult Function()? deleted,
    TResult Function(KtList<T> entityList)? loadSuccess,
    TResult Function(CrudFailure failure)? loadFailure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial<T> value) initial,
    required TResult Function(LoadInProgress<T> value) loadInProgress,
    required TResult Function(Deleted<T> value) deleted,
    required TResult Function(LoadSuccess<T> value) loadSuccess,
    required TResult Function(LoadFailure<T> value) loadFailure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial<T> value)? initial,
    TResult Function(LoadInProgress<T> value)? loadInProgress,
    TResult Function(Deleted<T> value)? deleted,
    TResult Function(LoadSuccess<T> value)? loadSuccess,
    TResult Function(LoadFailure<T> value)? loadFailure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class Initial<T extends Entity<dynamic>>
    implements EntityWatcherState<T> {
  const factory Initial() = _$Initial<T>;
}

/// @nodoc
abstract class $LoadInProgressCopyWith<T extends Entity<dynamic>, $Res> {
  factory $LoadInProgressCopyWith(
          LoadInProgress<T> value, $Res Function(LoadInProgress<T>) then) =
      _$LoadInProgressCopyWithImpl<T, $Res>;
}

/// @nodoc
class _$LoadInProgressCopyWithImpl<T extends Entity<dynamic>, $Res>
    extends _$EntityWatcherStateCopyWithImpl<T, $Res>
    implements $LoadInProgressCopyWith<T, $Res> {
  _$LoadInProgressCopyWithImpl(
      LoadInProgress<T> _value, $Res Function(LoadInProgress<T>) _then)
      : super(_value, (v) => _then(v as LoadInProgress<T>));

  @override
  LoadInProgress<T> get _value => super._value as LoadInProgress<T>;
}

/// @nodoc

class _$LoadInProgress<T extends Entity<dynamic>> implements LoadInProgress<T> {
  const _$LoadInProgress();

  @override
  String toString() {
    return 'EntityWatcherState<$T>.loadInProgress()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is LoadInProgress<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loadInProgress,
    required TResult Function() deleted,
    required TResult Function(KtList<T> entityList) loadSuccess,
    required TResult Function(CrudFailure failure) loadFailure,
  }) {
    return loadInProgress();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loadInProgress,
    TResult Function()? deleted,
    TResult Function(KtList<T> entityList)? loadSuccess,
    TResult Function(CrudFailure failure)? loadFailure,
    required TResult orElse(),
  }) {
    if (loadInProgress != null) {
      return loadInProgress();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial<T> value) initial,
    required TResult Function(LoadInProgress<T> value) loadInProgress,
    required TResult Function(Deleted<T> value) deleted,
    required TResult Function(LoadSuccess<T> value) loadSuccess,
    required TResult Function(LoadFailure<T> value) loadFailure,
  }) {
    return loadInProgress(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial<T> value)? initial,
    TResult Function(LoadInProgress<T> value)? loadInProgress,
    TResult Function(Deleted<T> value)? deleted,
    TResult Function(LoadSuccess<T> value)? loadSuccess,
    TResult Function(LoadFailure<T> value)? loadFailure,
    required TResult orElse(),
  }) {
    if (loadInProgress != null) {
      return loadInProgress(this);
    }
    return orElse();
  }
}

abstract class LoadInProgress<T extends Entity<dynamic>>
    implements EntityWatcherState<T> {
  const factory LoadInProgress() = _$LoadInProgress<T>;
}

/// @nodoc
abstract class $DeletedCopyWith<T extends Entity<dynamic>, $Res> {
  factory $DeletedCopyWith(Deleted<T> value, $Res Function(Deleted<T>) then) =
      _$DeletedCopyWithImpl<T, $Res>;
}

/// @nodoc
class _$DeletedCopyWithImpl<T extends Entity<dynamic>, $Res>
    extends _$EntityWatcherStateCopyWithImpl<T, $Res>
    implements $DeletedCopyWith<T, $Res> {
  _$DeletedCopyWithImpl(Deleted<T> _value, $Res Function(Deleted<T>) _then)
      : super(_value, (v) => _then(v as Deleted<T>));

  @override
  Deleted<T> get _value => super._value as Deleted<T>;
}

/// @nodoc

class _$Deleted<T extends Entity<dynamic>> implements Deleted<T> {
  const _$Deleted();

  @override
  String toString() {
    return 'EntityWatcherState<$T>.deleted()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is Deleted<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loadInProgress,
    required TResult Function() deleted,
    required TResult Function(KtList<T> entityList) loadSuccess,
    required TResult Function(CrudFailure failure) loadFailure,
  }) {
    return deleted();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loadInProgress,
    TResult Function()? deleted,
    TResult Function(KtList<T> entityList)? loadSuccess,
    TResult Function(CrudFailure failure)? loadFailure,
    required TResult orElse(),
  }) {
    if (deleted != null) {
      return deleted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial<T> value) initial,
    required TResult Function(LoadInProgress<T> value) loadInProgress,
    required TResult Function(Deleted<T> value) deleted,
    required TResult Function(LoadSuccess<T> value) loadSuccess,
    required TResult Function(LoadFailure<T> value) loadFailure,
  }) {
    return deleted(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial<T> value)? initial,
    TResult Function(LoadInProgress<T> value)? loadInProgress,
    TResult Function(Deleted<T> value)? deleted,
    TResult Function(LoadSuccess<T> value)? loadSuccess,
    TResult Function(LoadFailure<T> value)? loadFailure,
    required TResult orElse(),
  }) {
    if (deleted != null) {
      return deleted(this);
    }
    return orElse();
  }
}

abstract class Deleted<T extends Entity<dynamic>>
    implements EntityWatcherState<T> {
  const factory Deleted() = _$Deleted<T>;
}

/// @nodoc
abstract class $LoadSuccessCopyWith<T extends Entity<dynamic>, $Res> {
  factory $LoadSuccessCopyWith(
          LoadSuccess<T> value, $Res Function(LoadSuccess<T>) then) =
      _$LoadSuccessCopyWithImpl<T, $Res>;
  $Res call({KtList<T> entityList});
}

/// @nodoc
class _$LoadSuccessCopyWithImpl<T extends Entity<dynamic>, $Res>
    extends _$EntityWatcherStateCopyWithImpl<T, $Res>
    implements $LoadSuccessCopyWith<T, $Res> {
  _$LoadSuccessCopyWithImpl(
      LoadSuccess<T> _value, $Res Function(LoadSuccess<T>) _then)
      : super(_value, (v) => _then(v as LoadSuccess<T>));

  @override
  LoadSuccess<T> get _value => super._value as LoadSuccess<T>;

  @override
  $Res call({
    Object? entityList = freezed,
  }) {
    return _then(LoadSuccess<T>(
      entityList == freezed
          ? _value.entityList
          : entityList // ignore: cast_nullable_to_non_nullable
              as KtList<T>,
    ));
  }
}

/// @nodoc

class _$LoadSuccess<T extends Entity<dynamic>> implements LoadSuccess<T> {
  const _$LoadSuccess(this.entityList);

  @override
  final KtList<T> entityList;

  @override
  String toString() {
    return 'EntityWatcherState<$T>.loadSuccess(entityList: $entityList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is LoadSuccess<T> &&
            (identical(other.entityList, entityList) ||
                const DeepCollectionEquality()
                    .equals(other.entityList, entityList)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(entityList);

  @JsonKey(ignore: true)
  @override
  $LoadSuccessCopyWith<T, LoadSuccess<T>> get copyWith =>
      _$LoadSuccessCopyWithImpl<T, LoadSuccess<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loadInProgress,
    required TResult Function() deleted,
    required TResult Function(KtList<T> entityList) loadSuccess,
    required TResult Function(CrudFailure failure) loadFailure,
  }) {
    return loadSuccess(entityList);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loadInProgress,
    TResult Function()? deleted,
    TResult Function(KtList<T> entityList)? loadSuccess,
    TResult Function(CrudFailure failure)? loadFailure,
    required TResult orElse(),
  }) {
    if (loadSuccess != null) {
      return loadSuccess(entityList);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial<T> value) initial,
    required TResult Function(LoadInProgress<T> value) loadInProgress,
    required TResult Function(Deleted<T> value) deleted,
    required TResult Function(LoadSuccess<T> value) loadSuccess,
    required TResult Function(LoadFailure<T> value) loadFailure,
  }) {
    return loadSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial<T> value)? initial,
    TResult Function(LoadInProgress<T> value)? loadInProgress,
    TResult Function(Deleted<T> value)? deleted,
    TResult Function(LoadSuccess<T> value)? loadSuccess,
    TResult Function(LoadFailure<T> value)? loadFailure,
    required TResult orElse(),
  }) {
    if (loadSuccess != null) {
      return loadSuccess(this);
    }
    return orElse();
  }
}

abstract class LoadSuccess<T extends Entity<dynamic>>
    implements EntityWatcherState<T> {
  const factory LoadSuccess(KtList<T> entityList) = _$LoadSuccess<T>;

  KtList<T> get entityList => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LoadSuccessCopyWith<T, LoadSuccess<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoadFailureCopyWith<T extends Entity<dynamic>, $Res> {
  factory $LoadFailureCopyWith(
          LoadFailure<T> value, $Res Function(LoadFailure<T>) then) =
      _$LoadFailureCopyWithImpl<T, $Res>;
  $Res call({CrudFailure failure});

  $CrudFailureCopyWith<$Res> get failure;
}

/// @nodoc
class _$LoadFailureCopyWithImpl<T extends Entity<dynamic>, $Res>
    extends _$EntityWatcherStateCopyWithImpl<T, $Res>
    implements $LoadFailureCopyWith<T, $Res> {
  _$LoadFailureCopyWithImpl(
      LoadFailure<T> _value, $Res Function(LoadFailure<T>) _then)
      : super(_value, (v) => _then(v as LoadFailure<T>));

  @override
  LoadFailure<T> get _value => super._value as LoadFailure<T>;

  @override
  $Res call({
    Object? failure = freezed,
  }) {
    return _then(LoadFailure<T>(
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

class _$LoadFailure<T extends Entity<dynamic>> implements LoadFailure<T> {
  const _$LoadFailure(this.failure);

  @override
  final CrudFailure failure;

  @override
  String toString() {
    return 'EntityWatcherState<$T>.loadFailure(failure: $failure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is LoadFailure<T> &&
            (identical(other.failure, failure) ||
                const DeepCollectionEquality().equals(other.failure, failure)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(failure);

  @JsonKey(ignore: true)
  @override
  $LoadFailureCopyWith<T, LoadFailure<T>> get copyWith =>
      _$LoadFailureCopyWithImpl<T, LoadFailure<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loadInProgress,
    required TResult Function() deleted,
    required TResult Function(KtList<T> entityList) loadSuccess,
    required TResult Function(CrudFailure failure) loadFailure,
  }) {
    return loadFailure(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loadInProgress,
    TResult Function()? deleted,
    TResult Function(KtList<T> entityList)? loadSuccess,
    TResult Function(CrudFailure failure)? loadFailure,
    required TResult orElse(),
  }) {
    if (loadFailure != null) {
      return loadFailure(failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial<T> value) initial,
    required TResult Function(LoadInProgress<T> value) loadInProgress,
    required TResult Function(Deleted<T> value) deleted,
    required TResult Function(LoadSuccess<T> value) loadSuccess,
    required TResult Function(LoadFailure<T> value) loadFailure,
  }) {
    return loadFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial<T> value)? initial,
    TResult Function(LoadInProgress<T> value)? loadInProgress,
    TResult Function(Deleted<T> value)? deleted,
    TResult Function(LoadSuccess<T> value)? loadSuccess,
    TResult Function(LoadFailure<T> value)? loadFailure,
    required TResult orElse(),
  }) {
    if (loadFailure != null) {
      return loadFailure(this);
    }
    return orElse();
  }
}

abstract class LoadFailure<T extends Entity<dynamic>>
    implements EntityWatcherState<T> {
  const factory LoadFailure(CrudFailure failure) = _$LoadFailure<T>;

  CrudFailure get failure => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LoadFailureCopyWith<T, LoadFailure<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
