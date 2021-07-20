// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:smart_chat/application/settings/settings_bloc.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences prefs;
  late SettingsBloc bloc;
  setUp(() {
    prefs = MockSharedPreferences();
    bloc = SettingsBloc(prefs);
  });

  tearDown(() {
    bloc.close();
  });

  group('initialized()', () {
    blocTest(
      'should emit [appLocale: null]',
      build: () => bloc,
      act: (_) => bloc.add(const SettingsEvent.initialized()),
      expect: () => [
        bloc.state.copyWith(appLocale: null),
      ],
    );

    blocTest(
      'should emit [appLocale: en]',
      build: () => bloc,
      act: (_) =>
          bloc.add(const SettingsEvent.initialized(localeAsString: 'en')),
      expect: () => [
        bloc.state.copyWith(appLocale: const Locale('en')),
      ],
    );
  });

  group('savedToSharedPreferences()', () {
    blocTest('''
    should save locale in shared prefereneces
    (call sharedPreferences.setString(LOCALE, en))
    and emit [appLocale: en]''',
        build: () {
          when(() => prefs.setString(any(), any()))
              .thenAnswer((invocation) async => true);
          return bloc;
        },
        act: (_) => bloc
            .add(const SettingsEvent.savedToSharedPreferences(Locale('en'))),
        expect: () => [
              bloc.state.copyWith(appLocale: const Locale('en')),
            ],
        verify: (_) => verify(() => prefs.setString(LOCALE, 'en')));
  });
}
