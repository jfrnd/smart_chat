// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/i_meta_data_provider.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/chatbot/chatbot.dart';
import 'package:smart_chat/domain/entities/subscription/subscription_trigger.dart';
import 'package:smart_chat/domain/repositories/api/i_crud_api.dart';
import 'package:smart_chat/domain/repositories/auth/i_auth_repo.dart';
import 'package:smart_chat/infrastructure/repositories/client/crud/client_chatbot_crud_repo.dart';
import '../../../../fixtures/chatbots/diary/chatbot_diary.dart';
import '../../../../fixtures/chatbots/survey/chatbot_survey.dart';
import '../../../../fixtures/user.dart';

class MockIAuthRepo extends Mock implements IAuthRepo {}

class MockIMetaDataProvider extends Mock implements IMetaDataProvider {}

class MockIChatBotCrudApi extends Mock implements IChatBotCrudApi {}

class MockIImageCrudApi extends Mock implements IImageCrudApi {}

class MockIUserCrudApi extends Mock implements IUserCrudApi {}

void main() {
  late MockIAuthRepo authRepo;
  late MockIMetaDataProvider metaDataProvider;
  late MockIChatBotCrudApi crudApi;
  late MockIImageCrudApi imageCrudApi;
  late MockIUserCrudApi userCrudApi;
  late ClientChatBotCrud repo;

  const UPDATED_AT = '2022-01-02T12:12:00.000000';
  final testTime = DateTime.parse(UPDATED_AT);
  const TEST_ID = 'TEST_ID';
  final testId = UniqueId.fromUniqueString(TEST_ID);

  setUp(() async {
    registerFallbackValue<ChatBot>(ChatBot.empty());
    registerFallbackValue<UniqueId>(UniqueId());
    authRepo = MockIAuthRepo();
    metaDataProvider = MockIMetaDataProvider();
    crudApi = MockIChatBotCrudApi();
    imageCrudApi = MockIImageCrudApi();
    userCrudApi = MockIUserCrudApi();

    repo = ClientChatBotCrud(
      authRepo,
      metaDataProvider,
      crudApi,
      imageCrudApi,
      userCrudApi,
    );

    when(() => authRepo.getSignedInUserId())
        .thenAnswer((_) async => dummyUserTwo.id);

    when(() => metaDataProvider.getCurrentTime()).thenAnswer((_) => testTime);

    when(() => metaDataProvider.getUniqueId()).thenAnswer((_) => testId);
  });

  tearDown(() {
    reset(metaDataProvider);
    reset(authRepo);
    reset(crudApi);
  });

  group('createWithMetaData()', () {
    final expectedChatBot = chatBotSurvey.copyWith(
      id: testId,
      createdAt: testTime,
      createdBy: dummyUserTwo.id,
      updatedAt: testTime,
      updatedBy: dummyUserTwo.id,
      triggers: chatBotSurvey.triggers.withOffSet(-3),
    );
    test(
      '''should
      call authFacade.getSignedInUserId()
      call metaDataProvider.getCurrentTime()
      call metaDataProvider.getUniqueId()
      call crudApi.readOne()
      call crudApi.createOnDB() with chatBot with metadata
      and return Right(ChatBot) when creation was successful
      ''',
      () async {
        // arrange
        when(() => crudApi.createOnDB(expectedChatBot))
            .thenAnswer((_) async => const Right(unit));
        when(() => userCrudApi.readOne(dummyUserTwo.id))
            .thenAnswer((_) async => Right(dummyUserTwo));
        // act
        final response = await repo.createWithMetaData(chatBotSurvey);

        // assert
        verify(() => authRepo.getSignedInUserId());
        verify(() => metaDataProvider.getCurrentTime());
        verify(() => metaDataProvider.getUniqueId());
        verify(() => crudApi.createOnDB(expectedChatBot));
        verify(() => userCrudApi.readOne(dummyUserTwo.id));
        expectLater(response, equals(Right(expectedChatBot)));
      },
    );
    test(
      '''should
      call authFacade.getSignedInUserId()
      call metaDataProvider.getCurrentTime()
      call metaDataProvider.getUniqueId()
      call crudApi.readOne()
      call crudApi.createOnDB() with chatBot with metadata
      and return Left(CrudFailure) when creation was not successful
      ''',
      () async {
        // arrange
        when(() => crudApi.createOnDB(expectedChatBot))
            .thenAnswer((_) async => const Left(CrudFailure.unexpected()));
        when(() => userCrudApi.readOne(dummyUserTwo.id))
            .thenAnswer((_) async => Right(dummyUserTwo));
        // act
        final response = await repo.createWithMetaData(chatBotSurvey);

        // assert
        verify(() => authRepo.getSignedInUserId());
        verify(() => metaDataProvider.getCurrentTime());
        verify(() => metaDataProvider.getUniqueId());
        verify(() => userCrudApi.readOne(dummyUserTwo.id));
        verify(() => crudApi.createOnDB(expectedChatBot));
        expectLater(response, equals(const Left(CrudFailure.unexpected())));
      },
    );
  });
  group('updateWithMetaData()', () {
    final updatedChatBot = chatBotDiary.copyWith(
      translations: chatBotNameLangMapDiaryExtended,
    );

    final updatedChatBotAndUpdatedMetaData = updatedChatBot.updateMetaData(
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
        when(() => crudApi.readOne(chatBotDiary.id))
            .thenAnswer((_) async => Right(chatBotDiary));
        when(() => crudApi.updateOnDB(updatedChatBotAndUpdatedMetaData))
            .thenAnswer((_) async => const Right(unit));
        // act
        final response = await repo.updateWithMetaData(updatedChatBot);

        // assert
        verify(() => authRepo.getSignedInUserId());
        verify(() => crudApi.readOne(chatBotDiary.id));
        verify(() => metaDataProvider.getCurrentTime());
        verify(() => crudApi.updateOnDB(updatedChatBotAndUpdatedMetaData));
        expectLater(response, equals(Right(updatedChatBotAndUpdatedMetaData)));
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
        when(() => crudApi.readOne(chatBotDiary.id))
            .thenAnswer((_) async => Right(updatedChatBot));

        // act
        final response = await repo.updateWithMetaData(updatedChatBot);

        verify(() => authRepo.getSignedInUserId());
        verify(() => crudApi.readOne(chatBotDiary.id));
        verifyNever(() => metaDataProvider.getCurrentTime());
        verifyNever(() => crudApi.updateOnDB(any()));
        expectLater(response, equals(Right(updatedChatBot)));
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
        when(() => crudApi.readOne(chatBotDiary.id))
            .thenAnswer((_) async => const Left(CrudFailure.unexpected()));

        // act
        final response = await repo.updateWithMetaData(updatedChatBot);

        verify(() => authRepo.getSignedInUserId());
        verify(() => crudApi.readOne(chatBotDiary.id));
        verifyNever(() => metaDataProvider.getCurrentTime());
        verifyNever(() => crudApi.updateOnDB(any()));
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
        when(() => crudApi.readOne(chatBotDiary.id))
            .thenAnswer((_) async => Right(chatBotDiary));
        when(() => crudApi.updateOnDB(updatedChatBotAndUpdatedMetaData))
            .thenAnswer((_) async => const Left(CrudFailure.unexpected()));

        // act
        final response = await repo.updateWithMetaData(updatedChatBot);

        verify(() => authRepo.getSignedInUserId());
        verify(() => crudApi.readOne(chatBotDiary.id));
        verify(() => metaDataProvider.getCurrentTime());
        verify(() => crudApi.updateOnDB(updatedChatBotAndUpdatedMetaData));
        expectLater(response, equals(const Left(CrudFailure.unexpected())));
      },
    );
  });
  group('delete()', () {
    test(
      '''should
      call crudApi.readOne()
      call crudApi.deleteFromDB()
      call imageCrudApi.deleteImage()
      and return Right(unit) when deletion was successful
      ''',
      () async {
        //arrange
        when(() => crudApi.readOne(chatBotDiary.id))
            .thenAnswer((_) async => Right(chatBotDiary));
        when(() => crudApi.deleteFromDB(chatBotDiary))
            .thenAnswer((_) async => const Right(unit));
        when(() => imageCrudApi.deleteImage(chatBotDiary.firebaseImagePath))
            .thenAnswer((_) async => const Right(unit));

        // act
        final response = await repo.delete(chatBotDiary.id);

        verify(() => crudApi.readOne(chatBotDiary.id));
        verify(() => crudApi.deleteFromDB(chatBotDiary));
        verify(() => imageCrudApi.deleteImage(chatBotDiary.firebaseImagePath));
        expectLater(response, equals(const Right(unit)));
      },
    );
    test(
      '''should
      call crudApi.readOne()
      not call crudApi.deleteFromDB()
      not call imageCrudApi.deleteImage()
      and return Left(CrudFailure.unexpected()) when readOne was not successful
      ''',
      () async {
        //arrange
        when(() => crudApi.readOne(chatBotDiary.id))
            .thenAnswer((_) async => const Left(CrudFailure.unexpected()));

        // act
        final response = await repo.delete(chatBotDiary.id);

        verify(() => crudApi.readOne(chatBotDiary.id));
        verifyNever(() => crudApi.deleteFromDB(chatBotDiary));
        verifyNever(
            () => imageCrudApi.deleteImage(chatBotDiary.firebaseImagePath));
        expectLater(response, equals(const Left(CrudFailure.unexpected())));
      },
    );
    test(
      '''should
      call crudApi.readOne()
      call crudApi.deleteFromDB()
      not call imageCrudApi.deleteImage()
      and return Left(CrudFailure.unexpected()) when deletion was not successful
      ''',
      () async {
        //arrange
        when(() => crudApi.readOne(chatBotDiary.id))
            .thenAnswer((_) async => Right(chatBotDiary));
        when(() => crudApi.deleteFromDB(chatBotDiary))
            .thenAnswer((_) async => const Left(CrudFailure.unexpected()));

        // act
        final response = await repo.delete(chatBotDiary.id);

        verify(() => crudApi.readOne(chatBotDiary.id));
        verify(() => crudApi.deleteFromDB(chatBotDiary));
        verifyNever(
            () => imageCrudApi.deleteImage(chatBotDiary.firebaseImagePath));
        expectLater(response, equals(const Left(CrudFailure.unexpected())));
      },
    );
  });
}
