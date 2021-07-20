// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/core/valueobjects/value_failures.dart';
import 'package:smart_chat/domain/core/valueobjects/value_validators.dart';

void main() {
  group('validateMinLength', () {
    test(
      'should return LEFT when input string has not the minimum length',
      () {
        // arrange
        const input = '123';
        const minLength = 4;
        // act
        final result = validateMinLength(input, minLength);
        // assert
        expect(
            result,
            equals(
                Left(TooShortString(listOf(input, input.length, minLength)))));
      },
    );

    test(
      'should return RIGHT when input does not exceed given length',
      () {
        // arrange
        const input = '1234';
        const minLength = 4;
        // act
        final result = validateMinLength(input, minLength);
        // assert
        expect(result, equals(const Right(input)));
      },
    );
  });

  group('validateMaxLength', () {
    test(
      'should return LEFT when input string is shorter than the minimum length',
      () {
        // arrange
        const input = '12345';
        const maxLength = 4;
        // act
        final result = validateMaxLength(input, maxLength);
        // assert
        expect(
            result,
            equals(
                Left(TooLongString(listOf(input, input.length, maxLength)))));
      },
    );

    test(
      'should return RIGHT when input does not exceed given length',
      () {
        // arrange
        const input = '123';
        const maxLength = 4;
        // act
        final result = validateMaxLength(input, maxLength);
        // assert
        expect(result, equals(const Right(input)));
      },
    );
  });

  group('validateFixedLength', () {
    test(
      'should return LEFT when the length of the input does not have the fixed length',
      () {
        // arrange
        const input = 'e';
        const fixedLength = 2;
        // act
        final result = validateFixedLength(input, fixedLength);
        // assert
        expect(
            result,
            equals(Left(InvalidStringLength(
                listOf(input, input.length, fixedLength)))));
      },
    );

    test(
      'should return RIGHT when input has the fixed length',
      () {
        // arrange
        const input = 'en';
        const fixedLength = 2;
        // act
        final result = validateMinLength(input, fixedLength);
        // assert
        expect(result, equals(const Right(input)));
      },
    );
  });

  group('validateStringNotEmpty', () {
    test(
      'should return LEFT when input is empty',
      () {
        // arrange
        const input = '';
        // act
        final result = validateStringNotEmpty(input);
        // assert
        expect(result, equals(const Left(EmptyString())));
      },
    );

    test(
      'should return RIGHT when input is not empty',
      () {
        // arrange
        const input = '1';
        // act
        final result = validateStringNotEmpty(input);
        // assert
        expect(result, equals(const Right(input)));
      },
    );
  });

  group('validateSingleLine', () {
    test(
      'should return LEFT when input is not a single line',
      () {
        // arrange
        const input = 'first line, \n second line';
        // act
        final result = validateSingleLine(input);
        // assert
        expect(result, equals(const Left(MultipleLines())));
      },
    );

    test(
      'should return RIGHT when input is a single line',
      () {
        // arrange
        const input = 'first line, no second line';
        // act
        final result = validateSingleLine(input);
        // assert
        expect(result, equals(const Right(input)));
      },
    );
  });
  group('validateNotEmptySingleLineMaxLength', () {
    const maxLength = 5;
    test(
      'should return LEFT when input is not a single line',
      () {
        // arrange
        const input = '1\n2';
        // act
        final result = validateNotEmptySingleLineMaxLength(input, maxLength);
        // assert
        expect(result, equals(const Left(MultipleLines())));
      },
    );
    test(
      'should return LEFT when input is empty',
      () {
        // arrange
        const input = '';
        // act
        final result = validateNotEmptySingleLineMaxLength(input, maxLength);
        // assert
        expect(result, equals(const Left(EmptyString())));
      },
    );
    test(
      'should return LEFT when input is too long',
      () {
        // arrange
        const input = '123456';
        // act
        final result = validateNotEmptySingleLineMaxLength(input, maxLength);
        // assert
        expect(
            result,
            equals(Left(TooLongString(listOf(
              input,
              input.length,
              maxLength,
            )))));
      },
    );

    test(
      'should return RIGHT when input is valid',
      () {
        // arrange
        const input = '123';
        // act
        final result = validateNotEmptySingleLineMaxLength(input, maxLength);
        // assert
        expect(result, equals(const Right(input)));
      },
    );
  });
}
