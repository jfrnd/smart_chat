// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/i_meta_data_provider.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/question/question.dart';
import 'package:smart_chat/domain/repositories/api/i_crud_api.dart';
import 'package:smart_chat/domain/repositories/auth/i_auth_repo.dart';
import 'package:smart_chat/domain/repositories/crud/i_crud_repo.dart';
import 'package:smart_chat/infrastructure/repositories/client/crud/client_question_crud_repo.dart';
import '../../../../fixtures/chatbots/diary/questions_diary.dart';
import '../../../../fixtures/user.dart';

class MockIAuthRepo extends Mock implements IAuthRepo {}

class MockIMetaDataProvider extends Mock implements IMetaDataProvider {}

class MockIQuestionCrudApi extends Mock implements IQuestionCrudApi {}

class MockIAnswerOptionCrudRepo extends Mock implements IAnswerOptionCrudRepo {}

void main() {
  late MockIAuthRepo authRepo;
  late MockIMetaDataProvider metaDataProvider;
  late MockIQuestionCrudApi questionCrudApi;
  late MockIAnswerOptionCrudRepo answerOptionRepoCrud;
  late ClientQuestionCrud repo;

  const UPDATED_AT = '2022-01-02T12:12:00.000000';
  final testTime = DateTime.parse(UPDATED_AT);
  const TEST_ID = 'TEST_ID';
  final testId = UniqueId.fromUniqueString(TEST_ID);

  setUp(() async {
    registerFallbackValue<Question>(Question.empty());
    authRepo = MockIAuthRepo();
    metaDataProvider = MockIMetaDataProvider();
    questionCrudApi = MockIQuestionCrudApi();
    answerOptionRepoCrud = MockIAnswerOptionCrudRepo();

    repo = ClientQuestionCrud(
      authRepo,
      metaDataProvider,
      answerOptionRepoCrud,
      questionCrudApi,
    );

    when(() => authRepo.getSignedInUserId())
        .thenAnswer((_) async => dummyUserTwo.id);

    when(() => metaDataProvider.getCurrentTime()).thenAnswer((_) => testTime);

    when(() => metaDataProvider.getUniqueId()).thenAnswer((_) => testId);
  });

  tearDown(() {
    reset(metaDataProvider);
    reset(authRepo);
    reset(questionCrudApi);
    reset(answerOptionRepoCrud);
  });

  group('create()', () {
//TODO create()
  });

  group('update()', () {
    final updatedQuestion = questionDay.copyWith(
      translations: questionBodyLangMapDayExtended,
    );

    final updatedQuestionAndUpdatedMetaData = updatedQuestion.updateMetaData(
      updatedAt: testTime,
      updatedBy: dummyUserTwo.id,
    );
    test(
      '''should
      call authFacade.getSignedInUserId()
      call crudApi.readOne()
      call metaDataProvider.getCurrentTime()
      call crudApi.updateOnDB() with updatedChatBotAndUpdatedMetaData
      and return Right(ChatBot) when update was successful
      ''',
      () async {
        // arrange
        when(() => questionCrudApi.readOne(questionDay.id))
            .thenAnswer((_) async => Right(questionDay));
        when(() =>
                questionCrudApi.updateOnDB(updatedQuestionAndUpdatedMetaData))
            .thenAnswer((_) async => const Right(unit));
        // act
        final response = await repo.update(updatedQuestion);

        // assert
        verify(() => authRepo.getSignedInUserId());
        verify(() => questionCrudApi.readOne(questionDay.id));
        verify(() => metaDataProvider.getCurrentTime());
        verify(() =>
            questionCrudApi.updateOnDB(updatedQuestionAndUpdatedMetaData));
        expectLater(response, equals(Right(updatedQuestionAndUpdatedMetaData)));
      },
    );
    test(
      '''should  
      call authFacade.getSignedInUserId()
      call crudApi.readOne()
      not call metaDataProvider.getCurrentTime()
      not call crudApi.updateOnDB() 
      and return Right(ChatBot) when updated chatbot and chatbot on db are equal
      ''',
      () async {
        // arrange
        when(() => questionCrudApi.readOne(questionDay.id))
            .thenAnswer((_) async => Right(updatedQuestion));

        // act
        final response = await repo.update(updatedQuestion);

        verify(() => authRepo.getSignedInUserId());
        verify(() => questionCrudApi.readOne(questionDay.id));
        verifyNever(() => metaDataProvider.getCurrentTime());
        verifyNever(() => questionCrudApi.updateOnDB(any()));
        expectLater(response, equals(Right(updatedQuestion)));
      },
    );

    test(
      '''should  
      call authFacade.getSignedInUserId()
      call crudApi.readOne()
      not call metaDataProvider.getCurrentTime()
      not crudApi.updateOnDB() 
      and return Left(CrudFailure.unexpected()) when readOne on crudApi is not successful
      ''',
      () async {
        // arrange
        when(() => questionCrudApi.readOne(questionDay.id))
            .thenAnswer((_) async => const Left(CrudFailure.unexpected()));

        // act
        final response = await repo.update(updatedQuestion);

        verify(() => authRepo.getSignedInUserId());
        verify(() => questionCrudApi.readOne(questionDay.id));
        verifyNever(() => metaDataProvider.getCurrentTime());
        verifyNever(() => questionCrudApi.updateOnDB(any()));
        expectLater(response, equals(const Left(CrudFailure.unexpected())));
      },
    );
    test(
      '''should  
      call authFacade.getSignedInUserId()
      call crudApi.readOne()
      call metaDataProvider.getCurrentTime()
      call crudApi.updateOnDB() with updatedChatBotAndUpdatedMetaData
      and return Left(CrudFailure.unexpected()) when update on crudApi is not successful
      ''',
      () async {
        // arrange
        when(() => questionCrudApi.readOne(questionDay.id))
            .thenAnswer((_) async => Right(questionDay));
        when(() =>
                questionCrudApi.updateOnDB(updatedQuestionAndUpdatedMetaData))
            .thenAnswer((_) async => const Left(CrudFailure.unexpected()));

        // act
        final response = await repo.update(updatedQuestion);

        verify(() => authRepo.getSignedInUserId());
        verify(() => questionCrudApi.readOne(questionDay.id));
        verify(() => metaDataProvider.getCurrentTime());
        verify(() =>
            questionCrudApi.updateOnDB(updatedQuestionAndUpdatedMetaData));
        expectLater(response, equals(const Left(CrudFailure.unexpected())));
      },
    );
  });
  group('delete()', () {
    test(
      '''should
      call crudApi.readOne()
      call crudApi.deleteFromDB()
      and return Right(unit) when deletion was successful
      ''',
      () async {
        //arrange
        when(() => questionCrudApi.readOne(questionDay.id))
            .thenAnswer((_) async => Right(questionDay));
        when(() => questionCrudApi.deleteFromDB(questionDay))
            .thenAnswer((_) async => const Right(unit));

        // act
        final response = await repo.delete(questionDay.id);

        verify(() => questionCrudApi.readOne(questionDay.id));
        verify(() => questionCrudApi.deleteFromDB(questionDay));
        expectLater(response, equals(const Right(unit)));
      },
    );
    test(
      '''should
      call crudApi.readOne()
      not call crudApi.deleteFromDB()
      and return Left(CrudFailure.unexpected()) when readOne was not successful
      ''',
      () async {
        //arrange
        when(() => questionCrudApi.readOne(questionDay.id))
            .thenAnswer((_) async => const Left(CrudFailure.unexpected()));

        // act
        final response = await repo.delete(questionDay.id);

        verify(() => questionCrudApi.readOne(questionDay.id));
        verifyNever(() => questionCrudApi.deleteFromDB(questionDay));
        expectLater(response, equals(const Left(CrudFailure.unexpected())));
      },
    );
    test(
      '''should
      call crudApi.readOne()
      not call crudApi.deleteFromDB()
      and return Left(CrudFailure.unexpected()) when deletion was not successful
      ''',
      () async {
        //arrange
        when(() => questionCrudApi.readOne(questionDay.id))
            .thenAnswer((_) async => Right(questionDay));
        when(() => questionCrudApi.deleteFromDB(questionDay))
            .thenAnswer((_) async => const Left(CrudFailure.unexpected()));

        // act
        final response = await repo.delete(questionDay.id);

        verify(() => questionCrudApi.readOne(questionDay.id));
        verify(() => questionCrudApi.deleteFromDB(questionDay));
        expectLater(response, equals(const Left(CrudFailure.unexpected())));
      },
    );
  });
}
