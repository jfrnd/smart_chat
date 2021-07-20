// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'subscription_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SubscriptionDto _$SubscriptionDtoFromJson(Map<String, dynamic> json) {
  return _SubscriptionDto.fromJson(json);
}

/// @nodoc
class _$SubscriptionDtoTearOff {
  const _$SubscriptionDtoTearOff();

  _SubscriptionDto call(
      {@JsonKey(ignore: true) String? id,
      @JsonKey(ignore: true) String? createdAt,
      required String chatBotId,
      required String userId,
      required String status,
      required Map<String, String> triggers}) {
    return _SubscriptionDto(
      id: id,
      createdAt: createdAt,
      chatBotId: chatBotId,
      userId: userId,
      status: status,
      triggers: triggers,
    );
  }

  SubscriptionDto fromJson(Map<String, Object> json) {
    return SubscriptionDto.fromJson(json);
  }
}

/// @nodoc
const $SubscriptionDto = _$SubscriptionDtoTearOff();

/// @nodoc
mixin _$SubscriptionDto {
  @JsonKey(ignore: true)
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  String? get createdAt => throw _privateConstructorUsedError;
  String get chatBotId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  Map<String, String> get triggers => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SubscriptionDtoCopyWith<SubscriptionDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscriptionDtoCopyWith<$Res> {
  factory $SubscriptionDtoCopyWith(
          SubscriptionDto value, $Res Function(SubscriptionDto) then) =
      _$SubscriptionDtoCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(ignore: true) String? id,
      @JsonKey(ignore: true) String? createdAt,
      String chatBotId,
      String userId,
      String status,
      Map<String, String> triggers});
}

/// @nodoc
class _$SubscriptionDtoCopyWithImpl<$Res>
    implements $SubscriptionDtoCopyWith<$Res> {
  _$SubscriptionDtoCopyWithImpl(this._value, this._then);

  final SubscriptionDto _value;
  // ignore: unused_field
  final $Res Function(SubscriptionDto) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? createdAt = freezed,
    Object? chatBotId = freezed,
    Object? userId = freezed,
    Object? status = freezed,
    Object? triggers = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      chatBotId: chatBotId == freezed
          ? _value.chatBotId
          : chatBotId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      triggers: triggers == freezed
          ? _value.triggers
          : triggers // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
    ));
  }
}

/// @nodoc
abstract class _$SubscriptionDtoCopyWith<$Res>
    implements $SubscriptionDtoCopyWith<$Res> {
  factory _$SubscriptionDtoCopyWith(
          _SubscriptionDto value, $Res Function(_SubscriptionDto) then) =
      __$SubscriptionDtoCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(ignore: true) String? id,
      @JsonKey(ignore: true) String? createdAt,
      String chatBotId,
      String userId,
      String status,
      Map<String, String> triggers});
}

/// @nodoc
class __$SubscriptionDtoCopyWithImpl<$Res>
    extends _$SubscriptionDtoCopyWithImpl<$Res>
    implements _$SubscriptionDtoCopyWith<$Res> {
  __$SubscriptionDtoCopyWithImpl(
      _SubscriptionDto _value, $Res Function(_SubscriptionDto) _then)
      : super(_value, (v) => _then(v as _SubscriptionDto));

  @override
  _SubscriptionDto get _value => super._value as _SubscriptionDto;

  @override
  $Res call({
    Object? id = freezed,
    Object? createdAt = freezed,
    Object? chatBotId = freezed,
    Object? userId = freezed,
    Object? status = freezed,
    Object? triggers = freezed,
  }) {
    return _then(_SubscriptionDto(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      chatBotId: chatBotId == freezed
          ? _value.chatBotId
          : chatBotId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
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
class _$_SubscriptionDto extends _SubscriptionDto {
  const _$_SubscriptionDto(
      {@JsonKey(ignore: true) this.id,
      @JsonKey(ignore: true) this.createdAt,
      required this.chatBotId,
      required this.userId,
      required this.status,
      required this.triggers})
      : super._();

  factory _$_SubscriptionDto.fromJson(Map<String, dynamic> json) =>
      _$_$_SubscriptionDtoFromJson(json);

  @override
  @JsonKey(ignore: true)
  final String? id;
  @override
  @JsonKey(ignore: true)
  final String? createdAt;
  @override
  final String chatBotId;
  @override
  final String userId;
  @override
  final String status;
  @override
  final Map<String, String> triggers;

  @override
  String toString() {
    return 'SubscriptionDto(id: $id, createdAt: $createdAt, chatBotId: $chatBotId, userId: $userId, status: $status, triggers: $triggers)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SubscriptionDto &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.chatBotId, chatBotId) ||
                const DeepCollectionEquality()
                    .equals(other.chatBotId, chatBotId)) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.triggers, triggers) ||
                const DeepCollectionEquality()
                    .equals(other.triggers, triggers)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(chatBotId) ^
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(triggers);

  @JsonKey(ignore: true)
  @override
  _$SubscriptionDtoCopyWith<_SubscriptionDto> get copyWith =>
      __$SubscriptionDtoCopyWithImpl<_SubscriptionDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_SubscriptionDtoToJson(this);
  }
}

abstract class _SubscriptionDto extends SubscriptionDto {
  const factory _SubscriptionDto(
      {@JsonKey(ignore: true) String? id,
      @JsonKey(ignore: true) String? createdAt,
      required String chatBotId,
      required String userId,
      required String status,
      required Map<String, String> triggers}) = _$_SubscriptionDto;
  const _SubscriptionDto._() : super._();

  factory _SubscriptionDto.fromJson(Map<String, dynamic> json) =
      _$_SubscriptionDto.fromJson;

  @override
  @JsonKey(ignore: true)
  String? get id => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  String? get createdAt => throw _privateConstructorUsedError;
  @override
  String get chatBotId => throw _privateConstructorUsedError;
  @override
  String get userId => throw _privateConstructorUsedError;
  @override
  String get status => throw _privateConstructorUsedError;
  @override
  Map<String, String> get triggers => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$SubscriptionDtoCopyWith<_SubscriptionDto> get copyWith =>
      throw _privateConstructorUsedError;
}
