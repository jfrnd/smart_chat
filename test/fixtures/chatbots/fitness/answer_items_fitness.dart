// Project imports:
import 'package:smart_chat/domain/core/valueobjects/numeric_value.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/answer_item/answer_item.dart';
import 'package:smart_chat/domain/entities/answer_item/answer_item_value.dart';
import '../diary/qars_diary.dart';
import 'qars_fitness.dart';
import 'questions_fitness.dart';

final answerItemFitness100kmMonday = createQarKMAnswerItem(
  MONDAY,
  NumericValue(10),
);

AnswerItem createQarKMAnswerItem(String date, NumericValue val) {
  return AnswerItem(
    id: UniqueId.fromUniqueString('${QAR_ID_KM}ITEM$date'),
    qarId: UniqueId.fromUniqueString(QAR_ID_KM + date),
    chatBotId: questionKM.chatBotId,
    questionId: questionKM.id,
    createdAt: DateTime.parse(date),
    createdBy: questionKM.createdBy,
    value: AnswerItemValue.fromNumericValue(val),
    validOn: DateTime.parse(date),
  );
}
