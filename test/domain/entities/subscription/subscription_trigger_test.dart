// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:smart_chat/domain/entities/subscription/subscription_frequency.dart';
import 'package:smart_chat/domain/entities/subscription/subscription_trigger.dart';
import 'package:smart_chat/domain/entities/subscription/subscription_time.dart';

void main() {
  setUp(() {});

  group('withOffset', () {
    test(
      'should return SubscriptionItem with time 23:30 ',
      () {
        // arrange
        final time = SubscriptionTime(hh: 01, mm: 30);
        final expectedTime = SubscriptionTime(hh: 23, mm: 30);
        // act
        final object = SubscriptionTrigger(
          frequency: SubscriptionFrequency.daily(),
          time: time,
        ).withOffset(2);
        // assert
        expect(
            object,
            equals(SubscriptionTrigger(
              frequency: SubscriptionFrequency.daily(),
              time: expectedTime,
            )));
      },
    );
    test(
      'should return SubscriptionItem with time 01:30 ',
      () {
        // arrange
        final time = SubscriptionTime(hh: 23, mm: 30);
        final expectedTime = SubscriptionTime(hh: 01, mm: 30);
        // act
        final object = SubscriptionTrigger(
          frequency: SubscriptionFrequency.daily(),
          time: time,
        ).withOffset(-2);
        // assert
        expect(
            object,
            equals(SubscriptionTrigger(
              frequency: SubscriptionFrequency.daily(),
              time: expectedTime,
            )));
      },
    );
  });
}
