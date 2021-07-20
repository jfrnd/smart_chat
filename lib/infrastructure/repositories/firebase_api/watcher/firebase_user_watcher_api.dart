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
import 'package:smart_chat/domain/entities/user/user.dart';
import 'package:smart_chat/domain/repositories/api/i_watcher_api.dart';
import 'package:smart_chat/infrastructure/core/firestore_helpers.dart';
import 'package:smart_chat/infrastructure/dto/chatbot_dto.dart';
import 'package:smart_chat/infrastructure/dto/user_dto.dart';

@LazySingleton(as: IUserWatcherApi)
class FireBaseUserWatcherApi implements IUserWatcherApi {
  final FirebaseFirestore fs;

  FireBaseUserWatcherApi(
    this.fs,
  );

  @override
  Stream<Either<CrudFailure, KtList<User>>> watchOfChatBot(
      UniqueId chatBotId) async* {
    late ChatBot chatBot;
    try {
      await fs.chatBots.doc(chatBotId.getOrCrash()).get().then(
        (snapshot) {
          if (snapshot.exists) {
            chatBot = ChatBotDto.fromFireStore(snapshot).toDomain();
          } else {
            throw Exception();
          }
        },
      );
    } catch (e) {
      yield left<CrudFailure, KtList<User>>(convertToCrudFailure(e));
    }
    yield* watchOne(chatBot.createdBy);
  }

  @override
  Stream<Either<CrudFailure, KtList<User>>> watchAllOfParentEntity(
      UniqueId userId) async* {
    watchOne(userId);
  }

  @override
  Stream<Either<CrudFailure, KtList<User>>> watchOne(UniqueId userId) async* {
    yield* fs.users.doc(userId.getOrCrash()).snapshots().map(
      (snapshot) {
        if (snapshot.exists) {
          return right<CrudFailure, KtList<User>>(
              listOf(UserDto.fromFireStore(snapshot).toDomain()));
        } else {
          return left<CrudFailure, KtList<User>>(
              const CrudFailure.doesNotExist());
        }
      },
    ).onErrorReturnWith(
      (e, stackTrace) {
        return left(convertToCrudFailure(e));
      },
    );
  }
}
