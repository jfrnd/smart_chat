// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/kt.dart';
import 'package:rxdart/rxdart.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/answer_option/answer_option.dart';
import 'package:smart_chat/domain/repositories/api/i_watcher_api.dart';
import 'package:smart_chat/infrastructure/core/firestore_helpers.dart';
import 'package:smart_chat/infrastructure/dto/answer_option_dto.dart';

@LazySingleton(as: IAnswerOptionWatcherApi)
class FireBaseAnswerOptionWatcherApi implements IAnswerOptionWatcherApi {
  final FirebaseFirestore fs;

  FireBaseAnswerOptionWatcherApi(this.fs);

  @override
  Stream<Either<CrudFailure, KtList<AnswerOption>>> watchOne(
      UniqueId answerOptionId) async* {
    yield* fs
        .queryOfAnswerOption(answerOptionId: answerOptionId)
        .snapshots()
        .map((snapshot) {
      final docs = snapshot.docs;
      if (docs.isNotEmpty) {
        return right<CrudFailure, KtList<AnswerOption>>(docs
            .map((doc) => AnswerOptionDto.fromFireStore(doc).toDomain())
            .toImmutableList());
      } else {
        return left<CrudFailure, KtList<AnswerOption>>(
          const CrudFailure.doesNotExist(),
        );
      }
    }).onErrorReturnWith((e, stackTrace) {
      return left(convertToCrudFailure(e));
    });
  }

  @override
  Stream<Either<CrudFailure, KtList<AnswerOption>>> watchAllOfParentEntity(
      UniqueId parentId) async* {
    yield* fs
        .queryOfAnswerOptionsOfQuestion(parentId)
        .orderBy(UPDATED_AT, descending: true)
        .snapshots()
        .map(
      (snapshot) {
        return right<CrudFailure, KtList<AnswerOption>>(snapshot.docs
            .map((doc) => AnswerOptionDto.fromFireStore(doc).toDomain())
            .toImmutableList());
      },
    ).onErrorReturnWith((e, stackTrace) {
      return left(convertToCrudFailure(e));
    });
  }

  @override
  Stream<Either<CrudFailure, KtList<AnswerOption>>> watchAllOfChatBot(
      UniqueId chatBotId) async* {
    yield* fs.queryOfAnswerOptionsOfChatBot(chatBotId).snapshots().map(
      (snapshot) {
        return right<CrudFailure, KtList<AnswerOption>>(snapshot.docs
            .map((doc) => AnswerOptionDto.fromFireStore(doc).toDomain())
            .toImmutableList());
      },
    ).onErrorReturnWith((e, stackTrace) {
      return left(convertToCrudFailure(e));
    });
  }

  @override
  Stream<Either<CrudFailure, KtList<AnswerOption>>> watchAllOfQuestion(
          UniqueId questionId) =>
      watchAllOfParentEntity(questionId);
}
