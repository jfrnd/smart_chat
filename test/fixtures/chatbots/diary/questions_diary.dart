// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/core/valueobjects/language_code.dart';
import 'package:smart_chat/domain/core/valueobjects/m_unit.dart';
import 'package:smart_chat/domain/core/valueobjects/numeric_value.dart';
import 'package:smart_chat/domain/core/valueobjects/translatable.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/question/digits.dart';
import 'package:smart_chat/domain/entities/question/question.dart';
import 'package:smart_chat/domain/entities/question/question_body.dart';
import 'package:smart_chat/domain/entities/question/question_type.dart';
import 'package:smart_chat/infrastructure/core/firestore_helpers.dart';
import 'package:smart_chat/infrastructure/dto/question_dto.dart';
import 'chatbot_diary.dart';

// ! HOW WAS YOUR DAY?

const QUESTION_ID_DAY = '101';
const QUESTION_BODY_DAY_EN = 'How was your day?';
const QUESTION_BODY_DAY_DE = 'Wie war dein Tag?';

final questionBodyDayEN = QuestionBody(QUESTION_BODY_DAY_EN);

final questionBodyDayDE = QuestionBody(QUESTION_BODY_DAY_DE);

final questionBodyLangMapDay = Translatable<QuestionBody>(
  KtMap.from(
    {
      LanguageCode.en(): questionBodyDayEN,
      LanguageCode.de(): questionBodyDayDE,
    },
  ),
);

final questionBodyLangMapDayUntrimmed = Translatable<QuestionBody>(
  KtMap.from(
    {
      LanguageCode.en(): questionBodyDayEN,
      LanguageCode.de(): questionBodyDayDE,
      LanguageCode.zh(): QuestionBody.empty()
    },
  ),
);

final questionBodyLangMapDayInvalid = Translatable<QuestionBody>(
  KtMap.from(
    {
      LanguageCode.en(): questionBodyDayEN,
      LanguageCode.de(): questionBodyDayDE,
      LanguageCode.zh():
          QuestionBody('Invalid QuestionBody Without Question Mark')
    },
  ),
);

const QUESTION_BODY_DAY_ZH = '今天怎么样?';
final questionBodyDayZH = QuestionBody(QUESTION_BODY_DAY_ZH);

final questionBodyLangMapDayExtended = Translatable<QuestionBody>(
  KtMap.from(
    {
      LanguageCode.en(): questionBodyDayEN,
      LanguageCode.de(): questionBodyDayDE,
      LanguageCode.zh(): questionBodyDayZH,
    },
  ),
);

final questionDay = Question(
  id: UniqueId.fromUniqueString(QUESTION_ID_DAY),
  chatBotId: chatBotDiary.id,
  createdBy: chatBotDiary.createdBy,
  updatedBy: chatBotDiary.createdBy,
  createdAt: chatBotDiary.createdAt,
  updatedAt: chatBotDiary.updatedAt,
  translations: questionBodyLangMapDay,
  unit: const MUnit.noUnit(),
  type: const QuestionType.multipleChoice(),
  multiSelection: false,
  minVal: NumericValue.empty(),
  maxVal: NumericValue.empty(),
  digits: Digits.empty(),
  position: 1,
);

final questionDayUntrimmed = questionDay.copyWith(
  translations: questionBodyLangMapDayUntrimmed,
);

final questionDayAsDto = QuestionDto(
  id: questionDay.id.getOrCrash(),
  chatBotId: chatBotDiary.id.getOrCrash(),
  createdBy: questionDay.createdBy.getOrCrash(),
  updatedBy: questionDay.updatedBy.getOrCrash(),
  createdAt: questionDay.createdAt.toIso8601String(),
  updatedAt: questionDay.updatedAt.toIso8601String(),
  translations: questionDay.translations.convertToRawMapOrCrash(),
  type: questionDay.type.asString(),
  multiSelection: questionDay.multiSelection,
  unit: questionDay.unit.asString(),
  minVal: null,
  maxVal: null,
  digits: null,
  position: questionDay.position,
);

final questionDayAsFirestoreMap = {
  CHAT_BOT_ID: questionDay.chatBotId.getOrCrash(),
  CREATED_BY: questionDay.createdBy.getOrCrash(),
  UPDATED_BY: questionDay.updatedBy.getOrCrash(),
  CREATED_AT: Timestamp.fromDate(questionDay.createdAt),
  UPDATED_AT: Timestamp.fromDate(questionDay.updatedAt),
  TRANSLATIONS: questionDay.translations.convertToRawMapOrCrash(),
  TYPE: questionDay.type.asString(),
  UNIT: questionDay.unit.asString(),
  MIN_VAL: null,
  MAX_VAL: null,
  DIGITS: null,
  DOCUMENT_ID: questionDay.id.getOrCrash(),
  POSITION: questionDay.position,
  MULTI_SELECTION: questionDay.multiSelection,
};

// ! HOW MANY HOURS DID YOU SLEEP LAST NIGHT?

const QUESTION_ID_SLEEP = '102';

const QUESTION_BODY_SLEEP_EN = 'How many hours did you sleep last night?';
const QUESTION_BODY_SLEEP_DE = 'Wie viele Stunden hast du gestern geschlafen?';

final questionBodySleepEN = QuestionBody(QUESTION_BODY_SLEEP_EN);
final questionBodySleepDE = QuestionBody(QUESTION_BODY_SLEEP_DE);

final questionBodyLangMapSleep = Translatable<QuestionBody>(
  KtMap.from(
    {
      LanguageCode.de(): questionBodySleepDE,
      LanguageCode.en(): questionBodySleepEN,
    },
  ),
);

final questionSleep = Question(
  id: UniqueId.fromUniqueString(QUESTION_ID_SLEEP),
  chatBotId: chatBotDiary.id,
  createdBy: chatBotDiary.createdBy,
  updatedBy: chatBotDiary.createdBy,
  createdAt: chatBotDiary.createdAt,
  updatedAt: chatBotDiary.updatedAt,
  translations: questionBodyLangMapSleep,
  type: const QuestionType.time(),
  multiSelection: false,
  unit: const MUnit.noUnit(),
  minVal: NumericValue.empty(),
  maxVal: NumericValue.empty(),
  digits: Digits.empty(),
  position: 2,
);

// ! WHAT DID YOU DO TODAY (ACTIVITY)?

const QUESTION_ID_ACTIVITY = '103';

const QUESTION_BODY_ACTIVITY_EN = 'What did you do today?';
const QUESTION_BODY_ACTIVITY_DE = 'Was hast du heute gemacht?';

final questionBodyActivityEN = QuestionBody(QUESTION_BODY_ACTIVITY_EN);
final questionBodyActivityDE = QuestionBody(QUESTION_BODY_ACTIVITY_DE);

final questionBodyLangMapActivity = Translatable<QuestionBody>(
  KtMap.from(
    {
      LanguageCode.de(): questionBodyActivityEN,
      LanguageCode.en(): questionBodyActivityDE,
    },
  ),
);

final questionActivity = Question(
  id: UniqueId.fromUniqueString(QUESTION_ID_ACTIVITY),
  chatBotId: chatBotDiary.id,
  createdBy: chatBotDiary.createdBy,
  updatedBy: chatBotDiary.createdBy,
  createdAt: chatBotDiary.createdAt,
  updatedAt: chatBotDiary.updatedAt,
  translations: questionBodyLangMapActivity,
  type: const QuestionType.multipleChoice(),
  multiSelection: true,
  unit: const MUnit.noUnit(),
  minVal: NumericValue.empty(),
  maxVal: NumericValue.empty(),
  digits: Digits.empty(),
  position: 3,
);
