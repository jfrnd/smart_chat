// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/qar/qar.dart';
import 'package:smart_chat/infrastructure/core/firestore_helpers.dart';
import 'package:smart_chat/infrastructure/dto/entity_dto.dart';

part 'qar_dto.freezed.dart';
part 'qar_dto.g.dart';

@freezed
class QarDto with _$QarDto implements EntityDto<Qar> {
  const QarDto._();

  const factory QarDto({
    @JsonKey(ignore: true) String? id,
    required String sessionId,
    required String chatBotId,
    required String questionId,
    required String createdBy,
    required List<String> answerItemIds,
    required bool isAnswered,
    required bool isVisible,
    required int position,
    @JsonKey(ignore: true) String? reactionItemId,
    @JsonKey(ignore: true) String? createdAt,
    @JsonKey(ignore: true) String? visibleSince,
  }) = _QarDto;

  factory QarDto.fromDomain(Qar qar) {
    return QarDto(
      id: qar.id.getOrCrash(),
      sessionId: qar.sessionId.getOrCrash(),
      chatBotId: qar.chatBotId.getOrCrash(),
      questionId: qar.questionId.getOrCrash(),
      createdBy: qar.createdBy.getOrCrash(),
      createdAt: qar.createdAt.toIso8601String(),
      visibleSince: qar.visibleSince?.toIso8601String(),
      position: qar.position,
      answerItemIds: qar.answerItemIds.map((uId) => uId.getOrCrash()).asList(),
      reactionItemId:
          qar.reactionItemId != null ? qar.reactionItemId!.getOrCrash() : null,
      isAnswered: qar.isAnswered,
      isVisible: qar.isVisible,
    );
  }

  @override
  Qar toDomain() {
    return Qar(
      id: UniqueId.fromUniqueString(id!),
      sessionId: UniqueId.fromUniqueString(sessionId),
      chatBotId: UniqueId.fromUniqueString(chatBotId),
      questionId: UniqueId.fromUniqueString(questionId),
      createdBy: UniqueId.fromUniqueString(createdBy),
      createdAt: DateTime.parse(createdAt!),
      answerItemIds:
          KtList.from(answerItemIds).map((id) => UniqueId.fromUniqueString(id)),
      reactionItemId: reactionItemId != null
          ? UniqueId.fromUniqueString(reactionItemId!)
          : null,
      position: position,
      isAnswered: isAnswered,
      isVisible: isVisible,
      visibleSince: visibleSince != null ? DateTime.parse(visibleSince!) : null,
    );
  }

  factory QarDto.fromJson(Map<String, dynamic> json) => _$QarDtoFromJson(json);

  factory QarDto.fromFireStore(DocumentSnapshot<Object?> snapshot) {
    final doc = snapshot as DocumentSnapshot<Map<String, dynamic>>;

    return QarDto.fromJson(doc.data()!).copyWith(
      id: doc.id,
      createdAt: (doc.get(CREATED_AT) as Timestamp).toDate().toIso8601String(),
      visibleSince: doc.get(VISIBLE_SINCE) != null
          ? (doc.get(VISIBLE_SINCE) as Timestamp).toDate().toIso8601String()
          : null,
      reactionItemId: doc.get(REACTION_ITEM_ID) != null
          ? doc.get(REACTION_ITEM_ID) as String
          : null,
    );
  }

  @override
  Map<String, dynamic> toFireStore() {
    final asJson = toJson();
    asJson.addAll(
      {
        DOCUMENT_ID: id,
        CREATED_AT: Timestamp.fromDate(DateTime.parse(createdAt!)),
        VISIBLE_SINCE: visibleSince != null
            ? Timestamp.fromDate(DateTime.parse(visibleSince!))
            : null,
        REACTION_ITEM_ID: reactionItemId
      },
    );
    return asJson;
  }
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
