// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

// Project imports:
import 'package:smart_chat/domain/core/valueobjects/time_value.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/answer_item/answer_item.dart';
import 'package:smart_chat/domain/entities/answer_item/answer_item_value.dart';
import 'package:smart_chat/infrastructure/core/firestore_helpers.dart';
import 'package:smart_chat/infrastructure/dto/answer_item_dto.dart';
import 'answer_options_diary.dart';
import 'qars_diary.dart';
import 'questions_diary.dart';

enum DayAnswer { good, bad }

enum ActivityAnswer { friends, soccer, working }

final answerItemDayGoodMonday = createQarDayAnswerItem(MONDAY, DayAnswer.good);
final answerItemDayBadTuesday = createQarDayAnswerItem(TUESDAY, DayAnswer.bad);

final answerItemSleepMonday =
    createQarSleepAnswerItem(MONDAY, TimeValue(hh: 8));
final answerItemSleepTuesday =
    createQarSleepAnswerItem(TUESDAY, TimeValue(hh: 7));

AnswerItem createQarDayAnswerItem(String date, DayAnswer answer) {
  return AnswerItem(
    id: UniqueId.fromUniqueString('${QAR_ID_DAY}ITEM$date'),
    qarId: UniqueId.fromUniqueString(QAR_ID_DAY + date),
    chatBotId: questionDay.chatBotId,
    questionId: questionDay.id,
    createdAt: DateTime.parse(date),
    createdBy: questionDay.createdBy,
    value: AnswerItemValue.fromAnswerOptionId(answer == DayAnswer.good
        ? answerOptionDayGood.id
        : answerOptionDayBad.id),
    validOn: DateTime.parse(date),
  );
}

AnswerItem createQarActivityAnswerItem(String date, ActivityAnswer answer) {
  return AnswerItem(
    id: UniqueId.fromUniqueString('${QAR_ID_ACTIVITY}ITEM$date'),
    qarId: UniqueId.fromUniqueString(QAR_ID_ACTIVITY + date),
    chatBotId: questionActivity.chatBotId,
    questionId: questionActivity.id,
    createdAt: DateTime.parse(date),
    createdBy: questionActivity.createdBy,
    value: AnswerItemValue.fromAnswerOptionId(
      answer == ActivityAnswer.friends
          ? answerOptionActivityFriends.id
          : answer == ActivityAnswer.soccer
              ? answerOptionActivitySoccer.id
              : answerOptionActivityWorking.id,
    ),
    validOn: DateTime.parse(date),
  );
}

final answerItemActivityFriendsMonday =
    createQarActivityAnswerItem(MONDAY, ActivityAnswer.friends);
final answerItemActivitySoccerMonday =
    createQarActivityAnswerItem(MONDAY, ActivityAnswer.soccer);
final answerItemActivityWorkingMonday =
    createQarActivityAnswerItem(MONDAY, ActivityAnswer.working);

AnswerItem createQarSleepAnswerItem(String date, TimeValue time) {
  return AnswerItem(
    id: UniqueId.fromUniqueString('${QAR_ID_SLEEP}ITEM$date'),
    qarId: UniqueId.fromUniqueString(QAR_ID_SLEEP + date),
    chatBotId: questionSleep.chatBotId,
    questionId: questionSleep.id,
    createdAt: DateTime.parse(date),
    createdBy: questionSleep.createdBy,
    value: AnswerItemValue.fromTimeValue(time),
    validOn: DateTime.parse(date),
  );
}

final answerItemDayGoodAsDto = AnswerItemDto(
  id: answerItemDayGoodMonday.id.getOrCrash(),
  qarId: answerItemDayGoodMonday.qarId.getOrCrash(),
  chatBotId: answerItemDayGoodMonday.chatBotId.getOrCrash(),
  questionId: answerItemDayGoodMonday.questionId.getOrCrash(),
  createdAt: answerItemDayGoodMonday.createdAt.toIso8601String(),
  createdBy: answerItemDayGoodMonday.createdBy.getOrCrash(),
  value: answerItemDayGoodMonday.value.getOrCrash(),
  validOn: answerItemDayGoodMonday.validOn.toIso8601String(),
);

final answerItemDayGoodMondayAsFirestoreMap = {
  DOCUMENT_ID: answerItemDayGoodMonday.id.getOrCrash(),
  QAR_ID: answerItemDayGoodMonday.qarId.getOrCrash(),
  CHAT_BOT_ID: answerItemDayGoodMonday.chatBotId.getOrCrash(),
  QUESTION_ID: answerItemDayGoodMonday.questionId.getOrCrash(),
  CREATED_BY: answerItemDayGoodMonday.createdBy.getOrCrash(),
  CREATED_AT: Timestamp.fromDate(answerItemDayGoodMonday.createdAt),
  VALUE: answerItemDayGoodMonday.value.getOrCrash(),
  VALID_ON: Timestamp.fromDate(answerItemDayGoodMonday.validOn),
};
