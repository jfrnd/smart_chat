// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:smart_chat/domain/entities/subscription/subscription_frequency.dart';

void main() {
  setUp(() {});

  group('instantiation', () {
    test(
      'should return value failure when input is not valid',
      () {
        // arrange

        // act
        final object = SubscriptionFrequency("123");
        // assert
        expect(
            object.getFailureOrCrash(), equals(const InvalidFrequency("123")));
      },
    );
    test(
      'should return valid object when input is fixed subscription frequency',
      () {
        // arrange

        // act
        final object = SubscriptionFrequency("daily");
        // assert
        expect(object.getOrCrash(), equals("daily"));
      },
    );
    test(
      'should return value failure when input is not valid',
      () {
        // arrange

        // act
        final object = SubscriptionFrequency("1991-1-01");
        // assert
        expect(object.getFailureOrCrash(),
            equals(const InvalidFrequency("1991-1-01")));
      },
    );
    test(
      'should return valid object when input is valid date subscription',
      () {
        // arrange

        // act
        final object = SubscriptionFrequency("1991-01-01");
        // assert
        expect(object.getOrCrash(), equals("1991-01-01"));
      },
    );
  });
}
