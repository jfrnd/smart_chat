// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:smart_chat/domain/core/value_failure.dart';
import 'package:smart_chat/domain/core/value_object.dart';
import 'package:smart_chat/domain/core/valueobjects/m_unit.dart';
import 'package:smart_chat/domain/entities/answer_item/answer_item_value.dart';

class NumericValue extends ValueObject<double> {
  @override
  final Either<ValueFailure, double> value;

  static const double NUMERIC_VALUE_MAX_VALUE = 9999999999.9;
  static const double NUMERIC_VALUE_MIN_VALUE = -9999999999.9;
  static const int NUMERIC_VALUE_DECIMAL_PLACES = 3;

  factory NumericValue(double value) {
    return NumericValue._(_validateInput(
      input: value,
    ));
  }

  factory NumericValue.fromString(String input) {
    final value = double.parse(input);
    return NumericValue._(_validateInput(input: value));
  }

  factory NumericValue.fromDouble(double input) {
    return NumericValue._(_validateInput(input: input));
  }

  factory NumericValue.fromItemValue(AnswerItemValue input) {
    return NumericValue.fromString(input.getOrCrash());
  }

  factory NumericValue.empty() {
    return const NumericValue._(Right(0.0));
  }

  String toDisplayedString(MUnit unit, int digits) {
    if (unit is NoUnit) {
      return getOrCrash().toStringAsFixed(digits);
    } else {
      return '${getOrCrash().toStringAsFixed(digits)} ${unit.asString()}';
    }
  }

  const NumericValue._(this.value);

  static Either<ValueFailure<String>, double> _validateInput(
      {required double input}) {
    if (input > NumericValue.NUMERIC_VALUE_MAX_VALUE) {
      return Left(ExceededMaxNumericValue(input.toString()));
    }
    if (input < NumericValue.NUMERIC_VALUE_MIN_VALUE) {
      return Left(ExceededMinNumericValue(input.toString()));
    }
    return Right(double.parse(
      input.toStringAsFixed(NumericValue.NUMERIC_VALUE_DECIMAL_PLACES),
    ));
  }
}

class ExceededMaxNumericValue extends ValueFailure<String> {
  @override
  final String failureInfo;

  const ExceededMaxNumericValue(this.failureInfo);

  @override
  String toString() => '$failureInfo is too high.';
}

class ExceededMinNumericValue extends ValueFailure<String> {
  @override
  final String failureInfo;

  const ExceededMinNumericValue(this.failureInfo);

  @override
  String toString() => '$failureInfo is too little.';
}
