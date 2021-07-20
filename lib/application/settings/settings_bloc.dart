// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_bloc.freezed.dart';
part 'settings_event.dart';
part 'settings_state.dart';

const LOCALE = 'LOCALE';

@lazySingleton
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SharedPreferences prefs;

  SettingsBloc(
    this.prefs,
  ) : super(SettingsState.initial());

  @override
  Stream<SettingsState> mapEventToState(
    SettingsEvent event,
  ) async* {
    yield* event.map(
      initialized: (e) async* {
        yield state.copyWith(
            appLocale:
                e.localeAsString != null ? Locale(e.localeAsString!) : null);
      },
      savedToSharedPreferences: (e) async* {
        await prefs.setString(LOCALE, e.locale.toString());
        yield state.copyWith(appLocale: e.locale);
      },
    );
  }
}
