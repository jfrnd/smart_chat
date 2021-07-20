// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'time_picker_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$TimePickerStateTearOff {
  const _$TimePickerStateTearOff();

  _TimePickerState call({required int hh, required int mm, required int ss}) {
    return _TimePickerState(
      hh: hh,
      mm: mm,
      ss: ss,
    );
  }
}

/// @nodoc
const $TimePickerState = _$TimePickerStateTearOff();

/// @nodoc
mixin _$TimePickerState {
  int get hh => throw _privateConstructorUsedError;
  int get mm => throw _privateConstructorUsedError;
  int get ss => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TimePickerStateCopyWith<TimePickerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimePickerStateCopyWith<$Res> {
  factory $TimePickerStateCopyWith(
          TimePickerState value, $Res Function(TimePickerState) then) =
      _$TimePickerStateCopyWithImpl<$Res>;
  $Res call({int hh, int mm, int ss});
}

/// @nodoc
class _$TimePickerStateCopyWithImpl<$Res>
    implements $TimePickerStateCopyWith<$Res> {
  _$TimePickerStateCopyWithImpl(this._value, this._then);

  final TimePickerState _value;
  // ignore: unused_field
  final $Res Function(TimePickerState) _then;

  @override
  $Res call({
    Object? hh = freezed,
    Object? mm = freezed,
    Object? ss = freezed,
  }) {
    return _then(_value.copyWith(
      hh: hh == freezed
          ? _value.hh
          : hh // ignore: cast_nullable_to_non_nullable
              as int,
      mm: mm == freezed
          ? _value.mm
          : mm // ignore: cast_nullable_to_non_nullable
              as int,
      ss: ss == freezed
          ? _value.ss
          : ss // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$TimePickerStateCopyWith<$Res>
    implements $TimePickerStateCopyWith<$Res> {
  factory _$TimePickerStateCopyWith(
          _TimePickerState value, $Res Function(_TimePickerState) then) =
      __$TimePickerStateCopyWithImpl<$Res>;
  @override
  $Res call({int hh, int mm, int ss});
}

/// @nodoc
class __$TimePickerStateCopyWithImpl<$Res>
    extends _$TimePickerStateCopyWithImpl<$Res>
    implements _$TimePickerStateCopyWith<$Res> {
  __$TimePickerStateCopyWithImpl(
      _TimePickerState _value, $Res Function(_TimePickerState) _then)
      : super(_value, (v) => _then(v as _TimePickerState));

  @override
  _TimePickerState get _value => super._value as _TimePickerState;

  @override
  $Res call({
    Object? hh = freezed,
    Object? mm = freezed,
    Object? ss = freezed,
  }) {
    return _then(_TimePickerState(
      hh: hh == freezed
          ? _value.hh
          : hh // ignore: cast_nullable_to_non_nullable
              as int,
      mm: mm == freezed
          ? _value.mm
          : mm // ignore: cast_nullable_to_non_nullable
              as int,
      ss: ss == freezed
          ? _value.ss
          : ss // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_TimePickerState implements _TimePickerState {
  const _$_TimePickerState(
      {required this.hh, required this.mm, required this.ss});

  @override
  final int hh;
  @override
  final int mm;
  @override
  final int ss;

  @override
  String toString() {
    return 'TimePickerState(hh: $hh, mm: $mm, ss: $ss)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _TimePickerState &&
            (identical(other.hh, hh) ||
                const DeepCollectionEquality().equals(other.hh, hh)) &&
            (identical(other.mm, mm) ||
                const DeepCollectionEquality().equals(other.mm, mm)) &&
            (identical(other.ss, ss) ||
                const DeepCollectionEquality().equals(other.ss, ss)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(hh) ^
      const DeepCollectionEquality().hash(mm) ^
      const DeepCollectionEquality().hash(ss);

  @JsonKey(ignore: true)
  @override
  _$TimePickerStateCopyWith<_TimePickerState> get copyWith =>
      __$TimePickerStateCopyWithImpl<_TimePickerState>(this, _$identity);
}

abstract class _TimePickerState implements TimePickerState {
  const factory _TimePickerState(
      {required int hh, required int mm, required int ss}) = _$_TimePickerState;

  @override
  int get hh => throw _privateConstructorUsedError;
  @override
  int get mm => throw _privateConstructorUsedError;
  @override
  int get ss => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$TimePickerStateCopyWith<_TimePickerState> get copyWith =>
      throw _privateConstructorUsedError;
}
