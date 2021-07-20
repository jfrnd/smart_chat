// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:smart_chat/application/watchers/subscription_watcher_cubit.dart';
import 'package:smart_chat/domain/repositories/api/i_watcher_api.dart';

class MockISubscriptionWatcherApi extends Mock
    implements ISubscriptionWatcherApi {}

void main() {
  late SubscriptionWatcherCubit cubit;
  late MockISubscriptionWatcherApi watcherApi;

  setUp(() {
    watcherApi = MockISubscriptionWatcherApi();
    cubit = SubscriptionWatcherCubit(watcherApi);
  });

  tearDown(() {
    cubit.close();
    reset(watcherApi);
  });

  group('watchOneStarted()', () {
    //TODO watchOneStarted()
  });
  group('watchAllOfSignedInUserStarted()', () {
    //TODO watchAllOfSignedInUserStarted()
  });
  group('watchOfChatBotAndSignedInUserStarted()', () {
    //TODO watchOfChatBotAndSignedInUserStarted()
  });
}
