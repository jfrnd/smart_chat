// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:smart_chat/domain/core/valueobjects/numeric_value.dart';

void main() {
  group('instantiation', () {
    test(
      'should return valid rounded NumericValue',
      () {
        // arrange
        const input = 1.123;
        // act
        final result = NumericValue(input);
        // assert
        expect(
            result.value,
            equals(Right(double.parse(input
                .toStringAsFixed(NumericValue.NUMERIC_VALUE_DECIMAL_PLACES)))));
      },
    );
    test(
      'should return ExceededMaxNumericValue',
      () {
        // arrange
        final invalidValue = NumericValue.NUMERIC_VALUE_MAX_VALUE + 1.0;
        // act
        final result = NumericValue(invalidValue);
        // assert
        expect(result.value,
            equals(Left(ExceededMaxNumericValue(invalidValue.toString()))));
      },
    );
    test(
      'should return ExceededMinNumericValue',
      () {
        // arrange
        final invalidValue = NumericValue.NUMERIC_VALUE_MIN_VALUE - 1.0;
        // act
        final result = NumericValue(invalidValue);
        // assert
        expect(result.value,
            equals(Left(ExceededMinNumericValue(invalidValue.toString()))));
      },
    );
  });
}
