// Package imports:
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/i_meta_data_provider.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/subscription/subscription.dart';
import 'package:smart_chat/domain/entities/subscription/subscription_status.dart';
import 'package:smart_chat/domain/repositories/api/i_auth_facade.dart';
import 'package:smart_chat/domain/repositories/api/i_crud_api.dart';
import 'package:smart_chat/domain/repositories/crud/i_crud_repo.dart';

@LazySingleton(as: ISubscriptionCrudRepo)
class ClientSubscriptionCrud implements ISubscriptionCrudRepo {
  final IMetaDataProvider metaDataProvider;
  final ISubscriptionCrudApi crudApi;
  final IAuthFacade authFacade;
  final IChatBotCrudApi chatBotCrudApi;

  ClientSubscriptionCrud(
    this.metaDataProvider,
    this.crudApi,
    this.chatBotCrudApi,
    this.authFacade,
  );

  @override
  Future<Either<CrudFailure, Subscription>> readOne(
          UniqueId subscriptionId) async =>
      crudApi.readOne(subscriptionId);

  @override
  Future<Either<CrudFailure, Subscription>> create(
      Subscription subscription) async {
    return crudApi.createOnDB(subscription).then(
          (failureOrUnit) => failureOrUnit.fold(
            (f) => left<CrudFailure, Subscription>(f),
            (r) => right(subscription),
          ),
        );
  }

  @override
  Future<Either<CrudFailure, Subscription>> update(
      Subscription subscription) async {
    return crudApi.updateOnDB(subscription).then(
          (failureOrUnit) => failureOrUnit.fold(
            (f) => left<CrudFailure, Subscription>(f),
            (r) => right(subscription),
          ),
        );
  }

  @override
  Future<Either<CrudFailure, Unit>> delete(UniqueId subscriptionId) async {
    return crudApi.readOne(subscriptionId).then(
          (failureOrSubscription) => failureOrSubscription.fold(
            (f) => left<CrudFailure, Unit>(f),
            (subscription) => crudApi.deleteFromDB(subscription),
          ),
        );
  }

  @override
  Future<Either<CrudFailure, Subscription>> subscribe(
      UniqueId chatBotId) async {
    final userId = await authFacade.getSignedInUserId();
    final curTime = metaDataProvider.getCurrentTime();
    final id = metaDataProvider.getUniqueId();

    return chatBotCrudApi.readOne(chatBotId).then(
          (failureOrChatBot) => failureOrChatBot.fold(
            (f) => left<CrudFailure, Subscription>(f),
            (chatBot) {
              final subscription = Subscription(
                id: id,
                createdAt: curTime,
                createdBy: userId,
                chatBotId: chatBotId,
                status: const SubscriptionStatus.active(),
                triggers: chatBot.triggers,
              );
              return crudApi.createOnDB(subscription).then(
                    (failureOrUnit) => failureOrUnit.fold(
                      (f) => left<CrudFailure, Subscription>(f),
                      (_) => right<CrudFailure, Subscription>(subscription),
                    ),
                  );
            },
          ),
        );
  }
}
