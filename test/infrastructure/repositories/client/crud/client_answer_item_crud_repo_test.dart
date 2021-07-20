// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kt_dart/kt.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/i_meta_data_provider.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/answer_item/answer_item.dart';
import 'package:smart_chat/domain/entities/answer_item/answer_item_value.dart';
import 'package:smart_chat/domain/entities/qar/qar.dart';
import 'package:smart_chat/domain/repositories/api/i_crud_api.dart';
import 'package:smart_chat/domain/repositories/auth/i_auth_repo.dart';
import 'package:smart_chat/infrastructure/repositories/client/crud/client_answer_item_crud_repo.dart';
import '../../../../fixtures/chatbots/diary/answer_items_diary.dart';
import '../../../../fixtures/chatbots/diary/answer_options_diary.dart';
import '../../../../fixtures/chatbots/diary/qars_diary.dart';
import '../../../../fixtures/chatbots/diary/questions_diary.dart';
import '../../../../fixtures/user.dart';

class MockIAuthRepo extends Mock implements IAuthRepo {}

class MockIMetaDataProvider extends Mock implements IMetaDataProvider {}

class MockIQarCrudApi extends Mock implements IQarCrudApi {}

class MockIAnswerItemCrudApi extends Mock implements IAnswerItemCrudApi {}

class MockIQuestionCrudApi extends Mock implements IQuestionCrudApi {}

void main() {
  late MockIAuthRepo authRepo;
  late MockIMetaDataProvider metaDataProvider;
  late MockIQarCrudApi qarCrudApi;
  late MockIAnswerItemCrudApi answerItemCrudApi;
  late MockIQuestionCrudApi questionCrudApi;
  late ClientAnswerItemCrud repo;

  const UPDATED_AT = '2022-01-02T12:12:00.000000';
  final testTime = DateTime.parse(UPDATED_AT);
  const TEST_ID = 'TEST_ID';
  final testId = UniqueId.fromUniqueString(TEST_ID);

  setUp(() async {
    registerFallbackValue<AnswerItem>(AnswerItem.empty());
    registerFallbackValue<Qar>(Qar.empty());
    registerFallbackValue<UniqueId>(UniqueId());
    registerFallbackValue<KtList<UniqueId>>(listOf(UniqueId()));

    authRepo = MockIAuthRepo();
    metaDataProvider = MockIMetaDataProvider();
    answerItemCrudApi = MockIAnswerItemCrudApi();
    questionCrudApi = MockIQuestionCrudApi();
    qarCrudApi = MockIQarCrudApi();

    when(() => authRepo.getSignedInUserId())
        .thenAnswer((_) async => dummyUserOne.id);
    when(() => metaDataProvider.getUniqueId()).thenReturn(testId);
    when(() => metaDataProvider.getCurrentTime()).thenReturn(testTime);

    repo = ClientAnswerItemCrud(
      authRepo,
      metaDataProvider,
      answerItemCrudApi,
      qarCrudApi,
      questionCrudApi,
    );
  });

  tearDown(() {
    reset(authRepo);
    reset(metaDataProvider);
    reset(answerItemCrudApi);
    reset(qarCrudApi);
    reset(questionCrudApi);
  });

  group('verifyUserAndReadOne()', () {
    test(
      '''should not return item but failure
      when requesting userId does not belong to the item
      ''',
      () async {
        // arrange
        when(() => authRepo.getSignedInUserId())
            .thenAnswer((_) async => dummyUserTwo.id);
        when(() => answerItemCrudApi.readOne(answerItemDayGoodMonday.id))
            .thenAnswer((_) async => Right(answerItemDayGoodMonday));
        // act
        final response =
            await repo.verifyUserAndReadOne(answerItemDayGoodMonday.id);
        // assert
        verify(() => authRepo.getSignedInUserId());
        verify(() => answerItemCrudApi.readOne(answerItemDayGoodMonday.id));
        expectLater(
            response, equals(const Left(CrudFailure.insufficientPermission())));
      },
    );
    test(
      '''should return failure
      when reading is not successful
      ''',
      () async {
        // arrange
        when(() => answerItemCrudApi.readOne(answerItemDayGoodMonday.id))
            .thenAnswer((_) async => const Left(CrudFailure.unexpected()));
        // act
        final response =
            await repo.verifyUserAndReadOne(answerItemDayGoodMonday.id);
        // assert
        verify(() => authRepo.getSignedInUserId());
        verify(() => answerItemCrudApi.readOne(answerItemDayGoodMonday.id));
        expectLater(response, equals(const Left(CrudFailure.unexpected())));
      },
    );
    test(
      '''should return item
      when userId belongs to item and reading is successful
      ''',
      () async {
        // arrange
        when(() => answerItemCrudApi.readOne(answerItemDayGoodMonday.id))
            .thenAnswer((_) async => Right(answerItemDayGoodMonday));
        // act
        final response =
            await repo.verifyUserAndReadOne(answerItemDayGoodMonday.id);
        // assert
        verify(() => authRepo.getSignedInUserId());
        verify(() => answerItemCrudApi.readOne(answerItemDayGoodMonday.id));
        expectLater(response, equals(Right(answerItemDayGoodMonday)));
      },
    );
  });
  group('createWithMetaData()', () {
    final expectedItem = answerItemDayGoodMonday.addMetaData(
      id: testId,
      createdBy: dummyUserOne.id,
      createdAt: testTime,
    );
    test(
      '''should
      call authFacade.getSignedInUserId()
      call metaDataProvider.getCurrentTime()
      call metaDataProvider.getUniqueId()
      call answerItemCrudApi.createOnDB() with answerItemDayGoodMonday with metadata
      and return Right(expectedItem) when creation was successful
      ''',
      () async {
        // arrange
        when(() => answerItemCrudApi.createOnDB(expectedItem))
            .thenAnswer((_) async => const Right(unit));
        // act
        final response = await repo.createWithMetaData(answerItemDayGoodMonday);

        // assert
        verify(() => authRepo.getSignedInUserId());
        verify(() => metaDataProvider.getCurrentTime());
        verify(() => metaDataProvider.getUniqueId());
        verify(() => answerItemCrudApi.createOnDB(expectedItem));
        expectLater(response, equals(Right(expectedItem)));
      },
    );
    test(
      '''should
      call authFacade.getSignedInUserId()
      call metaDataProvider.getCurrentTime()
      call metaDataProvider.getUniqueId()
      call answerItemCrudApi.createOnDB() with answerItemDayGoodMonday with metadata
      and return Left(CrudFailure) when creation was not successful
      ''',
      () async {
        // arrange
        when(() => answerItemCrudApi.createOnDB(expectedItem))
            .thenAnswer((_) async => const Left(CrudFailure.unexpected()));
        // act
        final response = await repo.createWithMetaData(answerItemDayGoodMonday);

        // assert
        verify(() => authRepo.getSignedInUserId());
        verify(() => metaDataProvider.getCurrentTime());
        verify(() => metaDataProvider.getUniqueId());
        verify(() => answerItemCrudApi.createOnDB(expectedItem));
        expectLater(response, equals(const Left(CrudFailure.unexpected())));
      },
    );
  });
  group('create', () {
    final itemMultiSelection = answerItemActivityFriendsMonday;
    final qarMultiSelection = qarActiviyMonday
        .linkedWithAnswerItem(answerItemActivitySoccerMonday.id);
    final questionMultiSelection = questionActivity;

    final firstItem = answerItemDayGoodMonday;
    final emptyQarSingleSelection = qarDayMonday;
    final questionSingleSelection = questionDay;

    final firstItemOnDB = firstItem.addMetaData(
        id: testId, createdBy: dummyUserOne.id, createdAt: testTime);
    final qarSingleSelection =
        qarDayMonday.linkedWithAnswerItem(firstItemOnDB.id);
    final updatedItem = AnswerItem.createWithQar(
        qar: qarSingleSelection,
        value: AnswerItemValue.fromAnswerOptionId(answerOptionDayBad.id));
    test(
      '''should read qar and return left(CrudFailure.unexpected()) 
      when reading is not successful''',
      () async {
        // arrange
        when(() => qarCrudApi.readOne(itemMultiSelection.qarId))
            .thenAnswer((_) async => const Left(CrudFailure.unexpected()));
        // act
        final response = await repo.create(itemMultiSelection);
        // assert
        verify(() => qarCrudApi.readOne(itemMultiSelection.qarId));
        expect(response, equals(const Left(CrudFailure.unexpected())));
      },
    );
    test(
      '''should read qar and question and return left(CrudFailure.unexpected()) 
      when reading question is not successful''',
      () async {
        // arrange
        when(() => qarCrudApi.readOne(itemMultiSelection.qarId))
            .thenAnswer((_) async => Right(qarMultiSelection));
        when(() => questionCrudApi.readOne(qarMultiSelection.questionId))
            .thenAnswer((_) async => const Left(CrudFailure.unexpected()));
        // act
        final response = await repo.create(itemMultiSelection);
        // assert
        verify(() => qarCrudApi.readOne(itemMultiSelection.qarId));
        verify(() => questionCrudApi.readOne(qarMultiSelection.questionId));
        expect(response, equals(const Left(CrudFailure.unexpected())));
      },
    );
    test(
      '''should read qar and question and call answerItemCrudApi.createOnDB 
      when question has multi selection enabled''',
      () async {
        // arrange
        when(() => qarCrudApi.readOne(itemMultiSelection.qarId))
            .thenAnswer((_) async => Right(qarMultiSelection));
        when(() => questionCrudApi.readOne(qarMultiSelection.questionId))
            .thenAnswer((_) async => Right(questionMultiSelection));
        when(() => answerItemCrudApi.createOnDB(any()))
            .thenAnswer((_) async => const Left(CrudFailure.unexpected()));

        // act
        final response = await repo.create(itemMultiSelection);
        // assert
        verify(() => qarCrudApi.readOne(itemMultiSelection.qarId));
        verify(() => questionCrudApi.readOne(qarMultiSelection.questionId));
        verify(() => answerItemCrudApi.createOnDB(
            itemMultiSelection.addMetaData(
                id: testId, createdBy: dummyUserOne.id, createdAt: testTime)));
        verifyNever(() => answerItemCrudApi.readOne(any()));
        verifyNever(() => answerItemCrudApi.updateOnDB(any()));
        expect(response, equals(const Left(CrudFailure.unexpected())));
      },
    );
    test(
      '''should read qar and question and call answerItemCrudApi.createOnDB 
      when question has multi selection disabled but qar has no items yet''',
      () async {
        // arrange
        when(() => qarCrudApi.readOne(firstItem.qarId))
            .thenAnswer((_) async => Right(emptyQarSingleSelection));
        when(() => questionCrudApi.readOne(emptyQarSingleSelection.questionId))
            .thenAnswer((_) async => Right(questionSingleSelection));
        when(() => answerItemCrudApi.createOnDB(any()))
            .thenAnswer((_) async => const Left(CrudFailure.unexpected()));

        // act
        final response = await repo.create(firstItem);
        // assert
        verify(() => qarCrudApi.readOne(firstItem.qarId));
        verify(
            () => questionCrudApi.readOne(emptyQarSingleSelection.questionId));
        verify(() => answerItemCrudApi.createOnDB(firstItemOnDB));
        verifyNever(() => answerItemCrudApi.readOne(any()));
        verifyNever(() => answerItemCrudApi.updateOnDB(any()));
        expect(response, equals(const Left(CrudFailure.unexpected())));
      },
    );
    test(
      '''should read qar and question and call answerItemCrudApi.updateOnDB 
      when question has multi selection disabled and qar already has an item''',
      () async {
        // arrange
        when(() => qarCrudApi.readOne(updatedItem.qarId))
            .thenAnswer((_) async => Right(qarSingleSelection));
        when(() => questionCrudApi.readOne(qarSingleSelection.questionId))
            .thenAnswer((_) async => Right(questionSingleSelection));
        when(() => answerItemCrudApi.updateOnDB(any()))
            .thenAnswer((_) async => const Left(CrudFailure.unexpected()));
        when(() => answerItemCrudApi
                .readOne(qarSingleSelection.answerItemIds.first()))
            .thenAnswer((_) async => Right(firstItemOnDB));

        // act
        final response = await repo.create(updatedItem);
        // assert
        verify(() => qarCrudApi.readOne(updatedItem.qarId));
        verify(
            () => questionCrudApi.readOne(emptyQarSingleSelection.questionId));
        verifyNever(() => answerItemCrudApi.createOnDB(any()));
        verify(() => answerItemCrudApi
            .readOne(qarSingleSelection.answerItemIds.first()));
        verify(() => answerItemCrudApi
            .updateOnDB(firstItemOnDB.copyWith(value: updatedItem.value)));
        expect(response, equals(const Left(CrudFailure.unexpected())));
      },
    );
  });
  group('createMultiple', () {
    test(
      '''should not call anything and return Left(CrudFailure.unexpected()
         when trying to create multiple items with different qars''',
      () async {
        // arrange
        final item_one = answerItemActivityFriendsMonday;
        final item_two = answerItemDayGoodMonday;
        final items = listOf(item_one, item_two);
        // act
        final response = await repo.createMultiple(items);
        // assert
        expectLater(
            response,
            const Left(CrudFailure.unexpected(
                info: 'cannot create mutliple items of different qar')));
      },
    );
    test(
      '''should read qar
      when items are all of same qar
      ''',
      () async {
        // arrange
        final item_one = answerItemActivityFriendsMonday;
        final item_two = answerItemActivitySoccerMonday;
        final items = listOf(item_one, item_two);
        when(() => qarCrudApi.readOne(item_one.qarId))
            .thenAnswer((_) async => const Left(CrudFailure.unexpected()));
        // act
        final response = await repo.createMultiple(items);
        // assert
        verify(() => qarCrudApi.readOne(item_one.qarId));
        expectLater(response, const Left(CrudFailure.unexpected()));
      },
    );
  });
  group('createItemsAndUpdateQar()', () {
    final item_one = answerItemActivityFriendsMonday;
    final item_two = answerItemActivitySoccerMonday;
    final item_three = answerItemActivityWorkingMonday;
    final items = listOf(item_one, item_two, item_three);
    final qar = qarActiviyMonday;
    final nextQar = qarSleepMonday;

    final item_one_meta_data = item_one.addMetaData(
        id: testId, createdBy: dummyUserOne.id, createdAt: testTime);
    final item_two_meta_data = item_two.addMetaData(
        id: testId, createdBy: dummyUserOne.id, createdAt: testTime);
    final item_three_meta_data = item_three.addMetaData(
        id: testId, createdBy: dummyUserOne.id, createdAt: testTime);
    final expectedItems =
        listOf(item_one_meta_data, item_two_meta_data, item_three_meta_data);

    test(
      '''
      should try to create three answerItems but not try to update qar
      when creation is not successful
      ''',
      () async {
        // arrange
        when(() => answerItemCrudApi.createOnDB(any()))
            .thenAnswer((_) async => const Left(CrudFailure.unexpected()));
        // act
        final response = await repo.createItemsAndUpdateQar(items, qar);
        // assert
        verify(() => answerItemCrudApi.createOnDB(item_one_meta_data));
        verify(() => answerItemCrudApi.createOnDB(item_two_meta_data));
        verify(() => answerItemCrudApi.createOnDB(item_three_meta_data));
        verifyNever(() => qarCrudApi.updateOnDB(any()));
        expectLater(response, equals(const Left(CrudFailure.unexpected())));
      },
    );
    test(
      '''
      should create three answerItems and try to update the answerItemIds of qar
      and return Left(CrudFailure.dataBaseNotSynchonWarning()) when updating qar
      is not successful
      ''',
      () async {
        // arrange
        when(() => answerItemCrudApi.createOnDB(any()))
            .thenAnswer((_) async => const Right(unit));
        when(() => qarCrudApi.updateOnDB(qar
                .linkedWithMultipleAnswerItems(listOf(testId, testId, testId))))
            .thenAnswer((_) async => const Left(CrudFailure.unexpected()));
        // act
        final response = await repo.createItemsAndUpdateQar(items, qar);
        // assert
        verify(() => answerItemCrudApi.createOnDB(item_one_meta_data));
        verify(() => answerItemCrudApi.createOnDB(item_two_meta_data));
        verify(() => answerItemCrudApi.createOnDB(item_three_meta_data));
        verify(() => qarCrudApi.updateOnDB(
            qar.linkedWithMultipleAnswerItems(listOf(testId, testId, testId))));
        expectLater(response,
            equals(const Left(CrudFailure.dataBaseNotSynchonWarning())));
      },
    );
    test(
      '''
      should create three answerItems and update qar and then 
      read the next qar and return right(unit) when there is no next qar
      ''',
      () async {
        // arrange
        when(() => answerItemCrudApi.createOnDB(any()))
            .thenAnswer((_) async => const Right(unit));
        when(() => qarCrudApi.updateOnDB(qar
                .linkedWithMultipleAnswerItems(listOf(testId, testId, testId))))
            .thenAnswer((_) async => const Right(unit));

        when(() => qarCrudApi.readBySessionIdAndPosition(
                qar.sessionId, qar.position + 1))
            .thenAnswer((_) async => const Left(CrudFailure.doesNotExist()));
        // act
        final response = await repo.createItemsAndUpdateQar(items, qar);
        // assert
        verify(() => answerItemCrudApi.createOnDB(item_one_meta_data));
        verify(() => answerItemCrudApi.createOnDB(item_two_meta_data));
        verify(() => answerItemCrudApi.createOnDB(item_three_meta_data));
        verify(() => qarCrudApi.updateOnDB(
            qar.linkedWithMultipleAnswerItems(listOf(testId, testId, testId))));
        verify(() => qarCrudApi.readBySessionIdAndPosition(
            qar.sessionId, qar.position + 1));
        expectLater(response, equals(Right(expectedItems)));
      },
    );
    test(
      '''
      should create three answerItems and update qar and 
      then read the next qar and 
      then return failure when reading is not successful
      ''',
      () async {
        // arrange
        when(() => answerItemCrudApi.createOnDB(any()))
            .thenAnswer((_) async => const Right(unit));
        when(() => qarCrudApi.updateOnDB(qar
                .linkedWithMultipleAnswerItems(listOf(testId, testId, testId))))
            .thenAnswer((_) async => const Right(unit));

        when(() => qarCrudApi.readBySessionIdAndPosition(
                qar.sessionId, qar.position + 1))
            .thenAnswer((_) async => const Left(CrudFailure.unexpected()));
        // act
        final response = await repo.createItemsAndUpdateQar(items, qar);
        // assert
        verify(() => answerItemCrudApi.createOnDB(item_one_meta_data));
        verify(() => answerItemCrudApi.createOnDB(item_two_meta_data));
        verify(() => answerItemCrudApi.createOnDB(item_three_meta_data));
        verify(() => qarCrudApi.updateOnDB(
            qar.linkedWithMultipleAnswerItems(listOf(testId, testId, testId))));
        verify(() => qarCrudApi.readBySessionIdAndPosition(
            qar.sessionId, qar.position + 1));
        expectLater(response, equals(const Left(CrudFailure.unexpected())));
      },
    );
    test(
      '''
      should create three answerItems and update qar and 
      then read the next qar and 
      then make the next qar visible
      and return Left(CrudFailure.dataBaseNotSynchonWarning()) when qar cannot be made visible
      ''',
      () async {
        // arrange
        when(() => answerItemCrudApi.createOnDB(any()))
            .thenAnswer((_) async => const Right(unit));
        when(() => qarCrudApi.updateOnDB(qar
                .linkedWithMultipleAnswerItems(listOf(testId, testId, testId))))
            .thenAnswer((_) async => const Right(unit));

        when(() => qarCrudApi.readBySessionIdAndPosition(
                qar.sessionId, qar.position + 1))
            .thenAnswer((_) async => Right(nextQar));

        when(() => qarCrudApi.updateOnDB(nextQar.makeVisible(testTime)))
            .thenAnswer((_) async => const Left(CrudFailure.unexpected()));
        // act
        final response = await repo.createItemsAndUpdateQar(items, qar);
        // assert
        verify(() => answerItemCrudApi.createOnDB(item_one_meta_data));
        verify(() => answerItemCrudApi.createOnDB(item_two_meta_data));
        verify(() => answerItemCrudApi.createOnDB(item_three_meta_data));
        verify(() => qarCrudApi.updateOnDB(
            qar.linkedWithMultipleAnswerItems(listOf(testId, testId, testId))));
        verify(() => qarCrudApi.readBySessionIdAndPosition(
            qar.sessionId, qar.position + 1));
        verify(() => qarCrudApi.updateOnDB(nextQar.makeVisible(testTime)));
        expectLater(response,
            equals(const Left(CrudFailure.dataBaseNotSynchonWarning())));
      },
    );
    test(
      '''
      should create three answerItems and update qar and 
      then read the next qar and 
      then make the next qar visible
      and return Right(unit)
      ''',
      () async {
        // arrange
        when(() => answerItemCrudApi.createOnDB(any()))
            .thenAnswer((_) async => const Right(unit));
        when(() => qarCrudApi.updateOnDB(qar
                .linkedWithMultipleAnswerItems(listOf(testId, testId, testId))))
            .thenAnswer((_) async => const Right(unit));

        when(() => qarCrudApi.readBySessionIdAndPosition(
                qar.sessionId, qar.position + 1))
            .thenAnswer((_) async => Right(nextQar));

        when(() => qarCrudApi.updateOnDB(nextQar.makeVisible(testTime)))
            .thenAnswer((_) async => const Right(unit));
        // act
        final response = await repo.createItemsAndUpdateQar(items, qar);
        // assert
        verify(() => answerItemCrudApi.createOnDB(item_one_meta_data));
        verify(() => answerItemCrudApi.createOnDB(item_two_meta_data));
        verify(() => answerItemCrudApi.createOnDB(item_three_meta_data));
        verify(() => qarCrudApi.updateOnDB(
            qar.linkedWithMultipleAnswerItems(listOf(testId, testId, testId))));
        verify(() => qarCrudApi.readBySessionIdAndPosition(
            qar.sessionId, qar.position + 1));
        verify(() => qarCrudApi.updateOnDB(nextQar.makeVisible(testTime)));
        expectLater(response, equals(Right(expectedItems)));
      },
    );
  });
  group('verifyUserAndDelete()', () {
    test(
      '''should
      call authFacade.getSignedInUserId()
      call answerItemCrudApi.readOne() 
      not call answerItemCrudApi.deleteFromDB()
      and return Left(CrudFailure.unexpected()
      when answerItem cannot be read
      ''',
      () async {
        // arrange
        when(() => answerItemCrudApi.readOne(answerItemDayGoodMonday.id))
            .thenAnswer((_) async => const Left(CrudFailure.unexpected()));
        // act
        final response =
            await repo.verifyUserAndDelete(answerItemDayGoodMonday.id);
        // assert
        verify(() => authRepo.getSignedInUserId());
        verify(() => answerItemCrudApi.readOne(answerItemDayGoodMonday.id));
        verifyNever(() => answerItemCrudApi.deleteFromDB(any()));
        expectLater(response, equals(const Left(CrudFailure.unexpected())));
      },
    );
    test(
      '''should
      call authFacade.getSignedInUserId()
      call answerItemCrudApi.readOne() 
      not call answerItemCrudApi.deleteFromDB()
      and return Left(CrudFailure.insufficientPermission()
      when user has no permission to delete answerItem
      ''',
      () async {
        // arrange
        when(() => answerItemCrudApi.readOne(answerItemDayGoodMonday.id))
            .thenAnswer((_) async => Right(answerItemDayGoodMonday));
        when(() => authRepo.getSignedInUserId())
            .thenAnswer((_) async => dummyUserTwo.id);
        // act
        final response =
            await repo.verifyUserAndDelete(answerItemDayGoodMonday.id);
        // assert
        verify(() => authRepo.getSignedInUserId());
        verify(() => answerItemCrudApi.readOne(answerItemDayGoodMonday.id));
        verifyNever(() => answerItemCrudApi.deleteFromDB(any()));
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
        when(() => answerItemCrudApi.readOne(answerItemDayGoodMonday.id))
            .thenAnswer((_) async => Right(answerItemDayGoodMonday));
        when(() => answerItemCrudApi.deleteFromDB(answerItemDayGoodMonday))
            .thenAnswer((_) async => const Right(unit));

        // act
        final response =
            await repo.verifyUserAndDelete(answerItemDayGoodMonday.id);

        // assert
        verify(() => authRepo.getSignedInUserId());
        verify(() => answerItemCrudApi.readOne(answerItemDayGoodMonday.id));
        verify(() => answerItemCrudApi.deleteFromDB(answerItemDayGoodMonday));
        expectLater(response, equals(const Right(unit)));
      },
    );
  });
  group('verifyUserAndUpdateWithMetaData()', () {
    final itemWithMetaData =
        answerItemDayGoodMonday.updateMetaData(createdAt: testTime);
    test(
      '''should
      call authFacade.getSignedInUserId()
      not call answerItemCrudApi.updadeOnDB()
      and return Left(CrudFailure.insufficientPermission())
      when user has no permission to update
      ''',
      () async {
        // arrange
        when(() => authRepo.getSignedInUserId())
            .thenAnswer((_) async => dummyUserTwo.id);
        // act
        final response =
            await repo.verifyUserAndUpdateWithMetaData(answerItemDayGoodMonday);
        // assert
        verify(() => authRepo.getSignedInUserId());
        verifyNever(() => answerItemCrudApi.updateOnDB(any()));
        expectLater(
            response, equals(const Left(CrudFailure.insufficientPermission())));
      },
    );
    test(
      '''should
      call authFacade.getSignedInUserId()
      call answerItemCrudApi.updadeOnDB() with updatedQar
      and return Left(CrudFailure.unexpected())
      when user has no permission to update
      ''',
      () async {
        // arrange
        when(() => answerItemCrudApi.updateOnDB(itemWithMetaData))
            .thenAnswer((_) async => const Left(CrudFailure.unexpected()));
        // act
        final response =
            await repo.verifyUserAndUpdateWithMetaData(answerItemDayGoodMonday);
        // assert
        verify(() => authRepo.getSignedInUserId());
        verify(() => answerItemCrudApi.updateOnDB(itemWithMetaData));
        expectLater(response, equals(const Left(CrudFailure.unexpected())));
      },
    );
    test(
      '''should
      call authFacade.getSignedInUserId()
      call answerItemCrudApi.updadeOnDB() with updatedQar
      and return Right(updatedQar)
      when update is successful
      ''',
      () async {
        // arrange
        when(() => answerItemCrudApi.updateOnDB(itemWithMetaData))
            .thenAnswer((_) async => const Right(unit));
        // act
        final response =
            await repo.verifyUserAndUpdateWithMetaData(answerItemDayGoodMonday);
        // assert
        verify(() => authRepo.getSignedInUserId());
        verify(() => answerItemCrudApi.updateOnDB(itemWithMetaData));
        expectLater(response, equals(Right(itemWithMetaData)));
      },
    );
  });
  group('updateItemValue()', () {
    final newValue = AnswerItemValue.fromAnswerOptionId(answerOptionDayBad.id);
    final updatedAnswerItem = answerItemDayGoodMonday
        .copyWith(value: newValue)
        .updateMetaData(createdAt: testTime);
    final qar = qarDayMonday.linkedWithAnswerItem(updatedAnswerItem.id);
    test(
      '''should call answerItemCrudApi.readOne but
      not call answerItemCrudApi.updateOnDB
      return Left(CrudFailure.unexpected())
      when reading is not successful
      ''',
      () async {
        // arrange
        when(
          () => answerItemCrudApi.readOne(qar.answerItemIds.first()),
        ).thenAnswer((_) async => const Left(CrudFailure.unexpected()));

        // act
        final updateResponse = await repo.updateItemValue(
          itemValue: newValue,
          qar: qar,
        );

        // assert
        verify(() => answerItemCrudApi.readOne(qar.answerItemIds.first()));
        verifyNever(() => answerItemCrudApi.updateOnDB(any()));
        expect(updateResponse, equals(const Left(CrudFailure.unexpected())));
      },
    );
    test(
      '''should call answerItemCrudApi.readOne
      call answerItemCrudApi.updateOnDB with updatedAnswerItem
      return Left(CrudFailure.unableToUpdate())
      when update is not successful
      ''',
      () async {
        // arrange
        when(() => answerItemCrudApi.readOne(qar.answerItemIds.first()))
            .thenAnswer((_) async => Right(answerItemDayGoodMonday));
        when(() => answerItemCrudApi.updateOnDB(updatedAnswerItem))
            .thenAnswer((_) async => const Left(CrudFailure.unableToUpdate()));

        // act
        final updateResponse = await repo.updateItemValue(
          itemValue: newValue,
          qar: qar,
        );

        // assert
        verify(() => answerItemCrudApi.readOne(qar.answerItemIds.first()));
        verify(() => answerItemCrudApi.updateOnDB(updatedAnswerItem));
        expect(
            updateResponse, equals(const Left(CrudFailure.unableToUpdate())));
      },
    );
    test(
      '''should call answerItemCrudApi.readOne
      call answerItemCrudApi.updateOnDB with updatedAnswerItem and
      return Right(unit)
      when update is successful
      ''',
      () async {
        // arrange
        when(() => answerItemCrudApi.readOne(qar.answerItemIds.first()))
            .thenAnswer((_) async => Right(answerItemDayGoodMonday));
        when(() => answerItemCrudApi.updateOnDB(updatedAnswerItem))
            .thenAnswer((_) async => const Right(unit));

        // act
        final updateResponse = await repo.updateItemValue(
          itemValue: newValue,
          qar: qar,
        );

        // assert
        verify(() => answerItemCrudApi.readOne(qar.answerItemIds.first()));
        verify(() => answerItemCrudApi.updateOnDB(updatedAnswerItem));
        expect(updateResponse, equals(Right(updatedAnswerItem)));
      },
    );
  });
  group('deleteItemAndUpdateQar', () {
    final answerItem = answerItemDayGoodMonday;
    final qar = qarDayMonday.linkedWithAnswerItem(answerItemDayGoodMonday.id);
    test(
      '''should 
      call answerItemCrudApi.readOne()
      and return Left(CrudFailure.doesNotExist())
      when answerItem does not exist
      ''',
      () async {
        // arrange
        when(() => answerItemCrudApi.readOne(answerItem.id))
            .thenAnswer((_) async => const Left(CrudFailure.doesNotExist()));
        // act
        final response = await repo.deleteItemAndUpdateQar(answerItem.id);
        // assert
        verify(() => answerItemCrudApi.readOne(answerItem.id));
        expectLater(response, equals(const Left(CrudFailure.doesNotExist())));
      },
    );
    test(
      '''should 
      call answerItemCrudApi.readOne()
      call qarCrudApi.readOne()
      and return Left(CrudFailure.unexpected())
      when qar cannot be read
      ''',
      () async {
        // arrange
        when(() => answerItemCrudApi.readOne(answerItem.id))
            .thenAnswer((_) async => Right(answerItem));
        when(() => qarCrudApi.readOne(answerItem.qarId))
            .thenAnswer((_) async => const Left(CrudFailure.unexpected()));
        // act
        final response = await repo.deleteItemAndUpdateQar(answerItem.id);
        // assert
        verify(() => answerItemCrudApi.readOne(answerItem.id));
        verify(() => qarCrudApi.readOne(answerItem.qarId));
        expectLater(response, equals(const Left(CrudFailure.unexpected())));
      },
    );
    test(
      '''should 
      call answerItemCrudApi.readOne()
      call qarCrudApi.readOne()
      call answerItemCrudApi.deleteFromDB()
      and return Right(unit)
      when qar does not exist and deletion is successful
      ''',
      () async {
        // arrange
        when(() => answerItemCrudApi.readOne(answerItem.id))
            .thenAnswer((_) async => Right(answerItem));
        when(() => answerItemCrudApi.deleteFromDB(answerItem))
            .thenAnswer((_) async => const Right(unit));
        when(() => qarCrudApi.readOne(answerItem.qarId))
            .thenAnswer((_) async => const Left(CrudFailure.doesNotExist()));
        // act
        final response = await repo.deleteItemAndUpdateQar(answerItem.id);
        // assert
        verify(() => answerItemCrudApi.readOne(answerItem.id));
        verify(() => qarCrudApi.readOne(answerItem.qarId));
        verify(() => answerItemCrudApi.deleteFromDB(answerItem));
        expectLater(response, equals(const Right(unit)));
      },
    );
    test(
      '''should 
      call answerItemCrudApi.readOne()
      call qarCrudApi.readOne()
      call answerItemCrudApi.deleteFromDB()
      and return Left(CrudFailure.unexpected())
      when qar does not exist but deletion is not successful
      ''',
      () async {
        // arrange
        when(() => answerItemCrudApi.readOne(answerItem.id))
            .thenAnswer((_) async => Right(answerItem));
        when(() => answerItemCrudApi.deleteFromDB(answerItem))
            .thenAnswer((_) async => const Left(CrudFailure.unexpected()));
        when(() => qarCrudApi.readOne(answerItem.qarId))
            .thenAnswer((_) async => const Left(CrudFailure.doesNotExist()));
        // act
        final response = await repo.deleteItemAndUpdateQar(answerItem.id);
        // assert
        verify(() => answerItemCrudApi.readOne(answerItem.id));
        verify(() => qarCrudApi.readOne(answerItem.qarId));
        verify(() => answerItemCrudApi.deleteFromDB(answerItem));
        expectLater(response, equals(const Left(CrudFailure.unexpected())));
      },
    );
    test(
      '''should 
      call answerItemCrudApi.readOne()
      call qarCrudApi.readOne()
      not call answerItemCrudApi.deleteFromDB()
      call qarCrudApi.updateOnDB() with unlinked qar
      and return Left(CrudFailure.unexpected())
      when qar cannot be unlinked
      ''',
      () async {
        // arrange
        when(() => answerItemCrudApi.readOne(answerItem.id))
            .thenAnswer((_) async => Right(answerItem));
        when(() => answerItemCrudApi.deleteFromDB(answerItem))
            .thenAnswer((_) async => const Left(CrudFailure.unexpected()));
        when(() => qarCrudApi.readOne(answerItem.qarId))
            .thenAnswer((_) async => Right(qar));
        when(() => qarCrudApi
                .updateOnDB(qar.unlinkedFromAnswerItem(answerItem.id)))
            .thenAnswer((_) async => const Left(CrudFailure.unexpected()));
        // act
        final response = await repo.deleteItemAndUpdateQar(answerItem.id);
        // assert
        verify(() => answerItemCrudApi.readOne(answerItem.id));
        verify(() => qarCrudApi.readOne(answerItem.qarId));
        verify(() =>
            qarCrudApi.updateOnDB(qar.unlinkedFromAnswerItem(answerItem.id)));
        verifyNever(() => answerItemCrudApi.deleteFromDB(any()));
        expectLater(response, equals(const Left(CrudFailure.unexpected())));
      },
    );
    test(
      '''should 
      call answerItemCrudApi.readOne()
      call qarCrudApi.readOne()
      call answerItemCrudApi.deleteFromDB()
      call qarCrudApi.updateOnDB() with unlinked qar
      call qarCrudApi.updateOnDB() with linked qar
      and return Left(CrudFailure.dataBaseNotSynchonWarning())
      when answerItem cannot be deleted but qar cannot be relinked again 
      ''',
      () async {
        // arrange
        when(() => answerItemCrudApi.readOne(answerItem.id))
            .thenAnswer((_) async => Right(answerItem));
        when(() => answerItemCrudApi.deleteFromDB(answerItem))
            .thenAnswer((_) async => const Left(CrudFailure.unexpected()));
        when(() => qarCrudApi.readOne(answerItem.qarId))
            .thenAnswer((_) async => Right(qar));
        when(() => qarCrudApi
                .updateOnDB(qar.unlinkedFromAnswerItem(answerItem.id)))
            .thenAnswer((_) async => const Right(unit));

        when(() =>
                qarCrudApi.updateOnDB(qar.linkedWithAnswerItem(answerItem.id)))
            .thenAnswer((_) async => const Left(CrudFailure.unexpected()));

        // act
        final response = await repo.deleteItemAndUpdateQar(answerItem.id);

        // assert
        verify(() => answerItemCrudApi.readOne(answerItem.id));
        verify(() => qarCrudApi.readOne(answerItem.qarId));
        verify(() =>
            qarCrudApi.updateOnDB(qar.linkedWithAnswerItem(answerItem.id)));
        verify(() =>
            qarCrudApi.updateOnDB(qar.unlinkedFromAnswerItem(answerItem.id)));
        verify(() => answerItemCrudApi.deleteFromDB(answerItem));
        expectLater(response,
            equals(const Left(CrudFailure.dataBaseNotSynchonWarning())));
      },
    );
    test(
      '''should 
      call answerItemCrudApi.readOne()
      call qarCrudApi.readOne()
      call answerItemCrudApi.deleteFromDB()
      call qarCrudApi.updateOnDB() with unlinked qar
      call qarCrudApi.updateOnDB() with linked qar
      and return Left(CrudFailure.unexpected())
      when answerItem cannot be deleted 
      ''',
      () async {
        // arrange
        when(() => answerItemCrudApi.readOne(answerItem.id))
            .thenAnswer((_) async => Right(answerItem));
        when(() => answerItemCrudApi.deleteFromDB(answerItem))
            .thenAnswer((_) async => const Left(CrudFailure.unexpected()));
        when(() => qarCrudApi.readOne(answerItem.qarId))
            .thenAnswer((_) async => Right(qar));
        when(() => qarCrudApi
                .updateOnDB(qar.unlinkedFromAnswerItem(answerItem.id)))
            .thenAnswer((_) async => const Right(unit));

        when(() =>
                qarCrudApi.updateOnDB(qar.linkedWithAnswerItem(answerItem.id)))
            .thenAnswer((_) async => const Right(unit));

        // act
        final response = await repo.deleteItemAndUpdateQar(answerItem.id);

        // assert
        verify(() => answerItemCrudApi.readOne(answerItem.id));
        verify(() => qarCrudApi.readOne(answerItem.qarId));
        verify(() =>
            qarCrudApi.updateOnDB(qar.linkedWithAnswerItem(answerItem.id)));
        verify(() =>
            qarCrudApi.updateOnDB(qar.unlinkedFromAnswerItem(answerItem.id)));
        verify(() => answerItemCrudApi.deleteFromDB(answerItem));
        expectLater(response, equals(const Left(CrudFailure.unexpected())));
      },
    );
    test(
      '''should 
      call answerItemCrudApi.readOne()
      call qarCrudApi.readOne()
      call answerItemCrudApi.deleteFromDB()
      call qarCrudApi.updateOnDB() with unlinked qar
      not call qarCrudApi.updateOnDB() with linked qar
      and return Right(unit)
      when answerItem can be deleted 
      ''',
      () async {
        // arrange
        when(() => answerItemCrudApi.readOne(answerItem.id))
            .thenAnswer((_) async => Right(answerItem));
        when(() => answerItemCrudApi.deleteFromDB(answerItem))
            .thenAnswer((_) async => const Right(unit));
        when(() => qarCrudApi.readOne(answerItem.qarId))
            .thenAnswer((_) async => Right(qar));
        when(() => qarCrudApi
                .updateOnDB(qar.unlinkedFromAnswerItem(answerItem.id)))
            .thenAnswer((_) async => const Right(unit));

        // act
        final response = await repo.deleteItemAndUpdateQar(answerItem.id);

        // assert
        verify(() => answerItemCrudApi.readOne(answerItem.id));
        verify(() => qarCrudApi.readOne(answerItem.qarId));
        verifyNever(() =>
            qarCrudApi.updateOnDB(qar.linkedWithAnswerItem(answerItem.id)));
        verify(() =>
            qarCrudApi.updateOnDB(qar.unlinkedFromAnswerItem(answerItem.id)));
        verify(() => answerItemCrudApi.deleteFromDB(answerItem));
        expectLater(response, equals(const Right(unit)));
      },
    );
  });
}
