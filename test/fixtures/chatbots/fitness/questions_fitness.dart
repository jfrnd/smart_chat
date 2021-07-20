// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kt_dart/collection.dart';

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
import 'chatbot_fitness.dart';

// ! SPORT

const QUESTION_ID_KM = '201';

const QUESTION_BODY_KM_EN = 'How many km did you go running today?';
const QUESTION_BODY_KM_DE = 'Wie viele km bist du heute gelaufen?';

final questionBodyKMEN = QuestionBody(QUESTION_BODY_KM_EN);
final questionBodyKMDE = QuestionBody(QUESTION_BODY_KM_DE);

final questionBodyLangMapKM = Translatable<QuestionBody>(
  KtMap.from(
    {
      LanguageCode.de(): questionBodyKMDE,
      LanguageCode.en(): questionBodyKMEN,
    },
  ),
);

final questionKM = Question(
  id: UniqueId.fromUniqueString(QUESTION_ID_KM),
  chatBotId: chatBotFitness.id,
  createdBy: chatBotFitness.createdBy,
  updatedBy: chatBotFitness.createdBy,
  createdAt: chatBotFitness.createdAt,
  updatedAt: chatBotFitness.updatedAt,
  translations: questionBodyLangMapKM,
  type: const QuestionType.numeric(),
  multiSelection: false,
  unit: const MUnit.km(),
  minVal: NumericValue(0.0),
  maxVal: NumericValue(10.0),
  digits: Digits(1),
  position: 0,
);

final questionKMAsDto = QuestionDto(
  id: questionKM.id.getOrCrash(),
  chatBotId: questionKM.chatBotId.getOrCrash(),
  createdBy: chatBotFitness.createdBy.getOrCrash(),
  updatedBy: chatBotFitness.createdBy.getOrCrash(),
  createdAt: chatBotFitness.createdAt.toIso8601String(),
  updatedAt: chatBotFitness.updatedAt.toIso8601String(),
  translations: questionKM.translations.convertToRawMapOrCrash(),
  type: questionKM.type.asString(),
  multiSelection: null,
  unit: questionKM.unit.asString(),
  minVal: questionKM.minVal.getOrCrash(),
  maxVal: questionKM.maxVal.getOrCrash(),
  digits: questionKM.digits.getOrCrash(),
  position: questionKM.position,
);

final questionKMAsFirestoreMap = {
  CHAT_BOT_ID: questionKM.chatBotId.getOrCrash(),
  CREATED_BY: questionKM.createdBy.getOrCrash(),
  UPDATED_BY: questionKM.updatedBy.getOrCrash(),
  CREATED_AT: Timestamp.fromDate(questionKM.createdAt),
  UPDATED_AT: Timestamp.fromDate(questionKM.updatedAt),
  TRANSLATIONS: questionKM.translations.convertToRawMapOrCrash(),
  TYPE: questionKM.type.asString(),
  UNIT: questionKM.unit.asString(),
  MIN_VAL: questionKM.minVal.getOrCrash(),
  MAX_VAL: questionKM.maxVal.getOrCrash(),
  DIGITS: questionKM.digits.getOrCrash(),
  DOCUMENT_ID: questionKM.id.getOrCrash(),
  MULTI_SELECTION: null,
  POSITION: questionKM.position,
};
