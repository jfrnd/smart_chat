// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/qar/qar.dart';
import 'package:smart_chat/infrastructure/core/firestore_helpers.dart';
import 'package:smart_chat/infrastructure/dto/qar_dto.dart';
import 'questions_diary.dart';

const MONDAY = "2021-01-04T18:00:00.000000";
const TUESDAY = "2021-01-05T18:00:00.000000";
const WEDNESDAY = "2021-01-06T18:00:00.000000";
const THURSDAY = "2021-01-07T18:00:00.000000";
const FRIDAY = "2021-01-08T18:00:00.000000";
const SATURDAY = "2021-01-09T18:00:00.000000";
const SUNDAY = "2021-01-10T18:00:00.000000";

const QAR_ID_DAY = '101';
const QAR_ID_SLEEP = '102';
const QAR_ID_ACTIVITY = '103';

//! QAR Question Day

final qarDayMonday = createQarDay(
  createdAt: MONDAY,
  visibleSince: null,
  isAnswered: false,
  isVisible: false,
);

final qarDayTuesday = createQarDay(
  createdAt: TUESDAY,
  visibleSince: null,
  isAnswered: false,
  isVisible: false,
);
final qarDayWednesday = createQarDay(
  createdAt: WEDNESDAY,
  visibleSince: null,
  isAnswered: false,
  isVisible: false,
);

final qarDayThursday = createQarDay(
  createdAt: THURSDAY,
  visibleSince: null,
  isAnswered: false,
  isVisible: false,
);

final qarDayAsDto = QarDto(
  position: qarDayMonday.position,
  id: qarDayMonday.id.getOrCrash(),
  chatBotId: qarDayMonday.chatBotId.getOrCrash(),
  questionId: qarDayMonday.questionId.getOrCrash(),
  createdBy: qarDayMonday.createdBy.getOrCrash(),
  createdAt: qarDayMonday.createdAt.toIso8601String(),
  answerItemIds:
      qarDayMonday.answerItemIds.map((it) => it.getOrCrash()).asList(),
  isAnswered: qarDayMonday.isAnswered,
  isVisible: qarDayMonday.isVisible,
  reactionItemId: qarDayMonday.reactionItemId != null
      ? qarDayMonday.reactionItemId!.getOrCrash()
      : null,
  sessionId: qarDayMonday.sessionId.getOrCrash(),
  visibleSince: qarDayMonday.visibleSince != null
      ? qarDayMonday.visibleSince!.toIso8601String()
      : null,
);

final qarDayAsFirestoreMap = {
  CHAT_BOT_ID: qarDayMonday.chatBotId.getOrCrash(),
  QUESTION_ID: qarDayMonday.questionId.getOrCrash(),
  CREATED_BY: qarDayMonday.createdBy.getOrCrash(),
  ANSWER_ITEM_IDS:
      qarDayMonday.answerItemIds.asList().map((id) => id.getOrCrash()),
  CREATED_AT: Timestamp.fromDate(qarDayMonday.createdAt),
  IS_ANSWERED: qarDayMonday.isAnswered,
  IS_VISIBLE: qarDayMonday.isVisible,
  SESSION_ID: qarDayMonday.sessionId.getOrCrash(),
  REACTION_ITEM_ID: qarDayMonday.reactionItemId,
  VISIBLE_SINCE: qarDayMonday.visibleSince,
  DOCUMENT_ID: qarDayMonday.id.getOrCrash(),
  POSITION: qarDayMonday.position,
};

Qar createQarDay({
  required String createdAt,
  required String? visibleSince,
  bool isAnswered = true,
  bool isVisible = true,
}) {
  return Qar(
    id: UniqueId.fromUniqueString(QAR_ID_DAY + createdAt),
    chatBotId: questionDay.chatBotId,
    position: questionDay.position,
    questionId: questionDay.id,
    createdBy: questionDay.createdBy,
    createdAt: DateTime.parse(createdAt),
    answerItemIds: isAnswered
        ? listOf(UniqueId.fromUniqueString('${QAR_ID_DAY}ITEM$createdAt'))
        : listOf(),
    isAnswered: isAnswered,
    isVisible: isVisible,
    reactionItemId: null,
    sessionId: UniqueId.fromUniqueString(createdAt),
    visibleSince: visibleSince != null ? DateTime.parse(visibleSince) : null,
  );
}

// ! QAR Question Sleep

final qarSleepMonday = createQarSleep(
  createdAt: MONDAY,
  visibleSince: null,
  isAnswered: false,
  isVisible: false,
);
final qarSleepTuesday = createQarSleep(
  createdAt: TUESDAY,
  visibleSince: null,
  isAnswered: false,
  isVisible: false,
);
final qarSleepWednesday = createQarSleep(
  createdAt: WEDNESDAY,
  visibleSince: null,
  isAnswered: false,
  isVisible: false,
);
final qarSleepThursday = createQarSleep(
  createdAt: THURSDAY,
  visibleSince: THURSDAY,
  isAnswered: false,
  isVisible: false,
);

Qar createQarSleep({
  required String createdAt,
  required String? visibleSince,
  bool isAnswered = true,
  bool isVisible = true,
}) {
  return Qar(
    id: UniqueId.fromUniqueString(QAR_ID_SLEEP + createdAt),
    position: questionSleep.position,
    chatBotId: questionSleep.chatBotId,
    questionId: questionSleep.id,
    createdBy: questionSleep.createdBy,
    createdAt: DateTime.parse(createdAt),
    answerItemIds: isAnswered
        ? listOf(UniqueId.fromUniqueString('${QAR_ID_SLEEP}ITEM$createdAt'))
        : listOf(),
    isAnswered: isAnswered,
    isVisible: isVisible,
    reactionItemId: null,
    sessionId: UniqueId.fromUniqueString(createdAt),
    visibleSince: visibleSince != null ? DateTime.parse(visibleSince) : null,
  );
}

// ! QAR Question Activity

final qarActiviyMonday = createQarActivity(
  createdAt: MONDAY,
  visibleSince: null,
  isAnswered: false,
  isVisible: false,
);

Qar createQarActivity({
  required String createdAt,
  required String? visibleSince,
  bool isAnswered = true,
  bool isVisible = true,
}) {
  return Qar(
    id: UniqueId.fromUniqueString(QAR_ID_ACTIVITY + createdAt),
    chatBotId: questionActivity.chatBotId,
    position: questionActivity.position,
    questionId: questionActivity.id,
    createdBy: questionActivity.createdBy,
    createdAt: DateTime.parse(createdAt),
    answerItemIds: isAnswered
        ? listOf(UniqueId.fromUniqueString('${QAR_ID_ACTIVITY}ITEM$createdAt'))
        : listOf(),
    isAnswered: isAnswered,
    isVisible: isVisible,
    reactionItemId: null,
    sessionId: UniqueId.fromUniqueString(createdAt),
    visibleSince: visibleSince != null ? DateTime.parse(visibleSince) : null,
  );
}
