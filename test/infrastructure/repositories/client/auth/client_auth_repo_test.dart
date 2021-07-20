// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_chat/domain/core/i_meta_data_provider.dart';
import 'package:smart_chat/domain/repositories/api/i_auth_facade.dart';
import 'package:smart_chat/domain/repositories/api/i_crud_api.dart';
import 'package:smart_chat/infrastructure/repositories/client/auth/client_auth_repo.dart';

class MockIAuthFacade extends Mock implements IAuthFacade {}

class MockIMetaDataProvider extends Mock implements IMetaDataProvider {}

class MockIUserCrudApi extends Mock implements IUserCrudApi {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockIAuthFacade authFacade;
  late MockIMetaDataProvider metaDataProvider;
  late MockIUserCrudApi userCrudApi;
  late MockSharedPreferences sharedPreferences;
  late ClientAuthRepo repo;

  setUp(() {
    authFacade = MockIAuthFacade();
    metaDataProvider = MockIMetaDataProvider();
    userCrudApi = MockIUserCrudApi();
    sharedPreferences = MockSharedPreferences();
    repo = ClientAuthRepo(
      authFacade: authFacade,
      crudApi: userCrudApi,
      metaDataProvider: metaDataProvider,
      preferences: sharedPreferences,
    );
  });

  tearDown(() {
    reset(authFacade);
    reset(metaDataProvider);
    reset(userCrudApi);
    reset(sharedPreferences);
  });

  group('registerWithEmailAndPassword()', () {
    //TODO registerWithEmailAndPassword()
  });
  group('signInWithEmailAndPassword()', () {
    //TODO signInWithEmailAndPassword()
  });
  group('signInWithGoogle()', () {
    //TODO signInWithGoogle()
  });
  group('signOut()', () {
    //TODO signOut()
  });
  group('watchUserState()', () {
    //TODO watchUserState()
  });
}
