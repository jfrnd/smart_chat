// Package imports:
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/answer_item/answer_item_value.dart';
import 'package:smart_chat/domain/entities/entity.dart';
import 'package:smart_chat/domain/entities/qar/qar.dart';

class AnswerItem extends Entity<AnswerItem> {
  final UniqueId qarId;
  final UniqueId chatBotId;
  final UniqueId questionId;
  final AnswerItemValue value;
  final DateTime validOn;

  factory AnswerItem.empty() => AnswerItem(
        id: UniqueId.dummy(),
        qarId: UniqueId.dummy(),
        chatBotId: UniqueId.dummy(),
        questionId: UniqueId.dummy(),
        createdBy: UniqueId.dummy(),
        createdAt: DateTime.utc(0),
        value: AnswerItemValue.empty(),
        validOn: DateTime.utc(0),
      );

  factory AnswerItem.createWithQar({
    required Qar qar,
    required AnswerItemValue value,
  }) =>
      AnswerItem(
          id: UniqueId.dummy(),
          qarId: qar.id,
          chatBotId: qar.chatBotId,
          questionId: qar.questionId,
          createdBy: UniqueId.dummy(),
          createdAt: DateTime.utc(0),
          value: value,
          validOn: qar.createdAt);

  AnswerItem updateMetaData({required DateTime createdAt}) => copyWith(
        createdAt: createdAt,
      );

  @override
  AnswerItem copyWith({
    UniqueId? id,
    UniqueId? qarId,
    UniqueId? chatBotId,
    UniqueId? questionId,
    UniqueId? createdBy,
    DateTime? createdAt,
    AnswerItemValue? value,
    DateTime? validOn,
  }) =>
      AnswerItem(
        id: id ?? this.id,
        qarId: qarId ?? this.qarId,
        chatBotId: chatBotId ?? this.chatBotId,
        questionId: questionId ?? this.questionId,
        createdBy: createdBy ?? this.createdBy,
        createdAt: createdAt ?? this.createdAt,
        value: value ?? this.value,
        validOn: validOn ?? this.validOn,
      );

  factory AnswerItem({
    required UniqueId id,
    required UniqueId qarId,
    required UniqueId chatBotId,
    required UniqueId questionId,
    required UniqueId createdBy,
    required DateTime createdAt,
    required AnswerItemValue value,
    required DateTime validOn,
  }) =>
      AnswerItem._(
        id: id,
        qarId: qarId,
        chatBotId: chatBotId,
        questionId: questionId,
        createdBy: createdBy,
        createdAt: createdAt,
        value: value,
        validOn: validOn,
      );

  @override
  List<Object?> get props => [
        id,
        qarId,
        chatBotId,
        questionId,
        createdBy,
        createdAt,
        value,
        validOn,
      ];

  const AnswerItem._({
    required UniqueId id,
    required this.qarId,
    required this.chatBotId,
    required this.questionId,
    required UniqueId createdBy,
    required DateTime createdAt,
    required this.value,
    required this.validOn,
  }) : super(
          id: id,
          createdAt: createdAt,
          createdBy: createdBy,
        );
}

extension AnswerItemListX on KtList<AnswerItem> {
  AnswerItem? findById(UniqueId answerItemId) {
    return find((item) => item.id == answerItemId);
  }

  KtList<UniqueId> get ids {
    return map((item) => item.id);
  }

  KtList<AnswerItemValue> get itemBodies {
    return map((item) => item.value);
  }

  KtList<AnswerItem> filterByQarId(UniqueId qarId) {
    return filter((item) => item.qarId == qarId);
  }

  KtList<AnswerItem> filterByQuestionId(UniqueId questionId) {
    return filter((item) => item.questionId == questionId);
  }
}
