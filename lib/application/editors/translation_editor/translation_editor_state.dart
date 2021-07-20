part of 'translation_editor_cubit.dart';

@freezed
class TranslationEditorState<V extends StringValueObject>
    with _$TranslationEditorState<V> {
  const factory TranslationEditorState({
    required V? translation,
    required bool saved,
    required bool showErrorMessages,
    required LanguageCode selectedLanguageCode,
  }) = _TranslationEditorState<V>;

  factory TranslationEditorState.initial({
    V? initTranslation,
    required LanguageCode selectedLanguageCode,
  }) =>
      TranslationEditorState<V>(
        translation: initTranslation,
        saved: false,
        showErrorMessages: false,
        selectedLanguageCode: selectedLanguageCode,
      );
}
