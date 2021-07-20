// Package imports:
import 'package:dartz/dartz.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/subscription/subscription.dart';
import 'package:smart_chat/domain/entities/subscription/subscription_status.dart';
import 'package:smart_chat/infrastructure/core/firestore_helpers.dart';
import 'package:smart_chat/infrastructure/repositories/firebase_api/crud/firebase_subscription_crud_api.dart';
import '../../../../fixtures/chatbots/diary/subscription.dart';
import '../../../../fixtures/mock_firebase_extensions.dart';

void main() {
  late FakeFirebaseFirestore fs;
  late FireBaseSubscriptionCrudApi repo;

  setUp(() async {
    fs = FakeFirebaseFirestore();
    repo = FireBaseSubscriptionCrudApi(fs);

    await fs.populateWithSubscription(twelveOClockSubscription);
  });

  group('readOne()', () {
    test(
      'should return twelveOClockSubscription',
      () async {
        // act
        final res = await repo.readOne(twelveOClockSubscription.id);
        // assert
        expectLater(
            res, right<CrudFailure, Subscription>(twelveOClockSubscription));
      },
    );

    test(
      'should return CrudFailure.doesNotExist() when document does not exist',
      () async {
        // act
        final res = await repo.readOne(UniqueId());
        // assert
        expectLater(res,
            left<CrudFailure, Subscription>(const CrudFailure.doesNotExist()));
      },
    );
  });
  group('createOnDB()', () {
    test(
      '''should add subscription to fs and return right(unit)''',
      () async {
        // act
        final response = await repo.createOnDB(threeOClockSubscription);
        // assert
        final chatBotOnFs = await fs.getSubscriptionOrNull(
          userId: threeOClockSubscription.createdBy,
          subscriptionId: threeOClockSubscription.id,
        );
        expectLater(response, equals(const Right(unit)));
        expectLater(chatBotOnFs, equals(threeOClockSubscription));
      },
    );
  });

  group('updateOnDB()', () {
    test(
      'should update user on fs and return right(unit)',
      () async {
        // arrange
        final updatedDomainSubscription = twelveOClockSubscription.copyWith(
          status: const SubscriptionStatus.inactive(),
        );
        // act
        final response = await repo.updateOnDB(updatedDomainSubscription);
        // assert
        final subscriptionOnFs = await fs.getSubscriptionOrNull(
          userId: twelveOClockSubscription.createdBy,
          subscriptionId: twelveOClockSubscription.id,
        );
        expectLater(response, equals(const Right(unit)));
        expectLater(subscriptionOnFs, equals(updatedDomainSubscription));
      },
    );
  });
  group('deleteFromDB()', () {
    test(
      'should delete subscription from fs and return right(unit)',
      () async {
        // arrange
        fs.populateWithSubscription(threeOClockSubscription);

        // act
        final response = await repo.deleteFromDB(threeOClockSubscription);

        // assert

        final doc = await fs.getSubscriptionOrNull(
            userId: threeOClockSubscription.createdBy,
            subscriptionId: threeOClockSubscription.id);
        final doc2 = await fs.getSubscriptionOrNull(
            userId: twelveOClockSubscription.createdBy,
            subscriptionId: twelveOClockSubscription.id);

        expectLater(doc == null, true);
        expectLater(doc2 == null, false);
        expectLater(response, equals(const Right(unit)));
      },
    );
  });
}
