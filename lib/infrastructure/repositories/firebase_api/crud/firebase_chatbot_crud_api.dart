// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/chatbot/chatbot.dart';
import 'package:smart_chat/domain/repositories/api/i_crud_api.dart';
import 'package:smart_chat/infrastructure/core/firestore_helpers.dart';
import 'package:smart_chat/infrastructure/dto/chatbot_dto.dart';

@LazySingleton(as: IChatBotCrudApi)
class FireBaseChatBotCrudApi implements IChatBotCrudApi {
  final FirebaseFirestore fs;

  FireBaseChatBotCrudApi(
    this.fs,
  );

  @override
  Future<Either<CrudFailure, ChatBot>> readOne(UniqueId chatBotId) async {
    try {
      return fs.chatBots.doc(chatBotId.getOrCrash()).get().then(
        (snapshot) {
          if (snapshot.exists) {
            return Right(
              ChatBotDto.fromFireStore(snapshot).toDomain(),
            );
          } else {
            return left<CrudFailure, ChatBot>(
              const CrudFailure.doesNotExist(),
            );
          }
        },
      );
    } catch (e) {
      return left(convertToCrudFailure(e));
    }
  }

  @override
  Future<Either<CrudFailure, KtList<ChatBot>>> readAllCreatedBy(
      UniqueId userId) async {
    try {
      return fs.chatBotsCreatedBy(userId).get().then(
        (snapshot) {
          return right<CrudFailure, KtList<ChatBot>>(
            snapshot.docs
                .map((doc) => ChatBotDto.fromFireStore(doc).toDomain())
                .toImmutableList(),
          );
        },
      );
    } catch (e) {
      return left(convertToCrudFailure(e));
    }
  }

  @override
  Future<Either<CrudFailure, Unit>> createOnDB(ChatBot chatBot) async {
    try {
      await fs.chatBots
          .doc(chatBot.id.getOrCrash())
          .set(ChatBotDto.fromDomain(chatBot).toFireStore());
      return right(unit);
    } catch (e) {
      return left(convertToCrudFailure(e));
    }
  }

  @override
  Future<Either<CrudFailure, Unit>> updateOnDB(ChatBot chatBot) async {
    try {
      await fs.chatBots
          .doc(chatBot.id.getOrCrash())
          .update(ChatBotDto.fromDomain(chatBot).toFireStore());
      return right(unit);
    } catch (e) {
      return left(convertToCrudFailure(e));
    }
  }

  @override
  Future<Either<CrudFailure, Unit>> deleteFromDB(ChatBot chatBot) async {
    try {
      await fs.chatBots.doc(chatBot.id.getOrCrash()).delete();
      return right(unit);
    } catch (e) {
      return left(convertToCrudFailure(e));
    }
  }
}
