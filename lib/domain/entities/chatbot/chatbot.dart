// Package imports:
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/core/valueobjects/image_url.dart';
import 'package:smart_chat/domain/core/valueobjects/translatable.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/chatbot/chatbot_name.dart';
import 'package:smart_chat/domain/entities/entity.dart';
import 'package:smart_chat/domain/entities/subscription/subscription_frequency.dart';
import 'package:smart_chat/domain/entities/subscription/subscription_trigger.dart';
import 'package:smart_chat/domain/entities/subscription/subscription_time.dart';

class ChatBot extends TranslatableEntity<ChatBot, ChatBotName> {
  final ImageUrl imageUrl;
  final KtList<SubscriptionTrigger> triggers;

  String get firebaseImagePath => '${createdBy.getOrCrash}/$id/image';

  factory ChatBot.empty() => ChatBot(
        id: UniqueId.dummy(),
        createdBy: UniqueId.dummy(),
        updatedBy: UniqueId.dummy(),
        createdAt: DateTime.utc(0),
        updatedAt: DateTime.utc(0),
        translations: Translatable<ChatBotName>.empty(),
        imageUrl: ImageUrl.empty(),
        triggers: listOf(
          SubscriptionTrigger(
            frequency: SubscriptionFrequency.daily(),
            time: SubscriptionTime(
              hh: 18,
            ),
          ),
        ),
        position: 0,
      );

  @override
  ChatBot copyWith(
      {UniqueId? id,
      UniqueId? createdBy,
      UniqueId? updatedBy,
      DateTime? createdAt,
      DateTime? updatedAt,
      Translatable<ChatBotName>? translations,
      ImageUrl? imageUrl,
      KtList<SubscriptionTrigger>? triggers,
      int? position}) {
    return ChatBot(
      id: id ?? this.id,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      translations: translations ?? this.translations,
      imageUrl: imageUrl ?? this.imageUrl,
      triggers: triggers ?? this.triggers,
      position: position ?? this.position,
    );
  }

  factory ChatBot({
    required UniqueId id,
    required UniqueId createdBy,
    required UniqueId updatedBy,
    required DateTime createdAt,
    required DateTime updatedAt,
    required Translatable<ChatBotName> translations,
    required ImageUrl imageUrl,
    required KtList<SubscriptionTrigger> triggers,
    required int position,
  }) {
    return ChatBot._(
      id,
      createdBy,
      updatedBy,
      createdAt,
      updatedAt,
      translations,
      imageUrl,
      triggers,
      position,
    );
  }

  @override
  List<Object?> get props => [
        id,
        createdBy,
        updatedBy,
        createdAt,
        updatedAt,
        translations,
        imageUrl,
        triggers.asList(),
        position,
      ];

  const ChatBot._(
    UniqueId id,
    UniqueId createdBy,
    UniqueId updatedBy,
    DateTime createdAt,
    DateTime updatedAt,
    Translatable<ChatBotName> translations,
    this.imageUrl,
    this.triggers,
    int position,
  ) : super(
          id: id,
          createdBy: createdBy,
          updatedBy: updatedBy,
          createdAt: createdAt,
          updatedAt: updatedAt,
          translations: translations,
          position: position,
        );
}

extension ChatBotsX on KtList<ChatBot> {
  KtList<UniqueId> get ids => map((it) => it.id);
}
