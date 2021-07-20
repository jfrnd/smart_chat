// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'answer_item_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AnswerItemDto _$AnswerItemDtoFromJson(Map<String, dynamic> json) {
  return _AnswerItemDto.fromJson(json);
}

/// @nodoc
class _$AnswerItemDtoTearOff {
  const _$AnswerItemDtoTearOff();

  _AnswerItemDto call(
      {@JsonKey(ignore: true) String? id,
      required String qarId,
      required String chatBotId,
      required String questionId,
      required String createdBy,
      @JsonKey(ignore: true) String? createdAt,
      @JsonKey(ignore: true) String? validOn,
      required String value}) {
    return _AnswerItemDto(
      id: id,
      qarId: qarId,
      chatBotId: chatBotId,
      questionId: questionId,
      createdBy: createdBy,
      createdAt: createdAt,
      validOn: validOn,
      value: value,
    );
  }

  AnswerItemDto fromJson(Map<String, Object> json) {
    return AnswerItemDto.fromJson(json);
  }
}

/// @nodoc
const $AnswerItemDto = _$AnswerItemDtoTearOff();

/// @nodoc
mixin _$AnswerItemDto {
  @JsonKey(ignore: true)
  String? get id => throw _privateConstructorUsedError;
  String get qarId => throw _privateConstructorUsedError;
  String get chatBotId => throw _privateConstructorUsedError;
  String get questionId => throw _privateConstructorUsedError;
  String get createdBy => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  String? get validOn => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AnswerItemDtoCopyWith<AnswerItemDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnswerItemDtoCopyWith<$Res> {
  factory $AnswerItemDtoCopyWith(
          AnswerItemDto value, $Res Function(AnswerItemDto) then) =
      _$AnswerItemDtoCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(ignore: true) String? id,
      String qarId,
      String chatBotId,
      String questionId,
      String createdBy,
      @JsonKey(ignore: true) String? createdAt,
      @JsonKey(ignore: true) String? validOn,
      String value});
}

/// @nodoc
class _$AnswerItemDtoCopyWithImpl<$Res>
    implements $AnswerItemDtoCopyWith<$Res> {
  _$AnswerItemDtoCopyWithImpl(this._value, this._then);

  final AnswerItemDto _value;
  // ignore: unused_field
  final $Res Function(AnswerItemDto) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? qarId = freezed,
    Object? chatBotId = freezed,
    Object? questionId = freezed,
    Object? createdBy = freezed,
    Object? createdAt = freezed,
    Object? validOn = freezed,
    Object? value = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      qarId: qarId == freezed
          ? _value.qarId
          : qarId // ignore: cast_nullable_to_non_nullable
              as String,
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
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      validOn: validOn == freezed
          ? _value.validOn
          : validOn // ignore: cast_nullable_to_non_nullable
              as String?,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$AnswerItemDtoCopyWith<$Res>
    implements $AnswerItemDtoCopyWith<$Res> {
  factory _$AnswerItemDtoCopyWith(
          _AnswerItemDto value, $Res Function(_AnswerItemDto) then) =
      __$AnswerItemDtoCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(ignore: true) String? id,
      String qarId,
      String chatBotId,
      String questionId,
      String createdBy,
      @JsonKey(ignore: true) String? createdAt,
      @JsonKey(ignore: true) String? validOn,
      String value});
}

/// @nodoc
class __$AnswerItemDtoCopyWithImpl<$Res>
    extends _$AnswerItemDtoCopyWithImpl<$Res>
    implements _$AnswerItemDtoCopyWith<$Res> {
  __$AnswerItemDtoCopyWithImpl(
      _AnswerItemDto _value, $Res Function(_AnswerItemDto) _then)
      : super(_value, (v) => _then(v as _AnswerItemDto));

  @override
  _AnswerItemDto get _value => super._value as _AnswerItemDto;

  @override
  $Res call({
    Object? id = freezed,
    Object? qarId = freezed,
    Object? chatBotId = freezed,
    Object? questionId = freezed,
    Object? createdBy = freezed,
    Object? createdAt = freezed,
    Object? validOn = freezed,
    Object? value = freezed,
  }) {
    return _then(_AnswerItemDto(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      qarId: qarId == freezed
          ? _value.qarId
          : qarId // ignore: cast_nullable_to_non_nullable
              as String,
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
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      validOn: validOn == freezed
          ? _value.validOn
          : validOn // ignore: cast_nullable_to_non_nullable
              as String?,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AnswerItemDto extends _AnswerItemDto {
  const _$_AnswerItemDto(
      {@JsonKey(ignore: true) this.id,
      required this.qarId,
      required this.chatBotId,
      required this.questionId,
      required this.createdBy,
      @JsonKey(ignore: true) this.createdAt,
      @JsonKey(ignore: true) this.validOn,
      required this.value})
      : super._();

  factory _$_AnswerItemDto.fromJson(Map<String, dynamic> json) =>
      _$_$_AnswerItemDtoFromJson(json);

  @override
  @JsonKey(ignore: true)
  final String? id;
  @override
  final String qarId;
  @override
  final String chatBotId;
  @override
  final String questionId;
  @override
  final String createdBy;
  @override
  @JsonKey(ignore: true)
  final String? createdAt;
  @override
  @JsonKey(ignore: true)
  final String? validOn;
  @override
  final String value;

  @override
  String toString() {
    return 'AnswerItemDto(id: $id, qarId: $qarId, chatBotId: $chatBotId, questionId: $questionId, createdBy: $createdBy, createdAt: $createdAt, validOn: $validOn, value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AnswerItemDto &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.qarId, qarId) ||
                const DeepCollectionEquality().equals(other.qarId, qarId)) &&
            (identical(other.chatBotId, chatBotId) ||
                const DeepCollectionEquality()
                    .equals(other.chatBotId, chatBotId)) &&
            (identical(other.questionId, questionId) ||
                const DeepCollectionEquality()
                    .equals(other.questionId, questionId)) &&
            (identical(other.createdBy, createdBy) ||
                const DeepCollectionEquality()
                    .equals(other.createdBy, createdBy)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.validOn, validOn) ||
                const DeepCollectionEquality()
                    .equals(other.validOn, validOn)) &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(qarId) ^
      const DeepCollectionEquality().hash(chatBotId) ^
      const DeepCollectionEquality().hash(questionId) ^
      const DeepCollectionEquality().hash(createdBy) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(validOn) ^
      const DeepCollectionEquality().hash(value);

  @JsonKey(ignore: true)
  @override
  _$AnswerItemDtoCopyWith<_AnswerItemDto> get copyWith =>
      __$AnswerItemDtoCopyWithImpl<_AnswerItemDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_AnswerItemDtoToJson(this);
  }
}

abstract class _AnswerItemDto extends AnswerItemDto {
  const factory _AnswerItemDto(
      {@JsonKey(ignore: true) String? id,
      required String qarId,
      required String chatBotId,
      required String questionId,
      required String createdBy,
      @JsonKey(ignore: true) String? createdAt,
      @JsonKey(ignore: true) String? validOn,
      required String value}) = _$_AnswerItemDto;
  const _AnswerItemDto._() : super._();

  factory _AnswerItemDto.fromJson(Map<String, dynamic> json) =
      _$_AnswerItemDto.fromJson;

  @override
  @JsonKey(ignore: true)
  String? get id => throw _privateConstructorUsedError;
  @override
  String get qarId => throw _privateConstructorUsedError;
  @override
  String get chatBotId => throw _privateConstructorUsedError;
  @override
  String get questionId => throw _privateConstructorUsedError;
  @override
  String get createdBy => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  String? get createdAt => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  String? get validOn => throw _privateConstructorUsedError;
  @override
  String get value => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$AnswerItemDtoCopyWith<_AnswerItemDto> get copyWith =>
      throw _privateConstructorUsedError;
}
