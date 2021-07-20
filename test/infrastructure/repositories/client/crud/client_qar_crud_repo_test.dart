// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kt_dart/kt.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/i_meta_data_provider.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/qar/qar.dart';
import 'package:smart_chat/domain/entities/question/question.dart';
import 'package:smart_chat/domain/repositories/api/i_crud_api.dart';
import 'package:smart_chat/domain/repositories/auth/i_auth_repo.dart';
import 'package:smart_chat/infrastructure/repositories/client/crud/client_qar_crud_repo.dart';
import '../../../../fixtures/chatbots/diary/answer_items_diary.dart';
import '../../../../fixtures/chatbots/diary/chatbot_diary.dart';
import '../../../../fixtures/chatbots/diary/qars_diary.dart';
import '../../../../fixtures/user.dart';

class MockIAuthRepo extends Mock implements IAuthRepo {}

class MockIQuestionCrudApi extends Mock implements IQuestionCrudApi {}

class MockIMetaDataProvider extends Mock implements IMetaDataProvider {}

class MockIQarCrudApi extends Mock implements IQarCrudApi {}

void main() {
  late MockIAuthRepo authRepo;
  late MockIMetaDataProvider metaDataProvider;
  late MockIQarCrudApi qarCrudApi;
  late MockIQuestionCrudApi questionCrudApi;
  late ClientQarCrud repo;

  final testSessionId = UniqueId.dummy();
  const UPDATED_AT = '2022-01-02T12:12:00.000000';
  final testTime = DateTime.parse(UPDATED_AT);
  const TEST_ID = 'TEST_ID';
  final testId = UniqueId.fromUniqueString(TEST_ID);

  setUp(() async {
    registerFallbackValue<Qar>(Qar.empty());

    authRepo = MockIAuthRepo();
    metaDataProvider = MockIMetaDataProvider();
    qarCrudApi = MockIQarCrudApi();
    questionCrudApi = MockIQuestionCrudApi();

    repo = ClientQarCrud(
      authRepo,
      metaDataProvider,
      qarCrudApi,
      questionCrudApi,
    );

    when(() => authRepo.getSignedInUserId())
        .thenAnswer((_) async => dummyUserOne.id);

    when(() => metaDataProvider.getSessionId()).thenReturn(testSessionId);
    when(() => metaDataProvider.getUniqueId()).thenReturn(testId);
    when(() => metaDataProvider.getCurrentTime()).thenReturn(testTime);
  });

  tearDown(() {
    reset(authRepo);
    reset(metaDataProvider);
    reset(qarCrudApi);
    reset(questionCrudApi);
  });
  group('verifyUserAndReadOne()', () {
    test(
      '''should
      call authFacade.getSignedInUserId()
      call qarCrudApi.readOne()
      and return Left(CrudFailure.insufficientPermission())
      when user has no permission to read
      ''',
      () async {
        // arrange
        when(() => authRepo.getSignedInUserId())
            .thenAnswer((_) async => dummyUserTwo.id);
        when(() => qarCrudApi.readOne(qarDayMonday.id))
            .thenAnswer((_) async => Right(qarDayMonday));
        // act
        final response = await repo.verifyUserAndReadOne(qarDayMonday.id);
        // assert
        verify(() => authRepo.getSignedInUserId());
        verify(() => qarCrudApi.readOne(qarDayMonday.id));
        expectLater(
            response, equals(const Left(CrudFailure.insufficientPermission())));
      },
    );
    test(
      '''should
      call authFacade.getSignedInUserId()
      call qarCrudApi.readOne()
      and return Left(CrudFailure.unexpected())
      when reading is not successful
      ''',
      () async {
        // arrange
        when(() => qarCrudApi.readOne(qarDayMonday.id))
            .thenAnswer((_) async => const Left(CrudFailure.unexpected()));
        // act
        final response = await repo.verifyUserAndReadOne(qarDayMonday.id);
        // assert
        verify(() => authRepo.getSignedInUserId());
        verify(() => qarCrudApi.readOne(qarDayMonday.id));
        expectLater(response, equals(const Left(CrudFailure.unexpected())));
      },
    );
    test(
      '''should
      call authFacade.getSignedInUserId()
      call qarCrudApi.readOne()
      and return Right(qar)
      when reading is successful
      ''',
      () async {
        // arrange
        when(() => qarCrudApi.readOne(qarDayMonday.id))
            .thenAnswer((_) async => Right(qarDayMonday));
        // act
        final response = await repo.verifyUserAndReadOne(qarDayMonday.id);
        // assert
        verify(() => authRepo.getSignedInUserId());
        verify(() => qarCrudApi.readOne(qarDayMonday.id));
        expectLater(response, equals(Right(qarDayMonday)));
      },
    );
  });
  group('createWithMetaData()', () {
    final expectedQar = qarDayMonday.addMetaData(
      id: testId,
      createdBy: dummyUserOne.id,
      createdAt: testTime,
    );
    test(
      '''should
      call authFacade.getSignedInUserId()
      call metaDataProvider.getCurrentTime()
      call metaDataProvider.getUniqueId()
      call qarCrudApi.createOnDB() with qar with metadata
      and return Right(expectedQar) when creation was successful
      ''',
      () async {
        // arrange
        when(() => qarCrudApi.createOnDB(expectedQar))
            .thenAnswer((_) async => const Right(unit));
        // act
        final response = await repo.createWithMetaData(qarDayMonday);

        // assert
        verify(() => authRepo.getSignedInUserId());
        verify(() => metaDataProvider.getCurrentTime());
        verify(() => metaDataProvider.getUniqueId());
        verify(() => qarCrudApi.createOnDB(expectedQar));
        expectLater(response, equals(Right(expectedQar)));
      },
    );
    test(
      '''should
      call authFacade.getSignedInUserId()
      call metaDataProvider.getCurrentTime()
      call metaDataProvider.getUniqueId()
      call qarCrudApi.createOnDB() with qar with metadata
      and return Left(CrudFailure) when creation was not successful
      ''',
      () async {
        // arrange
        when(() => qarCrudApi.createOnDB(expectedQar))
            .thenAnswer((_) async => const Left(CrudFailure.unexpected()));
        // act
        final response = await repo.createWithMetaData(qarDayMonday);

        // assert
        verify(() => authRepo.getSignedInUserId());
        verify(() => metaDataProvider.getCurrentTime());
        verify(() => metaDataProvider.getUniqueId());
        verify(() => qarCrudApi.createOnDB(expectedQar));
        expectLater(response, equals(const Left(CrudFailure.unexpected())));
      },
    );
  });
  group('verifyUserAndUpdate()', () {
    final updatedQar =
        qarDayMonday.linkedWithAnswerItem(answerItemDayGoodMonday.id);
    test(
      '''should
      call authFacade.getSignedInUserId()
      not call qarCrudApi.updadeOnDB()
      and return Left(CrudFailure.insufficientPermission())
      when user has no permission to update
      ''',
      () async {
        // arrange
        when(() => authRepo.getSignedInUserId())
            .thenAnswer((_) async => dummyUserTwo.id);
        // act
        final response = await repo.verifyUserAndUpdate(updatedQar);
        // assert
        verify(() => authRepo.getSignedInUserId());
        verifyNever(() => qarCrudApi.updateOnDB(any()));
        expectLater(
            response, equals(const Left(CrudFailure.insufficientPermission())));
      },
    );
    test(
      '''should
      call authFacade.getSignedInUserId()
      call qarCrudApi.updadeOnDB() with updatedQar
      and return Left(CrudFailure.unexpected())
      when user has no permission to update
      ''',
      () async {
        // arrange
        when(() => qarCrudApi.updateOnDB(updatedQar))
            .thenAnswer((_) async => const Left(CrudFailure.unexpected()));
        // act
        final response = await repo.verifyUserAndUpdate(updatedQar);
        // assert
        verify(() => authRepo.getSignedInUserId());
        verify(() => qarCrudApi.updateOnDB(updatedQar));
        expectLater(response, equals(const Left(CrudFailure.unexpected())));
      },
    );
    test(
      '''should
      call authFacade.getSignedInUserId()
      call qarCrudApi.updadeOnDB() with updatedQar
      and return Right(updatedQar)
      when update is successful
      ''',
      () async {
        // arrange
        when(() => qarCrudApi.updateOnDB(updatedQar))
            .thenAnswer((_) async => const Right(unit));
        // act
        final response = await repo.verifyUserAndUpdate(updatedQar);
        // assert
        verify(() => authRepo.getSignedInUserId());
        verify(() => qarCrudApi.updateOnDB(updatedQar));
        expectLater(response, equals(Right(updatedQar)));
      },
    );
  });
  group('verifyUserAndDelete()', () {
    test(
      '''should
      call authFacade.getSignedInUserId()
      call qarCrudApi.readOne() 
      not call qarCrudApi.deleteFromDB()
      and return Left(CrudFailure.unexpected()
      when qar cannot be read
      ''',
      () async {
        // arrange
        when(() => qarCrudApi.readOne(qarDayMonday.id))
            .thenAnswer((_) async => const Left(CrudFailure.unexpected()));
        // act
        final response = await repo.verifyUserAndDelete(qarDayMonday.id);
        // assert
        verify(() => authRepo.getSignedInUserId());
        verify(() => qarCrudApi.readOne(qarDayMonday.id));
        verifyNever(() => qarCrudApi.deleteFromDB(any()));
        expectLater(response, equals(const Left(CrudFailure.unexpected())));
      },
    );
    test(
      '''should
      call authFacade.getSignedInUserId()
      call qarCrudApi.readOne() 
      not call qarCrudApi.deleteFromDB()
      and return Left(CrudFailure.insufficientPermission()
      when user has no permission to delete qar
      ''',
      () async {
        // arrange
        when(() => qarCrudApi.readOne(qarDayMonday.id))
            .thenAnswer((_) async => Right(qarDayMonday));
        when(() => authRepo.getSignedInUserId())
            .thenAnswer((_) async => dummyUserTwo.id);
        // act
        final response = await repo.verifyUserAndDelete(qarDayMonday.id);
        // assert
        verify(() => authRepo.getSignedInUserId());
        verify(() => qarCrudApi.readOne(qarDayMonday.id));
        verifyNever(() => qarCrudApi.deleteFromDB(any()));
        expectLater(
            response, equals(const Left(CrudFailure.insufficientPermission())));
      },
    );
    test(
      '''should
      call authFacade.getSignedInUserId()
      call qarCrudApi.readOne() 
      call qarCrudApi.deleteFromDB()
      and return Right(unit)
      when deletion is successful
      ''',
      () async {
        // arrange
        when(() => qarCrudApi.readOne(qarDayMonday.id))
            .thenAnswer((_) async => Right(qarDayMonday));
        when(() => qarCrudApi.deleteFromDB(qarDayMonday))
            .thenAnswer((_) async => const Right(unit));

        // act
        final response = await repo.verifyUserAndDelete(qarDayMonday.id);

        // assert
        verify(() => authRepo.getSignedInUserId());
        verify(() => qarCrudApi.readOne(qarDayMonday.id));
        verify(() => qarCrudApi.deleteFromDB(qarDayMonday));
        expectLater(response, equals(const Right(unit)));
      },
    );
  });
  group('createSession()', () {
    test(
      '''
      should call questionCrudApi.readAllOfChatBot() but
      not call qarCrudApi.createOnDB()
      and return Left(CrudFailure.unexpected())
      when call on questionRepo is not successful
      ''',
      () async {
        // arrange
        when(() => questionCrudApi.readAllOfChatBot(chatBotDiary.id))
            .thenAnswer(
          (_) async => const Left(CrudFailure.unexpected()),
        );

        // act
        final response = await repo.createSession(chatBotId: chatBotDiary.id);

        // assert
        verify(() => questionCrudApi.readAllOfChatBot(chatBotDiary.id));
        verifyNever(() => qarCrudApi.createOnDB(any()));
        expect(response, equals(const Left(CrudFailure.unexpected())));
      },
    );

    test(
      '''
      should call questionCrudApi.readAllOfChatBot() but
      not call qarCrudApi.createOnDB()
      and return Left(CrudFailure.unexpected(info: 'chatbot has no questions'))
      when chatbot has no questions
      ''',
      () async {
        // arrange

        when(() => questionCrudApi.readAllOfChatBot(chatBotDiary.id))
            .thenAnswer((_) async => Right(emptyList()));
        // act
        final response = await repo.createSession(chatBotId: chatBotDiary.id);

        // assert
        verify(() => questionCrudApi.readAllOfChatBot(chatBotDiary.id));
        verifyNever(() => qarCrudApi.createOnDB(any()));
        expect(
          response,
          equals(
            const Left(
              CrudFailure.unexpected(info: 'chatbot has no questions'),
            ),
          ),
        );
      },
    );
    test(
      '''
      should call questionCrudApi.readAllOfChatBot() and
      call qarCrudApi.createOnDB()
      and return Left(CrudFailure.unexpected())
      when qar creation is not successful
      ''',
      () async {
        // arrange

        when(() => questionCrudApi.readAllOfChatBot(chatBotDiary.id))
            .thenAnswer((_) async => Right(listOf(Question.empty())));

        when(() => qarCrudApi.createOnDB(any()))
            .thenAnswer((_) async => const Left(CrudFailure.unexpected()));
        // act
        final response = await repo.createSession(chatBotId: chatBotDiary.id);

        // assert
        verify(() => questionCrudApi.readAllOfChatBot(chatBotDiary.id));
        verify(() => qarCrudApi.createOnDB(any()));
        expect(
          response,
          equals(
            const Left(
              CrudFailure.unexpected(),
            ),
          ),
        );
      },
    );
    test(
      '''
      should call questionCrudApi.readAllOfChatBot() and
      call qarCrudApi.createOnDB() with the arguments in the following order:
        qar1,
        qar2,
        qar3,
      and return Right(sessionId)
      when qar creation is not successful
      ''',
      () async {
        // arrange
        final q1 = Question.empty().copyWith(
          updatedAt: DateTime.utc(1),
        );
        final q2 = Question.empty().copyWith(
          updatedAt: DateTime.utc(2),
        );
        final q3 = Question.empty().copyWith(
          updatedAt: DateTime.utc(3),
        );

        final qar1 = Qar.createWithQuestion(q1)
            .copyWith(
              isVisible: true,
              sessionId: testSessionId,
              visibleSince: testTime,
            )
            .addMetaData(
                id: testId, createdBy: dummyUserOne.id, createdAt: testTime);
        final qar2 = Qar.createWithQuestion(q1)
            .copyWith(isVisible: false, sessionId: testSessionId)
            .addMetaData(
                id: testId, createdBy: dummyUserOne.id, createdAt: testTime);
        final qar3 = Qar.createWithQuestion(q1)
            .copyWith(isVisible: false, sessionId: testSessionId)
            .addMetaData(
                id: testId, createdBy: dummyUserOne.id, createdAt: testTime);

        when(() => questionCrudApi.readAllOfChatBot(chatBotDiary.id))
            .thenAnswer((_) async => Right(listOf(q2, q1, q3)));

        when(() => qarCrudApi.createOnDB(any()))
            .thenAnswer((_) async => const Right(unit));
        // act
        final response = await repo.createSession(chatBotId: chatBotDiary.id);

        // assert
        verify(() => questionCrudApi.readAllOfChatBot(chatBotDiary.id));
        verifyInOrder([
          () => qarCrudApi.createOnDB(qar1),
          () => qarCrudApi.createOnDB(qar2),
          () => qarCrudApi.createOnDB(qar3),
        ]);

        expect(response, equals(Right(testSessionId)));
      },
    );
  });
}
