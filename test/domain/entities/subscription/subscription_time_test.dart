// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:smart_chat/domain/entities/subscription/subscription_time.dart';

void main() {
  setUp(() {});

  group('instantiation', () {
    test(
      'should return value failure when input is not valid',
      () {
        // arrange

        // act
        final object = SubscriptionTime(hh: 25, mm: 0);
        // assert
        expect(object.getFailureOrCrash(),
            equals(const InvalidSubscriptionTimeValue("25:00")));
      },
    );
    test(
      'should return value failure when input is not valid',
      () {
        // arrange

        // act
        final object = SubscriptionTime(hh: 23, mm: 60);
        // assert
        expect(object.getFailureOrCrash(),
            equals(const InvalidSubscriptionTimeValue("23:60")));
      },
    );
    test(
      'should return valid object when input is valid time',
      () {
        // arrange

        // act
        final object = SubscriptionTime(hh: 23, mm: 11);
        // assert
        expect(object.getOrCrash(), equals("23:11"));
      },
    );
  });
}
