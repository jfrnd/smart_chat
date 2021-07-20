// Package imports:
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/core/valueobjects/m_unit.dart';
import 'package:smart_chat/domain/core/valueobjects/numeric_value.dart';
import 'package:smart_chat/domain/core/valueobjects/translatable.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/entity.dart';
import 'package:smart_chat/domain/entities/question/question_body.dart';
import 'package:smart_chat/domain/entities/question/question_type.dart';
import 'digits.dart';

class Question extends TranslatableEntity<Question, QuestionBody> {
  final UniqueId chatBotId;
  final QuestionType type;
  final MUnit unit;
  final NumericValue minVal;
  final NumericValue maxVal;
  final Digits digits;
  final bool multiSelection;

  factory Question.createFor(UniqueId chatBotId) => Question(
        id: UniqueId.dummy(),
        chatBotId: chatBotId,
        createdBy: UniqueId.dummy(),
        updatedBy: UniqueId.dummy(),
        createdAt: DateTime.utc(0),
        updatedAt: DateTime.utc(0),
        translations: Translatable<QuestionBody>.empty(),
        type: const QuestionType.yesNo(),
        multiSelection: false,
        unit: const MUnit.noUnit(),
        minVal: NumericValue.fromDouble(0),
        maxVal: NumericValue.fromDouble(100),
        digits: Digits.empty(),
        position: 0,
      );

  factory Question.empty() => Question(
        id: UniqueId.dummy(),
        chatBotId: UniqueId.dummy(),
        createdBy: UniqueId.dummy(),
        updatedBy: UniqueId.dummy(),
        createdAt: DateTime.utc(0),
        updatedAt: DateTime.utc(0),
        translations: Translatable<QuestionBody>.empty(),
        type: const QuestionType.open(),
        multiSelection: false,
        unit: const MUnit.noUnit(),
        minVal: NumericValue.empty(),
        maxVal: NumericValue.empty(),
        digits: Digits.empty(),
        position: 0,
      );

  Question addPosition(int position) => copyWith(position: position);

  @override
  Question copyWith({
    UniqueId? id,
    UniqueId? chatBotId,
    UniqueId? createdBy,
    UniqueId? updatedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    Translatable<QuestionBody>? translations,
    QuestionType? type,
    bool? multiSelection,
    MUnit? unit,
    NumericValue? minVal,
    NumericValue? maxVal,
    Digits? digits,
    int? position,
  }) =>
      Question(
        id: id ?? this.id,
        chatBotId: chatBotId ?? this.chatBotId,
        createdBy: createdBy ?? this.createdBy,
        updatedBy: updatedBy ?? this.updatedBy,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        translations: translations ?? this.translations,
        type: type ?? this.type,
        multiSelection: multiSelection ?? this.multiSelection,
        unit: unit ?? this.unit,
        minVal: minVal ?? this.minVal,
        maxVal: maxVal ?? this.maxVal,
        digits: digits ?? this.digits,
        position: position ?? this.position,
      );

  factory Question({
    required UniqueId id,
    required UniqueId chatBotId,
    required UniqueId createdBy,
    required UniqueId updatedBy,
    required DateTime createdAt,
    required DateTime updatedAt,
    required Translatable<QuestionBody> translations,
    required QuestionType type,
    required bool multiSelection,
    required MUnit unit,
    required NumericValue minVal,
    required NumericValue maxVal,
    required Digits digits,
    required int position,
  }) =>
      Question._(
        id: id,
        chatBotId: chatBotId,
        createdAt: createdAt,
        createdBy: createdBy,
        translations: translations,
        type: type,
        multiSelection: multiSelection,
        unit: unit,
        minVal: minVal,
        maxVal: maxVal,
        digits: digits,
        updatedAt: updatedAt,
        updatedBy: updatedBy,
        position: position,
      );

  @override
  List<Object?> get props => [
        id,
        chatBotId,
        createdAt,
        createdBy,
        translations,
        type,
        unit,
        minVal,
        maxVal,
        digits,
        updatedAt,
        updatedBy,
        multiSelection,
        position,
      ];

  const Question._({
    required UniqueId id,
    required this.chatBotId,
    required DateTime createdAt,
    required UniqueId createdBy,
    required Translatable<QuestionBody> translations,
    required this.type,
    required this.multiSelection,
    required this.unit,
    required this.minVal,
    required this.maxVal,
    required this.digits,
    required DateTime updatedAt,
    required UniqueId updatedBy,
    required int position,
  }) : super(
          id: id,
          createdBy: createdBy,
          createdAt: createdAt,
          updatedAt: updatedAt,
          updatedBy: updatedBy,
          translations: translations,
          position: position,
        );
}

extension QuestionListX on KtList<Question> {
  Question? findById(UniqueId questionId) {
    return find((q) => q.id == questionId);
  }
}
