// Package imports:
import 'package:dartz/dartz.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/core/valueobjects/language_code.dart';
import 'package:smart_chat/domain/core/valueobjects/translatable.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/answer_item/answer_item_value.dart';
import 'package:smart_chat/domain/entities/answer_option/answer_option_body.dart';
import 'package:smart_chat/domain/entities/entity.dart';
import 'package:smart_chat/domain/entities/qar/qar.dart';
import 'package:smart_chat/domain/entities/question/question.dart';
import 'package:smart_chat/domain/entities/question/question_type.dart';

const YES = 'YES';
const NO = 'NO';

class AnswerOption extends TranslatableEntity<AnswerOption, AnswerOptionBody> {
  final UniqueId chatBotId;
  final UniqueId questionId;

  factory AnswerOption.empty() => AnswerOption(
        id: UniqueId.dummy(),
        questionId: UniqueId.dummy(),
        chatBotId: UniqueId.dummy(),
        createdBy: UniqueId.dummy(),
        updatedBy: UniqueId.dummy(),
        createdAt: DateTime.utc(0),
        updatedAt: DateTime.utc(0),
        translations: Translatable<AnswerOptionBody>.empty(),
        position: 0,
      );

  factory AnswerOption.error() => AnswerOption(
        id: UniqueId.fromUniqueString('dummyAnswerOption'),
        questionId: UniqueId.fromUniqueString('0'),
        chatBotId: UniqueId.fromUniqueString('0'),
        createdBy: UniqueId.fromUniqueString('0'),
        updatedBy: UniqueId.fromUniqueString('0'),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        translations: Translatable<AnswerOptionBody>(KtMap.from(
            {LanguageCode.en(): AnswerOptionBody('ANSWER DELETED')})),
        position: 0,
      );

  factory AnswerOption.yes() => AnswerOption(
        id: UniqueId.fromUniqueString(YES),
        questionId: UniqueId.fromUniqueString(YES),
        chatBotId: UniqueId.fromUniqueString(YES),
        createdBy: UniqueId.fromUniqueString(YES),
        updatedBy: UniqueId.fromUniqueString(YES),
        createdAt: DateTime.utc(0),
        updatedAt: DateTime.utc(0),
        translations: Translatable<AnswerOptionBody>(
          KtMap.from({
            LanguageCode.en(): AnswerOptionBody('yes ☑️'),
            LanguageCode.de(): AnswerOptionBody('ja ☑️'),
            LanguageCode.zh(): AnswerOptionBody('是 ☑️'),
          }),
        ),
        position: 1,
      );

  factory AnswerOption.no() => AnswerOption(
        id: UniqueId.fromUniqueString(NO),
        questionId: UniqueId.fromUniqueString(NO),
        chatBotId: UniqueId.fromUniqueString(NO),
        createdBy: UniqueId.fromUniqueString(NO),
        updatedBy: UniqueId.fromUniqueString(NO),
        createdAt: DateTime.utc(0),
        updatedAt: DateTime.utc(0),
        translations: Translatable<AnswerOptionBody>(
          KtMap.from({
            LanguageCode.en(): AnswerOptionBody('no ✖️'),
            LanguageCode.de(): AnswerOptionBody('nein ✖️'),
            LanguageCode.zh(): AnswerOptionBody('不是 ✖️'),
          }),
        ),
        position: 0,
      );

  factory AnswerOption.createWithQar({
    required Qar qar,
    required LanguageCode languageCode,
    required AnswerOptionBody body,
  }) =>
      AnswerOption(
        id: UniqueId.dummy(),
        questionId: qar.questionId,
        chatBotId: qar.chatBotId,
        createdBy: qar.createdBy,
        updatedBy: qar.createdBy,
        createdAt: DateTime.utc(0),
        updatedAt: DateTime.utc(0),
        translations:
            Translatable<AnswerOptionBody>(KtMap.from({languageCode: body})),
        position: 0,
      );

  factory AnswerOption.createWithQuestion({
    required Question question,
  }) =>
      AnswerOption(
        id: UniqueId.dummy(),
        questionId: question.id,
        chatBotId: question.chatBotId,
        createdBy: UniqueId.dummy(),
        updatedBy: UniqueId.dummy(),
        createdAt: DateTime.utc(0),
        updatedAt: DateTime.utc(0),
        translations: Translatable<AnswerOptionBody>.empty(),
        position: 0,
      );

  factory AnswerOption.createWithIds({
    required UniqueId chatBotId,
    required UniqueId questionId,
  }) =>
      AnswerOption(
        id: UniqueId.dummy(),
        questionId: questionId,
        chatBotId: chatBotId,
        createdBy: UniqueId.dummy(),
        updatedBy: UniqueId.dummy(),
        createdAt: DateTime.utc(0),
        updatedAt: DateTime.utc(0),
        translations: Translatable<AnswerOptionBody>.empty(),
        position: 0,
      );

  @override
  AnswerOption copyWith({
    UniqueId? id,
    UniqueId? chatBotId,
    UniqueId? questionId,
    UniqueId? createdBy,
    UniqueId? updatedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    Translatable<AnswerOptionBody>? translations,
    int? position,
  }) =>
      AnswerOption(
        id: id ?? this.id,
        chatBotId: chatBotId ?? this.chatBotId,
        questionId: questionId ?? this.questionId,
        createdBy: createdBy ?? this.createdBy,
        updatedBy: updatedBy ?? this.updatedBy,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        translations: translations ?? this.translations,
        position: position ?? this.position,
      );

  factory AnswerOption({
    required UniqueId id,
    required UniqueId chatBotId,
    required UniqueId questionId,
    required UniqueId createdBy,
    required UniqueId updatedBy,
    required DateTime createdAt,
    required DateTime updatedAt,
    required Translatable<AnswerOptionBody> translations,
    required int position,
  }) =>
      AnswerOption._(
        id: id,
        chatBotId: chatBotId,
        questionId: questionId,
        createdAt: createdAt,
        createdBy: createdBy,
        translations: translations,
        updatedAt: updatedAt,
        updatedBy: updatedBy,
        position: position,
      );

  @override
  List<Object?> get props => [
        id,
        chatBotId,
        questionId,
        createdAt,
        createdBy,
        translations,
        unit,
        updatedAt,
        updatedBy,
        position,
      ];

  const AnswerOption._({
    required UniqueId id,
    required DateTime createdAt,
    required UniqueId createdBy,
    required DateTime updatedAt,
    required UniqueId updatedBy,
    required this.chatBotId,
    required this.questionId,
    required Translatable<AnswerOptionBody> translations,
    required int position,
  }) : super(
          id: id,
          createdAt: createdAt,
          createdBy: createdBy,
          updatedAt: updatedAt,
          updatedBy: updatedBy,
          translations: translations,
          position: position,
        );
}

extension AnswerOptionX on AnswerOption {
  // NumericValue getNumericValueOrCrash() {
  // return translations.getFailureOrValueObject(LanguageCode.math()).fold(
  //       (failure) => throw UnexpectedValueError(failure),
  //       (body) => NumericValue.fromString(body.getOrCrash()),
  //     );
  // }

  // TimeValue getTimeValueOrCrash() {
  // return translations.getFailureOrValueObject(LanguageCode.math()).fold(
  //       (failure) => throw UnexpectedValueError(failure),
  //       (body) => TimeValue.fromString(body.getOrCrash()),
  //     );
  // }
}

extension AnswerOptionListX on KtList<AnswerOption> {
  bool notContains(String textInput, LanguageCode languageCode) {
    return !getBodiesAsString(languageCode).contains(textInput);
  }

  KtList<String> getBodiesAsString(LanguageCode languageCode) {
    return map((option) => option.getTranslationAsString(languageCode));
  }

  AnswerOption? findByBody(LanguageCode languageCode, String body) {
    return find(
        (option) => option.getTranslationAsString(languageCode) == body);
  }

  AnswerOption? findById(UniqueId answerOptionId) {
    return find((option) => option.id == answerOptionId);
  }

  KtList<AnswerItemValue> asAnswerItemBodies(QuestionType type) {
    return type.map(
        yesNo: (_) =>
            map((option) => AnswerItemValue.fromAnswerOptionId(option.id)),
        numeric: (_) => map((option) => AnswerItemValue.fromString(
            option.getTranslationAsString(LanguageCode.math()))),
        time: (_) => map((option) => AnswerItemValue.fromString(
            option.getTranslationAsString(LanguageCode.math()))),
        multipleChoice: (_) =>
            map((option) => AnswerItemValue.fromAnswerOptionId(option.id)),
        open: (_) =>
            map((option) => AnswerItemValue.fromAnswerOptionId(option.id)));
  }
}
