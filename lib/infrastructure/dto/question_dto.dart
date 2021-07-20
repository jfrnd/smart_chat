// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
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
import 'package:smart_chat/infrastructure/core/firestore_helpers.dart';
import 'package:smart_chat/infrastructure/dto/entity_dto.dart';

part 'question_dto.freezed.dart';

part 'question_dto.g.dart';

@freezed
class QuestionDto with _$QuestionDto implements EntityDto<Question> {
  const QuestionDto._();

  const factory QuestionDto({
    @JsonKey(ignore: true) String? id,
    required String chatBotId,
    required Map<String, String> translations,
    required String createdBy,
    required String updatedBy,
    @JsonKey(ignore: true) String? createdAt,
    @JsonKey(ignore: true) String? updatedAt,
    required String type,
    required bool? multiSelection,
    required String? unit,
    required double? minVal,
    required double? maxVal,
    required int? digits,
    required int position,
  }) = _QuestionDto;

  factory QuestionDto.fromDomain(Question question) {
    return QuestionDto(
      id: question.id.getOrCrash(),
      chatBotId: question.chatBotId.toString(),
      createdBy: question.createdBy.getOrCrash(),
      updatedBy: question.updatedBy.getOrCrash(),
      createdAt: question.createdAt.toIso8601String(),
      updatedAt: question.updatedAt.toIso8601String(),
      translations: question.translations.convertToRawMapOrCrash(),
      type: question.type.asString(),
      multiSelection:
          question.type is MultipleChoice ? question.multiSelection : null,
      unit: question.type is Numeric ? question.unit.asString() : null,
      minVal: question.type is Numeric ? question.minVal.getOrCrash() : null,
      maxVal: question.type is Numeric ? question.maxVal.getOrCrash() : null,
      digits: question.type is Numeric ? question.digits.getOrCrash() : null,
      position: question.position,
    );
  }

  @override
  Question toDomain() {
    return Question(
      id: UniqueId.fromUniqueString(id!),
      chatBotId: UniqueId.fromUniqueString(chatBotId),
      createdBy: UniqueId.fromUniqueString(createdBy),
      updatedBy: UniqueId.fromUniqueString(updatedBy),
      createdAt: DateTime.parse(createdAt!),
      updatedAt: DateTime.parse(updatedAt!),
      translations: Translatable<QuestionBody>(translations.toVoMap()),
      type: QuestionType.fromString(type),
      multiSelection: multiSelection ?? false,
      unit: MUnit.fromString(unit),
      minVal: minVal != null ? NumericValue(minVal!) : NumericValue.empty(),
      maxVal: maxVal != null ? NumericValue(maxVal!) : NumericValue.empty(),
      digits: digits != null ? Digits(digits!) : Digits.empty(),
      position: position,
    );
  }

  factory QuestionDto.fromJson(Map<String, dynamic> json) =>
      _$QuestionDtoFromJson(json);

  factory QuestionDto.fromFireStore(DocumentSnapshot<Object?> snapshot) {
    final doc = snapshot as DocumentSnapshot<Map<String, dynamic>>;

    return QuestionDto.fromJson(doc.data()!).copyWith(
      id: doc.id,
      createdAt: (doc.get(CREATED_AT) as Timestamp).toDate().toIso8601String(),
      updatedAt: (doc.get(UPDATED_AT) as Timestamp).toDate().toIso8601String(),
    );
  }

  @override
  Map<String, dynamic> toFireStore() {
    final asJson = toJson();
    asJson.addAll(
      {
        DOCUMENT_ID: id,
        CREATED_AT: Timestamp.fromDate(DateTime.parse(createdAt!)),
        UPDATED_AT: Timestamp.fromDate(DateTime.parse(updatedAt!))
      },
    );
    return asJson;
  }
}

extension MapX on Map<String, String> {
  KtMap<LanguageCode, QuestionBody> toVoMap() {
    return KtMap.from(
        map((key, value) => MapEntry(LanguageCode(key), QuestionBody(value))));
  }
}
