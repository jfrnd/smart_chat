// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserDto _$_$_UserDtoFromJson(Map<String, dynamic> json) {
  return _$_UserDto(
    email: json['email'] as String,
    userName: json['userName'] as String,
    imageUrl: json['imageUrl'] as String,
    token: json['token'] as String,
    languageCode: json['languageCode'] as String,
    timeZoneOffset: json['timeZoneOffset'] as int,
  );
}

Map<String, dynamic> _$_$_UserDtoToJson(_$_UserDto instance) =>
    <String, dynamic>{
      'email': instance.email,
      'userName': instance.userName,
      'imageUrl': instance.imageUrl,
      'token': instance.token,
      'languageCode': instance.languageCode,
      'timeZoneOffset': instance.timeZoneOffset,
    };
