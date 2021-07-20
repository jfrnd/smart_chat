// Package imports:
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/entity.dart';
import 'package:smart_chat/domain/entities/subscription/subscription_trigger.dart';
import 'package:smart_chat/domain/entities/subscription/subscription_status.dart';

class Subscription extends Entity<Subscription> {
  final KtList<SubscriptionTrigger> triggers;
  final SubscriptionStatus status;
  final UniqueId chatBotId;

  factory Subscription.empty() => Subscription(
        id: UniqueId.dummy(),
        createdAt: DateTime.utc(0),
        createdBy: UniqueId.dummy(),
        chatBotId: UniqueId.dummy(),
        status: const SubscriptionStatus.active(),
        triggers: listOf(),
      );

  @override
  Subscription copyWith({
    UniqueId? id,
    DateTime? createdAt,
    UniqueId? createdBy,
    UniqueId? chatBotId,
    SubscriptionStatus? status,
    KtList<SubscriptionTrigger>? triggers,
  }) {
    return Subscription(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      chatBotId: chatBotId ?? this.chatBotId,
      status: status ?? this.status,
      triggers: triggers ?? this.triggers,
    );
  }

  factory Subscription({
    required UniqueId id,
    required DateTime createdAt,
    required UniqueId createdBy,
    required UniqueId chatBotId,
    required SubscriptionStatus status,
    required KtList<SubscriptionTrigger> triggers,
  }) {
    return Subscription._(
      id,
      createdBy,
      createdAt,
      chatBotId,
      status,
      triggers,
    );
  }

  @override
  List<Object?> get props => [
        id,
        createdAt,
        createdBy,
        chatBotId,
        status,
        triggers.asList(),
      ];

  const Subscription._(
    UniqueId id,
    UniqueId createdBy,
    DateTime createdAt,
    this.chatBotId,
    this.status,
    this.triggers,
  ) : super(
          id: id,
          createdBy: createdBy,
          createdAt: createdAt,
        );
}

extension SubscriptionsX on KtList<Subscription> {
  KtList<UniqueId> get chatBotIds => map((subscription) => subscription.chatBotId);
}
