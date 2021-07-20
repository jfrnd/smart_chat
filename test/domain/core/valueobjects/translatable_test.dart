// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kt_dart/kt.dart';
import 'package:matcher/matcher.dart';

// Project imports:
import 'package:smart_chat/domain/core/errors.dart';
import 'package:smart_chat/domain/core/valueobjects/language_code.dart';
import 'package:smart_chat/domain/core/valueobjects/translatable.dart';
import 'package:smart_chat/domain/entities/chatbot/chatbot_name.dart';

void main() {
  const validNameEN = 'validNameEN';
  const validNameDE = 'validNameDE';
  const validNameZH = 'validNameZH';

  final validEntryEN = MapEntry(LanguageCode.en(), ChatBotName(validNameEN));
  final validEntryDE = MapEntry(LanguageCode.de(), ChatBotName(validNameDE));
  final validEntryZH = MapEntry(LanguageCode.zh(), ChatBotName(validNameZH));
  final emptyEntry = MapEntry(LanguageCode.fr(), ChatBotName.empty());
  final invalidEntry =
      MapEntry(LanguageCode.it(), ChatBotName('Multi \n line'));

  group('instantiation', () {
    test(
      '''should instantiate as EmptyTranslatable 
      when input has no entry''',
      () {
        // act
        final result = Translatable<ChatBotName>.empty();
        // assert
        expect(result.getFailureOrCrash(), isA<EmptyTranslatable>());
        expect(
            result.value, equals(const Left(EmptyTranslatable<ChatBotName>())));
      },
    );
    test(
      '''should instantiate as EmptyTranslatable 
      when input has only empty entries''',
      () {
        // act
        final result = Translatable<ChatBotName>(
          mapFrom(Map.fromEntries([emptyEntry])),
        );
        // assert
        expect(result.getFailureOrCrash(), isA<EmptyTranslatable>());
        expect(
            result.value, equals(const Left(EmptyTranslatable<ChatBotName>())));
      },
    );
    test(
      '''should instantiate as InvalidTranslatable
      when input has only invalid entries''',
      () {
        // act
        final result = Translatable<ChatBotName>(
          mapFrom(Map.fromEntries([invalidEntry])),
        );
        // assert
        expect(result.getFailureOrCrash(), isA<InvalidTranslatable>());
        expect(
            result.value,
            equals(Left(InvalidTranslatable(
              mapFrom(Map.fromEntries([invalidEntry])),
            ))));
      },
    );

    test(
      '''should instantiate as InvalidTranslatable when 
      input has invalid and valid entries ''',
      () {
        // act
        final result = Translatable<ChatBotName>(
            mapFrom(Map.fromEntries([invalidEntry, validEntryEN])));
        // assert
        expect(result.getFailureOrCrash(), isA<InvalidTranslatable>());
        expect(
            result.value,
            equals(Left(InvalidTranslatable(mapFrom(Map.fromEntries([
              invalidEntry,
              validEntryEN,
            ]))))));
      },
    );
    test(
      '''should instantiate as InvalidTranslatable when 
      input has invalid and valid entries ''',
      () {
        // act
        final result = Translatable<ChatBotName>(
            mapFrom(Map.fromEntries([invalidEntry, validEntryEN])));
        // assert
        expect(result.getFailureOrCrash(), isA<InvalidTranslatable>());
        expect(
            result.value,
            equals(Left(InvalidTranslatable(
                mapFrom(Map.fromEntries([invalidEntry, validEntryEN]))))));
      },
    );
    test(
      '''should instantiate as InvalidTranslatable 
      when input has invalid, empty and valid entries ''',
      () {
        // act
        final result = Translatable<ChatBotName>(
            mapFrom(Map.fromEntries([invalidEntry, emptyEntry, validEntryEN])));
        // assert
        expect(result.getFailureOrCrash(), isA<InvalidTranslatable>());
        expect(
            result.value,
            equals(Left(InvalidTranslatable(mapFrom(
                Map.fromEntries([invalidEntry, emptyEntry, validEntryEN]))))));
      },
    );
    test(
      '''should instantiate as UntrimmedTranslatable 
      when input has empty and valid entries ''',
      () {
        // act
        final result = Translatable<ChatBotName>(
            mapFrom(Map.fromEntries([emptyEntry, validEntryEN])));
        // assert
        expect(result.getFailureOrCrash(), isA<UntrimmedTranslatable>());
        expect(
            result.value,
            equals(Left(UntrimmedTranslatable(
                mapFrom(Map.fromEntries([emptyEntry, validEntryEN]))))));
      },
    );
    test(
      '''should instantiate as valid Translatable 
      when input has only valid entries ''',
      () {
        // act
        final result = Translatable<ChatBotName>(
            mapFrom(Map.fromEntries([validEntryEN, validEntryDE])));
        // assert
        expect(
            result.value,
            equals(
                Right(mapFrom(Map.fromEntries([validEntryEN, validEntryDE])))));
      },
    );
  });

  group('Equality of valid translatables', () {
    test(
      'Two valid translatables with same values should be equal',
      () {
        // arrange
        final validA = Translatable<ChatBotName>(
            KtMap.from({LanguageCode.en(): ChatBotName('A')}));
        final validB = Translatable<ChatBotName>(
            KtMap.from({LanguageCode.en(): ChatBotName('A')}));
        // act
        final result = validA == validB;
        //assert
        expect(result, equals(true));
      },
    );
    test('Two valid translatables with different values should not be equal',
        () {
      // arrange
      final validA = Translatable<ChatBotName>(
          KtMap.from({LanguageCode.en(): ChatBotName('A')}));
      final validB = Translatable<ChatBotName>(
          KtMap.from({LanguageCode.en(): ChatBotName('B')}));
      // act
      final result = validA == validB;
      //assert
      expect(result, equals(false));
    });
  });

  group('Equality of invalid translatables', () {
    test(
      'One invalid and one valid translatables should not be equal',
      () {
        // arrange
        final valid = Translatable<ChatBotName>(
            KtMap.from({LanguageCode.en(): ChatBotName('A')}));
        final invalid = Translatable<ChatBotName>(
            KtMap.from({LanguageCode.en(): ChatBotName.empty()}));
        // act
        final result = valid == invalid;
        //assert
        expect(result, equals(false));
      },
    );

    test(
      'Two invalid translatables with same ValueFailures should be equal',
      () {
        // arrange
        final invalidA = Translatable<ChatBotName>(
            KtMap.from({LanguageCode.en(): ChatBotName.empty()}));
        final invalidB = Translatable<ChatBotName>(
            KtMap.from({LanguageCode.en(): ChatBotName.empty()}));
        // act
        final result = invalidA == invalidB;

        //assert
        expect(result, equals(true));
      },
    );
    test(
        'Two invalid translatables with different ValueFailures should not be equal',
        () {
      // arrange
      final invalidA = Translatable<ChatBotName>(
          KtMap.from({LanguageCode.en(): ChatBotName.empty()}));
      final invalidB = Translatable<ChatBotName>(
          KtMap.from({LanguageCode.en(): ChatBotName('Multi \n line')}));
      // act
      final result = invalidA == invalidB;
      //assert
      expect(result, equals(false));
    });
  });

  group('Equality of list of valid translatables', () {
    test(
      'Two lists of valid translatables with same values should be equal',
      () {
        // arrange
        final a = listOf(Translatable<ChatBotName>(
            KtMap.from({LanguageCode.en(): ChatBotName('A')})));
        final b = listOf(Translatable<ChatBotName>(
            KtMap.from({LanguageCode.en(): ChatBotName('A')})));
        // act
        final result = a == b;
        //assert
        expect(result, equals(true));
      },
    );
    test(
        'Two lists of valid translatables with different values should not be equal',
        () {
      // arrange
      final a = listOf(Translatable<ChatBotName>(
          KtMap.from({LanguageCode.en(): ChatBotName('A')})));
      final b = listOf(Translatable<ChatBotName>(
          KtMap.from({LanguageCode.en(): ChatBotName('B')})));
      // act
      final result = a == b;
      //assert
      expect(result, equals(false));
    });
  });

  group('Equality of list of invalid translatables', () {
    test(
      'List of invalid and list of valid translatables should not be equal',
      () {
        // arrange
        final a = listOf(Translatable<ChatBotName>(
            KtMap.from({LanguageCode.en(): ChatBotName('A')})));
        final b = listOf(Translatable<ChatBotName>(
            KtMap.from({LanguageCode.en(): ChatBotName.empty()})));
        // act
        final result = a == b;
        //assert
        expect(result, equals(false));
      },
    );

    test(
      'Two lists of invalid translatables with same ValueFailures should be equal',
      () {
        // arrange
        final a = listOf(Translatable<ChatBotName>(
            KtMap.from({LanguageCode.en(): ChatBotName.empty()})));
        final b = listOf(Translatable<ChatBotName>(
            KtMap.from({LanguageCode.en(): ChatBotName.empty()})));
        // act
        final result = a == b;
        //assert
        expect(result, equals(true));
      },
    );
    test(
        'Two lists of invalid translatables with different ValueFailures should not be equal',
        () {
      // arrange
      final a = listOf(Translatable<ChatBotName>(
          KtMap.from({LanguageCode.en(): ChatBotName.empty()})));
      final b = listOf(Translatable<ChatBotName>(
          KtMap.from({LanguageCode.en(): ChatBotName('Multi \n line')})));
      // act
      final result = a == b;
      //assert
      expect(result, equals(false));
    });
  });

  group('convertToRawMapOrCrash()', () {
    test(
      '''should return map of Strings (Map<String, String>)
      when translatable is valid''',
      () {
        // act
        final result = Translatable<ChatBotName>(
                mapFrom(Map.fromEntries([validEntryEN, validEntryDE])))
            .convertToRawMapOrCrash();
        // assert
        expect(result, equals({EN: validNameEN, DE: validNameDE}));
      },
    );
    test('''should crash
        when translatable is invalid''', () {
      // act
      final call = Translatable<ChatBotName>(
              mapFrom(Map.fromEntries([validEntryEN, invalidEntry])))
          .convertToRawMapOrCrash;
      // assert
      expect(() => call(), throwsA(const TypeMatcher<UnexpectedValueError>()));
    });
    test('''should crash
        when translatable is untrimmed''', () {
      // act
      final call = Translatable<ChatBotName>(
              mapFrom(Map.fromEntries([validEntryEN, emptyEntry])))
          .convertToRawMapOrCrash;
      // assert
      expect(() => call(), throwsA(const TypeMatcher<UnexpectedValueError>()));
    });
  });

  group('plus', () {
    test(
      '''should return translatable with an added entry
      when initial translatable is valid''',
      () {
        // act
        final result =
            Translatable<ChatBotName>(mapFrom(Map.fromEntries([validEntryEN])))
                .plus(LanguageCode.zh(), ChatBotName(validNameZH));
        // assert
        expect(
            result,
            equals(Translatable<ChatBotName>(
                mapFrom(Map.fromEntries([validEntryEN, validEntryZH])))));
      },
    );
    test(
      '''should return translatable with an added entry
      when initial translatable is invalid''',
      () {
        // act
        final result = Translatable<ChatBotName>(
                mapFrom(Map.fromEntries([validEntryEN, invalidEntry])))
            .plus(LanguageCode.zh(), ChatBotName(validNameZH));
        // assert
        expect(
            result,
            equals(Translatable<ChatBotName>(mapFrom(
                Map.fromEntries([validEntryEN, invalidEntry, validEntryZH])))));
      },
    );
    test(
      '''should return translatable with an added entry
      when initial translatable is untrimmed''',
      () {
        // act
        final result = Translatable<ChatBotName>(
                mapFrom(Map.fromEntries([validEntryEN, emptyEntry])))
            .plus(LanguageCode.zh(), ChatBotName(validNameZH));
        // assert
        expect(
            result,
            equals(Translatable<ChatBotName>(mapFrom(
                Map.fromEntries([validEntryEN, emptyEntry, validEntryZH])))));
      },
    );
    test(
      '''should return translatable with an added entry
      when initial translatable is empty''',
      () {
        // act
        final result = Translatable<ChatBotName>.empty()
            .plus(LanguageCode.zh(), ChatBotName(validNameZH));
        // assert
        expect(
            result,
            equals(Translatable<ChatBotName>(
                mapFrom(Map.fromEntries([validEntryZH])))));
      },
    );
    test(
      '''should return translatable with an added entry
      when added entry is invalid''',
      () {
        // act
        final result =
            Translatable<ChatBotName>(mapFrom(Map.fromEntries([validEntryEN])))
                .plus(LanguageCode.it(), ChatBotName('Multi \n line'));
        // assert
        expect(
            result,
            equals(Translatable<ChatBotName>(
                mapFrom(Map.fromEntries([validEntryEN, invalidEntry])))));
      },
    );
  });
  group('minus', () {
    test(
      '''should return translatable with removed german translation''',
      () {
        // act
        final result = Translatable<ChatBotName>(
            mapFrom(Map.fromEntries([validEntryEN, validEntryDE]))).minus(
          LanguageCode.de(),
        );
        // assert
        expect(
            result,
            equals(Translatable<ChatBotName>(
                mapFrom(Map.fromEntries([validEntryEN])))));
      },
    );
    test(
      '''should return same translatable when there is only one translation left''',
      () {
        // act
        final result =
            Translatable<ChatBotName>(mapFrom(Map.fromEntries([validEntryEN])))
                .minus(
          LanguageCode.en(),
        );
        // assert
        expect(
            result,
            equals(Translatable<ChatBotName>(
                mapFrom(Map.fromEntries([validEntryEN])))));
      },
    );
  });

  group('getValueObjectOrCrash', () {
    test(
      '''should return english entry 
      when looking for an english entry and
      when there is a valid english entry''',
      () {
        // act
        final result = Translatable<ChatBotName>(
                mapFrom(Map.fromEntries([validEntryEN, validEntryDE])))
            .getValueObjectOrCrash(LanguageCode.en());
        // assert
        expect(result, validEntryEN.value);
      },
    );
    test(
      '''should return italian entry 
      when looking for italian value and
      when there is an invalid italian entry and a valid english entry''',
      () {
        // act
        final result = Translatable<ChatBotName>(
                mapFrom(Map.fromEntries([invalidEntry, validEntryEN])))
            .getValueObjectOrCrash(LanguageCode.it());
        // assert
        expect(result, invalidEntry.value);
      },
    );
    test(
      '''should return italian entry 
      when looking for italian value and
      when there is an invalid italian entry and an empty entry''',
      () {
        // act
        final result = Translatable<ChatBotName>(
                mapFrom(Map.fromEntries([invalidEntry, emptyEntry])))
            .getValueObjectOrCrash(LanguageCode.it());
        // assert
        expect(result, invalidEntry.value);
      },
    );

    test(
      '''should return fist valid entry (in this case: english)
       when looking for a german entry but
       when there is no german entry''',
      () {
        // act
        final result =
            Translatable<ChatBotName>(mapFrom(Map.fromEntries([validEntryEN])))
                .getValueObjectOrCrash(LanguageCode.de());
        // assert
        expect(result, validEntryEN.value);
      },
    );

    test(
      '''should crash
       when looking for a german entry but
       when there is no invalid german entry and no other valid entry at all
       ''',
      () {
        // act
        final call = Translatable<ChatBotName>(
                mapFrom(Map.fromEntries([invalidEntry, emptyEntry])))
            .getValueObjectOrCrash;
        // assert
        expect(() => call(LanguageCode.en()),
            throwsA(const TypeMatcher<UnexpectedValueError>()));
      },
    );
  });
  group('getStringOrCrash', () {
    test(
      '''should return english entry as String
      when looking for an english entry and
      when there is a valid english entry''',
      () {
        // act
        final result = Translatable<ChatBotName>(
                mapFrom(Map.fromEntries([validEntryEN, validEntryDE])))
            .getStringOrCrash(LanguageCode.en());
        // assert
        expect(result, validEntryEN.value.getOrCrash());
      },
    );
    test(
      '''should return english entry as String
      when looking for italian value but
      when there is only an invalid italian entry but a valid english entry''',
      () {
        // act
        final result = Translatable<ChatBotName>(
                mapFrom(Map.fromEntries([invalidEntry, validEntryEN])))
            .getStringOrCrash(LanguageCode.it());
        // assert
        expect(result, validEntryEN.value.getOrCrash());
      },
    );
    test(
      '''should crash
      when looking for an english value but
      when there is no valid entry at all''',
      () {
        // act
        final call = Translatable<ChatBotName>(
                mapFrom(Map.fromEntries([invalidEntry, emptyEntry])))
            .getStringOrCrash;
        // assert
        expect(() => call(LanguageCode.en()),
            throwsA(const TypeMatcher<UnexpectedValueError>()));
      },
    );
  });
  group('getSupportedLanguageCodes', () {
    test(
      'should crash when trying to getSupportedLanguageCodes of invalid map',
      () {
        // act
        final call = Translatable<ChatBotName>(
                mapFrom(Map.fromEntries([invalidEntry, validEntryDE])))
            .getSupportedLanguageCodesOrCrash;
        // assert
        expect(
            () => call(), throwsA(const TypeMatcher<UnexpectedValueError>()));
      },
    );
    test(
      'should return list of supported Language Codes',
      () {
        // act
        final result = Translatable<ChatBotName>(
                mapFrom(Map.fromEntries([validEntryEN, validEntryDE])))
            .getSupportedLanguageCodesOrCrash();
        // assert
        expect(result, equals(listOf(LanguageCode.en(), LanguageCode.de())));
      },
    );
  });
}
