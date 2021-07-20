// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'question_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

QuestionDto _$QuestionDtoFromJson(Map<String, dynamic> json) {
  return _QuestionDto.fromJson(json);
}

/// @nodoc
class _$QuestionDtoTearOff {
  const _$QuestionDtoTearOff();

  _QuestionDto call(
      {@JsonKey(ignore: true) String? id,
      required String chatBotId,
      required Map<String, String> translations,
      required String createdBy,
      required String updatedBy,
      @JsonKey(ignore: true) String? createdAt,
      @JsonKey(ignore: true) String? updatedAt,
      required String type,
      required bool? multiSelection,
      required String? unit,
      required double? minVal,
      required double? maxVal,
      required int? digits,
      required int position}) {
    return _QuestionDto(
      id: id,
      chatBotId: chatBotId,
      translations: translations,
      createdBy: createdBy,
      updatedBy: updatedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
      type: type,
      multiSelection: multiSelection,
      unit: unit,
      minVal: minVal,
      maxVal: maxVal,
      digits: digits,
      position: position,
    );
  }

  QuestionDto fromJson(Map<String, Object> json) {
    return QuestionDto.fromJson(json);
  }
}

/// @nodoc
const $QuestionDto = _$QuestionDtoTearOff();

/// @nodoc
mixin _$QuestionDto {
  @JsonKey(ignore: true)
  String? get id => throw _privateConstructorUsedError;
  String get chatBotId => throw _privateConstructorUsedError;
  Map<String, String> get translations => throw _privateConstructorUsedError;
  String get createdBy => throw _privateConstructorUsedError;
  String get updatedBy => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  String? get updatedAt => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  bool? get multiSelection => throw _privateConstructorUsedError;
  String? get unit => throw _privateConstructorUsedError;
  double? get minVal => throw _privateConstructorUsedError;
  double? get maxVal => throw _privateConstructorUsedError;
  int? get digits => throw _privateConstructorUsedError;
  int get position => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QuestionDtoCopyWith<QuestionDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestionDtoCopyWith<$Res> {
  factory $QuestionDtoCopyWith(
          QuestionDto value, $Res Function(QuestionDto) then) =
      _$QuestionDtoCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(ignore: true) String? id,
      String chatBotId,
      Map<String, String> translations,
      String createdBy,
      String updatedBy,
      @JsonKey(ignore: true) String? createdAt,
      @JsonKey(ignore: true) String? updatedAt,
      String type,
      bool? multiSelection,
      String? unit,
      double? minVal,
      double? maxVal,
      int? digits,
      int position});
}

/// @nodoc
class _$QuestionDtoCopyWithImpl<$Res> implements $QuestionDtoCopyWith<$Res> {
  _$QuestionDtoCopyWithImpl(this._value, this._then);

  final QuestionDto _value;
  // ignore: unused_field
  final $Res Function(QuestionDto) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? chatBotId = freezed,
    Object? translations = freezed,
    Object? createdBy = freezed,
    Object? updatedBy = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? type = freezed,
    Object? multiSelection = freezed,
    Object? unit = freezed,
    Object? minVal = freezed,
    Object? maxVal = freezed,
    Object? digits = freezed,
    Object? position = freezed,
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
      translations: translations == freezed
          ? _value.translations
          : translations // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
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
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      multiSelection: multiSelection == freezed
          ? _value.multiSelection
          : multiSelection // ignore: cast_nullable_to_non_nullable
              as bool?,
      unit: unit == freezed
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String?,
      minVal: minVal == freezed
          ? _value.minVal
          : minVal // ignore: cast_nullable_to_non_nullable
              as double?,
      maxVal: maxVal == freezed
          ? _value.maxVal
          : maxVal // ignore: cast_nullable_to_non_nullable
              as double?,
      digits: digits == freezed
          ? _value.digits
          : digits // ignore: cast_nullable_to_non_nullable
              as int?,
      position: position == freezed
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$QuestionDtoCopyWith<$Res>
    implements $QuestionDtoCopyWith<$Res> {
  factory _$QuestionDtoCopyWith(
          _QuestionDto value, $Res Function(_QuestionDto) then) =
      __$QuestionDtoCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(ignore: true) String? id,
      String chatBotId,
      Map<String, String> translations,
      String createdBy,
      String updatedBy,
      @JsonKey(ignore: true) String? createdAt,
      @JsonKey(ignore: true) String? updatedAt,
      String type,
      bool? multiSelection,
      String? unit,
      double? minVal,
      double? maxVal,
      int? digits,
      int position});
}

/// @nodoc
class __$QuestionDtoCopyWithImpl<$Res> extends _$QuestionDtoCopyWithImpl<$Res>
    implements _$QuestionDtoCopyWith<$Res> {
  __$QuestionDtoCopyWithImpl(
      _QuestionDto _value, $Res Function(_QuestionDto) _then)
      : super(_value, (v) => _then(v as _QuestionDto));

  @override
  _QuestionDto get _value => super._value as _QuestionDto;

  @override
  $Res call({
    Object? id = freezed,
    Object? chatBotId = freezed,
    Object? translations = freezed,
    Object? createdBy = freezed,
    Object? updatedBy = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? type = freezed,
    Object? multiSelection = freezed,
    Object? unit = freezed,
    Object? minVal = freezed,
    Object? maxVal = freezed,
    Object? digits = freezed,
    Object? position = freezed,
  }) {
    return _then(_QuestionDto(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      chatBotId: chatBotId == freezed
          ? _value.chatBotId
          : chatBotId // ignore: cast_nullable_to_non_nullable
              as String,
      translations: translations == freezed
          ? _value.translations
          : translations // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
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
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      multiSelection: multiSelection == freezed
          ? _value.multiSelection
          : multiSelection // ignore: cast_nullable_to_non_nullable
              as bool?,
      unit: unit == freezed
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String?,
      minVal: minVal == freezed
          ? _value.minVal
          : minVal // ignore: cast_nullable_to_non_nullable
              as double?,
      maxVal: maxVal == freezed
          ? _value.maxVal
          : maxVal // ignore: cast_nullable_to_non_nullable
              as double?,
      digits: digits == freezed
          ? _value.digits
          : digits // ignore: cast_nullable_to_non_nullable
              as int?,
      position: position == freezed
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_QuestionDto extends _QuestionDto {
  const _$_QuestionDto(
      {@JsonKey(ignore: true) this.id,
      required this.chatBotId,
      required this.translations,
      required this.createdBy,
      required this.updatedBy,
      @JsonKey(ignore: true) this.createdAt,
      @JsonKey(ignore: true) this.updatedAt,
      required this.type,
      required this.multiSelection,
      required this.unit,
      required this.minVal,
      required this.maxVal,
      required this.digits,
      required this.position})
      : super._();

  factory _$_QuestionDto.fromJson(Map<String, dynamic> json) =>
      _$_$_QuestionDtoFromJson(json);

  @override
  @JsonKey(ignore: true)
  final String? id;
  @override
  final String chatBotId;
  @override
  final Map<String, String> translations;
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
  final String type;
  @override
  final bool? multiSelection;
  @override
  final String? unit;
  @override
  final double? minVal;
  @override
  final double? maxVal;
  @override
  final int? digits;
  @override
  final int position;

  @override
  String toString() {
    return 'QuestionDto(id: $id, chatBotId: $chatBotId, translations: $translations, createdBy: $createdBy, updatedBy: $updatedBy, createdAt: $createdAt, updatedAt: $updatedAt, type: $type, multiSelection: $multiSelection, unit: $unit, minVal: $minVal, maxVal: $maxVal, digits: $digits, position: $position)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _QuestionDto &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.chatBotId, chatBotId) ||
                const DeepCollectionEquality()
                    .equals(other.chatBotId, chatBotId)) &&
            (identical(other.translations, translations) ||
                const DeepCollectionEquality()
                    .equals(other.translations, translations)) &&
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
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.multiSelection, multiSelection) ||
                const DeepCollectionEquality()
                    .equals(other.multiSelection, multiSelection)) &&
            (identical(other.unit, unit) ||
                const DeepCollectionEquality().equals(other.unit, unit)) &&
            (identical(other.minVal, minVal) ||
                const DeepCollectionEquality().equals(other.minVal, minVal)) &&
            (identical(other.maxVal, maxVal) ||
                const DeepCollectionEquality().equals(other.maxVal, maxVal)) &&
            (identical(other.digits, digits) ||
                const DeepCollectionEquality().equals(other.digits, digits)) &&
            (identical(other.position, position) ||
                const DeepCollectionEquality()
                    .equals(other.position, position)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(chatBotId) ^
      const DeepCollectionEquality().hash(translations) ^
      const DeepCollectionEquality().hash(createdBy) ^
      const DeepCollectionEquality().hash(updatedBy) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(multiSelection) ^
      const DeepCollectionEquality().hash(unit) ^
      const DeepCollectionEquality().hash(minVal) ^
      const DeepCollectionEquality().hash(maxVal) ^
      const DeepCollectionEquality().hash(digits) ^
      const DeepCollectionEquality().hash(position);

  @JsonKey(ignore: true)
  @override
  _$QuestionDtoCopyWith<_QuestionDto> get copyWith =>
      __$QuestionDtoCopyWithImpl<_QuestionDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_QuestionDtoToJson(this);
  }
}

abstract class _QuestionDto extends QuestionDto {
  const factory _QuestionDto(
      {@JsonKey(ignore: true) String? id,
      required String chatBotId,
      required Map<String, String> translations,
      required String createdBy,
      required String updatedBy,
      @JsonKey(ignore: true) String? createdAt,
      @JsonKey(ignore: true) String? updatedAt,
      required String type,
      required bool? multiSelection,
      required String? unit,
      required double? minVal,
      required double? maxVal,
      required int? digits,
      required int position}) = _$_QuestionDto;
  const _QuestionDto._() : super._();

  factory _QuestionDto.fromJson(Map<String, dynamic> json) =
      _$_QuestionDto.fromJson;

  @override
  @JsonKey(ignore: true)
  String? get id => throw _privateConstructorUsedError;
  @override
  String get chatBotId => throw _privateConstructorUsedError;
  @override
  Map<String, String> get translations => throw _privateConstructorUsedError;
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
  String get type => throw _privateConstructorUsedError;
  @override
  bool? get multiSelection => throw _privateConstructorUsedError;
  @override
  String? get unit => throw _privateConstructorUsedError;
  @override
  double? get minVal => throw _privateConstructorUsedError;
  @override
  double? get maxVal => throw _privateConstructorUsedError;
  @override
  int? get digits => throw _privateConstructorUsedError;
  @override
  int get position => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$QuestionDtoCopyWith<_QuestionDto> get copyWith =>
      throw _privateConstructorUsedError;
}
