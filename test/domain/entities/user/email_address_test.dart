// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:smart_chat/domain/entities/user/email_address.dart';

// Project imports:

void main() {
  group('value validators', () {
    test(
      'should return LEFT when invalid email',
      () {
        // arrange
        const invalidInput = 'invalidInput';
        // act
        final result = validateEmailAddress(invalidInput);
        // assert
        expect(result, equals(const Left(InvalidEmail(invalidInput))));
      },
    );

    test(
      'should return RIGHT when valid email',
      () {
        // arrange
        const validInput = 'rightinput@email.de';
        // act
        final result = validateEmailAddress(validInput);
        // assert
        expect(result, const Right(validInput));
      },
    );
  });

  group('instantiation', () {
    test(
      'should instantiate as ValueFailure when input is an invalid email',
      () {
        // arrange
        const invalidInput = 'abc';
        // act
        final failureOrEmail = EmailAddress(invalidInput);
        // assert
        expect(
            failureOrEmail.value, equals(const Left(InvalidEmail(invalidInput))));
      },
    );

    test(
      'should instantiate as valid Email Address when input is a valid email',
      () {
        // arrange
        const validInput = 'rightinput@email.de';
        // act
        final failureOrEmail = EmailAddress(validInput);
        // assert
        expect(failureOrEmail.value, const Right(validInput));
      },
    );
  });
}
