// Package imports:
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

// Project imports:
import 'package:smart_chat/domain/entities/answer_item/answer_item.dart';
import 'package:smart_chat/domain/entities/answer_option/answer_option.dart';
import 'package:smart_chat/domain/entities/chatbot/chatbot.dart';
import 'package:smart_chat/domain/entities/qar/qar.dart';
import 'package:smart_chat/domain/entities/question/question.dart';
import 'package:smart_chat/domain/entities/subscription/subscription.dart';
import 'package:smart_chat/domain/entities/user/user.dart';
import 'package:smart_chat/infrastructure/core/firestore_helpers.dart';
import 'package:smart_chat/infrastructure/dto/answer_item_dto.dart';
import 'package:smart_chat/infrastructure/dto/answer_option_dto.dart';
import 'package:smart_chat/infrastructure/dto/chatbot_dto.dart';
import 'package:smart_chat/infrastructure/dto/qar_dto.dart';
import 'package:smart_chat/infrastructure/dto/question_dto.dart';
import 'package:smart_chat/infrastructure/dto/subscription_dto.dart';
import 'package:smart_chat/infrastructure/dto/user_dto.dart';

extension MockFireBasePopulationX on FakeFirebaseFirestore {
// ! SUBSCRIPTION !

  Future<void> populateWithSubscription(Subscription subscription) =>
      subscriptions(userId: subscription.createdBy)
          .doc(subscription.id.getOrCrash())
          .set(SubscriptionDto.fromDomain(subscription).toFireStore());
// ! USER !

  Future<void> populateWithUser(User user) => users
      .doc(user.id.getOrCrash())
      .set(UserDto.fromDomain(user).toFireStore());

// ! CHATBOTS !

  Future<void> populateWithChatBot(ChatBot chatBot) => chatBots
      .doc(chatBot.id.getOrCrash())
      .set(ChatBotDto.fromDomain(chatBot).toFireStore());

// ! QUESTIONS !

  Future<void> populateWithQuestion(Question question) =>
      questions(chatBotId: question.chatBotId)
          .doc(question.id.getOrCrash())
          .set(QuestionDto.fromDomain(question).toFireStore());

  // ! ANSWER OPTION !

  Future<void> populateWithAnswerOption(AnswerOption answerOption) =>
      answerOptions(
              chatBotId: answerOption.chatBotId,
              questionId: answerOption.questionId)
          .doc(answerOption.id.getOrCrash())
          .set(AnswerOptionDto.fromDomain(answerOption).toFireStore());

// ! QAR !

  Future<void> populateWithQar(Qar qar) =>
      qars(userId: qar.createdBy, chatBotId: qar.chatBotId)
          .doc(qar.id.getOrCrash())
          .set(QarDto.fromDomain(qar).toFireStore());

// ! ANSWER ITEM !

  Future<void> populateWithAnswerItem(AnswerItem answerItem) => answerItemsOf(
          userId: answerItem.createdBy, chatBotId: answerItem.chatBotId)
      .doc(answerItem.id.getOrCrash())
      .set(AnswerItemDto.fromDomain(answerItem).toFireStore());
}
