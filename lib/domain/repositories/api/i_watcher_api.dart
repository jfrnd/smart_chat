// Package imports:
import 'package:dartz/dartz.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/answer_item/answer_item.dart';
import 'package:smart_chat/domain/entities/answer_option/answer_option.dart';
import 'package:smart_chat/domain/entities/chatbot/chatbot.dart';
import 'package:smart_chat/domain/entities/entity.dart';
import 'package:smart_chat/domain/entities/qar/qar.dart';
import 'package:smart_chat/domain/entities/question/question.dart';
import 'package:smart_chat/domain/entities/subscription/subscription.dart';
import 'package:smart_chat/domain/entities/user/user.dart';

abstract class IWatcherApi<T extends Entity> {
  Stream<Either<CrudFailure, KtList<T>>> watchOne(UniqueId id);
  Stream<Either<CrudFailure, KtList<T>>> watchAllOfParentEntity(UniqueId id);
}

abstract class ISubscriptionWatcherApi implements IWatcherApi<Subscription> {
  Stream<Either<CrudFailure, KtList<Subscription>>> watchAllOfUser(
      UniqueId userId);
  Stream<Either<CrudFailure, KtList<Subscription>>> watchAllOfSignedInUser();
  Stream<Either<CrudFailure, KtList<Subscription>>> watchOfChatBotAndSignedInUser(UniqueId chatBotId);
}

abstract class IUserWatcherApi implements IWatcherApi<User> {
  Stream<Either<CrudFailure, KtList<User>>> watchOfChatBot(UniqueId chatBotId);
}

abstract class IChatBotWatcherApi implements IWatcherApi<ChatBot> {
  Stream<Either<CrudFailure, KtList<ChatBot>>> watchAll();
  Stream<Either<CrudFailure, KtList<ChatBot>>> watchAllCreatedBy(
      UniqueId userId);
  Stream<Either<CrudFailure, KtList<ChatBot>>> watchAllSubscribed(
      UniqueId userId);
}

abstract class IQuestionWatcherApi implements IWatcherApi<Question> {
  Stream<Either<CrudFailure, KtList<Question>>> watchAllOfChatBot(
      UniqueId chatBotId);
}

abstract class IAnswerOptionWatcherApi implements IWatcherApi<AnswerOption> {
  Stream<Either<CrudFailure, KtList<AnswerOption>>> watchAllOfQuestion(
      UniqueId questionId);

  Stream<Either<CrudFailure, KtList<AnswerOption>>> watchAllOfChatBot(
      UniqueId chatBotId);
}

abstract class IQarWatcherApi implements IWatcherApi<Qar> {
  Stream<Either<CrudFailure, KtList<Qar>>> watchAllOfChatBot(
      UniqueId chatBotId);
  Stream<Either<CrudFailure, KtList<Qar>>> watchAllOfQuestion(
      UniqueId questionId);

  Stream<Either<CrudFailure, KtList<Qar>>> watchAllVisibleOfChatBot(
      UniqueId chatBotId);

  Stream<KtMap<UniqueId, Either<CrudFailure, Qar?>>>
      watchUnreadOrMostRecentQarOfChatBots(
          KtList<UniqueId> chatBotIds, UniqueId userId);
}

abstract class IAnswerItemWatcherApi implements IWatcherApi<AnswerItem> {
  Stream<Either<CrudFailure, KtList<AnswerItem>>>
      watchAllOfChatBotAndSignedInUser(UniqueId chatBotId);

  Stream<Either<CrudFailure, KtList<AnswerItem>>>
      watchAllOfQuestionAndSignedInUser(UniqueId questionId);

  Stream<Either<CrudFailure, KtList<AnswerItem>>> watchAllOfQar(UniqueId qarId);
}
