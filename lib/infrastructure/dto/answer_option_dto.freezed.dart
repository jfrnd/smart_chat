// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'answer_option_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AnswerOptionDto _$AnswerOptionDtoFromJson(Map<String, dynamic> json) {
  return _AnswerOptionDto.fromJson(json);
}

/// @nodoc
class _$AnswerOptionDtoTearOff {
  const _$AnswerOptionDtoTearOff();

  _AnswerOptionDto call(
      {@JsonKey(ignore: true) String? id,
      required String chatBotId,
      required String questionId,
      required String createdBy,
      required String updatedBy,
      @JsonKey(ignore: true) String? createdAt,
      @JsonKey(ignore: true) String? updatedAt,
      required Map<String, String> translations}) {
    return _AnswerOptionDto(
      id: id,
      chatBotId: chatBotId,
      questionId: questionId,
      createdBy: createdBy,
      updatedBy: updatedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
      translations: translations,
    );
  }

  AnswerOptionDto fromJson(Map<String, Object> json) {
    return AnswerOptionDto.fromJson(json);
  }
}

/// @nodoc
const $AnswerOptionDto = _$AnswerOptionDtoTearOff();

/// @nodoc
mixin _$AnswerOptionDto {
  @JsonKey(ignore: true)
  String? get id => throw _privateConstructorUsedError;
  String get chatBotId => throw _privateConstructorUsedError;
  String get questionId => throw _privateConstructorUsedError;
  String get createdBy => throw _privateConstructorUsedError;
  String get updatedBy => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  String? get updatedAt => throw _privateConstructorUsedError;
  Map<String, String> get translations => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AnswerOptionDtoCopyWith<AnswerOptionDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnswerOptionDtoCopyWith<$Res> {
  factory $AnswerOptionDtoCopyWith(
          AnswerOptionDto value, $Res Function(AnswerOptionDto) then) =
      _$AnswerOptionDtoCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(ignore: true) String? id,
      String chatBotId,
      String questionId,
      String createdBy,
      String updatedBy,
      @JsonKey(ignore: true) String? createdAt,
      @JsonKey(ignore: true) String? updatedAt,
      Map<String, String> translations});
}

/// @nodoc
class _$AnswerOptionDtoCopyWithImpl<$Res>
    implements $AnswerOptionDtoCopyWith<$Res> {
  _$AnswerOptionDtoCopyWithImpl(this._value, this._then);

  final AnswerOptionDto _value;
  // ignore: unused_field
  final $Res Function(AnswerOptionDto) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? chatBotId = freezed,
    Object? questionId = freezed,
    Object? createdBy = freezed,
    Object? updatedBy = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? translations = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      chatBotId: chatBotId == freezed
          ? _value.chatBotId
          : chatBotId // ignore: cast_nullable_to_non_nullable
              as String,
      questionId: questionId == freezed
          ? _value.questionId
          : questionId // ignore: cast_nullable_to_non_nullable
              as String,
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
    ));
  }
}

/// @nodoc
abstract class _$AnswerOptionDtoCopyWith<$Res>
    implements $AnswerOptionDtoCopyWith<$Res> {
  factory _$AnswerOptionDtoCopyWith(
          _AnswerOptionDto value, $Res Function(_AnswerOptionDto) then) =
      __$AnswerOptionDtoCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(ignore: true) String? id,
      String chatBotId,
      String questionId,
      String createdBy,
      String updatedBy,
      @JsonKey(ignore: true) String? createdAt,
      @JsonKey(ignore: true) String? updatedAt,
      Map<String, String> translations});
}

/// @nodoc
class __$AnswerOptionDtoCopyWithImpl<$Res>
    extends _$AnswerOptionDtoCopyWithImpl<$Res>
    implements _$AnswerOptionDtoCopyWith<$Res> {
  __$AnswerOptionDtoCopyWithImpl(
      _AnswerOptionDto _value, $Res Function(_AnswerOptionDto) _then)
      : super(_value, (v) => _then(v as _AnswerOptionDto));

  @override
  _AnswerOptionDto get _value => super._value as _AnswerOptionDto;

  @override
  $Res call({
    Object? id = freezed,
    Object? chatBotId = freezed,
    Object? questionId = freezed,
    Object? createdBy = freezed,
    Object? updatedBy = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? translations = freezed,
  }) {
    return _then(_AnswerOptionDto(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      chatBotId: chatBotId == freezed
          ? _value.chatBotId
          : chatBotId // ignore: cast_nullable_to_non_nullable
              as String,
      questionId: questionId == freezed
          ? _value.questionId
          : questionId // ignore: cast_nullable_to_non_nullable
              as String,
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AnswerOptionDto extends _AnswerOptionDto {
  const _$_AnswerOptionDto(
      {@JsonKey(ignore: true) this.id,
      required this.chatBotId,
      required this.questionId,
      required this.createdBy,
      required this.updatedBy,
      @JsonKey(ignore: true) this.createdAt,
      @JsonKey(ignore: true) this.updatedAt,
      required this.translations})
      : super._();

  factory _$_AnswerOptionDto.fromJson(Map<String, dynamic> json) =>
      _$_$_AnswerOptionDtoFromJson(json);

  @override
  @JsonKey(ignore: true)
  final String? id;
  @override
  final String chatBotId;
  @override
  final String questionId;
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
  String toString() {
    return 'AnswerOptionDto(id: $id, chatBotId: $chatBotId, questionId: $questionId, createdBy: $createdBy, updatedBy: $updatedBy, createdAt: $createdAt, updatedAt: $updatedAt, translations: $translations)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AnswerOptionDto &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.chatBotId, chatBotId) ||
                const DeepCollectionEquality()
                    .equals(other.chatBotId, chatBotId)) &&
            (identical(other.questionId, questionId) ||
                const DeepCollectionEquality()
                    .equals(other.questionId, questionId)) &&
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
                    .equals(other.translations, translations)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(chatBotId) ^
      const DeepCollectionEquality().hash(questionId) ^
      const DeepCollectionEquality().hash(createdBy) ^
      const DeepCollectionEquality().hash(updatedBy) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      const DeepCollectionEquality().hash(translations);

  @JsonKey(ignore: true)
  @override
  _$AnswerOptionDtoCopyWith<_AnswerOptionDto> get copyWith =>
      __$AnswerOptionDtoCopyWithImpl<_AnswerOptionDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_AnswerOptionDtoToJson(this);
  }
}

abstract class _AnswerOptionDto extends AnswerOptionDto {
  const factory _AnswerOptionDto(
      {@JsonKey(ignore: true) String? id,
      required String chatBotId,
      required String questionId,
      required String createdBy,
      required String updatedBy,
      @JsonKey(ignore: true) String? createdAt,
      @JsonKey(ignore: true) String? updatedAt,
      required Map<String, String> translations}) = _$_AnswerOptionDto;
  const _AnswerOptionDto._() : super._();

  factory _AnswerOptionDto.fromJson(Map<String, dynamic> json) =
      _$_AnswerOptionDto.fromJson;

  @override
  @JsonKey(ignore: true)
  String? get id => throw _privateConstructorUsedError;
  @override
  String get chatBotId => throw _privateConstructorUsedError;
  @override
  String get questionId => throw _privateConstructorUsedError;
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
  @JsonKey(ignore: true)
  _$AnswerOptionDtoCopyWith<_AnswerOptionDto> get copyWith =>
      throw _privateConstructorUsedError;
}
