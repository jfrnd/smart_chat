// Package imports:
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/answer_item/answer_item.dart';
import 'package:smart_chat/domain/entities/answer_option/answer_option.dart';
import 'package:smart_chat/domain/entities/entity.dart';
import 'package:smart_chat/domain/entities/question/question.dart';

// QAR = QuestionAnswerReaction
// A reaction is a feedback to an answer: e.g. "Congratulations. This is your personal record!"
// The feature reaction is not implemented yet
class Qar extends Entity<Qar> {
  final UniqueId sessionId;
  final UniqueId chatBotId;
  final UniqueId questionId;
  final KtList<UniqueId> answerItemIds;
  final UniqueId? reactionItemId;
  final bool isVisible;
  final bool isAnswered;
  final DateTime? visibleSince;
  final int position;

  factory Qar.createWithQuestion(Question question) => Qar._(
        id: UniqueId.dummy(),
        sessionId: UniqueId.dummy(),
        chatBotId: question.chatBotId,
        questionId: question.id,
        answerItemIds: emptyList(),
        reactionItemId: null,
        isVisible: false,
        isAnswered: false,
        createdBy: UniqueId.dummy(),
        createdAt: DateTime.utc(0),
        visibleSince: null,
        position: question.position,
      );

  factory Qar.empty() => Qar(
        id: UniqueId.dummy(),
        sessionId: UniqueId.fromUniqueString(DateTime.utc(0).toIso8601String()),
        chatBotId: UniqueId.dummy(),
        questionId: UniqueId.dummy(),
        answerItemIds: listOf(),
        reactionItemId: null,
        isVisible: false,
        isAnswered: true,
        createdBy: UniqueId.dummy(),
        createdAt: DateTime.utc(0),
        visibleSince: null,
        position: 1,
      );

  Question? getQuestion(KtList<Question> questions) {
    return questions.find((question) => question.id == questionId);
  }

  KtList<AnswerItem>? getAnswerItems(KtList<AnswerItem> answerItems) {
    return answerItems.filter((item) => answerItemIds.contains(item.id));
  }

  KtList<AnswerOption>? getAnswerOptions(KtList<AnswerOption> answerOptions) {
    return answerOptions.filter((option) => answerOptions.contains(option));
  }

  bool get hasNoAnswerItems => answerItemIds.isEmpty();

  Qar makeVisible(DateTime time) {
    if (!isVisible) {
      return copyWith(
        isVisible: true,
        visibleSince: time,
      );
    } else {
      return this;
    }
  }

  Qar makeAnswered() => copyWith(
        isAnswered: true,
      );

  Qar linkWithSession(UniqueId sessionId) => copyWith(
        sessionId: sessionId,
      );

  Qar linkedWithAnswerItem(UniqueId itemId) => copyWith(
        answerItemIds: answerItemIds.plusElement(itemId),
        isAnswered: true,
      );
  Qar linkedWithMultipleAnswerItems(KtList<UniqueId> itemIds) => copyWith(
        answerItemIds: answerItemIds.plus(itemIds),
        isAnswered: true,
      );

  Qar unlinkedFromMultipleAnswerItems(KtList<UniqueId> itemIds) => copyWith(
        answerItemIds: answerItemIds.minus(itemIds),
        isAnswered: answerItemIds.minus(itemIds).isNotEmpty(),
      );

  Qar unlinkedFromAnswerItem(UniqueId itemId) => copyWith(
        answerItemIds: answerItemIds.minusElement(itemId),
        isAnswered: answerItemIds.minusElement(itemId).isNotEmpty(),
      );

  @override
  Qar copyWith({
    UniqueId? id,
    UniqueId? sessionId,
    UniqueId? chatBotId,
    UniqueId? questionId,
    KtList<UniqueId>? answerItemIds,
    UniqueId? reactionItemId,
    bool? isVisible,
    bool? isAnswered,
    UniqueId? createdBy,
    DateTime? createdAt,
    DateTime? visibleSince,
    int? position,
  }) =>
      Qar(
        id: id ?? this.id,
        sessionId: sessionId ?? this.sessionId,
        chatBotId: chatBotId ?? this.chatBotId,
        questionId: questionId ?? this.questionId,
        answerItemIds: answerItemIds ?? this.answerItemIds,
        reactionItemId: reactionItemId ?? this.reactionItemId,
        isVisible: isVisible ?? this.isVisible,
        isAnswered: isAnswered ?? this.isAnswered,
        createdBy: createdBy ?? this.createdBy,
        createdAt: createdAt ?? this.createdAt,
        visibleSince: visibleSince ?? this.visibleSince,
        position: position ?? this.position,
      );

  factory Qar({
    required UniqueId id,
    required UniqueId sessionId,
    required UniqueId chatBotId,
    required UniqueId questionId,
    required KtList<UniqueId> answerItemIds,
    required UniqueId? reactionItemId,
    required bool isVisible,
    required bool isAnswered,
    required UniqueId createdBy,
    required DateTime createdAt,
    required DateTime? visibleSince,
    required int position,
  }) =>
      Qar._(
        id: id,
        sessionId: sessionId,
        chatBotId: chatBotId,
        questionId: questionId,
        answerItemIds: answerItemIds,
        reactionItemId: reactionItemId,
        isVisible: isVisible,
        isAnswered: isAnswered,
        createdBy: createdBy,
        createdAt: createdAt,
        visibleSince: visibleSince,
        position: position,
      );

  @override
  List<Object?> get props => [
        id,
        sessionId,
        chatBotId,
        questionId,
        answerItemIds.toList(),
        reactionItemId,
        isVisible,
        isAnswered,
        createdBy,
        createdAt,
        visibleSince,
        position,
      ];

  const Qar._({
    required UniqueId id,
    required this.sessionId,
    required this.chatBotId,
    required this.questionId,
    required this.answerItemIds,
    required this.reactionItemId,
    required this.isVisible,
    required this.isAnswered,
    required UniqueId createdBy,
    required DateTime createdAt,
    required this.visibleSince,
    required this.position,
  }) : super(
          id: id,
          createdBy: createdBy,
          createdAt: createdAt,
        );
}

extension QarListX on KtList<Qar> {
  Qar? findById(UniqueId id) {
    return find((q) => q.id == id);
  }

  KtList<Qar> filterVisible() {
    return filter((q) => q.isVisible);
  }
}
