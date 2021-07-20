part of 'settings_bloc.dart';

@freezed
class SettingsEvent with _$SettingsEvent {
  const factory SettingsEvent.initialized({String? localeAsString}) =
      _Initialized;
  const factory SettingsEvent.savedToSharedPreferences(Locale locale) =
      _LocaleChanged;
}
