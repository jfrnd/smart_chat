// Package imports:
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
import 'chatbot_politics.dart';

// ! WHAT WOULD YOU VOTE?

const QUESTION_ID_VOTE = '301';
const QUESTION_BODY_VOTE_EN = 'What would you vote?';
const QUESTION_BODY_VOTE_DE = 'Was würdest du wählen?';

final questionBodyVoteEN = QuestionBody(QUESTION_BODY_VOTE_EN);

final questionBodyVoteDE = QuestionBody(QUESTION_BODY_VOTE_DE);

final questionBodyLangMapVote = Translatable<QuestionBody>(
  KtMap.from(
    {
      LanguageCode.en(): questionBodyVoteEN,
      LanguageCode.de(): questionBodyVoteDE,
    },
  ),
);

final questionBodyLangMapVoteUntrimmed = Translatable<QuestionBody>(
  KtMap.from(
    {
      LanguageCode.en(): questionBodyVoteEN,
      LanguageCode.de(): questionBodyVoteDE,
      LanguageCode.zh(): QuestionBody.empty()
    },
  ),
);

final questionVote = Question(
  id: UniqueId.fromUniqueString(QUESTION_ID_VOTE),
  chatBotId: chatBotPolitics.id,
  createdBy: chatBotPolitics.createdBy,
  updatedBy: chatBotPolitics.createdBy,
  createdAt: chatBotPolitics.createdAt,
  updatedAt: chatBotPolitics.updatedAt,
  translations: questionBodyLangMapVote,
  type: const QuestionType.multipleChoice(),
  multiSelection: false,
  unit: const MUnit.noUnit(),
  minVal: NumericValue.empty(),
  maxVal: NumericValue.empty(),
  digits: Digits.empty(),
  position: 0,
);

final questionVOTEUntrimmed = questionVote.copyWith(
  translations: questionBodyLangMapVoteUntrimmed,
);
