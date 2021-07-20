// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_QuestionDto _$_$_QuestionDtoFromJson(Map<String, dynamic> json) {
  return _$_QuestionDto(
    chatBotId: json['chatBotId'] as String,
    translations: Map<String, String>.from(json['translations'] as Map),
    createdBy: json['createdBy'] as String,
    updatedBy: json['updatedBy'] as String,
    type: json['type'] as String,
    multiSelection: json['multiSelection'] as bool?,
    unit: json['unit'] as String?,
    minVal: (json['minVal'] as num?)?.toDouble(),
    maxVal: (json['maxVal'] as num?)?.toDouble(),
    digits: json['digits'] as int?,
    position: json['position'] as int,
  );
}

Map<String, dynamic> _$_$_QuestionDtoToJson(_$_QuestionDto instance) =>
    <String, dynamic>{
      'chatBotId': instance.chatBotId,
      'translations': instance.translations,
      'createdBy': instance.createdBy,
      'updatedBy': instance.updatedBy,
      'type': instance.type,
      'multiSelection': instance.multiSelection,
      'unit': instance.unit,
      'minVal': instance.minVal,
      'maxVal': instance.maxVal,
      'digits': instance.digits,
      'position': instance.position,
    };
