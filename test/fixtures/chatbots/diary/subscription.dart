// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/subscription/subscription.dart';
import 'package:smart_chat/domain/entities/subscription/subscription_frequency.dart';
import 'package:smart_chat/domain/entities/subscription/subscription_trigger.dart';
import 'package:smart_chat/domain/entities/subscription/subscription_status.dart';
import 'package:smart_chat/domain/entities/subscription/subscription_time.dart';
import 'package:smart_chat/infrastructure/core/firestore_helpers.dart';
import 'package:smart_chat/infrastructure/dto/subscription_dto.dart';
import '../../user.dart';
import 'chatbot_diary.dart';

const ID_SUBSCRIPTION_DIARY = "1001";

final twelveOClockSubscription = Subscription(
  id: UniqueId.fromUniqueString(ID_SUBSCRIPTION_DIARY),
  chatBotId: chatBotDiary.id,
  createdAt: DateTime.parse(DIARY_CREATED_AT),
  createdBy: dummyUserOne.id,
  status: const SubscriptionStatus.active(),
  triggers: listOf(
    SubscriptionTrigger(
      frequency: SubscriptionFrequency.daily(),
      time: SubscriptionTime(hh: 12),
    ),
  ),
);

final twelveOClockSubscriptionDto = SubscriptionDto(
  id: twelveOClockSubscription.id.getOrCrash(),
  chatBotId: twelveOClockSubscription.chatBotId.getOrCrash(),
  createdAt: twelveOClockSubscription.createdAt.toIso8601String(),
  userId: twelveOClockSubscription.createdBy.getOrCrash(),
  status: twelveOClockSubscription.status.asString(),
  triggers:
      twelveOClockSubscription.triggers.convertToUTC().convertToRawMapOrCrash(),
);

final twelveOClockSubscriptionFirestoreMap = {
  DOCUMENT_ID: twelveOClockSubscription.id.getOrCrash(),
  CHAT_BOT_ID: twelveOClockSubscription.chatBotId.getOrCrash(),
  CREATED_AT: Timestamp.fromDate(twelveOClockSubscription.createdAt),
  USERID: twelveOClockSubscription.createdBy.getOrCrash(),
  STATUS: twelveOClockSubscription.status.asString(),
  TRIGGERS:
      twelveOClockSubscription.triggers.convertToUTC().convertToRawMapOrCrash(),
};

const ID_SUBSCRIPTION_DIARY_TWO = "1002";

final threeOClockSubscription = Subscription(
  id: UniqueId.fromUniqueString(ID_SUBSCRIPTION_DIARY_TWO),
  chatBotId: chatBotDiary.id,
  createdAt: DateTime.parse(DIARY_CREATED_AT),
  createdBy: dummyUserTwo.id,
  status: const SubscriptionStatus.active(),
  triggers: listOf(
    SubscriptionTrigger(
      frequency: SubscriptionFrequency.daily(),
      time: SubscriptionTime(hh: 3),
    ),
  ).convertToUTC(),
);
