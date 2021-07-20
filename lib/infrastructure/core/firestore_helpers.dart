// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/answer_item/answer_item.dart';
import 'package:smart_chat/domain/entities/answer_option/answer_option.dart';
import 'package:smart_chat/domain/entities/chatbot/chatbot.dart';
import 'package:smart_chat/domain/entities/qar/qar.dart';
import 'package:smart_chat/domain/entities/question/question.dart';
import 'package:smart_chat/domain/entities/subscription/subscription.dart';
import 'package:smart_chat/domain/entities/user/user.dart';
import 'package:smart_chat/infrastructure/dto/answer_item_dto.dart';
import 'package:smart_chat/infrastructure/dto/answer_option_dto.dart';
import 'package:smart_chat/infrastructure/dto/chatbot_dto.dart';
import 'package:smart_chat/infrastructure/dto/qar_dto.dart';
import 'package:smart_chat/infrastructure/dto/question_dto.dart';
import 'package:smart_chat/infrastructure/dto/subscription_dto.dart';
import 'package:smart_chat/infrastructure/dto/user_dto.dart';

//! PATH
const USERS = 'users';
const CHATBOTS = 'chatbots';
const QUESTIONS = 'questions';
const ANSWER_OPTIONS = 'answer_options';
const ANSWER_ITEMS = 'answer_items';
const QARS = 'qars';
const SUBSCRIPTIONS = 'subscriptions';

//! General
const DOCUMENT_ID = 'documentId';
const CREATED_BY = 'createdBy';
const UPDATED_BY = 'updatedBy';
const CREATED_AT = 'createdAt';
const UPDATED_AT = 'updatedAt';
const IMAGE_URL = 'imageUrl';
const USERID = 'userId';

//! SUBSCRIPTION
const STATUS = 'status';
const TRIGGERS = 'triggers';

//! USER
const EMAIL = 'email';
const USER_NAME = 'userName';
const ACTIVE_AT = 'activeAt';
const TOKEN = 'token';
const LANGUAGE_CODE = 'languageCode';
const TIME_ZONE_OFFSET = 'timeZoneOffset';

//! ChatBot
const CHAT_BOT_ID = 'chatBotId';
const TRANSLATIONS = 'translations';

//! Question
const QUESTION_ID = 'questionId';
const TYPE = 'type';
const UNIT = 'unit';
const MIN_VAL = 'minVal';
const MAX_VAL = 'maxVal';
const DIGITS = 'digits';
const MULTI_SELECTION = 'multiSelection';
const POSITION = 'position';

//! AnswerOption

//! Qar
const QAR_ID = 'qarId';
const IS_ANSWERED = 'isAnswered';
const VISIBLE_SINCE = 'visibleSince';
const IS_VISIBLE = 'isVisible';
const SESSION_ID = 'sessionId';
const REACTION_ITEM_ID = 'reactionItemId';
const ANSWER_ITEM_IDS = 'answerItemIds';

//! AnswerItem
const VALID_ON = 'validOn';
const VALUE = 'value';

extension FirestoreX on FirebaseFirestore {
  DocumentReference userDocOf(User user) {
    return collection(USERS).doc(user.id.getOrCrash());
  }

  //! USERS
  CollectionReference get users => collection(USERS);

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDoc(UniqueId userId) =>
      collection(USERS).doc(userId.getOrCrash()).get();

  Future<User?> getUserOrNull(UniqueId userId) =>
      collection(USERS).doc(userId.getOrCrash()).get().then(
            (snapshot) => snapshot.exists
                ? UserDto.fromFireStore(snapshot).toDomain()
                : null,
          );

  //! SUBSCRIPTIONS
  CollectionReference subscriptions({required UniqueId userId}) =>
      collection(USERS).doc(userId.getOrCrash()).collection(SUBSCRIPTIONS);

  Query subscriptionOfUserAndChatBot({
    required UniqueId userId,
    required UniqueId chatBotId,
  }) =>
      collection(USERS)
          .doc(userId.getOrCrash())
          .collection(SUBSCRIPTIONS)
          .where(CHAT_BOT_ID, isEqualTo: chatBotId.getOrCrash());

  Query queryOfSubscription({required UniqueId subscriptionId}) =>
      collectionGroup(SUBSCRIPTIONS)
          .where(DOCUMENT_ID, isEqualTo: subscriptionId.getOrCrash());

  Future<DocumentSnapshot<Map<String, dynamic>>> getSubscriptionDoc({
    required UniqueId userId,
    required UniqueId subscriptionId,
  }) =>
      collection(USERS)
          .doc(userId.getOrCrash())
          .collection(SUBSCRIPTIONS)
          .doc(subscriptionId.getOrCrash())
          .get();

  Future<Subscription?> getSubscriptionOrNull({
    required UniqueId userId,
    required UniqueId subscriptionId,
  }) =>
      collection(USERS)
          .doc(userId.getOrCrash())
          .collection(SUBSCRIPTIONS)
          .doc(subscriptionId.getOrCrash())
          .get()
          .then(
            (snapshot) => snapshot.exists
                ? SubscriptionDto.fromFireStore(snapshot).toDomain()
                : null,
          );

  //! CHATBOTS
  CollectionReference get chatBots => collection(CHATBOTS);

  Query chatBotsCreatedBy(UniqueId userId) =>
      collection(CHATBOTS).where(CREATED_BY, isEqualTo: userId.getOrCrash());

  Query chatBotsWithId(KtList<UniqueId> ids) => collection(CHATBOTS)
      .where(DOCUMENT_ID, whereIn: ids.map((id) => id.getOrCrash()).asList());

  Future<DocumentSnapshot<Map<String, dynamic>>> getChatBotDoc(
          UniqueId chatBotId) =>
      collection(CHATBOTS).doc(chatBotId.getOrCrash()).get();

  Future<ChatBot?> getChatBotOrNull(UniqueId chatBotId) =>
      collection(CHATBOTS).doc(chatBotId.getOrCrash()).get().then(
            (snapshot) => snapshot.exists
                ? ChatBotDto.fromFireStore(snapshot).toDomain()
                : null,
          );

  //! QUESTIONS

  CollectionReference questions({required UniqueId chatBotId}) =>
      collection(CHATBOTS).doc(chatBotId.getOrCrash()).collection(QUESTIONS);

  Query queryOfQuestion({required UniqueId questionId}) =>
      collectionGroup(QUESTIONS)
          .where(DOCUMENT_ID, isEqualTo: questionId.getOrCrash());

  Future<DocumentSnapshot<Map<String, dynamic>>> getQuestionDoc({
    required UniqueId chatBotId,
    required UniqueId questionId,
  }) =>
      collection(CHATBOTS)
          .doc(chatBotId.getOrCrash())
          .collection(QUESTIONS)
          .doc(questionId.getOrCrash())
          .get();

  Future<Question?> getQuestionOrNull({
    required UniqueId chatBotId,
    required UniqueId questionId,
  }) =>
      collection(CHATBOTS)
          .doc(chatBotId.getOrCrash())
          .collection(QUESTIONS)
          .doc(questionId.getOrCrash())
          .get()
          .then(
            (snapshot) => snapshot.exists
                ? QuestionDto.fromFireStore(snapshot).toDomain()
                : null,
          );

//! ANSWER_OPTIONS

  CollectionReference answerOptions(
          {required UniqueId chatBotId, required UniqueId questionId}) =>
      collection(CHATBOTS)
          .doc(chatBotId.getOrCrash())
          .collection(QUESTIONS)
          .doc(questionId.getOrCrash())
          .collection(ANSWER_OPTIONS);

  Query queryOfAnswerOptionsOfQuestion(UniqueId questionId) =>
      collectionGroup(ANSWER_OPTIONS)
          .where(QUESTION_ID, isEqualTo: questionId.getOrCrash());

  Query queryOfAnswerOptionsOfChatBot(UniqueId chatBotId) =>
      collectionGroup(ANSWER_OPTIONS)
          .where(CHAT_BOT_ID, isEqualTo: chatBotId.getOrCrash());

  Query queryOfAnswerOption({
    required UniqueId answerOptionId,
  }) =>
      collectionGroup(ANSWER_OPTIONS)
          .where(DOCUMENT_ID, isEqualTo: answerOptionId.getOrCrash());

  Future<DocumentSnapshot<Map<String, dynamic>>> getAnswerOptionDoc(
          {required UniqueId chatBotId,
          required UniqueId questionId,
          required UniqueId answerOptionId}) =>
      collection(CHATBOTS)
          .doc(chatBotId.getOrCrash())
          .collection(QUESTIONS)
          .doc(questionId.getOrCrash())
          .collection(ANSWER_OPTIONS)
          .doc(answerOptionId.getOrCrash())
          .get();

  Future<AnswerOption?> getAnswerOptionOrNull(
          {required UniqueId chatBotId,
          required UniqueId questionId,
          required UniqueId answerOptionId}) =>
      collection(CHATBOTS)
          .doc(chatBotId.getOrCrash())
          .collection(QUESTIONS)
          .doc(questionId.getOrCrash())
          .collection(ANSWER_OPTIONS)
          .doc(answerOptionId.getOrCrash())
          .get()
          .then(
            (snapshot) => snapshot.exists
                ? AnswerOptionDto.fromFireStore(snapshot).toDomain()
                : null,
          );

// !QARS

  Query queryOfQarByAnswerItemId(UniqueId answerItemId) => collectionGroup(QARS)
      .where(ANSWER_ITEM_IDS, arrayContains: answerItemId.getOrCrash());

  Query queryOfQar({required UniqueId qarId}) =>
      collectionGroup(QARS).where(DOCUMENT_ID, isEqualTo: qarId.getOrCrash());

  Query queryOfQarsBySessionId(UniqueId sessionId) => collectionGroup(QARS)
      .where(SESSION_ID, isEqualTo: sessionId.getOrCrash());

  Query queryOfQarBySessionIdAndPosition(UniqueId sessionId, int position) =>
      collectionGroup(QARS)
          .where(SESSION_ID, isEqualTo: sessionId.getOrCrash())
          .where(POSITION, isEqualTo: position);

  CollectionReference qars(
          {required UniqueId userId, required UniqueId chatBotId}) =>
      collection(USERS)
          .doc(userId.getOrCrash())
          .collection(CHATBOTS)
          .doc(chatBotId.getOrCrash())
          .collection(QARS);

  Future<DocumentSnapshot<Map<String, dynamic>>> getQarDoc(
          {required UniqueId userId,
          required UniqueId chatBotId,
          required UniqueId qarId}) =>
      collection(USERS)
          .doc(userId.getOrCrash())
          .collection(CHATBOTS)
          .doc(chatBotId.getOrCrash())
          .collection(QARS)
          .doc(qarId.getOrCrash())
          .get();

  Future<Qar?> getQarOrNull(
          {required UniqueId userId,
          required UniqueId chatBotId,
          required UniqueId qarId}) =>
      collection(USERS)
          .doc(userId.getOrCrash())
          .collection(CHATBOTS)
          .doc(chatBotId.getOrCrash())
          .collection(QARS)
          .doc(qarId.getOrCrash())
          .get()
          .then(
            (snapshot) => snapshot.exists
                ? QarDto.fromFireStore(snapshot).toDomain()
                : null,
          );

// !ANSWER ITEMS

  CollectionReference answerItemsOf(
          {required UniqueId userId, required UniqueId chatBotId}) =>
      collection(USERS)
          .doc(userId.getOrCrash())
          .collection(CHATBOTS)
          .doc(chatBotId.getOrCrash())
          .collection(ANSWER_ITEMS);

  Query queryOfAnswerItem({required UniqueId answerItemId}) =>
      collectionGroup(ANSWER_ITEMS)
          .where(DOCUMENT_ID, isEqualTo: answerItemId.getOrCrash());

  DocumentReference answerItemDocOf({
    required UniqueId userId,
    required UniqueId chatBotId,
    required UniqueId itemId,
  }) =>
      collection(USERS)
          .doc(userId.getOrCrash())
          .collection(CHATBOTS)
          .doc(chatBotId.getOrCrash())
          .collection(ANSWER_ITEMS)
          .doc(itemId.getOrCrash());

  Future<AnswerItem?> getAnswerItemOrNull({
    required UniqueId userId,
    required UniqueId chatBotId,
    required UniqueId answerItemId,
  }) =>
      collection(USERS)
          .doc(userId.getOrCrash())
          .collection(CHATBOTS)
          .doc(chatBotId.getOrCrash())
          .collection(ANSWER_ITEMS)
          .doc(answerItemId.getOrCrash())
          .get()
          .then(
            (snapshot) => snapshot.exists
                ? AnswerItemDto.fromFireStore(snapshot).toDomain()
                : null,
          );

  Future<DocumentSnapshot<Map<String, dynamic>>> getAnswerItemDoc({
    required UniqueId userId,
    required UniqueId chatBotId,
    required UniqueId anserItemId,
  }) =>
      collection(USERS)
          .doc(userId.getOrCrash())
          .collection(CHATBOTS)
          .doc(chatBotId.getOrCrash())
          .collection(ANSWER_ITEMS)
          .doc(anserItemId.getOrCrash())
          .get();
}
