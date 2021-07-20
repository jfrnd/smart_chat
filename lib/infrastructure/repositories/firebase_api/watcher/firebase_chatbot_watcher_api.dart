// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/kt.dart';
import 'package:rxdart/rxdart.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/chatbot/chatbot.dart';
import 'package:smart_chat/domain/entities/subscription/subscription.dart';
import 'package:smart_chat/domain/repositories/api/i_watcher_api.dart';
import 'package:smart_chat/infrastructure/core/firestore_helpers.dart';
import 'package:smart_chat/infrastructure/dto/chatbot_dto.dart';

@LazySingleton(as: IChatBotWatcherApi)
class FireBaseChatBotWatcherApi implements IChatBotWatcherApi {
  final FirebaseFirestore fs;
  final ISubscriptionWatcherApi subscriptionWatcherApi;

  FireBaseChatBotWatcherApi(
    this.fs,
    this.subscriptionWatcherApi,
  );

  @override
  Stream<Either<CrudFailure, KtList<ChatBot>>> watchOne(
      UniqueId chatBotId) async* {
    yield* fs.chatBots.doc(chatBotId.getOrCrash()).snapshots().map((snapshot) {
      if (snapshot.exists) {
        return right<CrudFailure, KtList<ChatBot>>(
            listOf(ChatBotDto.fromFireStore(snapshot).toDomain()));
      } else {
        return left<CrudFailure, KtList<ChatBot>>(
            const CrudFailure.doesNotExist());
      }
    }).onErrorReturnWith((e, stackTrace) {
      return left(convertToCrudFailure(e));
    });
  }

  @override
  Stream<Either<CrudFailure, KtList<ChatBot>>> watchAllCreatedBy(
      UniqueId userId) async* {
    yield* fs.chatBotsCreatedBy(userId).snapshots().map((snapshot) {
      return right<CrudFailure, KtList<ChatBot>>(
        snapshot.docs
            .map((doc) => ChatBotDto.fromFireStore(doc).toDomain())
            .toImmutableList(),
      );
    }).onErrorReturnWith((e, stackTrace) {
      return left(convertToCrudFailure(e));
    });
  }

  @override
  Stream<Either<CrudFailure, KtList<ChatBot>>> watchAllOfParentEntity(
          UniqueId parentId) =>
      watchAllCreatedBy(parentId);

  @override
  Stream<Either<CrudFailure, KtList<ChatBot>>> watchAllSubscribed(
      UniqueId userId) async* {
    yield* subscriptionWatcherApi.watchAllOfUser(userId).switchMap(
          (failureOrSubscriptions) => failureOrSubscriptions
              .fold(
            (f) => Stream.value(left<CrudFailure, KtList<ChatBot>>(f)),
            (subscriptions) => subscriptions.isEmpty()
                ? Stream.value(right<CrudFailure, KtList<ChatBot>>(listOf()))
                : fs.chatBotsWithId(subscriptions.chatBotIds).snapshots().map(
                    (snapshot) {
                      return right<CrudFailure, KtList<ChatBot>>(
                        snapshot.docs
                            .map((doc) =>
                                ChatBotDto.fromFireStore(doc).toDomain())
                            .toImmutableList(),
                      );
                    },
                  ),
          )
              .onErrorReturnWith(
            (e, stackTrace) {
              return left(convertToCrudFailure(e));
            },
          ),
        );
  }

  @override
  Stream<Either<CrudFailure, KtList<ChatBot>>> watchAll() async* {
    yield* fs.chatBots.snapshots().map((snapshot) {
      return right<CrudFailure, KtList<ChatBot>>(
        snapshot.docs
            .map((doc) => ChatBotDto.fromFireStore(doc).toDomain())
            .toImmutableList(),
      );
    }).onErrorReturnWith((e, stackTrace) {
      return left(convertToCrudFailure(e));
    });
  }
}
