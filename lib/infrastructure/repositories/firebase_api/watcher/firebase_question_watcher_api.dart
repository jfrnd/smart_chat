// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/kt.dart';
import 'package:rxdart/rxdart.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/question/question.dart';
import 'package:smart_chat/domain/repositories/api/i_watcher_api.dart';
import 'package:smart_chat/infrastructure/core/firestore_helpers.dart';
import 'package:smart_chat/infrastructure/dto/question_dto.dart';

@LazySingleton(as: IQuestionWatcherApi)
class FireBaseQuestionWatcherApi implements IQuestionWatcherApi {
  final FirebaseFirestore fs;

  FireBaseQuestionWatcherApi(
    this.fs,
  );

  @override
  Stream<Either<CrudFailure, KtList<Question>>> watchOne(
      UniqueId questionId) async* {
    yield* fs.queryOfQuestion(questionId: questionId).snapshots().map(
      (snapshot) {
        final docs = snapshot.docs;
        if (docs.isNotEmpty) {
          return right<CrudFailure, KtList<Question>>(
            docs
                .map((doc) => QuestionDto.fromFireStore(doc).toDomain())
                .toImmutableList(),
          );
        } else {
          return left<CrudFailure, KtList<Question>>(
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
  Stream<Either<CrudFailure, KtList<Question>>> watchAllOfChatBot(
      UniqueId chatBotId) async* {
    yield* fs
        .questions(chatBotId: chatBotId)
        .orderBy(POSITION, descending: false)
        .snapshots()
        .map(
      (snapshot) {
        return right<CrudFailure, KtList<Question>>(
          snapshot.docs
              .map((doc) => QuestionDto.fromFireStore(doc).toDomain())
              .toImmutableList(),
        );
      },
    ).onErrorReturnWith((e, stackTrace) {
      return left(convertToCrudFailure(e));
    });
  }

  @override
  Stream<Either<CrudFailure, KtList<Question>>> watchAllOfParentEntity(
          UniqueId parentId) =>
      watchAllOfChatBot(parentId);
}
