// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'translation_editor_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$TranslationEditorStateTearOff {
  const _$TranslationEditorStateTearOff();

  _TranslationEditorState<V> call<V extends StringValueObject<dynamic>>(
      {required V? translation,
      required bool saved,
      required bool showErrorMessages,
      required LanguageCode selectedLanguageCode}) {
    return _TranslationEditorState<V>(
      translation: translation,
      saved: saved,
      showErrorMessages: showErrorMessages,
      selectedLanguageCode: selectedLanguageCode,
    );
  }
}

/// @nodoc
const $TranslationEditorState = _$TranslationEditorStateTearOff();

/// @nodoc
mixin _$TranslationEditorState<V extends StringValueObject<dynamic>> {
  V? get translation => throw _privateConstructorUsedError;
  bool get saved => throw _privateConstructorUsedError;
  bool get showErrorMessages => throw _privateConstructorUsedError;
  LanguageCode get selectedLanguageCode => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TranslationEditorStateCopyWith<V, TranslationEditorState<V>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TranslationEditorStateCopyWith<
    V extends StringValueObject<dynamic>, $Res> {
  factory $TranslationEditorStateCopyWith(TranslationEditorState<V> value,
          $Res Function(TranslationEditorState<V>) then) =
      _$TranslationEditorStateCopyWithImpl<V, $Res>;
  $Res call(
      {V? translation,
      bool saved,
      bool showErrorMessages,
      LanguageCode selectedLanguageCode});
}

/// @nodoc
class _$TranslationEditorStateCopyWithImpl<V extends StringValueObject<dynamic>,
    $Res> implements $TranslationEditorStateCopyWith<V, $Res> {
  _$TranslationEditorStateCopyWithImpl(this._value, this._then);

  final TranslationEditorState<V> _value;
  // ignore: unused_field
  final $Res Function(TranslationEditorState<V>) _then;

  @override
  $Res call({
    Object? translation = freezed,
    Object? saved = freezed,
    Object? showErrorMessages = freezed,
    Object? selectedLanguageCode = freezed,
  }) {
    return _then(_value.copyWith(
      translation: translation == freezed
          ? _value.translation
          : translation // ignore: cast_nullable_to_non_nullable
              as V?,
      saved: saved == freezed
          ? _value.saved
          : saved // ignore: cast_nullable_to_non_nullable
              as bool,
      showErrorMessages: showErrorMessages == freezed
          ? _value.showErrorMessages
          : showErrorMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedLanguageCode: selectedLanguageCode == freezed
          ? _value.selectedLanguageCode
          : selectedLanguageCode // ignore: cast_nullable_to_non_nullable
              as LanguageCode,
    ));
  }
}

/// @nodoc
abstract class _$TranslationEditorStateCopyWith<
    V extends StringValueObject<dynamic>,
    $Res> implements $TranslationEditorStateCopyWith<V, $Res> {
  factory _$TranslationEditorStateCopyWith(_TranslationEditorState<V> value,
          $Res Function(_TranslationEditorState<V>) then) =
      __$TranslationEditorStateCopyWithImpl<V, $Res>;
  @override
  $Res call(
      {V? translation,
      bool saved,
      bool showErrorMessages,
      LanguageCode selectedLanguageCode});
}

/// @nodoc
class __$TranslationEditorStateCopyWithImpl<
        V extends StringValueObject<dynamic>,
        $Res> extends _$TranslationEditorStateCopyWithImpl<V, $Res>
    implements _$TranslationEditorStateCopyWith<V, $Res> {
  __$TranslationEditorStateCopyWithImpl(_TranslationEditorState<V> _value,
      $Res Function(_TranslationEditorState<V>) _then)
      : super(_value, (v) => _then(v as _TranslationEditorState<V>));

  @override
  _TranslationEditorState<V> get _value =>
      super._value as _TranslationEditorState<V>;

  @override
  $Res call({
    Object? translation = freezed,
    Object? saved = freezed,
    Object? showErrorMessages = freezed,
    Object? selectedLanguageCode = freezed,
  }) {
    return _then(_TranslationEditorState<V>(
      translation: translation == freezed
          ? _value.translation
          : translation // ignore: cast_nullable_to_non_nullable
              as V?,
      saved: saved == freezed
          ? _value.saved
          : saved // ignore: cast_nullable_to_non_nullable
              as bool,
      showErrorMessages: showErrorMessages == freezed
          ? _value.showErrorMessages
          : showErrorMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedLanguageCode: selectedLanguageCode == freezed
          ? _value.selectedLanguageCode
          : selectedLanguageCode // ignore: cast_nullable_to_non_nullable
              as LanguageCode,
    ));
  }
}

/// @nodoc

class _$_TranslationEditorState<V extends StringValueObject<dynamic>>
    with DiagnosticableTreeMixin
    implements _TranslationEditorState<V> {
  const _$_TranslationEditorState(
      {required this.translation,
      required this.saved,
      required this.showErrorMessages,
      required this.selectedLanguageCode});

  @override
  final V? translation;
  @override
  final bool saved;
  @override
  final bool showErrorMessages;
  @override
  final LanguageCode selectedLanguageCode;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TranslationEditorState<$V>(translation: $translation, saved: $saved, showErrorMessages: $showErrorMessages, selectedLanguageCode: $selectedLanguageCode)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TranslationEditorState<$V>'))
      ..add(DiagnosticsProperty('translation', translation))
      ..add(DiagnosticsProperty('saved', saved))
      ..add(DiagnosticsProperty('showErrorMessages', showErrorMessages))
      ..add(DiagnosticsProperty('selectedLanguageCode', selectedLanguageCode));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _TranslationEditorState<V> &&
            (identical(other.translation, translation) ||
                const DeepCollectionEquality()
                    .equals(other.translation, translation)) &&
            (identical(other.saved, saved) ||
                const DeepCollectionEquality().equals(other.saved, saved)) &&
            (identical(other.showErrorMessages, showErrorMessages) ||
                const DeepCollectionEquality()
                    .equals(other.showErrorMessages, showErrorMessages)) &&
            (identical(other.selectedLanguageCode, selectedLanguageCode) ||
                const DeepCollectionEquality()
                    .equals(other.selectedLanguageCode, selectedLanguageCode)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(translation) ^
      const DeepCollectionEquality().hash(saved) ^
      const DeepCollectionEquality().hash(showErrorMessages) ^
      const DeepCollectionEquality().hash(selectedLanguageCode);

  @JsonKey(ignore: true)
  @override
  _$TranslationEditorStateCopyWith<V, _TranslationEditorState<V>>
      get copyWith =>
          __$TranslationEditorStateCopyWithImpl<V, _TranslationEditorState<V>>(
              this, _$identity);
}

abstract class _TranslationEditorState<V extends StringValueObject<dynamic>>
    implements TranslationEditorState<V> {
  const factory _TranslationEditorState(
          {required V? translation,
          required bool saved,
          required bool showErrorMessages,
          required LanguageCode selectedLanguageCode}) =
      _$_TranslationEditorState<V>;

  @override
  V? get translation => throw _privateConstructorUsedError;
  @override
  bool get saved => throw _privateConstructorUsedError;
  @override
  bool get showErrorMessages => throw _privateConstructorUsedError;
  @override
  LanguageCode get selectedLanguageCode => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$TranslationEditorStateCopyWith<V, _TranslationEditorState<V>>
      get copyWith => throw _privateConstructorUsedError;
}
