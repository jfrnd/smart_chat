// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/core/valueobjects/image_url.dart';
import 'package:smart_chat/domain/core/valueobjects/language_code.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/user/email_address.dart';
import 'package:smart_chat/domain/entities/user/user.dart';
import 'package:smart_chat/domain/entities/user/user_name.dart';
import 'package:smart_chat/infrastructure/core/firestore_helpers.dart';
import 'package:smart_chat/infrastructure/dto/entity_dto.dart';

part 'user_dto.freezed.dart';

part 'user_dto.g.dart';

@freezed
class UserDto with _$UserDto implements EntityDto<User> {
  const UserDto._();

  const factory UserDto({
    @JsonKey(ignore: true) String? id,
    @JsonKey(ignore: true) String? createdAt,
    @JsonKey(ignore: true) String? updatedAt,
    @JsonKey(ignore: true) String? activeAt,
    required String email,
    required String userName,
    required String imageUrl,
    required String token,
    required String languageCode,
    required int timeZoneOffset,
  }) = _UserDto;

  @override
  factory UserDto.fromDomain(User user) {
    return UserDto(
      id: user.id.getOrCrash(),
      createdAt: user.createdAt.toIso8601String(),
      updatedAt: user.updatedAt.toIso8601String(),
      activeAt: user.activeAt.toIso8601String(),
      imageUrl: user.imageUrl.toString(),
      email: user.email.getOrCrash(),
      userName: user.userName.getOrCrash(),
      token: user.token,
      languageCode: user.languageCode.toString(),
      timeZoneOffset: user.timeZoneOffset.inHours,
    );
  }

  @override
  User toDomain() {
    return User(
      id: UniqueId.fromUniqueString(id!),
      createdAt: DateTime.parse(createdAt!),
      updatedAt: DateTime.parse(updatedAt!),
      activeAt: DateTime.parse(activeAt!),
      imageUrl: ImageUrl(imageUrl),
      email: EmailAddress(email),
      userName: UserName(userName),
      token: token,
      languageCode: LanguageCode(languageCode),
      timeZoneOffset: Duration(hours: timeZoneOffset),
    );
  }

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  factory UserDto.fromFireStore(DocumentSnapshot<Object?> snapshot) {
    final doc = snapshot as DocumentSnapshot<Map<String, dynamic>>;
    return UserDto.fromJson(doc.data()!).copyWith(
      id: doc.id,
      createdAt: (doc.get(CREATED_AT) as Timestamp).toDate().toIso8601String(),
      updatedAt: (doc.get(UPDATED_AT) as Timestamp).toDate().toIso8601String(),
      activeAt: (doc.get(ACTIVE_AT) as Timestamp).toDate().toIso8601String(),
    );
  }

  @override
  Map<String, dynamic> toFireStore() {
    final asJson = toJson();
    asJson.addAll(
      {
        CREATED_AT: Timestamp.fromDate(DateTime.parse(createdAt!)),
        UPDATED_AT: Timestamp.fromDate(DateTime.parse(updatedAt!)),
        ACTIVE_AT: Timestamp.fromDate(DateTime.parse(activeAt!)),
      },
    );
    return asJson;
  }
}
