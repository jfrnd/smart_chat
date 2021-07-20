// Package imports:
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/core/valueobjects/language_code.dart';
import 'package:smart_chat/domain/core/valueobjects/translatable.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/answer_option/answer_option.dart';
import 'package:smart_chat/domain/entities/answer_option/answer_option_body.dart';
import 'package:smart_chat/infrastructure/dto/answer_option_dto.dart';
import 'questions_politics.dart';

// Chat Bot Diary
// Question VOTE Answer Option 1
// VALUE OBJECT
//

// ! Q: WHAT WOULD YOU VOTE?
// ! OPTION: SPD

const ANSWER_OPTION_ID_VOTE_SPD = '301';

const TIMESTAMP_ANSWER_OPTION_VOTE_SPD = "2021-01-01T12:00:00.000000";

const ANSWER_OPTION_BODY_VOTE_SPD_EN = 'SPD';
const ANSWER_OPTION_BODY_VOTE_SPD_DE = 'SPD';

final answerOptionBodyVOTESPDEN =
    AnswerOptionBody(ANSWER_OPTION_BODY_VOTE_SPD_EN);
final answerOptionBodyVOTESPDDE =
    AnswerOptionBody(ANSWER_OPTION_BODY_VOTE_SPD_DE);

final answerOptionBodyLangMapVOTESPD =
    Translatable<AnswerOptionBody>(KtMap.from({
  LanguageCode.en(): answerOptionBodyVOTESPDEN,
  LanguageCode.de(): answerOptionBodyVOTESPDDE,
}));
final answerOptionBodyLangMapVOTESPDUntrimmed =
    Translatable<AnswerOptionBody>(KtMap.from({
  LanguageCode.en(): answerOptionBodyVOTESPDEN,
  LanguageCode.de(): answerOptionBodyVOTESPDDE,
}));

final answerOptionVoteSPD = AnswerOption(
  id: UniqueId.fromUniqueString(ANSWER_OPTION_ID_VOTE_SPD),
  chatBotId: questionVote.chatBotId,
  questionId: questionVote.id,
  createdBy: questionVote.createdBy,
  updatedBy: questionVote.createdBy,
  createdAt: questionVote.createdAt,
  updatedAt: questionVote.createdAt,
  translations: answerOptionBodyLangMapVOTESPD,
  position: 0,
);
final answerOptionVoteSPDUntrimmed = answerOptionVoteSPD.copyWith(
  translations: answerOptionBodyLangMapVOTESPDUntrimmed,
);

final answerOptionVoteSPDAsDto = AnswerOptionDto(
  id: answerOptionVoteSPD.id.getOrCrash(),
  chatBotId: answerOptionVoteSPD.chatBotId.getOrCrash(),
  questionId: answerOptionVoteSPD.questionId.getOrCrash(),
  createdBy: answerOptionVoteSPD.createdBy.getOrCrash(),
  updatedBy: answerOptionVoteSPD.createdBy.getOrCrash(),
  createdAt: answerOptionVoteSPD.createdAt.toIso8601String(),
  updatedAt: answerOptionVoteSPD.createdAt.toIso8601String(),
  translations: answerOptionBodyLangMapVOTESPD.convertToRawMapOrCrash(),
);

// ! Q: WHAT WOULD YOU VOTE?
// ! OPTION: CDU

const ANSWER_OPTION_ID_VOTE_CDU = '302';

const TIMESTAMP_ANSWER_OPTION_VOTE_CDU = "2021-01-01T13:00:00.000000";

const ANSWER_OPTION_BODY_VOTE_CDU_EN = 'CDU';
const ANSWER_OPTION_BODY_VOTE_CDU_DE = 'CDU';

final answerOptionBodyVOTECDUEN =
    AnswerOptionBody(ANSWER_OPTION_BODY_VOTE_CDU_EN);
final answerOptionBodyVOTECDUDE =
    AnswerOptionBody(ANSWER_OPTION_BODY_VOTE_CDU_DE);

final answerOptionBodyLangMapVoteCDU =
    Translatable<AnswerOptionBody>(KtMap.from({
  LanguageCode.en(): answerOptionBodyVOTECDUEN,
  LanguageCode.de(): answerOptionBodyVOTECDUDE,
}));

final answerOptionVoteCDU = AnswerOption(
  id: UniqueId.fromUniqueString(ANSWER_OPTION_ID_VOTE_CDU),
  chatBotId: questionVote.chatBotId,
  questionId: questionVote.id,
  createdBy: questionVote.createdBy,
  updatedBy: questionVote.createdBy,
  createdAt: questionVote.createdAt,
  updatedAt: questionVote.createdAt,
  translations: answerOptionBodyLangMapVoteCDU,
  position: 0,
);
