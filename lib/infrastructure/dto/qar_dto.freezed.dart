// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'qar_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

QarDto _$QarDtoFromJson(Map<String, dynamic> json) {
  return _QarDto.fromJson(json);
}

/// @nodoc
class _$QarDtoTearOff {
  const _$QarDtoTearOff();

  _QarDto call(
      {@JsonKey(ignore: true) String? id,
      required String sessionId,
      required String chatBotId,
      required String questionId,
      required String createdBy,
      required List<String> answerItemIds,
      required bool isAnswered,
      required bool isVisible,
      required int position,
      @JsonKey(ignore: true) String? reactionItemId,
      @JsonKey(ignore: true) String? createdAt,
      @JsonKey(ignore: true) String? visibleSince}) {
    return _QarDto(
      id: id,
      sessionId: sessionId,
      chatBotId: chatBotId,
      questionId: questionId,
      createdBy: createdBy,
      answerItemIds: answerItemIds,
      isAnswered: isAnswered,
      isVisible: isVisible,
      position: position,
      reactionItemId: reactionItemId,
      createdAt: createdAt,
      visibleSince: visibleSince,
    );
  }

  QarDto fromJson(Map<String, Object> json) {
    return QarDto.fromJson(json);
  }
}

/// @nodoc
const $QarDto = _$QarDtoTearOff();

/// @nodoc
mixin _$QarDto {
  @JsonKey(ignore: true)
  String? get id => throw _privateConstructorUsedError;
  String get sessionId => throw _privateConstructorUsedError;
  String get chatBotId => throw _privateConstructorUsedError;
  String get questionId => throw _privateConstructorUsedError;
  String get createdBy => throw _privateConstructorUsedError;
  List<String> get answerItemIds => throw _privateConstructorUsedError;
  bool get isAnswered => throw _privateConstructorUsedError;
  bool get isVisible => throw _privateConstructorUsedError;
  int get position => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  String? get reactionItemId => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  String? get visibleSince => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QarDtoCopyWith<QarDto> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QarDtoCopyWith<$Res> {
  factory $QarDtoCopyWith(QarDto value, $Res Function(QarDto) then) =
      _$QarDtoCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(ignore: true) String? id,
      String sessionId,
      String chatBotId,
      String questionId,
      String createdBy,
      List<String> answerItemIds,
      bool isAnswered,
      bool isVisible,
      int position,
      @JsonKey(ignore: true) String? reactionItemId,
      @JsonKey(ignore: true) String? createdAt,
      @JsonKey(ignore: true) String? visibleSince});
}

/// @nodoc
class _$QarDtoCopyWithImpl<$Res> implements $QarDtoCopyWith<$Res> {
  _$QarDtoCopyWithImpl(this._value, this._then);

  final QarDto _value;
  // ignore: unused_field
  final $Res Function(QarDto) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? sessionId = freezed,
    Object? chatBotId = freezed,
    Object? questionId = freezed,
    Object? createdBy = freezed,
    Object? answerItemIds = freezed,
    Object? isAnswered = freezed,
    Object? isVisible = freezed,
    Object? position = freezed,
    Object? reactionItemId = freezed,
    Object? createdAt = freezed,
    Object? visibleSince = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      sessionId: sessionId == freezed
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
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
      answerItemIds: answerItemIds == freezed
          ? _value.answerItemIds
          : answerItemIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isAnswered: isAnswered == freezed
          ? _value.isAnswered
          : isAnswered // ignore: cast_nullable_to_non_nullable
              as bool,
      isVisible: isVisible == freezed
          ? _value.isVisible
          : isVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      position: position == freezed
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
      reactionItemId: reactionItemId == freezed
          ? _value.reactionItemId
          : reactionItemId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      visibleSince: visibleSince == freezed
          ? _value.visibleSince
          : visibleSince // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$QarDtoCopyWith<$Res> implements $QarDtoCopyWith<$Res> {
  factory _$QarDtoCopyWith(_QarDto value, $Res Function(_QarDto) then) =
      __$QarDtoCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(ignore: true) String? id,
      String sessionId,
      String chatBotId,
      String questionId,
      String createdBy,
      List<String> answerItemIds,
      bool isAnswered,
      bool isVisible,
      int position,
      @JsonKey(ignore: true) String? reactionItemId,
      @JsonKey(ignore: true) String? createdAt,
      @JsonKey(ignore: true) String? visibleSince});
}

/// @nodoc
class __$QarDtoCopyWithImpl<$Res> extends _$QarDtoCopyWithImpl<$Res>
    implements _$QarDtoCopyWith<$Res> {
  __$QarDtoCopyWithImpl(_QarDto _value, $Res Function(_QarDto) _then)
      : super(_value, (v) => _then(v as _QarDto));

  @override
  _QarDto get _value => super._value as _QarDto;

  @override
  $Res call({
    Object? id = freezed,
    Object? sessionId = freezed,
    Object? chatBotId = freezed,
    Object? questionId = freezed,
    Object? createdBy = freezed,
    Object? answerItemIds = freezed,
    Object? isAnswered = freezed,
    Object? isVisible = freezed,
    Object? position = freezed,
    Object? reactionItemId = freezed,
    Object? createdAt = freezed,
    Object? visibleSince = freezed,
  }) {
    return _then(_QarDto(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      sessionId: sessionId == freezed
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
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
      answerItemIds: answerItemIds == freezed
          ? _value.answerItemIds
          : answerItemIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isAnswered: isAnswered == freezed
          ? _value.isAnswered
          : isAnswered // ignore: cast_nullable_to_non_nullable
              as bool,
      isVisible: isVisible == freezed
          ? _value.isVisible
          : isVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      position: position == freezed
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
      reactionItemId: reactionItemId == freezed
          ? _value.reactionItemId
          : reactionItemId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      visibleSince: visibleSince == freezed
          ? _value.visibleSince
          : visibleSince // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_QarDto extends _QarDto {
  const _$_QarDto(
      {@JsonKey(ignore: true) this.id,
      required this.sessionId,
      required this.chatBotId,
      required this.questionId,
      required this.createdBy,
      required this.answerItemIds,
      required this.isAnswered,
      required this.isVisible,
      required this.position,
      @JsonKey(ignore: true) this.reactionItemId,
      @JsonKey(ignore: true) this.createdAt,
      @JsonKey(ignore: true) this.visibleSince})
      : super._();

  factory _$_QarDto.fromJson(Map<String, dynamic> json) =>
      _$_$_QarDtoFromJson(json);

  @override
  @JsonKey(ignore: true)
  final String? id;
  @override
  final String sessionId;
  @override
  final String chatBotId;
  @override
  final String questionId;
  @override
  final String createdBy;
  @override
  final List<String> answerItemIds;
  @override
  final bool isAnswered;
  @override
  final bool isVisible;
  @override
  final int position;
  @override
  @JsonKey(ignore: true)
  final String? reactionItemId;
  @override
  @JsonKey(ignore: true)
  final String? createdAt;
  @override
  @JsonKey(ignore: true)
  final String? visibleSince;

  @override
  String toString() {
    return 'QarDto(id: $id, sessionId: $sessionId, chatBotId: $chatBotId, questionId: $questionId, createdBy: $createdBy, answerItemIds: $answerItemIds, isAnswered: $isAnswered, isVisible: $isVisible, position: $position, reactionItemId: $reactionItemId, createdAt: $createdAt, visibleSince: $visibleSince)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _QarDto &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.sessionId, sessionId) ||
                const DeepCollectionEquality()
                    .equals(other.sessionId, sessionId)) &&
            (identical(other.chatBotId, chatBotId) ||
                const DeepCollectionEquality()
                    .equals(other.chatBotId, chatBotId)) &&
            (identical(other.questionId, questionId) ||
                const DeepCollectionEquality()
                    .equals(other.questionId, questionId)) &&
            (identical(other.createdBy, createdBy) ||
                const DeepCollectionEquality()
                    .equals(other.createdBy, createdBy)) &&
            (identical(other.answerItemIds, answerItemIds) ||
                const DeepCollectionEquality()
                    .equals(other.answerItemIds, answerItemIds)) &&
            (identical(other.isAnswered, isAnswered) ||
                const DeepCollectionEquality()
                    .equals(other.isAnswered, isAnswered)) &&
            (identical(other.isVisible, isVisible) ||
                const DeepCollectionEquality()
                    .equals(other.isVisible, isVisible)) &&
            (identical(other.position, position) ||
                const DeepCollectionEquality()
                    .equals(other.position, position)) &&
            (identical(other.reactionItemId, reactionItemId) ||
                const DeepCollectionEquality()
                    .equals(other.reactionItemId, reactionItemId)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.visibleSince, visibleSince) ||
                const DeepCollectionEquality()
                    .equals(other.visibleSince, visibleSince)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(sessionId) ^
      const DeepCollectionEquality().hash(chatBotId) ^
      const DeepCollectionEquality().hash(questionId) ^
      const DeepCollectionEquality().hash(createdBy) ^
      const DeepCollectionEquality().hash(answerItemIds) ^
      const DeepCollectionEquality().hash(isAnswered) ^
      const DeepCollectionEquality().hash(isVisible) ^
      const DeepCollectionEquality().hash(position) ^
      const DeepCollectionEquality().hash(reactionItemId) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(visibleSince);

  @JsonKey(ignore: true)
  @override
  _$QarDtoCopyWith<_QarDto> get copyWith =>
      __$QarDtoCopyWithImpl<_QarDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_QarDtoToJson(this);
  }
}

abstract class _QarDto extends QarDto {
  const factory _QarDto(
      {@JsonKey(ignore: true) String? id,
      required String sessionId,
      required String chatBotId,
      required String questionId,
      required String createdBy,
      required List<String> answerItemIds,
      required bool isAnswered,
      required bool isVisible,
      required int position,
      @JsonKey(ignore: true) String? reactionItemId,
      @JsonKey(ignore: true) String? createdAt,
      @JsonKey(ignore: true) String? visibleSince}) = _$_QarDto;
  const _QarDto._() : super._();

  factory _QarDto.fromJson(Map<String, dynamic> json) = _$_QarDto.fromJson;

  @override
  @JsonKey(ignore: true)
  String? get id => throw _privateConstructorUsedError;
  @override
  String get sessionId => throw _privateConstructorUsedError;
  @override
  String get chatBotId => throw _privateConstructorUsedError;
  @override
  String get questionId => throw _privateConstructorUsedError;
  @override
  String get createdBy => throw _privateConstructorUsedError;
  @override
  List<String> get answerItemIds => throw _privateConstructorUsedError;
  @override
  bool get isAnswered => throw _privateConstructorUsedError;
  @override
  bool get isVisible => throw _privateConstructorUsedError;
  @override
  int get position => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  String? get reactionItemId => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  String? get createdAt => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  String? get visibleSince => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$QarDtoCopyWith<_QarDto> get copyWith => throw _privateConstructorUsedError;
}
