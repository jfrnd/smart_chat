// Package imports:
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/i_meta_data_provider.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/chatbot/chatbot.dart';
import 'package:smart_chat/domain/entities/subscription/subscription_trigger.dart';
import 'package:smart_chat/domain/repositories/api/i_crud_api.dart';
import 'package:smart_chat/domain/repositories/auth/i_auth_repo.dart';
import 'package:smart_chat/domain/repositories/crud/i_crud_repo.dart';

@LazySingleton(as: IChatBotCrudRepo)
class ClientChatBotCrud implements IChatBotCrudRepo {
  final IAuthRepo authRepo;
  final IMetaDataProvider metaDataProvider;
  final IChatBotCrudApi crudApi;
  final IImageCrudApi imageCrudApi;
  final IUserCrudApi userCrudApi;

  ClientChatBotCrud(
    this.authRepo,
    this.metaDataProvider,
    this.crudApi,
    this.imageCrudApi,
    this.userCrudApi,
  );

  @override
  Future<Either<CrudFailure, ChatBot>> readOne(UniqueId chatBotId) async =>
      crudApi.readOne(chatBotId);

  @override
  Future<Either<CrudFailure, KtList<ChatBot>>> readAllCreatedBy(
          UniqueId userId) async =>
      crudApi.readAllCreatedBy(userId);

  @override
  Future<Either<CrudFailure, ChatBot>> create(ChatBot chatBot) async {
    return createWithMetaData(chatBot);
  }

  @override
  Future<Either<CrudFailure, ChatBot>> update(ChatBot chatBot) async {
    return updateWithMetaData(chatBot);
  }

  @override
  Future<Either<CrudFailure, Unit>> delete(UniqueId chatBotId) async {
    return crudApi.readOne(chatBotId).then(
          (failureOrChatBot) => failureOrChatBot.fold(
            (f) => left<CrudFailure, Unit>(f),
            (chatBot) => crudApi.deleteFromDB(chatBot).then(
                  (failureOrUnit) => failureOrUnit.fold(
                    (f) => left<CrudFailure, Unit>(f),
                    (_) => imageCrudApi
                        .deleteImage(chatBot.firebaseImagePath)
                        .then((failureOrUnit) => right(unit)),
                  ),
                ),
          ),
        );
  }

  Future<Either<CrudFailure, ChatBot>> createWithMetaData(
      ChatBot chatBot) async {
    final userId = await authRepo.getSignedInUserId();

    final newChatBot = chatBot.addMetaData(
      id: metaDataProvider.getUniqueId(),
      createdBy: userId,
      createdAt: metaDataProvider.getCurrentTime(),
    );

    return userCrudApi.readOne(userId).then(
          (failureOrUser) => failureOrUser.fold(
            (f) => left<CrudFailure, ChatBot>(f),
            (user) {
              final newChatBotWithOffset = newChatBot.copyWith(
                triggers: newChatBot.triggers.map(
                  (item) => item.withOffset(user.timeZoneOffset.inHours),
                ),
              );
              return crudApi.createOnDB(newChatBotWithOffset).then(
                    (failureOrUnit) => failureOrUnit.fold(
                      (f) => left<CrudFailure, ChatBot>(f),
                      (_) => right<CrudFailure, ChatBot>(newChatBotWithOffset),
                    ),
                  );
            },
          ),
        );
  }

  Future<Either<CrudFailure, ChatBot>> updateWithMetaData(
      ChatBot chatBot) async {
    final userId = await authRepo.getSignedInUserId();

    return crudApi.readOne(chatBot.id).then(
          (failureOrChatBot) => failureOrChatBot.fold(
            (f) => left<CrudFailure, ChatBot>(f),
            (curChatBot) {
              if (curChatBot == chatBot) {
                return right<CrudFailure, ChatBot>(chatBot);
              } else {
                final updatedChatBot = chatBot.updateMetaData(
                  updatedBy: userId,
                  updatedAt: metaDataProvider.getCurrentTime(),
                );
                return crudApi.updateOnDB(updatedChatBot).then(
                      (failureOrUnit) => failureOrUnit.fold(
                        (f) => left<CrudFailure, ChatBot>(f),
                        (_) => right<CrudFailure, ChatBot>(updatedChatBot),
                      ),
                    );
              }
            },
          ),
        );
  }
}
