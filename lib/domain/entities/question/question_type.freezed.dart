// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'question_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$QuestionTypeTearOff {
  const _$QuestionTypeTearOff();

  YesNo yesNo() {
    return const YesNo();
  }

  Numeric numeric() {
    return const Numeric();
  }

  Time time() {
    return const Time();
  }

  MultipleChoice multipleChoice() {
    return const MultipleChoice();
  }

  Open open() {
    return const Open();
  }
}

/// @nodoc
const $QuestionType = _$QuestionTypeTearOff();

/// @nodoc
mixin _$QuestionType {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() yesNo,
    required TResult Function() numeric,
    required TResult Function() time,
    required TResult Function() multipleChoice,
    required TResult Function() open,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? yesNo,
    TResult Function()? numeric,
    TResult Function()? time,
    TResult Function()? multipleChoice,
    TResult Function()? open,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(YesNo value) yesNo,
    required TResult Function(Numeric value) numeric,
    required TResult Function(Time value) time,
    required TResult Function(MultipleChoice value) multipleChoice,
    required TResult Function(Open value) open,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(YesNo value)? yesNo,
    TResult Function(Numeric value)? numeric,
    TResult Function(Time value)? time,
    TResult Function(MultipleChoice value)? multipleChoice,
    TResult Function(Open value)? open,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestionTypeCopyWith<$Res> {
  factory $QuestionTypeCopyWith(
          QuestionType value, $Res Function(QuestionType) then) =
      _$QuestionTypeCopyWithImpl<$Res>;
}

/// @nodoc
class _$QuestionTypeCopyWithImpl<$Res> implements $QuestionTypeCopyWith<$Res> {
  _$QuestionTypeCopyWithImpl(this._value, this._then);

  final QuestionType _value;
  // ignore: unused_field
  final $Res Function(QuestionType) _then;
}

/// @nodoc
abstract class $YesNoCopyWith<$Res> {
  factory $YesNoCopyWith(YesNo value, $Res Function(YesNo) then) =
      _$YesNoCopyWithImpl<$Res>;
}

/// @nodoc
class _$YesNoCopyWithImpl<$Res> extends _$QuestionTypeCopyWithImpl<$Res>
    implements $YesNoCopyWith<$Res> {
  _$YesNoCopyWithImpl(YesNo _value, $Res Function(YesNo) _then)
      : super(_value, (v) => _then(v as YesNo));

  @override
  YesNo get _value => super._value as YesNo;
}

/// @nodoc

class _$YesNo implements YesNo {
  const _$YesNo();

  @override
  String toString() {
    return 'QuestionType.yesNo()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is YesNo);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() yesNo,
    required TResult Function() numeric,
    required TResult Function() time,
    required TResult Function() multipleChoice,
    required TResult Function() open,
  }) {
    return yesNo();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? yesNo,
    TResult Function()? numeric,
    TResult Function()? time,
    TResult Function()? multipleChoice,
    TResult Function()? open,
    required TResult orElse(),
  }) {
    if (yesNo != null) {
      return yesNo();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(YesNo value) yesNo,
    required TResult Function(Numeric value) numeric,
    required TResult Function(Time value) time,
    required TResult Function(MultipleChoice value) multipleChoice,
    required TResult Function(Open value) open,
  }) {
    return yesNo(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(YesNo value)? yesNo,
    TResult Function(Numeric value)? numeric,
    TResult Function(Time value)? time,
    TResult Function(MultipleChoice value)? multipleChoice,
    TResult Function(Open value)? open,
    required TResult orElse(),
  }) {
    if (yesNo != null) {
      return yesNo(this);
    }
    return orElse();
  }
}

abstract class YesNo implements QuestionType {
  const factory YesNo() = _$YesNo;
}

/// @nodoc
abstract class $NumericCopyWith<$Res> {
  factory $NumericCopyWith(Numeric value, $Res Function(Numeric) then) =
      _$NumericCopyWithImpl<$Res>;
}

/// @nodoc
class _$NumericCopyWithImpl<$Res> extends _$QuestionTypeCopyWithImpl<$Res>
    implements $NumericCopyWith<$Res> {
  _$NumericCopyWithImpl(Numeric _value, $Res Function(Numeric) _then)
      : super(_value, (v) => _then(v as Numeric));

  @override
  Numeric get _value => super._value as Numeric;
}

/// @nodoc

class _$Numeric implements Numeric {
  const _$Numeric();

  @override
  String toString() {
    return 'QuestionType.numeric()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is Numeric);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() yesNo,
    required TResult Function() numeric,
    required TResult Function() time,
    required TResult Function() multipleChoice,
    required TResult Function() open,
  }) {
    return numeric();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? yesNo,
    TResult Function()? numeric,
    TResult Function()? time,
    TResult Function()? multipleChoice,
    TResult Function()? open,
    required TResult orElse(),
  }) {
    if (numeric != null) {
      return numeric();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(YesNo value) yesNo,
    required TResult Function(Numeric value) numeric,
    required TResult Function(Time value) time,
    required TResult Function(MultipleChoice value) multipleChoice,
    required TResult Function(Open value) open,
  }) {
    return numeric(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(YesNo value)? yesNo,
    TResult Function(Numeric value)? numeric,
    TResult Function(Time value)? time,
    TResult Function(MultipleChoice value)? multipleChoice,
    TResult Function(Open value)? open,
    required TResult orElse(),
  }) {
    if (numeric != null) {
      return numeric(this);
    }
    return orElse();
  }
}

abstract class Numeric implements QuestionType {
  const factory Numeric() = _$Numeric;
}

/// @nodoc
abstract class $TimeCopyWith<$Res> {
  factory $TimeCopyWith(Time value, $Res Function(Time) then) =
      _$TimeCopyWithImpl<$Res>;
}

/// @nodoc
class _$TimeCopyWithImpl<$Res> extends _$QuestionTypeCopyWithImpl<$Res>
    implements $TimeCopyWith<$Res> {
  _$TimeCopyWithImpl(Time _value, $Res Function(Time) _then)
      : super(_value, (v) => _then(v as Time));

  @override
  Time get _value => super._value as Time;
}

/// @nodoc

class _$Time implements Time {
  const _$Time();

  @override
  String toString() {
    return 'QuestionType.time()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is Time);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() yesNo,
    required TResult Function() numeric,
    required TResult Function() time,
    required TResult Function() multipleChoice,
    required TResult Function() open,
  }) {
    return time();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? yesNo,
    TResult Function()? numeric,
    TResult Function()? time,
    TResult Function()? multipleChoice,
    TResult Function()? open,
    required TResult orElse(),
  }) {
    if (time != null) {
      return time();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(YesNo value) yesNo,
    required TResult Function(Numeric value) numeric,
    required TResult Function(Time value) time,
    required TResult Function(MultipleChoice value) multipleChoice,
    required TResult Function(Open value) open,
  }) {
    return time(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(YesNo value)? yesNo,
    TResult Function(Numeric value)? numeric,
    TResult Function(Time value)? time,
    TResult Function(MultipleChoice value)? multipleChoice,
    TResult Function(Open value)? open,
    required TResult orElse(),
  }) {
    if (time != null) {
      return time(this);
    }
    return orElse();
  }
}

abstract class Time implements QuestionType {
  const factory Time() = _$Time;
}

/// @nodoc
abstract class $MultipleChoiceCopyWith<$Res> {
  factory $MultipleChoiceCopyWith(
          MultipleChoice value, $Res Function(MultipleChoice) then) =
      _$MultipleChoiceCopyWithImpl<$Res>;
}

/// @nodoc
class _$MultipleChoiceCopyWithImpl<$Res>
    extends _$QuestionTypeCopyWithImpl<$Res>
    implements $MultipleChoiceCopyWith<$Res> {
  _$MultipleChoiceCopyWithImpl(
      MultipleChoice _value, $Res Function(MultipleChoice) _then)
      : super(_value, (v) => _then(v as MultipleChoice));

  @override
  MultipleChoice get _value => super._value as MultipleChoice;
}

/// @nodoc

class _$MultipleChoice implements MultipleChoice {
  const _$MultipleChoice();

  @override
  String toString() {
    return 'QuestionType.multipleChoice()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is MultipleChoice);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() yesNo,
    required TResult Function() numeric,
    required TResult Function() time,
    required TResult Function() multipleChoice,
    required TResult Function() open,
  }) {
    return multipleChoice();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? yesNo,
    TResult Function()? numeric,
    TResult Function()? time,
    TResult Function()? multipleChoice,
    TResult Function()? open,
    required TResult orElse(),
  }) {
    if (multipleChoice != null) {
      return multipleChoice();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(YesNo value) yesNo,
    required TResult Function(Numeric value) numeric,
    required TResult Function(Time value) time,
    required TResult Function(MultipleChoice value) multipleChoice,
    required TResult Function(Open value) open,
  }) {
    return multipleChoice(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(YesNo value)? yesNo,
    TResult Function(Numeric value)? numeric,
    TResult Function(Time value)? time,
    TResult Function(MultipleChoice value)? multipleChoice,
    TResult Function(Open value)? open,
    required TResult orElse(),
  }) {
    if (multipleChoice != null) {
      return multipleChoice(this);
    }
    return orElse();
  }
}

abstract class MultipleChoice implements QuestionType {
  const factory MultipleChoice() = _$MultipleChoice;
}

/// @nodoc
abstract class $OpenCopyWith<$Res> {
  factory $OpenCopyWith(Open value, $Res Function(Open) then) =
      _$OpenCopyWithImpl<$Res>;
}

/// @nodoc
class _$OpenCopyWithImpl<$Res> extends _$QuestionTypeCopyWithImpl<$Res>
    implements $OpenCopyWith<$Res> {
  _$OpenCopyWithImpl(Open _value, $Res Function(Open) _then)
      : super(_value, (v) => _then(v as Open));

  @override
  Open get _value => super._value as Open;
}

/// @nodoc

class _$Open implements Open {
  const _$Open();

  @override
  String toString() {
    return 'QuestionType.open()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is Open);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() yesNo,
    required TResult Function() numeric,
    required TResult Function() time,
    required TResult Function() multipleChoice,
    required TResult Function() open,
  }) {
    return open();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? yesNo,
    TResult Function()? numeric,
    TResult Function()? time,
    TResult Function()? multipleChoice,
    TResult Function()? open,
    required TResult orElse(),
  }) {
    if (open != null) {
      return open();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(YesNo value) yesNo,
    required TResult Function(Numeric value) numeric,
    required TResult Function(Time value) time,
    required TResult Function(MultipleChoice value) multipleChoice,
    required TResult Function(Open value) open,
  }) {
    return open(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(YesNo value)? yesNo,
    TResult Function(Numeric value)? numeric,
    TResult Function(Time value)? time,
    TResult Function(MultipleChoice value)? multipleChoice,
    TResult Function(Open value)? open,
    required TResult orElse(),
  }) {
    if (open != null) {
      return open(this);
    }
    return orElse();
  }
}

abstract class Open implements QuestionType {
  const factory Open() = _$Open;
}
