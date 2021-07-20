// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:smart_chat/domain/core/i_meta_data_provider.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/chatbot/chatbot.dart';
import 'package:smart_chat/domain/repositories/api/i_auth_facade.dart';
import 'package:smart_chat/domain/repositories/api/i_crud_api.dart';
import 'package:smart_chat/domain/repositories/auth/i_auth_repo.dart';
import 'package:smart_chat/infrastructure/repositories/client/crud/client_subscription_crud_repo.dart';
import '../../../../fixtures/user.dart';

class MockIAuthRepo extends Mock implements IAuthRepo {}

class MockIMetaDataProvider extends Mock implements IMetaDataProvider {}

class MockISubscriptionCrudApi extends Mock implements ISubscriptionCrudApi {}

class MockIChatBotCrudApi extends Mock implements IChatBotCrudApi {}

class MockIAuthFacade extends Mock implements IAuthFacade {}

void main() {
  late MockIAuthRepo authRepo;
  late MockIMetaDataProvider metaDataProvider;
  late MockISubscriptionCrudApi subscriptionCrudApi;
  late MockIChatBotCrudApi chatBotCrudApi;
  late MockIAuthFacade authFacade;
  late ClientSubscriptionCrud repo;

  const UPDATED_AT = '2022-01-02T12:12:00.000000';
  final testTime = DateTime.parse(UPDATED_AT);
  const TEST_ID = 'TEST_ID';
  final testId = UniqueId.fromUniqueString(TEST_ID);

  setUp(() async {
    registerFallbackValue<ChatBot>(ChatBot.empty());
    registerFallbackValue<UniqueId>(UniqueId());
    metaDataProvider = MockIMetaDataProvider();
    subscriptionCrudApi = MockISubscriptionCrudApi();
    chatBotCrudApi = MockIChatBotCrudApi();
    authFacade = MockIAuthFacade();

    repo = ClientSubscriptionCrud(
        metaDataProvider, subscriptionCrudApi, chatBotCrudApi, authFacade);

    when(() => metaDataProvider.getCurrentTime()).thenAnswer((_) => testTime);

    when(() => metaDataProvider.getUniqueId()).thenAnswer((_) => testId);
  });

  tearDown(() {
    reset(metaDataProvider);
    reset(authFacade);
    reset(chatBotCrudApi);
    reset(subscriptionCrudApi);
  });

  group('subscribe()', () {
    //TODO subscribe()
  });
  group('create()', () {
    //TODO create()
  });
  group('delete()', () {
    //TODO delete()
  });
  group('update()', () {
    //TODO update()
  });
  group('readOne()', () {
    //TODO readOne()
  });
}
