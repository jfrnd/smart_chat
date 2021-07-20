// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/core/value_object.dart';
import 'package:smart_chat/domain/core/valueobjects/language_code.dart';
import 'package:smart_chat/domain/core/valueobjects/translatable.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/answer_option/answer_option.dart';
import 'package:smart_chat/domain/entities/answer_option/answer_option_body.dart';
import 'package:smart_chat/infrastructure/core/firestore_helpers.dart';
import 'package:smart_chat/infrastructure/dto/entity_dto.dart';

part 'answer_option_dto.freezed.dart';
part 'answer_option_dto.g.dart';

@freezed
class AnswerOptionDto
    with _$AnswerOptionDto
    implements EntityDto<AnswerOption> {
  const AnswerOptionDto._();

  const factory AnswerOptionDto({
    @JsonKey(ignore: true) String? id,
    required String chatBotId,
    required String questionId,
    required String createdBy,
    required String updatedBy,
    @JsonKey(ignore: true) String? createdAt,
    @JsonKey(ignore: true) String? updatedAt,
    required Map<String, String> translations,
  }) = _AnswerOptionDto;

  factory AnswerOptionDto.fromDomain(AnswerOption answerOption) {
    return AnswerOptionDto(
      id: answerOption.id.getOrCrash(),
      chatBotId: answerOption.chatBotId.getOrCrash(),
      questionId: answerOption.questionId.getOrCrash(),
      createdBy: answerOption.createdBy.getOrCrash(),
      updatedBy: answerOption.updatedBy.getOrCrash(),
      createdAt: answerOption.createdAt.toIso8601String(),
      updatedAt: answerOption.updatedAt.toIso8601String(),
      translations: answerOption.translations.convertToRawMapOrCrash(),
    );
  }

  @override
  AnswerOption toDomain() {
    return AnswerOption(
      id: UniqueId.fromUniqueString(id!),
      chatBotId: UniqueId.fromUniqueString(chatBotId),
      questionId: UniqueId.fromUniqueString(questionId),
      createdBy: UniqueId.fromUniqueString(createdBy),
      updatedBy: UniqueId.fromUniqueString(updatedBy),
      createdAt: DateTime.parse(createdAt!),
      updatedAt: DateTime.parse(updatedAt!),
      translations: Translatable<AnswerOptionBody>(
        translations.toDomainMap(),
      ),
      position: 0,
    );
  }

  factory AnswerOptionDto.fromFireStore(DocumentSnapshot<Object?> snapshot) {
    final doc = snapshot as DocumentSnapshot<Map<String, dynamic>>;

    return AnswerOptionDto.fromJson(doc.data()!).copyWith(
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

  factory AnswerOptionDto.fromJson(Map<String, dynamic> json) =>
      _$AnswerOptionDtoFromJson(json);
}

extension MapX<T extends ValueObject<String>> on Map<String, String> {
  KtMap<LanguageCode, AnswerOptionBody> toDomainMap() {
    return KtMap.from(map(
        (key, value) => MapEntry(LanguageCode(key), AnswerOptionBody(value))));
  }
}
