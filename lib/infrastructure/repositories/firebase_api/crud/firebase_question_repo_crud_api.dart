// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/question/question.dart';
import 'package:smart_chat/domain/repositories/api/i_crud_api.dart';
import 'package:smart_chat/infrastructure/core/firestore_helpers.dart';
import 'package:smart_chat/infrastructure/dto/question_dto.dart';

@LazySingleton(as: IQuestionCrudApi)
class FireBaseQuestionCrudApi implements IQuestionCrudApi {
  final FirebaseFirestore fs;

  FireBaseQuestionCrudApi(this.fs);

  @override
  Future<Either<CrudFailure, Question>> readOne(UniqueId questionId) async {
    try {
      return fs.queryOfQuestion(questionId: questionId).get().then(
        (snapshot) {
          final docs = snapshot.docs;
          if (docs.isNotEmpty) {
            return right(QuestionDto.fromFireStore(docs.first).toDomain());
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
  Future<Either<CrudFailure, KtList<Question>>> readAllOfChatBot(
      UniqueId chatBotId) async {
    try {
      return fs
          .questions(chatBotId: chatBotId)
          .orderBy(POSITION, descending: false)
          .get()
          .then((snapshot) => right<CrudFailure, KtList<Question>>(snapshot.docs
              .map((q) => QuestionDto.fromFireStore(q).toDomain())
              .toImmutableList()));
    } catch (e) {
      return left(convertToCrudFailure(e));
    }
  }

  @override
  Future<Either<CrudFailure, Unit>> createOnDB(Question question) async {
    try {
      await fs
          .questions(chatBotId: question.chatBotId)
          .doc(question.id.getOrCrash())
          .set(QuestionDto.fromDomain(question).toFireStore());

      return right(unit);
    } catch (e) {
      return left(convertToCrudFailure(e));
    }
  }

  @override
  Future<Either<CrudFailure, Unit>> updateOnDB(Question question) async {
    try {
      await fs
          .questions(chatBotId: question.chatBotId)
          .doc(question.id.getOrCrash())
          .update(QuestionDto.fromDomain(question).toFireStore());

      return right(unit);
    } catch (e) {
      return left(convertToCrudFailure(e));
    }
  }

  @override
  Future<Either<CrudFailure, Unit>> deleteFromDB(Question question) async {
    try {
      await fs
          .questions(chatBotId: question.chatBotId)
          .doc(question.id.getOrCrash())
          .delete();

      return right(unit);
    } catch (e) {
      return left(convertToCrudFailure(e));
    }
  }

  @override
  Future<Either<CrudFailure, int>> readCurrentNumberOfQuestions(
      UniqueId chatBotId) async {
    try {
      return fs
          .questions(chatBotId: chatBotId)
          .orderBy(POSITION, descending: true)
          .limit(1)
          .get()
          .then((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          return Right(QuestionDto.fromFireStore(snapshot.docs.first).position);
        } else {
          return const Right(0);
        }
      });
    } catch (e) {
      return left(convertToCrudFailure(e));
    }
  }
}
