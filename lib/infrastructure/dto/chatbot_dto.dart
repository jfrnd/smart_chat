// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/core/valueobjects/image_url.dart';
import 'package:smart_chat/domain/core/valueobjects/language_code.dart';
import 'package:smart_chat/domain/core/valueobjects/translatable.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/chatbot/chatbot.dart';
import 'package:smart_chat/domain/entities/chatbot/chatbot_name.dart';
import 'package:smart_chat/domain/entities/subscription/subscription_trigger.dart';
import 'package:smart_chat/infrastructure/core/firestore_helpers.dart';
import 'package:smart_chat/infrastructure/dto/entity_dto.dart';

part 'chatbot_dto.freezed.dart';

part 'chatbot_dto.g.dart';

@freezed
class ChatBotDto with _$ChatBotDto implements EntityDto<ChatBot> {
  const ChatBotDto._();

  const factory ChatBotDto({
    @JsonKey(ignore: true) String? id,
    required String createdBy,
    required String updatedBy,
    @JsonKey(ignore: true) String? createdAt,
    @JsonKey(ignore: true) String? updatedAt,
    required Map<String, String> translations,
    required String imageUrl,
    required Map<String, String> triggers,
  }) = _ChatBotDto;

  @override
  factory ChatBotDto.fromDomain(ChatBot chatBot) {
    return ChatBotDto(
        id: chatBot.id.getOrCrash(),
        createdBy: chatBot.createdBy.getOrCrash(),
        updatedBy: chatBot.updatedBy.getOrCrash(),
        createdAt: chatBot.createdAt.toIso8601String(),
        updatedAt: chatBot.updatedAt.toIso8601String(),
        translations: chatBot.translations.convertToRawMapOrCrash(),
        imageUrl: chatBot.imageUrl.toString(),
        triggers: chatBot.triggers.convertToUTC().convertToRawMapOrCrash());
  }

  @override
  ChatBot toDomain() {
    return ChatBot(
      id: UniqueId.fromUniqueString(id!),
      createdBy: UniqueId.fromUniqueString(createdBy),
      updatedBy: UniqueId.fromUniqueString(updatedBy),
      createdAt: DateTime.parse(createdAt!),
      updatedAt: DateTime.parse(updatedAt!),
      translations: Translatable<ChatBotName>(translations.toVoMap()),
      imageUrl: ImageUrl(imageUrl),
      triggers: triggers.toDomainList().convertToDeviceTime(),
      position: 0,
    );
  }

  factory ChatBotDto.fromJson(Map<String, dynamic> json) =>
      _$ChatBotDtoFromJson(json);

  factory ChatBotDto.fromFireStore(DocumentSnapshot<Object?> snapshot) {
    final doc = snapshot as DocumentSnapshot<Map<String, dynamic>>;
    return ChatBotDto.fromJson(doc.data()!).copyWith(
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
        UPDATED_AT: Timestamp.fromDate(DateTime.parse(updatedAt!)),
      },
    );
    return asJson;
  }
}

extension MapX on Map<String, String> {
  KtMap<LanguageCode, ChatBotName> toVoMap() {
    return KtMap.from(
        map((key, value) => MapEntry(LanguageCode(key), ChatBotName(value))));
  }
}
