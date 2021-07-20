// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:smart_chat/application/watchers/user_watcher_cubit.dart';
import 'package:smart_chat/domain/repositories/api/i_watcher_api.dart';
import 'package:smart_chat/domain/repositories/auth/i_auth_repo.dart';

class MockIUserWatcherApi extends Mock implements IUserWatcherApi {}

class MockIAuthRepo extends Mock implements IAuthRepo {}

void main() {
  late UserWatcherCubit cubit;
  late MockIUserWatcherApi watcherApi;
  late MockIAuthRepo authRepo;

  setUp(() {
    watcherApi = MockIUserWatcherApi();
    authRepo = MockIAuthRepo();
    cubit = UserWatcherCubit(watcherApi, authRepo);
  });

  tearDown(() {
    cubit.close();
    reset(watcherApi);
    reset(authRepo);
  });

  group('watchOneStarted()', () {
    //TODO watchOneStarted()
  });
  group('watchCreatorOfChatBotStarted()', () {
    //TODO watchCreatorOfChatBotStarted()
  });
  group('watchSignedInUserStarted()', () {
    //TODO watchSignedInUserStarted()
  });
}
