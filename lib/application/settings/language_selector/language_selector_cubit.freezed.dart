// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'language_selector_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$LanguageSelectorStateTearOff {
  const _$LanguageSelectorStateTearOff();

  _LanguageSelectorState call({required Locale locale}) {
    return _LanguageSelectorState(
      locale: locale,
    );
  }
}

/// @nodoc
const $LanguageSelectorState = _$LanguageSelectorStateTearOff();

/// @nodoc
mixin _$LanguageSelectorState {
  Locale get locale => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LanguageSelectorStateCopyWith<LanguageSelectorState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LanguageSelectorStateCopyWith<$Res> {
  factory $LanguageSelectorStateCopyWith(LanguageSelectorState value,
          $Res Function(LanguageSelectorState) then) =
      _$LanguageSelectorStateCopyWithImpl<$Res>;
  $Res call({Locale locale});
}

/// @nodoc
class _$LanguageSelectorStateCopyWithImpl<$Res>
    implements $LanguageSelectorStateCopyWith<$Res> {
  _$LanguageSelectorStateCopyWithImpl(this._value, this._then);

  final LanguageSelectorState _value;
  // ignore: unused_field
  final $Res Function(LanguageSelectorState) _then;

  @override
  $Res call({
    Object? locale = freezed,
  }) {
    return _then(_value.copyWith(
      locale: locale == freezed
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as Locale,
    ));
  }
}

/// @nodoc
abstract class _$LanguageSelectorStateCopyWith<$Res>
    implements $LanguageSelectorStateCopyWith<$Res> {
  factory _$LanguageSelectorStateCopyWith(_LanguageSelectorState value,
          $Res Function(_LanguageSelectorState) then) =
      __$LanguageSelectorStateCopyWithImpl<$Res>;
  @override
  $Res call({Locale locale});
}

/// @nodoc
class __$LanguageSelectorStateCopyWithImpl<$Res>
    extends _$LanguageSelectorStateCopyWithImpl<$Res>
    implements _$LanguageSelectorStateCopyWith<$Res> {
  __$LanguageSelectorStateCopyWithImpl(_LanguageSelectorState _value,
      $Res Function(_LanguageSelectorState) _then)
      : super(_value, (v) => _then(v as _LanguageSelectorState));

  @override
  _LanguageSelectorState get _value => super._value as _LanguageSelectorState;

  @override
  $Res call({
    Object? locale = freezed,
  }) {
    return _then(_LanguageSelectorState(
      locale: locale == freezed
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as Locale,
    ));
  }
}

/// @nodoc

class _$_LanguageSelectorState implements _LanguageSelectorState {
  const _$_LanguageSelectorState({required this.locale});

  @override
  final Locale locale;

  @override
  String toString() {
    return 'LanguageSelectorState(locale: $locale)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _LanguageSelectorState &&
            (identical(other.locale, locale) ||
                const DeepCollectionEquality().equals(other.locale, locale)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(locale);

  @JsonKey(ignore: true)
  @override
  _$LanguageSelectorStateCopyWith<_LanguageSelectorState> get copyWith =>
      __$LanguageSelectorStateCopyWithImpl<_LanguageSelectorState>(
          this, _$identity);
}

abstract class _LanguageSelectorState implements LanguageSelectorState {
  const factory _LanguageSelectorState({required Locale locale}) =
      _$_LanguageSelectorState;

  @override
  Locale get locale => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$LanguageSelectorStateCopyWith<_LanguageSelectorState> get copyWith =>
      throw _privateConstructorUsedError;
}
