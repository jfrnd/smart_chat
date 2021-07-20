// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'slider_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$SliderStateTearOff {
  const _$SliderStateTearOff();

  _SliderState call(
      {required double value,
      required double minValue,
      required double maxValue,
      required MUnit unit}) {
    return _SliderState(
      value: value,
      minValue: minValue,
      maxValue: maxValue,
      unit: unit,
    );
  }
}

/// @nodoc
const $SliderState = _$SliderStateTearOff();

/// @nodoc
mixin _$SliderState {
  double get value => throw _privateConstructorUsedError;
  double get minValue => throw _privateConstructorUsedError;
  double get maxValue => throw _privateConstructorUsedError;
  MUnit get unit => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SliderStateCopyWith<SliderState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SliderStateCopyWith<$Res> {
  factory $SliderStateCopyWith(
          SliderState value, $Res Function(SliderState) then) =
      _$SliderStateCopyWithImpl<$Res>;
  $Res call({double value, double minValue, double maxValue, MUnit unit});

  $MUnitCopyWith<$Res> get unit;
}

/// @nodoc
class _$SliderStateCopyWithImpl<$Res> implements $SliderStateCopyWith<$Res> {
  _$SliderStateCopyWithImpl(this._value, this._then);

  final SliderState _value;
  // ignore: unused_field
  final $Res Function(SliderState) _then;

  @override
  $Res call({
    Object? value = freezed,
    Object? minValue = freezed,
    Object? maxValue = freezed,
    Object? unit = freezed,
  }) {
    return _then(_value.copyWith(
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      minValue: minValue == freezed
          ? _value.minValue
          : minValue // ignore: cast_nullable_to_non_nullable
              as double,
      maxValue: maxValue == freezed
          ? _value.maxValue
          : maxValue // ignore: cast_nullable_to_non_nullable
              as double,
      unit: unit == freezed
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as MUnit,
    ));
  }

  @override
  $MUnitCopyWith<$Res> get unit {
    return $MUnitCopyWith<$Res>(_value.unit, (value) {
      return _then(_value.copyWith(unit: value));
    });
  }
}

/// @nodoc
abstract class _$SliderStateCopyWith<$Res>
    implements $SliderStateCopyWith<$Res> {
  factory _$SliderStateCopyWith(
          _SliderState value, $Res Function(_SliderState) then) =
      __$SliderStateCopyWithImpl<$Res>;
  @override
  $Res call({double value, double minValue, double maxValue, MUnit unit});

  @override
  $MUnitCopyWith<$Res> get unit;
}

/// @nodoc
class __$SliderStateCopyWithImpl<$Res> extends _$SliderStateCopyWithImpl<$Res>
    implements _$SliderStateCopyWith<$Res> {
  __$SliderStateCopyWithImpl(
      _SliderState _value, $Res Function(_SliderState) _then)
      : super(_value, (v) => _then(v as _SliderState));

  @override
  _SliderState get _value => super._value as _SliderState;

  @override
  $Res call({
    Object? value = freezed,
    Object? minValue = freezed,
    Object? maxValue = freezed,
    Object? unit = freezed,
  }) {
    return _then(_SliderState(
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      minValue: minValue == freezed
          ? _value.minValue
          : minValue // ignore: cast_nullable_to_non_nullable
              as double,
      maxValue: maxValue == freezed
          ? _value.maxValue
          : maxValue // ignore: cast_nullable_to_non_nullable
              as double,
      unit: unit == freezed
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as MUnit,
    ));
  }
}

/// @nodoc

class _$_SliderState implements _SliderState {
  const _$_SliderState(
      {required this.value,
      required this.minValue,
      required this.maxValue,
      required this.unit});

  @override
  final double value;
  @override
  final double minValue;
  @override
  final double maxValue;
  @override
  final MUnit unit;

  @override
  String toString() {
    return 'SliderState(value: $value, minValue: $minValue, maxValue: $maxValue, unit: $unit)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SliderState &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)) &&
            (identical(other.minValue, minValue) ||
                const DeepCollectionEquality()
                    .equals(other.minValue, minValue)) &&
            (identical(other.maxValue, maxValue) ||
                const DeepCollectionEquality()
                    .equals(other.maxValue, maxValue)) &&
            (identical(other.unit, unit) ||
                const DeepCollectionEquality().equals(other.unit, unit)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(value) ^
      const DeepCollectionEquality().hash(minValue) ^
      const DeepCollectionEquality().hash(maxValue) ^
      const DeepCollectionEquality().hash(unit);

  @JsonKey(ignore: true)
  @override
  _$SliderStateCopyWith<_SliderState> get copyWith =>
      __$SliderStateCopyWithImpl<_SliderState>(this, _$identity);
}

abstract class _SliderState implements SliderState {
  const factory _SliderState(
      {required double value,
      required double minValue,
      required double maxValue,
      required MUnit unit}) = _$_SliderState;

  @override
  double get value => throw _privateConstructorUsedError;
  @override
  double get minValue => throw _privateConstructorUsedError;
  @override
  double get maxValue => throw _privateConstructorUsedError;
  @override
  MUnit get unit => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$SliderStateCopyWith<_SliderState> get copyWith =>
      throw _privateConstructorUsedError;
}
