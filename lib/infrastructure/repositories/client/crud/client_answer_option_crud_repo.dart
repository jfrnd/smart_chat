// Package imports:
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/i_meta_data_provider.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/answer_option/answer_option.dart';
import 'package:smart_chat/domain/repositories/api/i_crud_api.dart';
import 'package:smart_chat/domain/repositories/auth/i_auth_repo.dart';
import 'package:smart_chat/domain/repositories/crud/i_crud_repo.dart';

@LazySingleton(as: IAnswerOptionCrudRepo)
class ClientAnswerOptionCrud implements IAnswerOptionCrudRepo {
  final IAuthRepo authRepo;
  final IMetaDataProvider metaDataProvider;
  final IAnswerOptionCrudApi crudApi;

  ClientAnswerOptionCrud(
    this.authRepo,
    this.metaDataProvider,
    this.crudApi,
  );

  @override
  Future<Either<CrudFailure, AnswerOption>> readOne(
          UniqueId answerOptionId) async =>
      crudApi.readOne(answerOptionId);

  @override
  Future<Either<CrudFailure, KtList<AnswerOption>>> readAllOfQuestion(
          UniqueId questionId) async =>
      crudApi.readAllOfQuestion(questionId);

  @override
  Future<Either<CrudFailure, KtList<AnswerOption>>> readAllOfChatBot(
          UniqueId chatBotId) async =>
      crudApi.readAllOfChatBot(chatBotId);

  @override
  Future<Either<CrudFailure, AnswerOption>> create(
      AnswerOption answerOption) async {
    return createWithMetaData(answerOption);
  }

  Future<Either<CrudFailure, AnswerOption>> createWithMetaData(
      AnswerOption answerOption) async {
    final userId = await authRepo.getSignedInUserId();

    final newAnswerOption = answerOption.addMetaData(
      id: metaDataProvider.getUniqueId(),
      createdBy: userId,
      createdAt: metaDataProvider.getCurrentTime(),
    );

    return crudApi.createOnDB(newAnswerOption).then(
          (failureOrUnit) => failureOrUnit.fold(
            (f) => left<CrudFailure, AnswerOption>(f),
            (_) => right<CrudFailure, AnswerOption>(newAnswerOption),
          ),
        );
  }

  @override
  Future<Either<CrudFailure, AnswerOption>> update(
      AnswerOption answerOption) async {
    return updateWithMetaData(answerOption);
  }

  Future<Either<CrudFailure, AnswerOption>> updateWithMetaData(
      AnswerOption answerOption) async {
    final userId = await authRepo.getSignedInUserId();

    return crudApi.readOne(answerOption.id).then(
          (failureOrAnswerOption) => failureOrAnswerOption.fold(
            (f) => left<CrudFailure, AnswerOption>(f),
            (curAnswerOption) {
              if (curAnswerOption == answerOption) {
                return right<CrudFailure, AnswerOption>(answerOption);
              } else {
                final updatedAnswerOption = answerOption.updateMetaData(
                  updatedBy: userId,
                  updatedAt: metaDataProvider.getCurrentTime(),
                );
                return crudApi.updateOnDB(updatedAnswerOption).then(
                      (failureOrUnit) => failureOrUnit.fold(
                        (f) => left<CrudFailure, AnswerOption>(f),
                        (_) => right<CrudFailure, AnswerOption>(
                            updatedAnswerOption),
                      ),
                    );
              }
            },
          ),
        );
  }

  @override
  Future<Either<CrudFailure, Unit>> delete(UniqueId answerOptionId) async {
    return crudApi.readOne(answerOptionId).then(
          (failureOrAnswerOption) => failureOrAnswerOption.fold(
            (f) => left<CrudFailure, Unit>(f),
            (answerOption) => crudApi.deleteFromDB(answerOption),
          ),
        );
  }
}
