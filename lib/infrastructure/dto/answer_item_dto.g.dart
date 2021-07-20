// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer_item_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AnswerItemDto _$_$_AnswerItemDtoFromJson(Map<String, dynamic> json) {
  return _$_AnswerItemDto(
    qarId: json['qarId'] as String,
    chatBotId: json['chatBotId'] as String,
    questionId: json['questionId'] as String,
    createdBy: json['createdBy'] as String,
    value: json['value'] as String,
  );
}

Map<String, dynamic> _$_$_AnswerItemDtoToJson(_$_AnswerItemDto instance) =>
    <String, dynamic>{
      'qarId': instance.qarId,
      'chatBotId': instance.chatBotId,
      'questionId': instance.questionId,
      'createdBy': instance.createdBy,
      'value': instance.value,
    };
