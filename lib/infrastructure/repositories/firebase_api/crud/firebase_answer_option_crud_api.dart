// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/answer_option/answer_option.dart';
import 'package:smart_chat/domain/repositories/api/i_crud_api.dart';
import 'package:smart_chat/infrastructure/core/firestore_helpers.dart';
import 'package:smart_chat/infrastructure/dto/answer_option_dto.dart';

@LazySingleton(as: IAnswerOptionCrudApi)
class FireBaseAnswerOptionCrudApi implements IAnswerOptionCrudApi {
  final FirebaseFirestore fs;

  FireBaseAnswerOptionCrudApi(this.fs);

  @override
  Future<Either<CrudFailure, AnswerOption>> readOne(
      UniqueId answerOptionId) async {
    try {
      return fs.queryOfAnswerOption(answerOptionId: answerOptionId).get().then(
        (snapshot) {
          final docs = snapshot.docs;
          if (docs.isNotEmpty) {
            return right(AnswerOptionDto.fromFireStore(docs.first).toDomain());
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
  Future<Either<CrudFailure, KtList<AnswerOption>>> readAllOfQuestion(
      UniqueId questionId) async {
    try {
      late KtList<AnswerOption> answerOptions;
      await fs.queryOfAnswerOptionsOfQuestion(questionId).get().then(
          (snapshot) => answerOptions = snapshot.docs
              .map((doc) => AnswerOptionDto.fromFireStore(doc).toDomain())
              .toImmutableList());

      return right(answerOptions);
    } catch (e) {
      return left(convertToCrudFailure(e));
    }
  }

  @override
  Future<Either<CrudFailure, KtList<AnswerOption>>> readAllOfChatBot(
      UniqueId chatBotId) async {
    try {
      late KtList<AnswerOption> answerOptions;
      await fs.queryOfAnswerOptionsOfChatBot(chatBotId).get().then((snapshot) =>
          answerOptions = snapshot.docs
              .map((doc) => AnswerOptionDto.fromFireStore(doc).toDomain())
              .toImmutableList());

      return right(answerOptions);
    } catch (e) {
      return left(convertToCrudFailure(e));
    }
  }

  @override
  Future<Either<CrudFailure, Unit>> createOnDB(AnswerOption answerOption) async {
    try {
      await fs
          .answerOptions(
            chatBotId: answerOption.chatBotId,
            questionId: answerOption.questionId,
          )
          .doc(answerOption.id.getOrCrash())
          .set(AnswerOptionDto.fromDomain(answerOption).toFireStore());

      return right(unit);
    } catch (e) {
      return left(convertToCrudFailure(e));
    }
  }

  @override
  Future<Either<CrudFailure, Unit>> updateOnDB(AnswerOption answerOption) async {
    try {
      await fs
          .answerOptions(
            chatBotId: answerOption.chatBotId,
            questionId: answerOption.questionId,
          )
          .doc(answerOption.id.getOrCrash())
          .update(AnswerOptionDto.fromDomain(answerOption).toFireStore());

      return right(unit);
    } catch (e) {
      return left(convertToCrudFailure(e));
    }
  }

  @override
  Future<Either<CrudFailure, Unit>> deleteFromDB(AnswerOption answerOption) async {
    try {
      await fs
          .answerOptions(
            chatBotId: answerOption.chatBotId,
            questionId: answerOption.questionId,
          )
          .doc(answerOption.id.getOrCrash())
          .delete();

      return right(unit);
    } catch (e) {
      return left(convertToCrudFailure(e));
    }
  }
}
