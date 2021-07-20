// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/answer_item/answer_item.dart';
import 'package:smart_chat/domain/entities/answer_item/answer_item_value.dart';
import 'package:smart_chat/infrastructure/core/firestore_helpers.dart';
import 'package:smart_chat/infrastructure/dto/entity_dto.dart';

part 'answer_item_dto.freezed.dart';
part 'answer_item_dto.g.dart';

@freezed
class AnswerItemDto with _$AnswerItemDto implements EntityDto<AnswerItem> {
  const AnswerItemDto._();

  const factory AnswerItemDto({
    @JsonKey(ignore: true) String? id,
    required String qarId,
    required String chatBotId,
    required String questionId,
    required String createdBy,
    @JsonKey(ignore: true) String? createdAt,
    @JsonKey(ignore: true) String? validOn,
    required String value,
  }) = _AnswerItemDto;

  factory AnswerItemDto.fromDomain(AnswerItem answerItem) {
    return AnswerItemDto(
      id: answerItem.id.getOrCrash(),
      qarId: answerItem.qarId.toString(),
      chatBotId: answerItem.chatBotId.toString(),
      questionId: answerItem.questionId.toString(),
      createdBy: answerItem.createdBy.toString(),
      createdAt: answerItem.createdAt.toIso8601String(),
      validOn: answerItem.validOn.toIso8601String(),
      value: answerItem.value.getOrCrash(),
    );
  }

  @override
  AnswerItem toDomain() {
    return AnswerItem(
      id: UniqueId.fromUniqueString(id!),
      qarId: UniqueId.fromUniqueString(qarId),
      chatBotId: UniqueId.fromUniqueString(chatBotId),
      questionId: UniqueId.fromUniqueString(questionId),
      createdBy: UniqueId.fromUniqueString(createdBy),
      createdAt: DateTime.parse(createdAt!),
      validOn: DateTime.parse(validOn!),
      value: AnswerItemValue.fromString(value),
    );
  }

  factory AnswerItemDto.fromFireStore(DocumentSnapshot<Object?> snapshot) {
    final doc = snapshot as DocumentSnapshot<Map<String, dynamic>>;

    return AnswerItemDto.fromJson(doc.data()!).copyWith(
      id: doc.id,
      validOn: (doc.get(VALID_ON) as Timestamp).toDate().toIso8601String(),
      createdAt: (doc.get(CREATED_AT) as Timestamp).toDate().toIso8601String(),
    );
  }

  @override
  Map<String, dynamic> toFireStore() {
    final asJson = toJson();
    asJson.addAll(
      {
        DOCUMENT_ID: id,
        CREATED_AT: Timestamp.fromDate(DateTime.parse(createdAt!)),
        VALID_ON: Timestamp.fromDate(DateTime.parse(validOn!)),
      },
    );
    return asJson;
  }

  factory AnswerItemDto.fromJson(Map<String, dynamic> json) =>
      _$AnswerItemDtoFromJson(json);
}

class ServerTimestampConverter implements JsonConverter<FieldValue, Object> {
  const ServerTimestampConverter();

  @override
  FieldValue fromJson(Object json) {
    return FieldValue.serverTimestamp();
  }

  @override
  Object toJson(FieldValue fieldValue) => fieldValue;
}
