// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'chatbot_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChatBotDto _$ChatBotDtoFromJson(Map<String, dynamic> json) {
  return _ChatBotDto.fromJson(json);
}

/// @nodoc
class _$ChatBotDtoTearOff {
  const _$ChatBotDtoTearOff();

  _ChatBotDto call(
      {@JsonKey(ignore: true) String? id,
      required String createdBy,
      required String updatedBy,
      @JsonKey(ignore: true) String? createdAt,
      @JsonKey(ignore: true) String? updatedAt,
      required Map<String, String> translations,
      required String imageUrl,
      required Map<String, String> triggers}) {
    return _ChatBotDto(
      id: id,
      createdBy: createdBy,
      updatedBy: updatedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
      translations: translations,
      imageUrl: imageUrl,
      triggers: triggers,
    );
  }

  ChatBotDto fromJson(Map<String, Object> json) {
    return ChatBotDto.fromJson(json);
  }
}

/// @nodoc
const $ChatBotDto = _$ChatBotDtoTearOff();

/// @nodoc
mixin _$ChatBotDto {
  @JsonKey(ignore: true)
  String? get id => throw _privateConstructorUsedError;
  String get createdBy => throw _privateConstructorUsedError;
  String get updatedBy => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  String? get updatedAt => throw _privateConstructorUsedError;
  Map<String, String> get translations => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  Map<String, String> get triggers => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatBotDtoCopyWith<ChatBotDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatBotDtoCopyWith<$Res> {
  factory $ChatBotDtoCopyWith(
          ChatBotDto value, $Res Function(ChatBotDto) then) =
      _$ChatBotDtoCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(ignore: true) String? id,
      String createdBy,
      String updatedBy,
      @JsonKey(ignore: true) String? createdAt,
      @JsonKey(ignore: true) String? updatedAt,
      Map<String, String> translations,
      String imageUrl,
      Map<String, String> triggers});
}

/// @nodoc
class _$ChatBotDtoCopyWithImpl<$Res> implements $ChatBotDtoCopyWith<$Res> {
  _$ChatBotDtoCopyWithImpl(this._value, this._then);

  final ChatBotDto _value;
  // ignore: unused_field
  final $Res Function(ChatBotDto) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? createdBy = freezed,
    Object? updatedBy = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? translations = freezed,
    Object? imageUrl = freezed,
    Object? triggers = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      createdBy: createdBy == freezed
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      updatedBy: updatedBy == freezed
          ? _value.updatedBy
          : updatedBy // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      translations: translations == freezed
          ? _value.translations
          : translations // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      imageUrl: imageUrl == freezed
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      triggers: triggers == freezed
          ? _value.triggers
          : triggers // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
    ));
  }
}

/// @nodoc
abstract class _$ChatBotDtoCopyWith<$Res> implements $ChatBotDtoCopyWith<$Res> {
  factory _$ChatBotDtoCopyWith(
          _ChatBotDto value, $Res Function(_ChatBotDto) then) =
      __$ChatBotDtoCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(ignore: true) String? id,
      String createdBy,
      String updatedBy,
      @JsonKey(ignore: true) String? createdAt,
      @JsonKey(ignore: true) String? updatedAt,
      Map<String, String> translations,
      String imageUrl,
      Map<String, String> triggers});
}

/// @nodoc
class __$ChatBotDtoCopyWithImpl<$Res> extends _$ChatBotDtoCopyWithImpl<$Res>
    implements _$ChatBotDtoCopyWith<$Res> {
  __$ChatBotDtoCopyWithImpl(
      _ChatBotDto _value, $Res Function(_ChatBotDto) _then)
      : super(_value, (v) => _then(v as _ChatBotDto));

  @override
  _ChatBotDto get _value => super._value as _ChatBotDto;

  @override
  $Res call({
    Object? id = freezed,
    Object? createdBy = freezed,
    Object? updatedBy = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? translations = freezed,
    Object? imageUrl = freezed,
    Object? triggers = freezed,
  }) {
    return _then(_ChatBotDto(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      createdBy: createdBy == freezed
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      updatedBy: updatedBy == freezed
          ? _value.updatedBy
          : updatedBy // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      translations: translations == freezed
          ? _value.translations
          : translations // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      imageUrl: imageUrl == freezed
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      triggers: triggers == freezed
          ? _value.triggers
          : triggers // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ChatBotDto extends _ChatBotDto {
  const _$_ChatBotDto(
      {@JsonKey(ignore: true) this.id,
      required this.createdBy,
      required this.updatedBy,
      @JsonKey(ignore: true) this.createdAt,
      @JsonKey(ignore: true) this.updatedAt,
      required this.translations,
      required this.imageUrl,
      required this.triggers})
      : super._();

  factory _$_ChatBotDto.fromJson(Map<String, dynamic> json) =>
      _$_$_ChatBotDtoFromJson(json);

  @override
  @JsonKey(ignore: true)
  final String? id;
  @override
  final String createdBy;
  @override
  final String updatedBy;
  @override
  @JsonKey(ignore: true)
  final String? createdAt;
  @override
  @JsonKey(ignore: true)
  final String? updatedAt;
  @override
  final Map<String, String> translations;
  @override
  final String imageUrl;
  @override
  final Map<String, String> triggers;

  @override
  String toString() {
    return 'ChatBotDto(id: $id, createdBy: $createdBy, updatedBy: $updatedBy, createdAt: $createdAt, updatedAt: $updatedAt, translations: $translations, imageUrl: $imageUrl, triggers: $triggers)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ChatBotDto &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.createdBy, createdBy) ||
                const DeepCollectionEquality()
                    .equals(other.createdBy, createdBy)) &&
            (identical(other.updatedBy, updatedBy) ||
                const DeepCollectionEquality()
                    .equals(other.updatedBy, updatedBy)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)) &&
            (identical(other.translations, translations) ||
                const DeepCollectionEquality()
                    .equals(other.translations, translations)) &&
            (identical(other.imageUrl, imageUrl) ||
                const DeepCollectionEquality()
                    .equals(other.imageUrl, imageUrl)) &&
            (identical(other.triggers, triggers) ||
                const DeepCollectionEquality()
                    .equals(other.triggers, triggers)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(createdBy) ^
      const DeepCollectionEquality().hash(updatedBy) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      const DeepCollectionEquality().hash(translations) ^
      const DeepCollectionEquality().hash(imageUrl) ^
      const DeepCollectionEquality().hash(triggers);

  @JsonKey(ignore: true)
  @override
  _$ChatBotDtoCopyWith<_ChatBotDto> get copyWith =>
      __$ChatBotDtoCopyWithImpl<_ChatBotDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ChatBotDtoToJson(this);
  }
}

abstract class _ChatBotDto extends ChatBotDto {
  const factory _ChatBotDto(
      {@JsonKey(ignore: true) String? id,
      required String createdBy,
      required String updatedBy,
      @JsonKey(ignore: true) String? createdAt,
      @JsonKey(ignore: true) String? updatedAt,
      required Map<String, String> translations,
      required String imageUrl,
      required Map<String, String> triggers}) = _$_ChatBotDto;
  const _ChatBotDto._() : super._();

  factory _ChatBotDto.fromJson(Map<String, dynamic> json) =
      _$_ChatBotDto.fromJson;

  @override
  @JsonKey(ignore: true)
  String? get id => throw _privateConstructorUsedError;
  @override
  String get createdBy => throw _privateConstructorUsedError;
  @override
  String get updatedBy => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  String? get createdAt => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  String? get updatedAt => throw _privateConstructorUsedError;
  @override
  Map<String, String> get translations => throw _privateConstructorUsedError;
  @override
  String get imageUrl => throw _privateConstructorUsedError;
  @override
  Map<String, String> get triggers => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ChatBotDtoCopyWith<_ChatBotDto> get copyWith =>
      throw _privateConstructorUsedError;
}
