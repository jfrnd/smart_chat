// Package imports:
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/errors.dart';
import 'package:smart_chat/domain/core/i_meta_data_provider.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/answer_item/answer_item.dart';
import 'package:smart_chat/domain/entities/answer_item/answer_item_value.dart';
import 'package:smart_chat/domain/entities/qar/qar.dart';
import 'package:smart_chat/domain/repositories/api/i_crud_api.dart';
import 'package:smart_chat/domain/repositories/auth/i_auth_repo.dart';
import 'package:smart_chat/domain/repositories/crud/i_crud_repo.dart';

@LazySingleton(as: IAnswerItemCrudRepo)
class ClientAnswerItemCrud implements IAnswerItemCrudRepo {
  final IAuthRepo authRepo;
  final IMetaDataProvider metaDataProvider;
  final IAnswerItemCrudApi itemCrudApi;
  final IQarCrudApi qarCrudApi;
  final IQuestionCrudApi questionCrudApi;

  ClientAnswerItemCrud(
    this.authRepo,
    this.metaDataProvider,
    this.itemCrudApi,
    this.qarCrudApi,
    this.questionCrudApi,
  );

  @override
  Future<Either<CrudFailure, AnswerItem>> readOne(UniqueId answerItemId) async {
    return verifyUserAndReadOne(answerItemId);
  }

  Future<Either<CrudFailure, AnswerItem>> verifyUserAndReadOne(
      UniqueId answerItemId) async {
    final userId = await authRepo.getSignedInUserId();

    return itemCrudApi.readOne(answerItemId).then(
          (failureOrItem) => failureOrItem.fold(
            (f) => left<CrudFailure, AnswerItem>(f),
            (item) => item.createdBy != userId
                ? left<CrudFailure, AnswerItem>(
                    const CrudFailure.insufficientPermission())
                : right<CrudFailure, AnswerItem>(item),
          ),
        );
  }

  @override
  Future<Either<CrudFailure, AnswerItem>> create(AnswerItem item) async {
    return qarCrudApi.readOne(item.qarId).then(
          (failureOrQar) => failureOrQar.fold(
            (f) => left(f),
            (qar) => questionCrudApi.readOne(qar.questionId).then(
                  (failureOrQuestion) => failureOrQuestion.fold(
                    (f) => left(f),
                    (question) =>
                        question.multiSelection || qar.hasNoAnswerItems
                            ? createItemsAndUpdateQar(listOf(item), qar).then(
                                (failureOrItems) => failureOrItems.fold(
                                  (f) => left(f),
                                  (items) => right(items.first()),
                                ),
                              )
                            : updateItemValue(
                                itemValue: item.value,
                                qar: qar,
                              ).then(
                                (failureOrUnit) => failureOrUnit.fold(
                                  (failure) => left(failure),
                                  (item) => right(item),
                                ),
                              ),
                  ),
                ),
          ),
        );
  }

  Future<Either<CrudFailure, AnswerItem>> createWithMetaData(
      AnswerItem item) async {
    final userId = await authRepo.getSignedInUserId();
    final itemId = metaDataProvider.getUniqueId();
    final curTime = metaDataProvider.getCurrentTime();

    final newItem = item.addMetaData(
      id: itemId,
      createdBy: userId,
      createdAt: curTime,
    );

    return itemCrudApi.createOnDB(newItem).then(
          (failureOrUnit) => failureOrUnit.fold(
            (f) => left<CrudFailure, AnswerItem>(f),
            (_) => right<CrudFailure, AnswerItem>(newItem),
          ),
        );
  }

  @override
  Future<Either<CrudFailure, KtList<AnswerItem>>> createMultiple(
      KtList<AnswerItem> items) async {
    if (items.map((item) => item.qarId).distinct().size != 1) {
      return const Left(CrudFailure.unexpected(
          info: 'cannot create mutliple items of different qar'));
    } else {
      return qarCrudApi.readOne(items.first().qarId).then(
            (failureOrQar) => failureOrQar.fold(
              (f) => left(f),
              (qar) => questionCrudApi.readOne(qar.questionId).then(
                    (failureOrQuestion) => failureOrQuestion.fold(
                      (f) => left(f),
                      (question) =>
                          question.multiSelection || qar.hasNoAnswerItems
                              ? createItemsAndUpdateQar(items, qar).then(
                                  (failureOrItems) => failureOrItems.fold(
                                    (f) => left(f),
                                    (items) => right(items),
                                  ),
                                )
                              : updateItemValue(
                                  itemValue: items.first().value,
                                  qar: qar,
                                ).then(
                                  (failureOrUnit) => failureOrUnit.fold(
                                    (failure) => left(failure),
                                    (item) => right(listOf(item)),
                                  ),
                                ),
                    ),
                  ),
            ),
          );
    }
  }

  @override
  Future<Either<CrudFailure, Unit>> delete(UniqueId answerItemId) async {
    return deleteItemAndUpdateQar(answerItemId);
  }

  Future<Either<CrudFailure, KtList<AnswerItem>>> createItemsAndUpdateQar(
    KtList<AnswerItem> items,
    Qar qar,
  ) async {
    final tasks =
        List.generate(items.size, (index) => createWithMetaData(items[index]));

    return Future.wait(tasks).then(
      (creationResponses) {
        if (creationResponses.haveAnyFailure) {
          return creationResponses.firstFailure;
        } else {
          final newItems = creationResponses
              .map(
                (failureOrItem) => failureOrItem.fold(
                  (f) => throw UnexpectedError(
                      'control flow should never reach here'),
                  (item) => item,
                ),
              )
              .toImmutableList();
          return qarCrudApi
              .updateOnDB(qar.linkedWithMultipleAnswerItems(newItems.ids))
              .then(
                (failureOrUnit) => failureOrUnit.fold(
                  (failure) =>
                      left(const CrudFailure.dataBaseNotSynchonWarning()),
                  (_) => qarCrudApi
                      .readBySessionIdAndPosition(
                          qar.sessionId, qar.position + 1)
                      .then(
                        (failureOrQar) => failureOrQar.fold(
                          (failure) => failure.maybeMap(
                            doesNotExist: (_) => right(newItems),
                            orElse: () => left(failure),
                          ),
                          (nextQar) => qarCrudApi
                              .updateOnDB(
                                nextQar.makeVisible(
                                  metaDataProvider.getCurrentTime(),
                                ),
                              )
                              .then(
                                (failureOrUnit) => failureOrUnit.fold(
                                  (failure) => left(const CrudFailure
                                      .dataBaseNotSynchonWarning()),
                                  (_) => right(newItems),
                                ),
                              ),
                        ),
                      ),
                ),
              );
        }
      },
    );
  }

  @override
  Future<Either<CrudFailure, AnswerItem>> update(AnswerItem item) async {
    return verifyUserAndUpdateWithMetaData(item);
  }

  Future<Either<CrudFailure, AnswerItem>> verifyUserAndUpdateWithMetaData(
      AnswerItem item) async {
    final userId = await authRepo.getSignedInUserId();

    if (userId != item.createdBy) {
      return const Left(CrudFailure.insufficientPermission());
    } else {
      final updatedItem = item.updateMetaData(
        createdAt: metaDataProvider.getCurrentTime(),
      );
      return itemCrudApi.updateOnDB(updatedItem).then(
            (failureOrUnit) => failureOrUnit.fold(
              (f) => left<CrudFailure, AnswerItem>(f),
              (_) => right<CrudFailure, AnswerItem>(updatedItem),
            ),
          );
    }
  }

  Future<Either<CrudFailure, AnswerItem>> updateItemValue({
    required AnswerItemValue itemValue,
    required Qar qar,
  }) async {
    return readOne(qar.answerItemIds.first()).then(
      (failureOrItem) => failureOrItem.fold(
        (failure) => left(failure),
        (item) {
          final updatedItem = item.copyWith(
            value: itemValue,
          );
          return update(updatedItem).then(
            (failureOrItem) => failureOrItem.fold(
              (failure) => left(failure),
              (item) => right(item),
            ),
          );
        },
      ),
    );
  }

  Future<Either<CrudFailure, Unit>> deleteItemAndUpdateQar(
      UniqueId answerItemId) async {
    return itemCrudApi.readOne(answerItemId).then(
          (failureOrItem) => failureOrItem.fold(
            (readFailure) => left(readFailure),
            (item) => qarCrudApi.readOne(item.qarId).then(
                  (failureOrQar) => failureOrQar.fold(
                    (readFailure) => readFailure.maybeMap(
                      doesNotExist: (_) =>
                          verifyUserAndDelete(answerItemId).then(
                        (failureOrUnit) => failureOrUnit.fold(
                          (failure) => left(failure),
                          (deleteSuccess) => right(unit),
                        ),
                      ),
                      orElse: () => left(readFailure),
                    ),
                    (qar) => qarCrudApi
                        .updateOnDB(
                          qar.unlinkedFromAnswerItem(item.id),
                        )
                        .then(
                          (failureOrUnit) => failureOrUnit.fold(
                            (unlinkFailure) => left(unlinkFailure),
                            (unlinkSuccess) =>
                                verifyUserAndDelete(answerItemId).then(
                              (failureOrUnit) => failureOrUnit.fold(
                                (failure) => qarCrudApi
                                    .updateOnDB(
                                      qar.linkedWithAnswerItem(answerItemId),
                                    )
                                    .then(
                                      (failureOrUnit) => failureOrUnit.fold(
                                        (updateFailure) => left(
                                          const CrudFailure
                                              .dataBaseNotSynchonWarning(),
                                        ),
                                        (success) => left(failure),
                                      ),
                                    ),
                                (deleteSuccess) => right(unit),
                              ),
                            ),
                          ),
                        ),
                  ),
                ),
          ),
        );
  }

  Future<Either<CrudFailure, Unit>> verifyUserAndDelete(UniqueId itemId) async {
    final userId = await authRepo.getSignedInUserId();

    return itemCrudApi.readOne(itemId).then(
          (failureOrItem) => failureOrItem.fold(
            (f) => left<CrudFailure, Unit>(f),
            (item) {
              if (item.createdBy != userId) {
                return left<CrudFailure, Unit>(
                    const CrudFailure.insufficientPermission());
              } else {
                return itemCrudApi.deleteFromDB(item);
              }
            },
          ),
        );
  }
}

extension ResponsesX on List<Either<CrudFailure, AnswerItem>> {
  Either<CrudFailure, KtList<AnswerItem>> get firstFailure => firstWhere(
        (failureOrUnit) => failureOrUnit.isLeft(),
      ).fold(
        (failure) => Left(failure),
        (_) => throw Exception(),
      );
  bool get haveAnyFailure => any((failureOrUnit) => failureOrUnit.isLeft());
}
