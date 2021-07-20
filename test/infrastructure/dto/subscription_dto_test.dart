// Package imports:
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:smart_chat/infrastructure/core/firestore_helpers.dart';
import 'package:smart_chat/infrastructure/dto/subscription_dto.dart';
import '../../fixtures/chatbots/diary/subscription.dart';
import '../../fixtures/mock_firebase_extensions.dart';

void main() {
  late FakeFirebaseFirestore fs;

  setUp(() async {
    fs = FakeFirebaseFirestore();
  });

  group('fromDomain()', () {
    test(
      'should return DTO',
      () async {
        // act
        final result = SubscriptionDto.fromDomain(twelveOClockSubscription);
        // assert
        expect(result, equals(twelveOClockSubscriptionDto));
      },
    );
  });
  group('toDomain()', () {
    test(
      'should return Domain Object',
      () {
        // act
        final result = twelveOClockSubscriptionDto.toDomain();
        // assert
        expect(result, equals(twelveOClockSubscription));
      },
    );
  });
  group('fromFireStore()', () {
    test(
      'should return DTO',
      () async {
        // arrange
        await fs.populateWithSubscription(twelveOClockSubscription);
        final snapshot = await fs.getSubscriptionDoc(
          userId: twelveOClockSubscription.createdBy,
          subscriptionId: twelveOClockSubscription.id,
        );

        // act
        final res = SubscriptionDto.fromFireStore(snapshot);
        // assert
        expect(res, equals(twelveOClockSubscriptionDto));
      },
    );
  });
  group('toFirestore()', () {
    test(
      'should return firestore map',
      () {
        // act
        final res = twelveOClockSubscriptionDto.toFireStore();
        // assert
        expect(res, equals(twelveOClockSubscriptionFirestoreMap));
      },
    );
  });
}
