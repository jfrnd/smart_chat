// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:smart_chat/application/settings/language_selector/language_selector_cubit.dart';

void main() {
  late LanguageSelectorCubit cubit;
  setUp(() {
    cubit = LanguageSelectorCubit();
  });

  tearDown(() {
    cubit.close();
  });

  group('localeChanged()', () {
    blocTest(
      'should emit [locale: de]',
      build: () => cubit,
      seed: () => cubit.state.copyWith(locale: const Locale('en')),
      act: (_) => cubit.localeChanged(const Locale('de')),
      expect: () => [cubit.state.copyWith(locale: const Locale('de'))],
    );
  });
}
