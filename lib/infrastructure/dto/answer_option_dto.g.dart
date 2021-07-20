// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer_option_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AnswerOptionDto _$_$_AnswerOptionDtoFromJson(Map<String, dynamic> json) {
  return _$_AnswerOptionDto(
    chatBotId: json['chatBotId'] as String,
    questionId: json['questionId'] as String,
    createdBy: json['createdBy'] as String,
    updatedBy: json['updatedBy'] as String,
    translations: Map<String, String>.from(json['translations'] as Map),
  );
}

Map<String, dynamic> _$_$_AnswerOptionDtoToJson(_$_AnswerOptionDto instance) =>
    <String, dynamic>{
      'chatBotId': instance.chatBotId,
      'questionId': instance.questionId,
      'createdBy': instance.createdBy,
      'updatedBy': instance.updatedBy,
      'translations': instance.translations,
    };
