// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SubscriptionDto _$_$_SubscriptionDtoFromJson(Map<String, dynamic> json) {
  return _$_SubscriptionDto(
    chatBotId: json['chatBotId'] as String,
    userId: json['userId'] as String,
    status: json['status'] as String,
    triggers: Map<String, String>.from(json['triggers'] as Map),
  );
}

Map<String, dynamic> _$_$_SubscriptionDtoToJson(_$_SubscriptionDto instance) =>
    <String, dynamic>{
      'chatBotId': instance.chatBotId,
      'userId': instance.userId,
      'status': instance.status,
      'triggers': instance.triggers,
    };
