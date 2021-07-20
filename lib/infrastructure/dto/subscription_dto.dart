// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/subscription/subscription.dart';
import 'package:smart_chat/domain/entities/subscription/subscription_trigger.dart';
import 'package:smart_chat/domain/entities/subscription/subscription_status.dart';
import 'package:smart_chat/infrastructure/core/firestore_helpers.dart';
import 'package:smart_chat/infrastructure/dto/entity_dto.dart';

part 'subscription_dto.freezed.dart';

part 'subscription_dto.g.dart';

@freezed
class SubscriptionDto
    with _$SubscriptionDto
    implements EntityDto<Subscription> {
  const SubscriptionDto._();

  const factory SubscriptionDto({
    @JsonKey(ignore: true) String? id,
    @JsonKey(ignore: true) String? createdAt,
    required String chatBotId,
    required String userId,
    required String status,
    required Map<String, String> triggers,
  }) = _SubscriptionDto;

  @override
  factory SubscriptionDto.fromDomain(Subscription subscription) {
    return SubscriptionDto(
      id: subscription.id.getOrCrash(),
      createdAt: subscription.createdAt.toIso8601String(),
      chatBotId: subscription.chatBotId.getOrCrash(),
      userId: subscription.createdBy.getOrCrash(),
      status: subscription.status.asString(),
      triggers: subscription.triggers.convertToUTC().convertToRawMapOrCrash(),
    );
  }

  @override
  Subscription toDomain() {
    return Subscription(
      id: UniqueId.fromUniqueString(id!),
      createdBy: UniqueId.fromUniqueString(userId),
      createdAt: DateTime.parse(createdAt!),
      chatBotId: UniqueId.fromUniqueString(chatBotId),
      status: SubscriptionStatus.fromString(status),
      triggers: triggers.toDomainList().convertToDeviceTime(),
    );
  }

  factory SubscriptionDto.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionDtoFromJson(json);

  factory SubscriptionDto.fromFireStore(DocumentSnapshot<Object?> snapshot) {
    final doc = snapshot as DocumentSnapshot<Map<String, dynamic>>;
    return SubscriptionDto.fromJson(doc.data()!).copyWith(
      id: doc.id,
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
      },
    );
    return asJson;
  }
}
