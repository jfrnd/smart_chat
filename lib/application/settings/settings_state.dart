part of 'settings_bloc.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState({
    required Locale? appLocale,
  }) = _SettingsState;

  factory SettingsState.initial() =>
      const SettingsState(appLocale: null);
}
