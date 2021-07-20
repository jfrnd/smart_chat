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

abstract class ICrudRepo<T> {
  Future<Either<CrudFailure, T>> readOne(UniqueId id);
  Future<Either<CrudFailure, T>> create(T entity);
  Future<Either<CrudFailure, T>> update(T entity);
  Future<Either<CrudFailure, Unit>> delete(UniqueId id);
}

abstract class IUserCrudRepo implements ICrudRepo<User> {}

abstract class ISubscriptionCrudRepo implements ICrudRepo<Subscription> {
  Future<Either<CrudFailure, Subscription>> subscribe(UniqueId chatBotId);
}

abstract class IChatBotCrudRepo implements ICrudRepo<ChatBot> {
  Future<Either<CrudFailure, KtList<ChatBot>>> readAllCreatedBy(
      UniqueId userId);
}

abstract class IQuestionCrudRepo implements ICrudRepo<Question> {
  Future<Either<CrudFailure, KtList<Question>>> readAllOfChatBot(
      UniqueId chatBotId);
}

abstract class IAnswerOptionCrudRepo implements ICrudRepo<AnswerOption> {
  Future<Either<CrudFailure, KtList<AnswerOption>>> readAllOfQuestion(
      UniqueId questionId);
  Future<Either<CrudFailure, KtList<AnswerOption>>> readAllOfChatBot(
      UniqueId chatBotId);
}

abstract class IQarCrudRepo implements ICrudRepo<Qar> {
  Future<Either<CrudFailure, UniqueId>> createSession(
      {required UniqueId chatBotId});
}

abstract class IAnswerItemCrudRepo implements ICrudRepo<AnswerItem> {
  Future<Either<CrudFailure, KtList<AnswerItem>>> createMultiple(
      KtList<AnswerItem> items);
}
