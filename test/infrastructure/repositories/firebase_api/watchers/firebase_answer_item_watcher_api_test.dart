// Package imports:
import 'package:dartz/dartz.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kt_dart/kt.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/errors.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/answer_item/answer_item.dart';
import 'package:smart_chat/domain/entities/qar/qar.dart';
import 'package:smart_chat/domain/repositories/auth/i_auth_repo.dart';
import 'package:smart_chat/infrastructure/repositories/firebase_api/watcher/firebase_answer_item_watcher_api.dart';
import '../../../../fixtures/chatbots/diary/answer_items_diary.dart';
import '../../../../fixtures/chatbots/diary/chatbot_diary.dart';
import '../../../../fixtures/chatbots/diary/qars_diary.dart';
import '../../../../fixtures/chatbots/diary/questions_diary.dart';
import '../../../../fixtures/chatbots/fitness/answer_items_fitness.dart';
import '../../../../fixtures/mock_firebase_extensions.dart';
import '../../../../fixtures/user.dart';

// Project imports:



class MockIAuthRepo extends Mock implements IAuthRepo {}

void main() {
  late FakeFirebaseFirestore fs;
  late MockIAuthRepo authRepo;
  late FireBaseAnswerItemWatcherApi repo;

  setUp(() async {
    registerFallbackValue<Qar>(Qar.empty());
    registerFallbackValue<UniqueId>(UniqueId());

    fs = FakeFirebaseFirestore();
    authRepo = MockIAuthRepo();
    repo = FireBaseAnswerItemWatcherApi(fs, authRepo);
  });

  tearDown(() {
    reset(authRepo);
  });

  group('watchOne()', () {
    test(
      'should stream a list containing only answerItem',
      () async {
        // arrange
        await fs.populateWithAnswerItem(answerItemDayGoodMonday);

        // act
        final stream = repo.watchOne(answerItemDayGoodMonday.id);
        // assert
        expectLater(
            stream,
            emits(right<CrudFailure, KtList<AnswerItem>>(
                listOf(answerItemDayGoodMonday))));
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
            emits(left<CrudFailure, KtList<AnswerItem>>(
                const CrudFailure.doesNotExist())));
      },
    );
  });
  group('watchAllOfChatBotAndSignedInUser()', () {
    test(
      'should stream a list containing only the answerItems of chatBotDiary',
      () async {
        // arrange
        when(() => authRepo.getSignedInUserId())
            .thenAnswer((_) async => dummyUserOne.id);
        //! chatBotDiary
        await fs.populateWithAnswerItem(answerItemDayGoodMonday);
        await fs.populateWithAnswerItem(answerItemSleepMonday);
        //! chatBotFitness
        await fs.populateWithAnswerItem(answerItemFitness100kmMonday);
        // act
        final stream = repo.watchAllOfChatBotAndSignedInUser(chatBotDiary.id);
        // assert
        expectLater(
          stream,
          emits(right<CrudFailure, KtList<AnswerItem>>(
              listOf(answerItemDayGoodMonday, answerItemSleepMonday))),
        );
      },
    );
    test(
      'should stream Left(CrudFailure.notSigendIn()) when user not signed in',
      () async {
        // arrange
        when(() => authRepo.getSignedInUserId())
            .thenThrow(NotAuthenticatedError());
        // act
        final stream = repo.watchAllOfChatBotAndSignedInUser(chatBotDiary.id);
        // assert
        expectLater(
          stream,
          emits(left<CrudFailure, KtList<AnswerItem>>(
              const CrudFailure.notSignedIn())),
        );
      },
    );
  });
  group('watchAllOfQuestionAndSignedInUser()', () {
    test(
      'should stream a list containing only the answerItems of questionDay',
      () async {
        // arrange
        when(() => authRepo.getSignedInUserId())
            .thenAnswer((_) async => dummyUserOne.id);

        //! question day
        await fs.populateWithQuestion(questionDay);
        await fs.populateWithAnswerItem(answerItemDayGoodMonday);
        //! other questions
        await fs.populateWithAnswerItem(answerItemSleepMonday);
        await fs.populateWithAnswerItem(answerItemFitness100kmMonday);
        // act
        final stream = repo.watchAllOfQuestionAndSignedInUser(questionDay.id);
        // assert
        expectLater(
          stream,
          emits(right<CrudFailure, KtList<AnswerItem>>(
              listOf(answerItemDayGoodMonday))),
        );
      },
    );
    test(
      'should stream Left(CrudFailure.notSigendIn()) when user not signed in',
      () async {
        // arrange
        when(() => authRepo.getSignedInUserId())
            .thenThrow(NotAuthenticatedError());
        // act
        final stream = repo.watchAllOfQuestionAndSignedInUser(questionDay.id);
        // assert
        expectLater(
          stream,
          emits(left<CrudFailure, KtList<AnswerItem>>(
              const CrudFailure.notSignedIn())),
        );
      },
    );
  });
  group('watchAllOfQar()', () {
    test(
      'should stream a list containing only the answerItems of qarDayMonday',
      () async {
        // arrange
        when(() => authRepo.getSignedInUserId())
            .thenAnswer((_) async => dummyUserOne.id);
        //! qarDayMonday
        await fs.populateWithQar(qarDayMonday);
        await fs.populateWithAnswerItem(answerItemDayGoodMonday);
        await fs.populateWithAnswerItem(answerItemSleepMonday);
        //! qarDayTuesDay
        await fs.populateWithAnswerItem(answerItemDayBadTuesday);
        await fs.populateWithAnswerItem(answerItemSleepTuesday);
        // act
        final stream = repo.watchAllOfQar(qarDayMonday.id);
        // assert
        expectLater(
          stream,
          emits(right<CrudFailure, KtList<AnswerItem>>(listOf(
            answerItemDayGoodMonday,
          ))),
        );
      },
    );
    test(
      '''should stream Left(CrudFailure.insufficientPermission()) when
      signed in user does not belong to the qar
      ''',
      () async {
        // arrange
        await fs.populateWithQar(qarDayMonday);
        when(() => authRepo.getSignedInUserId())
            .thenAnswer((_) async => dummyUserTwo.id);
        // act
        final stream = repo.watchAllOfQar(qarDayMonday.id);
        // assert
        expectLater(
          stream,
          emits(left<CrudFailure, KtList<AnswerItem>>(
              const CrudFailure.insufficientPermission())),
        );
      },
    );
    test(
      '''should stream Left(CrudFailure.notSignedIn()) when
      user not signed in
      ''',
      () async {
        // arrange
        when(() => authRepo.getSignedInUserId())
            .thenThrow(NotAuthenticatedError());
        // act
        final stream = repo.watchAllOfQar(qarDayMonday.id);
        // assert
        expectLater(
          stream,
          emits(left<CrudFailure, KtList<AnswerItem>>(
              const CrudFailure.notSignedIn())),
        );
      },
    );
  });
}
