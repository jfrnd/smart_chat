// Package imports:
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/core/valueobjects/image_url.dart';
import 'package:smart_chat/domain/core/valueobjects/language_code.dart';
import 'package:smart_chat/domain/core/valueobjects/translatable.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/chatbot/chatbot.dart';
import 'package:smart_chat/domain/entities/chatbot/chatbot_name.dart';
import 'package:smart_chat/domain/entities/subscription/subscription_trigger.dart';
import 'package:smart_chat/infrastructure/dto/chatbot_dto.dart';
import '../../user.dart';

// ! POLITICS

const POLITICS_CREATED_AT = '2021-02-01T12:12:00.000000';
const POLITICS_UPDATED_AT = '2021-03-02T12:12:00.000000';

const ID_POLITICS = '300';

const POLITICS_EN = 'Politics';
const FPOLITICS_DE = 'Politik';

final chatBotNamePoliticsEN = ChatBotName(POLITICS_EN);

final chatBotNamePoliticsDE = ChatBotName(FPOLITICS_DE);

final chatBotNameLangMapPolitics = Translatable<ChatBotName>(KtMap.from({
  LanguageCode.en(): chatBotNamePoliticsEN,
  LanguageCode.de(): chatBotNamePoliticsDE,
}));

final chatBotPolitics = ChatBot(
  id: UniqueId.fromUniqueString(ID_POLITICS),
  createdBy: dummyUserTwo.id,
  updatedBy: dummyUserTwo.id,
  createdAt: DateTime.parse(POLITICS_CREATED_AT),
  updatedAt: DateTime.parse(POLITICS_UPDATED_AT),
  translations: chatBotNameLangMapPolitics,
  imageUrl: ImageUrl.empty(),
  triggers: listOf(),
  position: 0,
);

final chatBotFitnessAsDto = ChatBotDto(
  id: chatBotPolitics.id.getOrCrash(),
  createdBy: chatBotPolitics.createdBy.getOrCrash(),
  updatedBy: chatBotPolitics.updatedBy.getOrCrash(),
  createdAt: chatBotPolitics.createdAt.toIso8601String(),
  updatedAt: chatBotPolitics.updatedAt.toIso8601String(),
  imageUrl: chatBotPolitics.imageUrl.toString(),
  translations: chatBotPolitics.translations.convertToRawMapOrCrash(),
  triggers: chatBotPolitics.triggers.convertToRawMapOrCrash(),
);
