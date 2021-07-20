// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/subscription/subscription.dart';
import 'package:smart_chat/domain/repositories/api/i_crud_api.dart';
import 'package:smart_chat/infrastructure/core/firestore_helpers.dart';
import 'package:smart_chat/infrastructure/dto/subscription_dto.dart';

@LazySingleton(as: ISubscriptionCrudApi)
class FireBaseSubscriptionCrudApi implements ISubscriptionCrudApi {
  final FirebaseFirestore fs;

  FireBaseSubscriptionCrudApi(
    this.fs,
  );

  @override
  Future<Either<CrudFailure, Subscription>> readOne(
      UniqueId subscriptionId) async {
    try {
      return fs.queryOfSubscription(subscriptionId: subscriptionId).get().then(
        (snapshot) {
          final docs = snapshot.docs;
          if (docs.isNotEmpty) {
            return right(SubscriptionDto.fromFireStore(docs.first).toDomain());
          } else {
            return left(const CrudFailure.doesNotExist());
          }
        },
      );
    } catch (e) {
      return left(convertToCrudFailure(e));
    }
  }

  @override
  Future<Either<CrudFailure, Unit>> createOnDB(
      Subscription subscription) async {
    try {
      await fs
          .subscriptions(userId: subscription.createdBy)
          .doc(subscription.id.getOrCrash())
          .set(SubscriptionDto.fromDomain(subscription).toFireStore());
      return right(unit);
    } catch (e) {
      return left(convertToCrudFailure(e));
    }
  }

  @override
  Future<Either<CrudFailure, Unit>> updateOnDB(
      Subscription subscription) async {
    try {
      await fs
          .subscriptions(userId: subscription.createdBy)
          .doc(subscription.id.getOrCrash())
          .update(SubscriptionDto.fromDomain(subscription).toFireStore());
      return right(unit);
    } catch (e) {
      return left(convertToCrudFailure(e));
    }
  }

  @override
  Future<Either<CrudFailure, Unit>> deleteFromDB(
      Subscription subscription) async {
    try {
      await fs
          .subscriptions(userId: subscription.createdBy)
          .doc(subscription.id.getOrCrash())
          .delete();
      return right(unit);
    } catch (e) {
      return left(convertToCrudFailure(e));
    }
  }
}
