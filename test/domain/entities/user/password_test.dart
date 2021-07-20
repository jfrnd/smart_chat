// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/core/valueobjects/value_failures.dart';
import 'package:smart_chat/domain/entities/user/password.dart';

void main() {
  group('instantiation', () {
    test(
      'should instantiate as ValueFailure when input is an invalid password',
      () {
        // arrange
        const invalidInput = '123';

        // act
        final failureOrPassword = Password(invalidInput);
        // assert
        expect(
            failureOrPassword.value,
            equals(Left(TooShortString(
              listOf(
                invalidInput,
                invalidInput.length,
                Password.MIN_LENGTH_PASSWORD,
              ),
            ))));
      },
    );

    test(
      'should instantiate as valid Password Object when input is a valid password',
      () {
        // arrange
        const validInput = '123456789';
        // act
        final failureOrPassword = Password(validInput);
        // assert
        expect(failureOrPassword.value, const Right(validInput));
      },
    );
  });
}
