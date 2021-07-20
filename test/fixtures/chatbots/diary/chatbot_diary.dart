// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'package:smart_chat/infrastructure/dto/chatbot_dto.dart';
import '../../user.dart';

// ! DIARY

const ID_DIARY = '100';

const DIARY_CREATED_AT = '2021-01-01T12:12:00.000000';
const DIARY_UPDATED_AT = '2021-01-02T12:12:00.000000';

const DIARY_EN = 'diary';
const DIARY_DE = 'tagebuch';
const DIARY_ZH = '日记';

final chatBotNameDiaryEN = ChatBotName(DIARY_EN);
final chatBotNameDiaryDE = ChatBotName(DIARY_DE);
final chatBotNameDiaryZH = ChatBotName(DIARY_ZH);

final chatBotNameLangMapDiary = Translatable<ChatBotName>(KtMap.from({
  LanguageCode.en(): chatBotNameDiaryEN,
  LanguageCode.de(): chatBotNameDiaryDE,
}));

final chatBotNameLangMapDiaryUntrimmed = Translatable<ChatBotName>(KtMap.from({
  LanguageCode.en(): chatBotNameDiaryEN,
  LanguageCode.de(): chatBotNameDiaryDE,
  LanguageCode.zh(): ChatBotName.empty(),
}));

final chatBotNameLangMapDiaryExtended = Translatable<ChatBotName>(KtMap.from({
  LanguageCode.en(): chatBotNameDiaryEN,
  LanguageCode.de(): chatBotNameDiaryDE,
  LanguageCode.zh(): chatBotNameDiaryZH,
}));

final chatBotNameLangMapDiaryInvalid = Translatable<ChatBotName>(KtMap.from({
  LanguageCode.en(): chatBotNameDiaryEN,
  LanguageCode.de(): chatBotNameDiaryDE,
  LanguageCode.zh(): ChatBotName('Multi \n line'),
}));

final chatBotDiary = ChatBot(
  id: UniqueId.fromUniqueString(ID_DIARY),
  createdBy: dummyUserOne.id,
  updatedBy: dummyUserOne.id,
  createdAt: DateTime.parse(DIARY_CREATED_AT),
  updatedAt: DateTime.parse(DIARY_UPDATED_AT),
  translations: chatBotNameLangMapDiary,
  imageUrl: ImageUrl.empty(),
  triggers: listOf(),
  position: 0,
);

final chatBotDiaryUntrimmed = chatBotDiary.copyWith(
  translations: chatBotNameLangMapDiaryUntrimmed,
);

final chatBotDiaryAsDto = ChatBotDto(
  id: chatBotDiary.id.getOrCrash(),
  createdBy: chatBotDiary.createdBy.getOrCrash(),
  updatedBy: chatBotDiary.updatedBy.getOrCrash(),
  createdAt: chatBotDiary.createdAt.toIso8601String(),
  updatedAt: chatBotDiary.updatedAt.toIso8601String(),
  imageUrl: chatBotDiary.imageUrl.toString(),
  translations: chatBotDiary.translations.convertToRawMapOrCrash(),
  triggers: chatBotDiary.triggers.convertToRawMapOrCrash(),
);

final chatBotDiaryAsFirebaseMap = {
  DOCUMENT_ID: chatBotDiary.id.getOrCrash(),
  CREATED_BY: chatBotDiary.createdBy.getOrCrash(),
  UPDATED_BY: chatBotDiary.updatedBy.getOrCrash(),
  CREATED_AT: Timestamp.fromDate(chatBotDiary.createdAt),
  UPDATED_AT: Timestamp.fromDate(chatBotDiary.updatedAt),
  IMAGE_URL: chatBotDiary.imageUrl.toString(),
  TRANSLATIONS: chatBotDiary.translations.convertToRawMapOrCrash(),
  TRIGGERS: chatBotDiary.triggers.convertToRawMapOrCrash(),
};
