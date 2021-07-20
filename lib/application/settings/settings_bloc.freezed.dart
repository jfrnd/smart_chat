// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'settings_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$SettingsEventTearOff {
  const _$SettingsEventTearOff();

  _Initialized initialized({String? localeAsString}) {
    return _Initialized(
      localeAsString: localeAsString,
    );
  }

  _LocaleChanged savedToSharedPreferences(Locale locale) {
    return _LocaleChanged(
      locale,
    );
  }
}

/// @nodoc
const $SettingsEvent = _$SettingsEventTearOff();

/// @nodoc
mixin _$SettingsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? localeAsString) initialized,
    required TResult Function(Locale locale) savedToSharedPreferences,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? localeAsString)? initialized,
    TResult Function(Locale locale)? savedToSharedPreferences,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initialized value) initialized,
    required TResult Function(_LocaleChanged value) savedToSharedPreferences,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initialized value)? initialized,
    TResult Function(_LocaleChanged value)? savedToSharedPreferences,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsEventCopyWith<$Res> {
  factory $SettingsEventCopyWith(
          SettingsEvent value, $Res Function(SettingsEvent) then) =
      _$SettingsEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$SettingsEventCopyWithImpl<$Res>
    implements $SettingsEventCopyWith<$Res> {
  _$SettingsEventCopyWithImpl(this._value, this._then);

  final SettingsEvent _value;
  // ignore: unused_field
  final $Res Function(SettingsEvent) _then;
}

/// @nodoc
abstract class _$InitializedCopyWith<$Res> {
  factory _$InitializedCopyWith(
          _Initialized value, $Res Function(_Initialized) then) =
      __$InitializedCopyWithImpl<$Res>;
  $Res call({String? localeAsString});
}

/// @nodoc
class __$InitializedCopyWithImpl<$Res> extends _$SettingsEventCopyWithImpl<$Res>
    implements _$InitializedCopyWith<$Res> {
  __$InitializedCopyWithImpl(
      _Initialized _value, $Res Function(_Initialized) _then)
      : super(_value, (v) => _then(v as _Initialized));

  @override
  _Initialized get _value => super._value as _Initialized;

  @override
  $Res call({
    Object? localeAsString = freezed,
  }) {
    return _then(_Initialized(
      localeAsString: localeAsString == freezed
          ? _value.localeAsString
          : localeAsString // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_Initialized implements _Initialized {
  const _$_Initialized({this.localeAsString});

  @override
  final String? localeAsString;

  @override
  String toString() {
    return 'SettingsEvent.initialized(localeAsString: $localeAsString)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Initialized &&
            (identical(other.localeAsString, localeAsString) ||
                const DeepCollectionEquality()
                    .equals(other.localeAsString, localeAsString)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(localeAsString);

  @JsonKey(ignore: true)
  @override
  _$InitializedCopyWith<_Initialized> get copyWith =>
      __$InitializedCopyWithImpl<_Initialized>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? localeAsString) initialized,
    required TResult Function(Locale locale) savedToSharedPreferences,
  }) {
    return initialized(localeAsString);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? localeAsString)? initialized,
    TResult Function(Locale locale)? savedToSharedPreferences,
    required TResult orElse(),
  }) {
    if (initialized != null) {
      return initialized(localeAsString);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initialized value) initialized,
    required TResult Function(_LocaleChanged value) savedToSharedPreferences,
  }) {
    return initialized(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initialized value)? initialized,
    TResult Function(_LocaleChanged value)? savedToSharedPreferences,
    required TResult orElse(),
  }) {
    if (initialized != null) {
      return initialized(this);
    }
    return orElse();
  }
}

abstract class _Initialized implements SettingsEvent {
  const factory _Initialized({String? localeAsString}) = _$_Initialized;

  String? get localeAsString => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$InitializedCopyWith<_Initialized> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$LocaleChangedCopyWith<$Res> {
  factory _$LocaleChangedCopyWith(
          _LocaleChanged value, $Res Function(_LocaleChanged) then) =
      __$LocaleChangedCopyWithImpl<$Res>;
  $Res call({Locale locale});
}

/// @nodoc
class __$LocaleChangedCopyWithImpl<$Res>
    extends _$SettingsEventCopyWithImpl<$Res>
    implements _$LocaleChangedCopyWith<$Res> {
  __$LocaleChangedCopyWithImpl(
      _LocaleChanged _value, $Res Function(_LocaleChanged) _then)
      : super(_value, (v) => _then(v as _LocaleChanged));

  @override
  _LocaleChanged get _value => super._value as _LocaleChanged;

  @override
  $Res call({
    Object? locale = freezed,
  }) {
    return _then(_LocaleChanged(
      locale == freezed
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as Locale,
    ));
  }
}

/// @nodoc

class _$_LocaleChanged implements _LocaleChanged {
  const _$_LocaleChanged(this.locale);

  @override
  final Locale locale;

  @override
  String toString() {
    return 'SettingsEvent.savedToSharedPreferences(locale: $locale)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _LocaleChanged &&
            (identical(other.locale, locale) ||
                const DeepCollectionEquality().equals(other.locale, locale)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(locale);

  @JsonKey(ignore: true)
  @override
  _$LocaleChangedCopyWith<_LocaleChanged> get copyWith =>
      __$LocaleChangedCopyWithImpl<_LocaleChanged>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? localeAsString) initialized,
    required TResult Function(Locale locale) savedToSharedPreferences,
  }) {
    return savedToSharedPreferences(locale);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? localeAsString)? initialized,
    TResult Function(Locale locale)? savedToSharedPreferences,
    required TResult orElse(),
  }) {
    if (savedToSharedPreferences != null) {
      return savedToSharedPreferences(locale);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initialized value) initialized,
    required TResult Function(_LocaleChanged value) savedToSharedPreferences,
  }) {
    return savedToSharedPreferences(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initialized value)? initialized,
    TResult Function(_LocaleChanged value)? savedToSharedPreferences,
    required TResult orElse(),
  }) {
    if (savedToSharedPreferences != null) {
      return savedToSharedPreferences(this);
    }
    return orElse();
  }
}

abstract class _LocaleChanged implements SettingsEvent {
  const factory _LocaleChanged(Locale locale) = _$_LocaleChanged;

  Locale get locale => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$LocaleChangedCopyWith<_LocaleChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$SettingsStateTearOff {
  const _$SettingsStateTearOff();

  _SettingsState call({required Locale? appLocale}) {
    return _SettingsState(
      appLocale: appLocale,
    );
  }
}

/// @nodoc
const $SettingsState = _$SettingsStateTearOff();

/// @nodoc
mixin _$SettingsState {
  Locale? get appLocale => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SettingsStateCopyWith<SettingsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsStateCopyWith<$Res> {
  factory $SettingsStateCopyWith(
          SettingsState value, $Res Function(SettingsState) then) =
      _$SettingsStateCopyWithImpl<$Res>;
  $Res call({Locale? appLocale});
}

/// @nodoc
class _$SettingsStateCopyWithImpl<$Res>
    implements $SettingsStateCopyWith<$Res> {
  _$SettingsStateCopyWithImpl(this._value, this._then);

  final SettingsState _value;
  // ignore: unused_field
  final $Res Function(SettingsState) _then;

  @override
  $Res call({
    Object? appLocale = freezed,
  }) {
    return _then(_value.copyWith(
      appLocale: appLocale == freezed
          ? _value.appLocale
          : appLocale // ignore: cast_nullable_to_non_nullable
              as Locale?,
    ));
  }
}

/// @nodoc
abstract class _$SettingsStateCopyWith<$Res>
    implements $SettingsStateCopyWith<$Res> {
  factory _$SettingsStateCopyWith(
          _SettingsState value, $Res Function(_SettingsState) then) =
      __$SettingsStateCopyWithImpl<$Res>;
  @override
  $Res call({Locale? appLocale});
}

/// @nodoc
class __$SettingsStateCopyWithImpl<$Res>
    extends _$SettingsStateCopyWithImpl<$Res>
    implements _$SettingsStateCopyWith<$Res> {
  __$SettingsStateCopyWithImpl(
      _SettingsState _value, $Res Function(_SettingsState) _then)
      : super(_value, (v) => _then(v as _SettingsState));

  @override
  _SettingsState get _value => super._value as _SettingsState;

  @override
  $Res call({
    Object? appLocale = freezed,
  }) {
    return _then(_SettingsState(
      appLocale: appLocale == freezed
          ? _value.appLocale
          : appLocale // ignore: cast_nullable_to_non_nullable
              as Locale?,
    ));
  }
}

/// @nodoc

class _$_SettingsState implements _SettingsState {
  const _$_SettingsState({required this.appLocale});

  @override
  final Locale? appLocale;

  @override
  String toString() {
    return 'SettingsState(appLocale: $appLocale)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SettingsState &&
            (identical(other.appLocale, appLocale) ||
                const DeepCollectionEquality()
                    .equals(other.appLocale, appLocale)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(appLocale);

  @JsonKey(ignore: true)
  @override
  _$SettingsStateCopyWith<_SettingsState> get copyWith =>
      __$SettingsStateCopyWithImpl<_SettingsState>(this, _$identity);
}

abstract class _SettingsState implements SettingsState {
  const factory _SettingsState({required Locale? appLocale}) = _$_SettingsState;

  @override
  Locale? get appLocale => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$SettingsStateCopyWith<_SettingsState> get copyWith =>
      throw _privateConstructorUsedError;
}
