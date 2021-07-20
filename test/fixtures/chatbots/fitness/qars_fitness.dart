//! QAR Question KM

// Package imports:
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/qar/qar.dart';
import '../diary/qars_diary.dart';
import 'questions_fitness.dart';

const QAR_ID_KM = '201';

final qarKM = createQarKM(
  createdAt: MONDAY,
  visibleSince: null,
  isAnswered: false,
  isVisible: false,
);

Qar createQarKM({
  required String createdAt,
  required String? visibleSince,
  bool isAnswered = true,
  bool isVisible = true,
}) {
  return Qar(
    id: UniqueId.fromUniqueString(QAR_ID_KM),
    position: questionKM.position,
    chatBotId: questionKM.chatBotId,
    questionId: questionKM.id,
    createdBy: questionKM.createdBy,
    createdAt: DateTime.parse(createdAt),
    answerItemIds: isAnswered
        ? listOf(UniqueId.fromUniqueString('${QAR_ID_KM}ITEM$createdAt'))
        : listOf(),
    isAnswered: isAnswered,
    isVisible: isVisible,
    reactionItemId: null,
    sessionId: UniqueId.fromUniqueString(createdAt),
    visibleSince: visibleSince != null ? DateTime.parse(visibleSince) : null,
  );
}
