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

// ! FITNESS

const FITNESS_CREATED_AT = '2021-01-01T12:12:00.000000';
const FITNESS_UPDATED_AT = '2021-01-02T12:12:00.000000';

const ID_FITNESS = '200';

const FITNESS_EN = 'Gym questions';
const FITNESS_DE = 'Fitness Fragen';

final chatBotNameFitnessEN = ChatBotName(FITNESS_EN);

final chatBotNameFItnessDE = ChatBotName(FITNESS_DE);

final chatBotNameLangMapFitness = Translatable<ChatBotName>(KtMap.from({
  LanguageCode.en(): chatBotNameFitnessEN,
  LanguageCode.de(): chatBotNameFItnessDE,
}));

final chatBotFitness = ChatBot(
  id: UniqueId.fromUniqueString(ID_FITNESS),
  createdBy: dummyUserOne.id,
  updatedBy: dummyUserOne.id,
  createdAt: DateTime.parse(FITNESS_CREATED_AT),
  updatedAt: DateTime.parse(FITNESS_UPDATED_AT),
  translations: chatBotNameLangMapFitness,
  imageUrl: ImageUrl.empty(),
  triggers: listOf(),
  position: 0,
);

final chatBotFitnessAsDto = ChatBotDto(
  id: chatBotFitness.id.getOrCrash(),
  createdBy: chatBotFitness.createdBy.getOrCrash(),
  updatedBy: chatBotFitness.updatedBy.getOrCrash(),
  createdAt: chatBotFitness.createdAt.toIso8601String(),
  updatedAt: chatBotFitness.updatedAt.toIso8601String(),
  imageUrl: chatBotFitness.imageUrl.toString(),
  translations: chatBotFitness.translations.convertToRawMapOrCrash(),
  triggers: chatBotFitness.triggers.convertToRawMapOrCrash(),
);
