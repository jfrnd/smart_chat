// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qar_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_QarDto _$_$_QarDtoFromJson(Map<String, dynamic> json) {
  return _$_QarDto(
    sessionId: json['sessionId'] as String,
    chatBotId: json['chatBotId'] as String,
    questionId: json['questionId'] as String,
    createdBy: json['createdBy'] as String,
    answerItemIds: (json['answerItemIds'] as List<dynamic>)
        .map((e) => e as String)
        .toList(),
    isAnswered: json['isAnswered'] as bool,
    isVisible: json['isVisible'] as bool,
    position: json['position'] as int,
  );
}

Map<String, dynamic> _$_$_QarDtoToJson(_$_QarDto instance) => <String, dynamic>{
      'sessionId': instance.sessionId,
      'chatBotId': instance.chatBotId,
      'questionId': instance.questionId,
      'createdBy': instance.createdBy,
      'answerItemIds': instance.answerItemIds,
      'isAnswered': instance.isAnswered,
      'isVisible': instance.isVisible,
      'position': instance.position,
    };
