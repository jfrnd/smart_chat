// Package imports:
import 'package:dartz/dartz.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/answer_item/answer_item.dart';
import 'package:smart_chat/domain/entities/answer_option/answer_option.dart';
import 'package:smart_chat/domain/entities/chatbot/chatbot.dart';
import 'package:smart_chat/domain/entities/qar/qar.dart';
import 'package:smart_chat/domain/entities/question/question.dart';
import 'package:smart_chat/domain/entities/subscription/subscription.dart';
import 'package:smart_chat/domain/entities/user/user.dart';

abstract class ICrudApi<T> {
  Future<Either<CrudFailure, T>> readOne(UniqueId id);
  Future<Either<CrudFailure, Unit>> createOnDB(T entity);
  Future<Either<CrudFailure, Unit>> updateOnDB(T entity);
  Future<Either<CrudFailure, Unit>> deleteFromDB(T entity);
}

abstract class IUserCrudApi implements ICrudApi<User> {}

abstract class ISubscriptionCrudApi implements ICrudApi<Subscription> {}

abstract class IChatBotCrudApi implements ICrudApi<ChatBot> {
  Future<Either<CrudFailure, KtList<ChatBot>>> readAllCreatedBy(
      UniqueId userId);
}

abstract class IQuestionCrudApi implements ICrudApi<Question> {
  Future<Either<CrudFailure, KtList<Question>>> readAllOfChatBot(
      UniqueId chatBotId);
  Future<Either<CrudFailure, int>> readCurrentNumberOfQuestions(
      UniqueId chatBotId);
}

abstract class IAnswerOptionCrudApi implements ICrudApi<AnswerOption> {
  Future<Either<CrudFailure, KtList<AnswerOption>>> readAllOfQuestion(
      UniqueId questionId);
  Future<Either<CrudFailure, KtList<AnswerOption>>> readAllOfChatBot(
      UniqueId chatBotId);
}

abstract class IQarCrudApi implements ICrudApi<Qar> {
  Future<Either<CrudFailure, KtList<Qar>>> readAllOfSession(UniqueId sessionId);
  Future<Either<CrudFailure, Qar>> readBySessionIdAndPosition(
      UniqueId sessionId, int position);
}

abstract class IAnswerItemCrudApi implements ICrudApi<AnswerItem> {}

abstract class IImageCrudApi {
  Future<Either<CrudFailure, String>> updateImage(
      {required String remoteImagePath, required String localImagePath});
  Future<Either<CrudFailure, Unit>> deleteImage(String remoteImagePath);
}
