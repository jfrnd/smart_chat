// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/core/valueobjects/language_code.dart';
import 'package:smart_chat/domain/core/valueobjects/translatable.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/answer_option/answer_option.dart';
import 'package:smart_chat/domain/entities/answer_option/answer_option_body.dart';
import 'package:smart_chat/infrastructure/core/firestore_helpers.dart';
import 'package:smart_chat/infrastructure/dto/answer_option_dto.dart';
import 'questions_diary.dart';

// ! Q: HOW WAS YOUR DAY?
// ! OPTION: good

const ANSWER_OPTION_ID_DAY_GOOD = '101';

const TIMESTAMP_ANSWER_OPTION_DAY_GOOD = "2021-01-01T12:00:00.000000";

const ANSWER_OPTION_BODY_DAY_GOOD_EN = 'good';
const ANSWER_OPTION_BODY_DAY_GOOD_DE = 'gut';
const ANSWER_OPTION_BODY_DAY_GOOD_ZH = '很好';

final answerOptionBodyDayGoodEN =
    AnswerOptionBody(ANSWER_OPTION_BODY_DAY_GOOD_EN);
final answerOptionBodyDayGoodDE =
    AnswerOptionBody(ANSWER_OPTION_BODY_DAY_GOOD_DE);
final answerOptionBodyDayGoodZH =
    AnswerOptionBody(ANSWER_OPTION_BODY_DAY_GOOD_DE);

final answerOptionBodyLangMapDayGood =
    Translatable<AnswerOptionBody>(KtMap.from({
  LanguageCode.en(): answerOptionBodyDayGoodEN,
  LanguageCode.de(): answerOptionBodyDayGoodDE,
}));
final answerOptionBodyLangMapDayGoodUntrimmed =
    Translatable<AnswerOptionBody>(KtMap.from({
  LanguageCode.en(): answerOptionBodyDayGoodEN,
  LanguageCode.de(): answerOptionBodyDayGoodDE,
  LanguageCode.zh(): AnswerOptionBody.empty(),
}));
final answerOptionBodyLangMapDayGoodExtended =
    Translatable<AnswerOptionBody>(KtMap.from({
  LanguageCode.en(): answerOptionBodyDayGoodEN,
  LanguageCode.de(): answerOptionBodyDayGoodDE,
  LanguageCode.zh(): answerOptionBodyDayGoodZH,
}));
final answerOptionBodyLangMapDayGoodInvalid =
    Translatable<AnswerOptionBody>(KtMap.from({
  LanguageCode.en(): answerOptionBodyDayGoodEN,
  LanguageCode.de(): AnswerOptionBody('Multi \n line'),
}));

final answerOptionDayGood = AnswerOption(
  id: UniqueId.fromUniqueString(ANSWER_OPTION_ID_DAY_GOOD),
  chatBotId: questionDay.chatBotId,
  questionId: questionDay.id,
  createdBy: questionDay.createdBy,
  updatedBy: questionDay.createdBy,
  createdAt: questionDay.createdAt,
  updatedAt: questionDay.createdAt,
  translations: answerOptionBodyLangMapDayGood,
  position: 0,
);
final answerOptionDayGoodUntrimmed = answerOptionDayGood.copyWith(
  translations: answerOptionBodyLangMapDayGoodUntrimmed,
);

final answerOptionDayGoodAsDto = AnswerOptionDto(
  id: answerOptionDayGood.id.getOrCrash(),
  chatBotId: answerOptionDayGood.chatBotId.getOrCrash(),
  questionId: answerOptionDayGood.questionId.getOrCrash(),
  createdBy: answerOptionDayGood.createdBy.getOrCrash(),
  updatedBy: answerOptionDayGood.createdBy.getOrCrash(),
  createdAt: answerOptionDayGood.createdAt.toIso8601String(),
  updatedAt: answerOptionDayGood.createdAt.toIso8601String(),
  translations: answerOptionBodyLangMapDayGood.convertToRawMapOrCrash(),
);

final answerOptionDayGoodAsFirestoreMap = {
  CHAT_BOT_ID: answerOptionDayGood.chatBotId.toString(),
  QUESTION_ID: answerOptionDayGood.questionId.toString(),
  CREATED_BY: answerOptionDayGood.createdBy.toString(),
  UPDATED_BY: answerOptionDayGood.updatedBy.toString(),
  CREATED_AT: Timestamp.fromDate(answerOptionDayGood.createdAt),
  UPDATED_AT: Timestamp.fromDate(answerOptionDayGood.updatedAt),
  TRANSLATIONS: answerOptionBodyLangMapDayGood.convertToRawMapOrCrash(),
  DOCUMENT_ID: answerOptionDayGood.id.getOrCrash(),
};

// ! Q: HOW WAS YOUR DAY?
// ! OPTION: bad

const ANSWER_OPTION_ID_DAY_BAD = '102';

const TIMESTAMP_ANSWER_OPTION_DAY_BAD = "2021-01-01T13:00:00.000000";

const ANSWER_OPTION_BODY_DAY_BAD_DE = 'schlecht';
final answerOptionBodyDayBadDE =
    AnswerOptionBody(ANSWER_OPTION_BODY_DAY_BAD_DE);

const ANSWER_OPTION_BODY_DAY_BAD_EN = 'bad';
final answerOptionBodyDayBadEN =
    AnswerOptionBody(ANSWER_OPTION_BODY_DAY_BAD_EN);

final answerOptionBodyLangMapDayBad =
    Translatable<AnswerOptionBody>(KtMap.from({
  LanguageCode.en(): answerOptionBodyDayBadEN,
  LanguageCode.de(): answerOptionBodyDayBadDE,
}));

final answerOptionDayBad = AnswerOption(
  id: UniqueId.fromUniqueString(ANSWER_OPTION_ID_DAY_BAD),
  chatBotId: questionDay.chatBotId,
  questionId: questionDay.id,
  createdBy: questionDay.createdBy,
  updatedBy: questionDay.createdBy,
  createdAt: questionDay.createdAt,
  updatedAt: questionDay.createdAt,
  translations: answerOptionBodyLangMapDayBad,
  position: 0,
);

// ! Q: WHAT DID YOU DO TODAY?
// ! OPTION: working

const ANSWER_OPTION_ID_ACTIVITY_WORKING = '103';

const TIMESTAMP_ANSWER_OPTION_ACTIVITY_WORKING = "2021-01-01T13:00:00.000000";

const ANSWER_OPTION_BODY_ACTIVITY_WORKING_DE = 'Arbeit';
final answerOptionBodyActivityWorkingDE =
    AnswerOptionBody(ANSWER_OPTION_BODY_ACTIVITY_WORKING_DE);

const ANSWER_OPTION_BODY_ACTIVITY_WORKING_EN = 'Working';
final answerOptionBodyActivityWorkingEN =
    AnswerOptionBody(ANSWER_OPTION_BODY_ACTIVITY_WORKING_EN);

final answerOptionBodyLangMapActivityWorking =
    Translatable<AnswerOptionBody>(KtMap.from({
  LanguageCode.en(): answerOptionBodyActivityWorkingDE,
  LanguageCode.de(): answerOptionBodyActivityWorkingDE,
}));

final answerOptionActivityWorking = AnswerOption(
  id: UniqueId.fromUniqueString(ANSWER_OPTION_ID_ACTIVITY_WORKING),
  chatBotId: questionActivity.chatBotId,
  questionId: questionActivity.id,
  createdBy: questionActivity.createdBy,
  updatedBy: questionActivity.createdBy,
  createdAt: questionActivity.createdAt,
  updatedAt: questionActivity.createdAt,
  translations: answerOptionBodyLangMapActivityWorking,
  position: 0,
);

// ! Q: WHAT DID YOU DO TODAY?
// ! OPTION: friends

const ANSWER_OPTION_ID_ACTIVITY_FRIENDS = '104';

const TIMESTAMP_ANSWER_OPTION_ACTIVITY_FRIENDS = "2021-01-01T14:00:00.000000";

const ANSWER_OPTION_BODY_ACTIVITY_FRIENDS_EN = 'Meeting Friends';
final answerOptionBodyActivityFriendsEN =
    AnswerOptionBody(ANSWER_OPTION_BODY_ACTIVITY_FRIENDS_EN);

const ANSWER_OPTION_BODY_ACTIVITY_FRIENDS_DE = 'Freunde treffen';
final answerOptionBodyActivityFriendsDE =
    AnswerOptionBody(ANSWER_OPTION_BODY_ACTIVITY_FRIENDS_DE);

final answerOptionBodyLangMapActivityFriends =
    Translatable<AnswerOptionBody>(KtMap.from({
  LanguageCode.en(): answerOptionBodyActivityFriendsDE,
  LanguageCode.de(): answerOptionBodyActivityFriendsDE,
}));

final answerOptionActivityFriends = AnswerOption(
  id: UniqueId.fromUniqueString(ANSWER_OPTION_ID_ACTIVITY_FRIENDS),
  chatBotId: questionActivity.chatBotId,
  questionId: questionActivity.id,
  createdBy: questionActivity.createdBy,
  updatedBy: questionActivity.createdBy,
  createdAt: questionActivity.createdAt,
  updatedAt: questionActivity.createdAt,
  translations: answerOptionBodyLangMapActivityFriends,
  position: 0,
);

// ! Q: WHAT DID YOU DO TODAY?
// ! OPTION: soccer

const ANSWER_OPTION_ID_ACTIVITY_SOCCER = '105';

const TIMESTAMP_ANSWER_OPTION_ACTIVITY_SOCCER = "2021-01-01T15:00:00.000000";

const ANSWER_OPTION_BODY_ACTIVITY_SOCCER_EN = 'soccer';
final answerOptionBodyActivitySoccerEN =
    AnswerOptionBody(ANSWER_OPTION_BODY_ACTIVITY_SOCCER_EN);

const ANSWER_OPTION_BODY_ACTIVITY_SOCCER_DE = 'Fussball';
final answerOptionBodyActivitySoccerDE =
    AnswerOptionBody(ANSWER_OPTION_BODY_ACTIVITY_SOCCER_DE);

final answerOptionBodyLangMapActivitySoccer =
    Translatable<AnswerOptionBody>(KtMap.from({
  LanguageCode.en(): answerOptionBodyActivitySoccerDE,
  LanguageCode.de(): answerOptionBodyActivitySoccerDE,
}));

final answerOptionActivitySoccer = AnswerOption(
  id: UniqueId.fromUniqueString(ANSWER_OPTION_ID_ACTIVITY_SOCCER),
  chatBotId: questionActivity.chatBotId,
  questionId: questionActivity.id,
  createdBy: questionActivity.createdBy,
  updatedBy: questionActivity.createdBy,
  createdAt: questionActivity.createdAt,
  updatedAt: questionActivity.createdAt,
  translations: answerOptionBodyLangMapActivitySoccer,
  position: 0,
);
