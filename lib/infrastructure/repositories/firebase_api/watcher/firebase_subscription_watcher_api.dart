// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/kt.dart';
import 'package:rxdart/rxdart.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/subscription/subscription.dart';
import 'package:smart_chat/domain/repositories/api/i_watcher_api.dart';
import 'package:smart_chat/domain/repositories/auth/i_auth_repo.dart';
import 'package:smart_chat/infrastructure/core/firestore_helpers.dart';
import 'package:smart_chat/infrastructure/dto/subscription_dto.dart';

@LazySingleton(as: ISubscriptionWatcherApi)
class FireBaseSubscriptionWatcherApi implements ISubscriptionWatcherApi {
  final FirebaseFirestore fs;
  final IAuthRepo authRepo;

  FireBaseSubscriptionWatcherApi(
    this.fs,
    this.authRepo,
  );

  @override
  Stream<Either<CrudFailure, KtList<Subscription>>> watchOne(
      UniqueId subscriptionId) async* {
    yield* fs
        .queryOfSubscription(subscriptionId: subscriptionId)
        .snapshots()
        .map(
      (snapshot) {
        final docs = snapshot.docs;
        if (docs.isNotEmpty) {
          return right<CrudFailure, KtList<Subscription>>(
            docs
                .map((doc) => SubscriptionDto.fromFireStore(doc).toDomain())
                .toImmutableList(),
          );
        } else {
          return left<CrudFailure, KtList<Subscription>>(
            const CrudFailure.doesNotExist(),
          );
        }
      },
    ).onErrorReturnWith(
      (e, stackTrace) {
        return left(
          convertToCrudFailure(e),
        );
      },
    );
  }

  @override
  Stream<Either<CrudFailure, KtList<Subscription>>> watchAllOfUser(
      UniqueId userId) async* {
    yield* fs.subscriptions(userId: userId).snapshots().map((snapshot) {
      return right<CrudFailure, KtList<Subscription>>(
        snapshot.docs
            .map((doc) => SubscriptionDto.fromFireStore(doc).toDomain())
            .toImmutableList(),
      );
    }).onErrorReturnWith((e, stackTrace) {
      return left(convertToCrudFailure(e));
    });
  }

  @override
  Stream<Either<CrudFailure, KtList<Subscription>>>
      watchAllOfSignedInUser() async* {
    final userId = await authRepo.getSignedInUserId();

    yield* fs.subscriptions(userId: userId).snapshots().map((snapshot) {
      return right<CrudFailure, KtList<Subscription>>(
        snapshot.docs
            .map((doc) => SubscriptionDto.fromFireStore(doc).toDomain())
            .toImmutableList(),
      );
    }).onErrorReturnWith((e, stackTrace) {
      return left(convertToCrudFailure(e));
    });
  }

  @override
  Stream<Either<CrudFailure, KtList<Subscription>>>
      watchOfChatBotAndSignedInUser(UniqueId chatBotId) async* {
    final userId = await authRepo.getSignedInUserId();

    yield* fs
        .subscriptionOfUserAndChatBot(userId: userId, chatBotId: chatBotId)
        .snapshots()
        .map((snapshot) {
      return right<CrudFailure, KtList<Subscription>>(
        snapshot.docs
            .map((doc) => SubscriptionDto.fromFireStore(doc).toDomain())
            .toImmutableList(),
      );
    }).onErrorReturnWith((e, stackTrace) {
      return left(convertToCrudFailure(e));
    });
  }

  @override
  Stream<Either<CrudFailure, KtList<Subscription>>> watchAllOfParentEntity(
          UniqueId parentId) =>
      watchAllOfUser(parentId);
}
