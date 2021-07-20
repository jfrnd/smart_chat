// Package imports:
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/i_meta_data_provider.dart';
import 'package:smart_chat/domain/core/valueobjects/language_code.dart';
import 'package:smart_chat/domain/core/valueobjects/time_value.dart';
import 'package:smart_chat/domain/core/valueobjects/translatable.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/answer_option/answer_option.dart';
import 'package:smart_chat/domain/entities/answer_option/answer_option_body.dart';
import 'package:smart_chat/domain/entities/question/question.dart';
import 'package:smart_chat/domain/entities/question/question_type.dart';
import 'package:smart_chat/domain/repositories/api/i_crud_api.dart';
import 'package:smart_chat/domain/repositories/auth/i_auth_repo.dart';
import 'package:smart_chat/domain/repositories/crud/i_crud_repo.dart';

@LazySingleton(as: IQuestionCrudRepo)
class ClientQuestionCrud implements IQuestionCrudRepo {
  final IQuestionCrudApi crudApi;
  final IAuthRepo authRepo;
  final IMetaDataProvider metaDataProvider;
  final IAnswerOptionCrudRepo answerOptionCrud;

  ClientQuestionCrud(
    this.authRepo,
    this.metaDataProvider,
    this.answerOptionCrud,
    this.crudApi,
  );

  @override
  Future<Either<CrudFailure, Question>> readOne(UniqueId questionId) async =>
      crudApi.readOne(questionId);

  @override
  Future<Either<CrudFailure, KtList<Question>>> readAllOfChatBot(
          UniqueId chatBotId) async =>
      crudApi.readAllOfChatBot(chatBotId);

  @override
  Future<Either<CrudFailure, Question>> create(Question question) async {
    final userId = await authRepo.getSignedInUserId();

    final newQuestion = question.addMetaData(
      id: metaDataProvider.getUniqueId(),
      createdBy: userId,
      createdAt: metaDataProvider.getCurrentTime(),
    );

    return crudApi.readCurrentNumberOfQuestions(question.chatBotId).then(
          (failureOrInt) => failureOrInt.fold(
            (f) => left<CrudFailure, Question>(f),
            (size) {
              final newQuestionWithPosition = newQuestion.addPosition(size + 1);
              return crudApi.createOnDB(newQuestionWithPosition).then(
                    (failureOrUnit) => failureOrUnit.fold(
                      (f) => left<CrudFailure, Question>(f),
                      (_) {
                        if (newQuestionWithPosition.type is Numeric) {
                          createDummyAnswerOptionsForNumericQuestion(
                              newQuestionWithPosition, question);
                        }
                        if (newQuestionWithPosition.type is Time) {
                          createDummyAnswerOptionsForTimeQuestion(
                              newQuestionWithPosition, question);
                        }

                        return right(newQuestionWithPosition);
                      },
                    ),
                  );
            },
          ),
        );
  }

  @override
  Future<Either<CrudFailure, Question>> update(Question question) async {
    final userId = await authRepo.getSignedInUserId();

    return crudApi.readOne(question.id).then(
          (faiureOrQuestion) => faiureOrQuestion.fold(
            (f) => left<CrudFailure, Question>(f),
            (curQuestion) {
              if (curQuestion == question) {
                return right<CrudFailure, Question>(question);
              } else {
                final updatedQuestion = question.updateMetaData(
                  updatedBy: userId,
                  updatedAt: metaDataProvider.getCurrentTime(),
                );
                return crudApi.updateOnDB(updatedQuestion).then(
                      (failureOrUnit) => failureOrUnit.fold(
                        (f) => left<CrudFailure, Question>(f),
                        (_) => right<CrudFailure, Question>(updatedQuestion),
                      ),
                    );
              }
            },
          ),
        );
  }

  @override
  Future<Either<CrudFailure, Unit>> delete(UniqueId questionId) async {
    return crudApi.readOne(questionId).then(
          (failureOrQuestion) => failureOrQuestion.fold(
            (f) => left<CrudFailure, Unit>(f),
            (question) => crudApi.deleteFromDB(question),
          ),
        );
  }

  Future<void> createDummyAnswerOptionsForNumericQuestion(
      Question newQuestionWithPosition, Question question) async {
    final answerOption_one =
        AnswerOption.createWithQuestion(question: newQuestionWithPosition)
            .copyWith(
                translations: Translatable<AnswerOptionBody>(KtMap.from({
      LanguageCode.math():
          AnswerOptionBody(question.minVal.getOrCrash().toString())
    })));
    final answerOption_two =
        AnswerOption.createWithQuestion(question: newQuestionWithPosition)
            .copyWith(
                translations: Translatable<AnswerOptionBody>(KtMap.from({
      LanguageCode.math(): AnswerOptionBody(
          ((question.maxVal.getOrCrash() - question.minVal.getOrCrash()) * 0.5)
              .toString())
    })));
    final answerOption_three =
        AnswerOption.createWithQuestion(question: newQuestionWithPosition)
            .copyWith(
                translations: Translatable<AnswerOptionBody>(KtMap.from({
      LanguageCode.math():
          AnswerOptionBody(question.maxVal.getOrCrash().toString())
    })));

    answerOptionCrud
        .create(answerOption_one)
        .then((_) => answerOptionCrud.create(answerOption_two))
        .then((_) => answerOptionCrud.create(answerOption_three));
  }

  Future<void> createDummyAnswerOptionsForTimeQuestion(
      Question newQuestionWithPosition, Question question) async {
    final answerOption_one =
        AnswerOption.createWithQuestion(question: newQuestionWithPosition)
            .copyWith(
                translations: Translatable<AnswerOptionBody>(KtMap.from({
      LanguageCode.math(): AnswerOptionBody(TimeValue(hh: 1).toString())
    })));
    final answerOption_two =
        AnswerOption.createWithQuestion(question: newQuestionWithPosition)
            .copyWith(
                translations: Translatable<AnswerOptionBody>(KtMap.from({
      LanguageCode.math(): AnswerOptionBody(TimeValue(mm: 30).toString())
    })));
    final answerOption_three =
        AnswerOption.createWithQuestion(question: newQuestionWithPosition)
            .copyWith(
                translations: Translatable<AnswerOptionBody>(KtMap.from({
      LanguageCode.math(): AnswerOptionBody(TimeValue(mm: 15).toString())
    })));

    answerOptionCrud
        .create(answerOption_one)
        .then((_) => answerOptionCrud.create(answerOption_two))
        .then((_) => answerOptionCrud.create(answerOption_three));
  }
}
