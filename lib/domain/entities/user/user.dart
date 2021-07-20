// Package imports:
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/core/valueobjects/image_url.dart';
import 'package:smart_chat/domain/core/valueobjects/language_code.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/entity.dart';
import 'email_address.dart';
import 'user_name.dart';

class User extends Entity<User> {
  final ImageUrl imageUrl;
  final DateTime updatedAt;
  final DateTime activeAt;
  final UserName userName;
  final EmailAddress email;
  final String token;
  final LanguageCode languageCode;
  final Duration timeZoneOffset;

  factory User.empty() => User(
        id: UniqueId.dummy(),
        createdAt: DateTime.utc(0),
        updatedAt: DateTime.utc(0),
        imageUrl: ImageUrl.empty(),
        userName: UserName.empty(),
        email: EmailAddress.empty(),
        token: "",
        activeAt: DateTime.utc(0),
        languageCode: LanguageCode.en(),
        timeZoneOffset: const Duration(days: 0),
      );

  @override
  User copyWith({
    UniqueId? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? activeAt,
    ImageUrl? imageUrl,
    UserName? userName,
    EmailAddress? email,
    UniqueId? createdBy,
    LanguageCode? languageCode,
    String? token,
    Duration? timeZoneOffset,
  }) {
    return User(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      imageUrl: imageUrl ?? this.imageUrl,
      email: email ?? this.email,
      userName: userName ?? this.userName,
      token: token ?? this.token,
      activeAt: activeAt ?? this.activeAt,
      languageCode: languageCode ?? this.languageCode,
      timeZoneOffset: timeZoneOffset ?? this.timeZoneOffset,
    );
  }

  User changeLanguageCode(LanguageCode languageCode) => copyWith(
        languageCode: languageCode,
      );

  User removeToken(String token) => copyWith(
        token: "",
      );

  User updateActivity(DateTime now) => copyWith(
        activeAt: now,
      );

  factory User({
    required UniqueId id,
    required DateTime createdAt,
    required DateTime updatedAt,
    required DateTime activeAt,
    required ImageUrl imageUrl,
    required UserName userName,
    required EmailAddress email,
    required String token,
    required LanguageCode languageCode,
    required Duration timeZoneOffset,
  }) {
    return User._(
      id,
      createdAt,
      updatedAt,
      imageUrl,
      userName,
      email,
      token,
      activeAt,
      languageCode,
      timeZoneOffset,
    );
  }

  User updateMetaData({
    required DateTime updatedAt,
  }) =>
      copyWith(
        updatedAt: updatedAt,
      );

  @override
  List<Object?> get props => [
        id,
        createdAt,
        updatedAt,
        imageUrl,
        userName,
        email,
        createdBy,
        token,
        activeAt,
        languageCode,
        timeZoneOffset,
      ];

  const User._(
    UniqueId id,
    DateTime createdAt,
    this.updatedAt,
    this.imageUrl,
    this.userName,
    this.email,
    this.token,
    this.activeAt,
    this.languageCode,
    this.timeZoneOffset,
  ) : super(
          id: id,
          createdBy: id,
          createdAt: createdAt,
        );
}
