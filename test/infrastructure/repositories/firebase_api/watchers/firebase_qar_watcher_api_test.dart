// Package imports:
import 'package:dartz/dartz.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kt_dart/kt.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/errors.dart';
import 'package:smart_chat/domain/core/valueobjects/language_code.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/qar/qar.dart';
import 'package:smart_chat/domain/repositories/api/i_watcher_api.dart';
import 'package:smart_chat/domain/repositories/auth/i_auth_repo.dart';
import 'package:smart_chat/infrastructure/repositories/firebase_api/watcher/firebase_qar_watcher_api.dart';
import '../../../../fixtures/chatbots/diary/chatbot_diary.dart';
import '../../../../fixtures/chatbots/diary/qars_diary.dart';
import '../../../../fixtures/chatbots/diary/questions_diary.dart';
import '../../../../fixtures/chatbots/fitness/chatbot_fitness.dart';
import '../../../../fixtures/chatbots/fitness/qars_fitness.dart';
import '../../../../fixtures/chatbots/survey/chatbot_survey.dart';
import '../../../../fixtures/mock_firebase_extensions.dart';
import '../../../../fixtures/user.dart';

class MockIAuthRepo extends Mock implements IAuthRepo {}

class MockIChatBotRepoWatcher extends Mock implements IChatBotWatcherApi {}

class MockIQuestionRepoWatcher extends Mock implements IQuestionWatcherApi {}

void main() {
  late FakeFirebaseFirestore fs;
  late MockIAuthRepo authRepo;
  late MockIChatBotRepoWatcher chatBotRepoWatcher;
  late MockIQuestionRepoWatcher questionRepoWatcher;
  late FireBaseQarWatcherApi repo;

  setUp(
    () async {
      registerFallbackValue<LanguageCode>(LanguageCode.en());
      registerFallbackValue<UniqueId>(UniqueId());

      fs = FakeFirebaseFirestore();
      authRepo = MockIAuthRepo();
      chatBotRepoWatcher = MockIChatBotRepoWatcher();
      questionRepoWatcher = MockIQuestionRepoWatcher();

      repo = FireBaseQarWatcherApi(
        fs,
        authRepo,
        chatBotRepoWatcher,
        questionRepoWatcher,
      );
    },
  );

  tearDown(() async {
    reset(authRepo);
  });

  group('watchOne()', () {
    test(
      'should stream qarDay',
      () async {
        // arrange
        await fs.populateWithQar(qarDayMonday);

        when(() => authRepo.getSignedInUserId())
            .thenAnswer((_) async => dummyUserOne.id);
        // act
        final stream = repo.watchOne(qarDayMonday.id);
        // assert
        expectLater(stream,
            emits(right<CrudFailure, KtList<Qar>>(listOf(qarDayMonday))));
      },
    );
    test(
      '''should stream Left(CrudFailure.insufficientPermission()) 
      when user has insufficient permissions''',
      () async {
        // arrange
        await fs.populateWithQar(qarDayMonday);

        when(() => authRepo.getSignedInUserId())
            .thenAnswer((_) async => dummyUserTwo.id);
        // act
        final stream = repo.watchOne(qarDayMonday.id);
        // assert
        expectLater(
          stream,
          emits(left<CrudFailure, KtList<Qar>>(
              const CrudFailure.insufficientPermission())),
        );
      },
    );
    test(
      'should stream Left(CrudFailure.notSignedIn()) when user not signed in',
      () async {
        // arrange
        when(() => authRepo.getSignedInUserId())
            .thenThrow(NotAuthenticatedError());
        // act
        final stream = repo.watchOne(qarDayMonday.id);
        // assert
        expectLater(
          stream,
          emits(
              left<CrudFailure, KtList<Qar>>(const CrudFailure.notSignedIn())),
        );
      },
    );
  });
  group('watchAllOfChatBot()', () {
    test(
      'should stream a list containing only qars of chatBotDiary',
      () async {
        // arrange

        // ChatBot Diary
        await fs.populateWithQar(qarDayMonday);
        await fs.populateWithQar(qarSleepMonday);
        // ChatBot Fitness
        await fs.populateWithQar(qarKM);

        when(() => authRepo.getSignedInUserId())
            .thenAnswer((_) async => dummyUserOne.id);
        // act
        final stream = repo.watchAllOfChatBot(chatBotDiary.id);
        // assert
        expectLater(
          stream,
          emits(right<CrudFailure, KtList<Qar>>(
            listOf(
              qarDayMonday,
              qarSleepMonday,
            ),
          )),
        );
      },
    );
    test(
      'should stream Left(CrudFailure.notSignedIn()) when user not signed in',
      () async {
        // arrange
        when(() => authRepo.getSignedInUserId())
            .thenThrow(NotAuthenticatedError());
        // act
        final stream = repo.watchAllOfChatBot(chatBotDiary.id);
        // assert
        expectLater(
          stream,
          emits(
              left<CrudFailure, KtList<Qar>>(const CrudFailure.notSignedIn())),
        );
      },
    );
  });
  group('watchAllOfQuestion()', () {
    test(
      'should stream a list containing only qars of questionDay',
      () async {
        // arrange
        when(() => authRepo.getSignedInUserId())
            .thenAnswer((_) async => dummyUserOne.id);

        // Question Day
        await fs.populateWithQuestion(questionDay);
        await fs.populateWithQar(qarDayMonday);
        await fs.populateWithQar(qarDayTuesday);
        // Question Sleep
        await fs.populateWithQar(qarSleepMonday);

        // act
        final stream = repo.watchAllOfQuestion(questionDay.id);
        // assert
        expectLater(
          stream,
          emits(right<CrudFailure, KtList<Qar>>(
            listOf(
              qarDayTuesday,
              qarDayMonday,
            ),
          )),
        );
      },
    );

    test(
      'should stream Left(CrudFailure.notSignedIn()) when user not signed in',
      () async {
        // arrange
        when(() => authRepo.getSignedInUserId())
            .thenThrow(NotAuthenticatedError());
        // act
        final stream = repo.watchAllOfQuestion(questionDay.id);
        // assert
        expectLater(
          stream,
          emits(
              left<CrudFailure, KtList<Qar>>(const CrudFailure.notSignedIn())),
        );
      },
    );
  });
  group('watchAllVisibleOfChatBot()', () {
    test(
      'should stream a list containing only visible qars of chatBotDiary',
      () async {
        // arrange
        when(() => authRepo.getSignedInUserId())
            .thenAnswer((_) async => dummyUserOne.id);
        await fs
            .populateWithQar(qarDayMonday.makeVisible(DateTime.parse(MONDAY)));
        await fs.populateWithQar(
            qarDayTuesday.makeVisible(DateTime.parse(TUESDAY)));
        await fs.populateWithQar(qarDayWednesday);
        await fs.populateWithQar(qarKM.makeVisible(DateTime.parse(MONDAY)));
        await fs.populateWithQar(
            qarSleepMonday.makeVisible(DateTime.parse(MONDAY)));

        // act
        final stream = repo.watchAllVisibleOfChatBot(chatBotDiary.id);
        // assert
        expectLater(
          stream,
          emits(
            right<CrudFailure, KtList<Qar>>(
              listOf(
                qarDayTuesday.makeVisible(DateTime.parse(TUESDAY)),
                qarDayMonday.makeVisible(DateTime.parse(MONDAY)),
                qarSleepMonday.makeVisible(DateTime.parse(MONDAY)),
              ),
            ),
          ),
        );
      },
    );
    test(
      'should stream Left(CrudFailure.notSignedIn()) when user not signed in',
      () async {
        // arrange
        when(() => authRepo.getSignedInUserId())
            .thenThrow(NotAuthenticatedError());
        // act
        final stream = repo.watchAllVisibleOfChatBot(chatBotDiary.id);
        // assert
        expectLater(
          stream,
          emits(
              left<CrudFailure, KtList<Qar>>(const CrudFailure.notSignedIn())),
        );
      },
    );
  });
  group('watchMostRecentAnsweredQar', () {
    test(
      'should stream most recent answered qar of chatBotDiary',
      () async {
        // arrange
        await fs.populateWithQar(
          qarDayMonday.makeVisible(DateTime.parse(MONDAY)).makeAnswered(),
        );
        await fs.populateWithQar(
            qarDayTuesday.makeVisible(DateTime.parse(TUESDAY)));
        await fs.populateWithQar(qarDayWednesday
            .makeVisible(DateTime.parse(WEDNESDAY))
            .makeAnswered());
        await fs.populateWithQar(
            qarDayThursday.makeVisible(DateTime.parse(MONDAY)));

        // act
        final stream =
            repo.watchMostRecentAnsweredQar(chatBotDiary.id, dummyUserOne.id);

        // assert
        expect(
            stream,
            emits(right<CrudFailure, Qar?>(qarDayWednesday
                .makeVisible(DateTime.parse(WEDNESDAY))
                .makeAnswered())));
      },
    );
  });
  group('watchMostRecentUnansweredAndVisibleQar', () {
    test(
      'should stream most recent unanswered and visible qar of chatBotDiary',
      () async {
        // arrange
        await fs
            .populateWithQar(qarDayMonday.makeVisible(DateTime.parse(MONDAY)));
        await fs.populateWithQar(
            qarDayTuesday.makeVisible(DateTime.parse(TUESDAY)).makeAnswered());
        await fs.populateWithQar(
            qarDayWednesday.makeVisible(DateTime.parse(WEDNESDAY)));

        await fs.populateWithQar(qarDayThursday);

        // act
        final stream = repo.watchMostRecentUnansweredAndVisibleQar(
            chatBotDiary.id, dummyUserOne.id);

        // assert
        expect(
            stream,
            emits(right<CrudFailure, Qar?>(
                qarDayWednesday.makeVisible(DateTime.parse(WEDNESDAY)))));
      },
    );
  });
  group('watchMostRecentUnansweredAndVisibleOrMostRecentAnswered', () {
    test(
      '''should stream null if there are no qars''',
      () async {
        // act
        final stream =
            repo.watchMostRecentUnansweredAndVisibleOrMostRecentAnswered(
                chatBotDiary.id, dummyUserOne.id);

        // assert
        expect(stream, emits(right<CrudFailure, Qar?>(null)));
      },
    );
    test(
      '''should stream most recent unanswered visible qar of chatBotDiary''',
      () async {
        // arrange
        await fs
            .populateWithQar(qarDayMonday.makeVisible(DateTime.parse(MONDAY)));
        await fs.populateWithQar(
            qarDayTuesday.makeVisible(DateTime.parse(TUESDAY)).makeAnswered());
        await fs.populateWithQar(qarDayWednesday
            .makeVisible(DateTime.parse(WEDNESDAY))
            .makeAnswered());
        await fs.populateWithQar(qarDayThursday);

        // act
        final stream =
            repo.watchMostRecentUnansweredAndVisibleOrMostRecentAnswered(
                chatBotDiary.id, dummyUserOne.id);

        // assert
        expect(
            stream,
            emits(right<CrudFailure, Qar?>(
                qarDayMonday.makeVisible(DateTime.parse(MONDAY)))));
      },
    );
    test(
      '''should stream most recent answered qar of chatBotDiary
      when there are not visible unanswered qars''',
      () async {
        // arrange
        await fs.populateWithQar(
            qarDayMonday.makeVisible(DateTime.parse(MONDAY)).makeAnswered());
        await fs.populateWithQar(
            qarDayTuesday.makeVisible(DateTime.parse(TUESDAY)).makeAnswered());
        await fs.populateWithQar(qarDayWednesday
            .makeVisible(DateTime.parse(WEDNESDAY))
            .makeAnswered());
        await fs.populateWithQar(qarDayThursday);

        // act
        final stream =
            repo.watchMostRecentUnansweredAndVisibleOrMostRecentAnswered(
                chatBotDiary.id, dummyUserOne.id);

        // assert
        expect(
            stream,
            emits(right<CrudFailure, Qar?>(qarDayWednesday
                .makeVisible(DateTime.parse(WEDNESDAY))
                .makeAnswered())));
      },
    );
  });
  group('watchMostRecentQarOfChatBots', () {
    test(
      '''should stream most recent unanswered visible qar of chatBotDiary
        most recent answered qar of chatBotFitness
        and null''',
      () async {
        // arrange

        await fs
            .populateWithQar(qarDayMonday.makeVisible(DateTime.parse(MONDAY)));
        await fs.populateWithQar(
            qarDayTuesday.makeVisible(DateTime.parse(TUESDAY)).makeAnswered());
        await fs.populateWithQar(
            qarDayWednesday.makeVisible(DateTime.parse(WEDNESDAY)));
        await fs.populateWithQar(qarDayThursday);

        await fs.populateWithQar(
            qarKM.makeVisible(DateTime.parse(MONDAY)).makeAnswered());

        // act
        final stream = repo.watchUnreadOrMostRecentQarOfChatBots(
            listOf(
              chatBotDiary.id,
              chatBotFitness.id,
              chatBotSurvey.id,
            ),
            dummyUserOne.id);

        // assert
        expect(
          stream,
          emits(
            KtMap.from(
              {
                chatBotDiary.id: Right(
                    qarDayWednesday.makeVisible(DateTime.parse(WEDNESDAY))),
                chatBotFitness.id: Right(
                    qarKM.makeVisible(DateTime.parse(MONDAY)).makeAnswered()),
                chatBotSurvey.id: const Right(null),
              },
            ),
          ),
        );
      },
    );
  });
}
