// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/i_meta_data_provider.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/answer_option/answer_option.dart';
import 'package:smart_chat/domain/repositories/api/i_crud_api.dart';
import 'package:smart_chat/domain/repositories/auth/i_auth_repo.dart';
import 'package:smart_chat/infrastructure/repositories/client/crud/client_answer_option_crud_repo.dart';
import '../../../../fixtures/chatbots/diary/answer_options_diary.dart';
import '../../../../fixtures/user.dart';

class MockIAuthRepo extends Mock implements IAuthRepo {}

class MockIMetaDataProvider extends Mock implements IMetaDataProvider {}

class MockIAnswerOptionCrudApi extends Mock implements IAnswerOptionCrudApi {}

void main() {
  late MockIAuthRepo authRepo;
  late MockIMetaDataProvider metaDataProvider;
  late MockIAnswerOptionCrudApi crudApi;
  late ClientAnswerOptionCrud repo;

  const UPDATED_AT = '2022-01-02T12:12:00.000000';
  final testTime = DateTime.parse(UPDATED_AT);
  const TEST_ID = 'TEST_ID';
  final testId = UniqueId.fromUniqueString(TEST_ID);

  setUp(() async {
    registerFallbackValue<AnswerOption>(AnswerOption.empty());
    authRepo = MockIAuthRepo();
    metaDataProvider = MockIMetaDataProvider();
    crudApi = MockIAnswerOptionCrudApi();

    repo = ClientAnswerOptionCrud(
      authRepo,
      metaDataProvider,
      crudApi,
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
    final expectedAnswerOption = answerOptionDayGood.copyWith(
      id: testId,
      createdAt: testTime,
      createdBy: dummyUserTwo.id,
      updatedAt: testTime,
      updatedBy: dummyUserTwo.id,
    );
    test(
      '''should
      call authFacade.getSignedInUserId()
      call metaDataProvider.getCurrentTime()
      call metaDataProvider.getUniqueId()
      call crudApi.createOnDB() with answerOption with metadata
      and return Right(answerOption) when creation was successful
      ''',
      () async {
        // arrange
        when(() => crudApi.createOnDB(expectedAnswerOption))
            .thenAnswer((_) async => const Right(unit));
        // act
        final response = await repo.createWithMetaData(answerOptionDayGood);

        // assert
        verify(() => authRepo.getSignedInUserId());
        verify(() => metaDataProvider.getCurrentTime());
        verify(() => metaDataProvider.getUniqueId());
        verify(() => crudApi.createOnDB(expectedAnswerOption));
        expectLater(response, equals(Right(expectedAnswerOption)));
      },
    );
    test(
      '''should
      call authFacade.getSignedInUserId()
      call metaDataProvider.getCurrentTime()
      call metaDataProvider.getUniqueId()
      call crudApi.createOnDB() with answerOption with metadata
      and return Left(CrudFailure) when creation was not successful
      ''',
      () async {
        // arrange
        when(() => crudApi.createOnDB(expectedAnswerOption))
            .thenAnswer((_) async => const Left(CrudFailure.unexpected()));
        // act
        final response = await repo.createWithMetaData(answerOptionDayGood);

        // assert
        verify(() => authRepo.getSignedInUserId());
        verify(() => metaDataProvider.getCurrentTime());
        verify(() => metaDataProvider.getUniqueId());
        verify(() => crudApi.createOnDB(expectedAnswerOption));
        expectLater(response, equals(const Left(CrudFailure.unexpected())));
      },
    );
  });
  group('updateWithMetaData()', () {
    final updatedAnswerOption = answerOptionDayGood.copyWith(
      translations: answerOptionBodyLangMapDayGoodExtended,
    );

    final updatedAnswerOptionAndUpdatedMetaData =
        updatedAnswerOption.updateMetaData(
      updatedAt: testTime,
      updatedBy: dummyUserTwo.id,
    );
    test(
      '''should
      call authFacade.getSignedInUserId()
      call crudApi.readOne()
      call metaDataProvider.getCurrentTime()
      call crudApi.updateOnDB() with updatedAnswerOptionAndUpdatedMetaData
      and return Right(answerOption) when update was successful
      ''',
      () async {
        // arrange
        when(() => crudApi.readOne(answerOptionDayGood.id))
            .thenAnswer((_) async => Right(answerOptionDayGood));
        when(() => crudApi.updateOnDB(updatedAnswerOptionAndUpdatedMetaData))
            .thenAnswer((_) async => const Right(unit));
        // act
        final response = await repo.updateWithMetaData(updatedAnswerOption);

        // assert
        verify(() => authRepo.getSignedInUserId());
        verify(() => crudApi.readOne(answerOptionDayGood.id));
        verify(() => metaDataProvider.getCurrentTime());
        verify(() => crudApi.updateOnDB(updatedAnswerOptionAndUpdatedMetaData));
        expectLater(
            response, equals(Right(updatedAnswerOptionAndUpdatedMetaData)));
      },
    );
    test(
      '''should  
      call authFacade.getSignedInUserId()
      call crudApi.readOne()
      not call metaDataProvider.getCurrentTime()
      not call crudApi.updateOnDB() 
      and return Right(answerOption) when updated answerOption and answerOption on db are equal
      ''',
      () async {
        // arrange
        when(() => crudApi.readOne(answerOptionDayGood.id))
            .thenAnswer((_) async => Right(updatedAnswerOption));

        // act
        final response = await repo.updateWithMetaData(updatedAnswerOption);

        verify(() => authRepo.getSignedInUserId());
        verify(() => crudApi.readOne(answerOptionDayGood.id));
        verifyNever(() => metaDataProvider.getCurrentTime());
        verifyNever(() => crudApi.updateOnDB(any()));
        expectLater(response, equals(Right(updatedAnswerOption)));
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
        when(() => crudApi.readOne(answerOptionDayGood.id))
            .thenAnswer((_) async => const Left(CrudFailure.unexpected()));

        // act
        final response = await repo.updateWithMetaData(updatedAnswerOption);

        verify(() => authRepo.getSignedInUserId());
        verify(() => crudApi.readOne(answerOptionDayGood.id));
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
      call crudApi.updateOnDB() with updatedAnswerOptionAndUpdatedMetaData
      and return Left(CrudFailure.unexpected()) when update on crudApi is not successful
      ''',
      () async {
        // arrange
        when(() => crudApi.readOne(answerOptionDayGood.id))
            .thenAnswer((_) async => Right(answerOptionDayGood));
        when(() => crudApi.updateOnDB(updatedAnswerOptionAndUpdatedMetaData))
            .thenAnswer((_) async => const Left(CrudFailure.unexpected()));

        // act
        final response = await repo.updateWithMetaData(updatedAnswerOption);

        verify(() => authRepo.getSignedInUserId());
        verify(() => crudApi.readOne(answerOptionDayGood.id));
        verify(() => metaDataProvider.getCurrentTime());
        verify(() => crudApi.updateOnDB(updatedAnswerOptionAndUpdatedMetaData));
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
        when(() => crudApi.readOne(answerOptionDayGood.id))
            .thenAnswer((_) async => Right(answerOptionDayGood));
        when(() => crudApi.deleteFromDB(answerOptionDayGood))
            .thenAnswer((_) async => const Right(unit));

        // act
        final response = await repo.delete(answerOptionDayGood.id);

        verify(() => crudApi.readOne(answerOptionDayGood.id));
        verify(() => crudApi.deleteFromDB(answerOptionDayGood));
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
        when(() => crudApi.readOne(answerOptionDayGood.id))
            .thenAnswer((_) async => const Left(CrudFailure.unexpected()));

        // act
        final response = await repo.delete(answerOptionDayGood.id);

        verify(() => crudApi.readOne(answerOptionDayGood.id));
        verifyNever(() => crudApi.deleteFromDB(answerOptionDayGood));
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
        when(() => crudApi.readOne(answerOptionDayGood.id))
            .thenAnswer((_) async => Right(answerOptionDayGood));
        when(() => crudApi.deleteFromDB(answerOptionDayGood))
            .thenAnswer((_) async => const Left(CrudFailure.unexpected()));

        // act
        final response = await repo.delete(answerOptionDayGood.id);

        verify(() => crudApi.readOne(answerOptionDayGood.id));
        verify(() => crudApi.deleteFromDB(answerOptionDayGood));
        expectLater(response, equals(const Left(CrudFailure.unexpected())));
      },
    );
  });
}
