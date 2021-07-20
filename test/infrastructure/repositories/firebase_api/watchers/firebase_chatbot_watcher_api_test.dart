// Package imports:
import 'package:dartz/dartz.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kt_dart/kt.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/chatbot/chatbot.dart';
import 'package:smart_chat/domain/repositories/api/i_watcher_api.dart';
import 'package:smart_chat/infrastructure/repositories/firebase_api/watcher/firebase_chatbot_watcher_api.dart';
import '../../../../fixtures/chatbots/diary/chatbot_diary.dart';
import '../../../../fixtures/chatbots/diary/subscription.dart';
import '../../../../fixtures/chatbots/fitness/chatbot_fitness.dart';
import '../../../../fixtures/chatbots/politics/chatbot_politics.dart';
import '../../../../fixtures/mock_firebase_extensions.dart';
import '../../../../fixtures/user.dart';

class MockISubscriptionWatcherApi extends Mock
    implements ISubscriptionWatcherApi {}

void main() {
  late FakeFirebaseFirestore fs;
  late MockISubscriptionWatcherApi subscriptionWatcherApi;

  late FireBaseChatBotWatcherApi repo;

  setUp(() async {
    fs = FakeFirebaseFirestore();
    subscriptionWatcherApi = MockISubscriptionWatcherApi();

    repo = FireBaseChatBotWatcherApi(fs, subscriptionWatcherApi);

    await fs.populateWithChatBot(chatBotDiary);
    await fs.populateWithChatBot(chatBotFitness);
    await fs.populateWithChatBot(chatBotPolitics); //user 2
  });

  group('watchOne()', () {
    test(
      'should stream a list containing only one chatBot',
      () async {
        // act
        final stream = repo.watchOne(chatBotDiary.id);
        // assert
        expectLater(stream,
            emits(right<CrudFailure, KtList<ChatBot>>(listOf(chatBotDiary))));
      },
    );
    test(
      'should stream CrudFailure.doesNotExist() when document does not exist',
      () async {
        // act
        final stream = repo.watchOne(UniqueId());
        // assert
        expectLater(
            stream,
            emits(left<CrudFailure, KtList<ChatBot>>(
                const CrudFailure.doesNotExist())));
      },
    );
  });
  group('watchAllCreatedBy()', () {
    test(
      'should stream a list containing only the chatBots of one user',
      () async {
        // act
        final stream = repo.watchAllCreatedBy(dummyUserOne.id);
        // assert
        expectLater(
            stream,
            emits(right<CrudFailure, KtList<ChatBot>>(
                listOf(chatBotDiary, chatBotFitness))));
      },
    );
  });
  group('watchAll()', () {
    test(
      'should stream a list containing all chatbots',
      () async {
        // act
        final stream = repo.watchAll();
        // assert
        expectLater(
            stream,
            emits(right<CrudFailure, KtList<ChatBot>>(
                listOf(chatBotDiary, chatBotFitness, chatBotPolitics))));
      },
    );
  });

  group('watchAllSubscribedStarted()', () {
    test(
      'should stream a list containing only the subscribed chatbots of dummyUserOne',
      () async {
        // arrange
        when(() => subscriptionWatcherApi.watchAllOfUser(dummyUserOne.id))
            .thenAnswer(
                (_) => Stream.value(Right(listOf(twelveOClockSubscription))));
        // act
        final stream = repo.watchAllSubscribed(dummyUserOne.id);
        // assert
        expectLater(stream,
            emits(right<CrudFailure, KtList<ChatBot>>(listOf(chatBotDiary))));
      },
    );
    test(
      'should stream an empty list when user has not subscribed any chatbots yet',
      () async {
        // arrange
        when(() => subscriptionWatcherApi.watchAllOfUser(dummyUserOne.id))
            .thenAnswer((_) => Stream.value(Right(listOf())));
        // act
        final stream = repo.watchAllSubscribed(dummyUserOne.id);
        // assert
        expectLater(
            stream, emits(right<CrudFailure, KtList<ChatBot>>(listOf())));
      },
    );
  });
}
