// Package imports:
import 'package:dartz/dartz.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kt_dart/kt.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/subscription/subscription.dart';
import 'package:smart_chat/domain/repositories/auth/i_auth_repo.dart';
import 'package:smart_chat/infrastructure/repositories/firebase_api/watcher/firebase_subscription_watcher_api.dart';
import '../../../../fixtures/chatbots/diary/chatbot_diary.dart';
import '../../../../fixtures/chatbots/diary/subscription.dart';
import '../../../../fixtures/chatbots/survey/chatbot_survey.dart';
import '../../../../fixtures/mock_firebase_extensions.dart';
import '../../../../fixtures/user.dart';

class MockIAuthRepo extends Mock implements IAuthRepo {}

void main() {
  late FakeFirebaseFirestore fs;
  late FireBaseSubscriptionWatcherApi repo;
  late MockIAuthRepo authRepo;

  setUp(() async {
    fs = FakeFirebaseFirestore();
    authRepo = MockIAuthRepo();
    repo = FireBaseSubscriptionWatcherApi(
      fs,
      authRepo,
    );

    // User: dummyUserOne
    await fs.populateWithSubscription(twelveOClockSubscription);
    // User: dummyUserOne
    await fs.populateWithSubscription(threeOClockSubscription);
  });

  group('watchOne()', () {
    test(
      'should stream a list containing only twelveOClockSubscription',
      () async {
        // act
        final stream = repo.watchOne(twelveOClockSubscription.id);
        // assert
        expectLater(
            stream,
            emits(right<CrudFailure, KtList<Subscription>>(
                listOf(twelveOClockSubscription))));
      },
    );
    test(
      'should stream CrudFailure.doesNotExist() when doc does not exist',
      () async {
        // act
        final stream = repo.watchOne(UniqueId());
        // assert
        expectLater(
            stream,
            emits(left<CrudFailure, KtList<Subscription>>(
                const CrudFailure.doesNotExist())));
      },
    );
  });
  group('watchAllOfUser()', () {
    test(
      'should stream a list containing only the subscriptions of dummyUserOne',
      () async {
        // act
        final stream = repo.watchAllOfUser(dummyUserOne.id);
        // assert
        expectLater(
          stream,
          emits(right<CrudFailure, KtList<Subscription>>(
            listOf(twelveOClockSubscription),
          )),
        );
      },
    );
  });
  group('watchAllOfSignedInUser()', () {
    test(
      'should stream a list containing only the subscriptions of dummyUserOne',
      () async {
        // arrange
        when(() => authRepo.getSignedInUserId())
            .thenAnswer((_) async => dummyUserOne.id);
        // act
        final stream = repo.watchAllOfSignedInUser();
        // assert
        expectLater(
          stream,
          emits(right<CrudFailure, KtList<Subscription>>(
            listOf(twelveOClockSubscription),
          )),
        );
      },
    );
  });
  group('watchOfChatBotAndSignedInUser()', () {
    test(
      'should stream a list containing only the subscriptions of chatBotDiary',
      () async {
        // arrange
        when(() => authRepo.getSignedInUserId())
            .thenAnswer((_) async => dummyUserOne.id);
        // act
        final stream = repo.watchOfChatBotAndSignedInUser(chatBotDiary.id);
        // assert
        expectLater(
          stream,
          emits(right<CrudFailure, KtList<Subscription>>(
            listOf(twelveOClockSubscription),
          )),
        );
      },
    );
    test(
      'should stream an empty list if subscription does not exist',
      () async {
        // arrange
        when(() => authRepo.getSignedInUserId())
            .thenAnswer((_) async => dummyUserOne.id);
        // act
        final stream = repo.watchOfChatBotAndSignedInUser(chatBotSurvey.id);
        // assert
        expectLater(
          stream,
          emits(right<CrudFailure, KtList<Subscription>>(
            listOf(),
          )),
        );
      },
    );
  });
}
