// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

// Project imports:
import 'package:smart_chat/domain/core/valueobjects/image_url.dart';
import 'package:smart_chat/domain/core/valueobjects/language_code.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/user/user.dart';
import 'package:smart_chat/domain/entities/user/user_name.dart';
import 'package:smart_chat/infrastructure/core/firestore_helpers.dart';
import 'package:smart_chat/infrastructure/dto/user_dto.dart';
import 'email_address.dart';

const USER_ID = '1';
const USER_ID2 = '2';

const USER_ONE_CREATED_AT = '2021-01-01T12:12:00.000000';
const USER_ONE_UPDATED_AT = '2021-01-02T12:12:00.000000';
const USER_ONE_ACTIVE_AT = '2021-01-03T12:12:00.000000';

const USER_TWO_CREATED_AT = '2021-01-04T12:12:00.000000';
const USER_TWO_UPDATED_AT = '2021-01-05T12:12:00.000000';
const USER_TWO_ACTIVE_AT = '2021-01-06T12:12:00.000000';

final dummyUserOne = User(
  id: UniqueId.fromUniqueString(USER_ID),
  email: validEmail,
  createdAt: DateTime.parse(USER_ONE_CREATED_AT),
  updatedAt: DateTime.parse(USER_ONE_UPDATED_AT),
  activeAt: DateTime.parse(USER_ONE_ACTIVE_AT),
  imageUrl: ImageUrl.empty(),
  userName: UserName("dummyUserOne"),
  token: "",
  languageCode: LanguageCode.en(),
  timeZoneOffset: const Duration(hours: 2),
);

final dummyUserOneDto = UserDto(
  id: dummyUserOne.id.getOrCrash(),
  email: dummyUserOne.email.getOrCrash(),
  imageUrl: dummyUserOne.imageUrl.toString(),
  userName: dummyUserOne.userName.getOrCrash(),
  createdAt: dummyUserOne.createdAt.toIso8601String(),
  updatedAt: dummyUserOne.updatedAt.toIso8601String(),
  activeAt: dummyUserOne.activeAt.toIso8601String(),
  token: dummyUserOne.token,
  languageCode: dummyUserOne.languageCode.toString(),
  timeZoneOffset: dummyUserOne.timeZoneOffset.inHours,
);

final dummyUserOneAsFirebaseMap = {
  CREATED_AT: Timestamp.fromDate(dummyUserOne.createdAt),
  UPDATED_AT: Timestamp.fromDate(dummyUserOne.updatedAt),
  ACTIVE_AT: Timestamp.fromDate(dummyUserOne.activeAt),
  IMAGE_URL: dummyUserOne.imageUrl.toString(),
  EMAIL: dummyUserOne.email.getOrCrash(),
  USER_NAME: dummyUserOne.userName.getOrCrash(),
  TOKEN: dummyUserOne.token,
  LANGUAGE_CODE: dummyUserOne.languageCode.toString(),
  TIME_ZONE_OFFSET: dummyUserOne.timeZoneOffset.inHours,
};

final dummyUserTwo = User(
  id: UniqueId.fromUniqueString(USER_ID2),
  email: validEmail2,
  createdAt: DateTime.parse(USER_TWO_CREATED_AT),
  updatedAt: DateTime.parse(USER_TWO_UPDATED_AT),
  activeAt: DateTime.parse(USER_TWO_ACTIVE_AT),
  imageUrl: ImageUrl.empty(),
  userName: UserName("dummyUserTwo"),
  token: "",
  languageCode: LanguageCode.en(),
  timeZoneOffset: const Duration(hours: -3),
);
