// Package imports:
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/core/valueobjects/image_url.dart';
import 'package:smart_chat/domain/core/valueobjects/language_code.dart';
import 'package:smart_chat/domain/core/valueobjects/translatable.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/chatbot/chatbot.dart';
import 'package:smart_chat/domain/entities/chatbot/chatbot_name.dart';
import 'package:smart_chat/domain/entities/subscription/subscription_frequency.dart';
import 'package:smart_chat/domain/entities/subscription/subscription_trigger.dart';
import 'package:smart_chat/domain/entities/subscription/subscription_time.dart';
import 'package:smart_chat/infrastructure/dto/chatbot_dto.dart';
import '../../user.dart';

// ! SURVEY

const ID_SURVEY = '400';

const SURVEY_CREATED_AT = '2021-01-01T15:12:00.000000';
const SURVEY_UPDATED_AT = '2021-01-02T15:12:00.000000';

const SURVEY_EN = 'survey';
const SURVEY_DE = 'Umfrage';

final chatBotNameSurveyEN = ChatBotName(SURVEY_EN);
final chatBotNameSurveyDE = ChatBotName(SURVEY_DE);

final chatBotNameLangMapSurvey = Translatable<ChatBotName>(KtMap.from({
  LanguageCode.en(): chatBotNameSurveyEN,
  LanguageCode.de(): chatBotNameSurveyDE,
}));

final chatBotSurvey = ChatBot(
  id: UniqueId.fromUniqueString(ID_SURVEY),
  createdBy: dummyUserOne.id,
  updatedBy: dummyUserOne.id,
  createdAt: DateTime.parse(SURVEY_CREATED_AT),
  updatedAt: DateTime.parse(SURVEY_UPDATED_AT),
  translations: chatBotNameLangMapSurvey,
  imageUrl: ImageUrl.empty(),
  triggers: listOf(
    SubscriptionTrigger(
      frequency: SubscriptionFrequency.daily(),
      time: SubscriptionTime(hh: 18),
    ),
  ),
  position: 0,
);

final chatBotSurveyAsDto = ChatBotDto(
  id: chatBotSurvey.id.getOrCrash(),
  createdBy: chatBotSurvey.createdBy.getOrCrash(),
  updatedBy: chatBotSurvey.updatedBy.getOrCrash(),
  createdAt: chatBotSurvey.createdAt.toIso8601String(),
  updatedAt: chatBotSurvey.updatedAt.toIso8601String(),
  imageUrl: chatBotSurvey.imageUrl.toString(),
  translations: chatBotSurvey.translations.convertToRawMapOrCrash(),
  triggers: chatBotSurvey.triggers.convertToRawMapOrCrash(),
);
