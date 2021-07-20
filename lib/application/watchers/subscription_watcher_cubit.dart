// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/cubits/entity_watcher/entity_watcher_cubit.dart';
import 'package:smart_chat/domain/entities/subscription/subscription.dart';
import 'package:smart_chat/domain/repositories/api/i_watcher_api.dart';

@injectable
class SubscriptionWatcherCubit extends EntityWatcherCubit<Subscription> {
  final ISubscriptionWatcherApi subscriptionWatcherApi;

  SubscriptionWatcherCubit(this.subscriptionWatcherApi)
      : super(subscriptionWatcherApi);

  Future<void> watchAllOfSignedInUserStarted() async {
    await streamSubscription?.cancel();

    emit(const EntityWatcherState.loadInProgress());

    streamSubscription = subscriptionWatcherApi
        .watchAllOfSignedInUser()
        .listen((failureOrEntities) {
      failureOrEntities.fold(
        (failure) => failure == const CrudFailure.doesNotExist()
            ? emit(const EntityWatcherState.deleted())
            : emit(EntityWatcherState.loadFailure(failure)),
        (entities) => emit(EntityWatcherState.loadSuccess(entities)),
      );
    });
  }

  Future<void> watchOfChatBotAndSignedInUserStarted(UniqueId chatBotId) async {
    await streamSubscription?.cancel();

    emit(const EntityWatcherState.loadInProgress());

    streamSubscription = subscriptionWatcherApi
        .watchOfChatBotAndSignedInUser(chatBotId)
        .listen((failureOrEntities) {
      failureOrEntities.fold(
        (failure) => failure == const CrudFailure.doesNotExist()
            ? emit(const EntityWatcherState.deleted())
            : emit(EntityWatcherState.loadFailure(failure)),
        (entities) => emit(EntityWatcherState.loadSuccess(entities)),
      );
    });
  }
}
