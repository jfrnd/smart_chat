part of 'language_selector_cubit.dart';

@freezed
class LanguageSelectorState with _$LanguageSelectorState {
  const factory LanguageSelectorState({required Locale locale}) = _LanguageSelectorState;

  factory LanguageSelectorState.initial() => const LanguageSelectorState(
    locale: Locale('en'),

      );
}
