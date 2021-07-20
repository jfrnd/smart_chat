// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'subscription_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$SubscriptionStatusTearOff {
  const _$SubscriptionStatusTearOff();

  Active active() {
    return const Active();
  }

  Inactive inactive() {
    return const Inactive();
  }
}

/// @nodoc
const $SubscriptionStatus = _$SubscriptionStatusTearOff();

/// @nodoc
mixin _$SubscriptionStatus {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() active,
    required TResult Function() inactive,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? active,
    TResult Function()? inactive,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Active value) active,
    required TResult Function(Inactive value) inactive,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Active value)? active,
    TResult Function(Inactive value)? inactive,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscriptionStatusCopyWith<$Res> {
  factory $SubscriptionStatusCopyWith(
          SubscriptionStatus value, $Res Function(SubscriptionStatus) then) =
      _$SubscriptionStatusCopyWithImpl<$Res>;
}

/// @nodoc
class _$SubscriptionStatusCopyWithImpl<$Res>
    implements $SubscriptionStatusCopyWith<$Res> {
  _$SubscriptionStatusCopyWithImpl(this._value, this._then);

  final SubscriptionStatus _value;
  // ignore: unused_field
  final $Res Function(SubscriptionStatus) _then;
}

/// @nodoc
abstract class $ActiveCopyWith<$Res> {
  factory $ActiveCopyWith(Active value, $Res Function(Active) then) =
      _$ActiveCopyWithImpl<$Res>;
}

/// @nodoc
class _$ActiveCopyWithImpl<$Res> extends _$SubscriptionStatusCopyWithImpl<$Res>
    implements $ActiveCopyWith<$Res> {
  _$ActiveCopyWithImpl(Active _value, $Res Function(Active) _then)
      : super(_value, (v) => _then(v as Active));

  @override
  Active get _value => super._value as Active;
}

/// @nodoc

class _$Active implements Active {
  const _$Active();

  @override
  String toString() {
    return 'SubscriptionStatus.active()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is Active);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() active,
    required TResult Function() inactive,
  }) {
    return active();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? active,
    TResult Function()? inactive,
    required TResult orElse(),
  }) {
    if (active != null) {
      return active();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Active value) active,
    required TResult Function(Inactive value) inactive,
  }) {
    return active(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Active value)? active,
    TResult Function(Inactive value)? inactive,
    required TResult orElse(),
  }) {
    if (active != null) {
      return active(this);
    }
    return orElse();
  }
}

abstract class Active implements SubscriptionStatus {
  const factory Active() = _$Active;
}

/// @nodoc
abstract class $InactiveCopyWith<$Res> {
  factory $InactiveCopyWith(Inactive value, $Res Function(Inactive) then) =
      _$InactiveCopyWithImpl<$Res>;
}

/// @nodoc
class _$InactiveCopyWithImpl<$Res>
    extends _$SubscriptionStatusCopyWithImpl<$Res>
    implements $InactiveCopyWith<$Res> {
  _$InactiveCopyWithImpl(Inactive _value, $Res Function(Inactive) _then)
      : super(_value, (v) => _then(v as Inactive));

  @override
  Inactive get _value => super._value as Inactive;
}

/// @nodoc

class _$Inactive implements Inactive {
  const _$Inactive();

  @override
  String toString() {
    return 'SubscriptionStatus.inactive()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is Inactive);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() active,
    required TResult Function() inactive,
  }) {
    return inactive();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? active,
    TResult Function()? inactive,
    required TResult orElse(),
  }) {
    if (inactive != null) {
      return inactive();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Active value) active,
    required TResult Function(Inactive value) inactive,
  }) {
    return inactive(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Active value)? active,
    TResult Function(Inactive value)? inactive,
    required TResult orElse(),
  }) {
    if (inactive != null) {
      return inactive(this);
    }
    return orElse();
  }
}

abstract class Inactive implements SubscriptionStatus {
  const factory Inactive() = _$Inactive;
}
