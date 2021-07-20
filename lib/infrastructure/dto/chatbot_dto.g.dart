// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chatbot_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ChatBotDto _$_$_ChatBotDtoFromJson(Map<String, dynamic> json) {
  return _$_ChatBotDto(
    createdBy: json['createdBy'] as String,
    updatedBy: json['updatedBy'] as String,
    translations: Map<String, String>.from(json['translations'] as Map),
    imageUrl: json['imageUrl'] as String,
    triggers: Map<String, String>.from(json['triggers'] as Map),
  );
}

Map<String, dynamic> _$_$_ChatBotDtoToJson(_$_ChatBotDto instance) =>
    <String, dynamic>{
      'createdBy': instance.createdBy,
      'updatedBy': instance.updatedBy,
      'translations': instance.translations,
      'imageUrl': instance.imageUrl,
      'triggers': instance.triggers,
    };
