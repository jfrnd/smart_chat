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
import 'package:smart_chat/domain/repositories/api/i_crud_api.dart';
import 'package:smart_chat/infrastructure/repositories/client/crud/client_user_crud_repo.dart';
import '../../../../fixtures/user.dart';

class MockIMetaDataProvider extends Mock implements IMetaDataProvider {}

class MockIUserCrudApi extends Mock implements IUserCrudApi {}

void main() {
  late MockIMetaDataProvider metaDataProvider;
  late MockIUserCrudApi crudApi;
  late ClientUserCrud repo;

  const UPDATED_AT = '2022-01-02T12:12:00.000000';
  final testTime = DateTime.parse(UPDATED_AT);
  const TEST_ID = 'TEST_ID';
  final testId = UniqueId.fromUniqueString(TEST_ID);

  setUp(() async {
    registerFallbackValue<ChatBot>(ChatBot.empty());
    registerFallbackValue<UniqueId>(UniqueId());
    metaDataProvider = MockIMetaDataProvider();
    crudApi = MockIUserCrudApi();

    repo = ClientUserCrud(
      metaDataProvider,
      crudApi,
    );

    when(() => metaDataProvider.getCurrentTime()).thenAnswer((_) => testTime);

    when(() => metaDataProvider.getUniqueId()).thenAnswer((_) => testId);
  });

  tearDown(() {
    reset(metaDataProvider);
    reset(crudApi);
  });

  group('create()', () {
//TODO create()
  });
  group('update()', () {
//TODO update()
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
        when(() => crudApi.readOne(dummyUserOne.id))
            .thenAnswer((_) async => Right(dummyUserOne));
        when(() => crudApi.deleteFromDB(dummyUserOne))
            .thenAnswer((_) async => const Right(unit));

        // act
        final response = await repo.delete(dummyUserOne.id);

        verify(() => crudApi.readOne(dummyUserOne.id));
        verify(() => crudApi.deleteFromDB(dummyUserOne));
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
        when(() => crudApi.readOne(dummyUserOne.id))
            .thenAnswer((_) async => const Left(CrudFailure.unexpected()));

        // act
        final response = await repo.delete(dummyUserOne.id);

        verify(() => crudApi.readOne(dummyUserOne.id));
        verifyNever(() => crudApi.deleteFromDB(dummyUserOne));
        expectLater(response, equals(const Left(CrudFailure.unexpected())));
      },
    );
    test(
      '''should
      call crudApi.readOne()
      call crudApi.deleteFromDB()
      and return Left(CrudFailure.unexpected()) when deletion was not successful
      ''',
      () async {
        //arrange
        when(() => crudApi.readOne(dummyUserOne.id))
            .thenAnswer((_) async => Right(dummyUserOne));
        when(() => crudApi.deleteFromDB(dummyUserOne))
            .thenAnswer((_) async => const Left(CrudFailure.unexpected()));

        // act
        final response = await repo.delete(dummyUserOne.id);

        verify(() => crudApi.readOne(dummyUserOne.id));
        verify(() => crudApi.deleteFromDB(dummyUserOne));
        expectLater(response, equals(const Left(CrudFailure.unexpected())));
      },
    );
  });
}
