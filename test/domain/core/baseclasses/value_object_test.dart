// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';

// Project imports:
import 'package:smart_chat/domain/core/errors.dart';
import 'package:smart_chat/domain/entities/user/email_address.dart';

void main() {
  group('getOrCrash', () {
    test(
      'should crash (throw an exception) when trying to get value but is ValueFailure',
      () {
        // arrange
        const wrongInput = 'abc';
        final valueFailure = EmailAddress(wrongInput);
        // act
        final call = valueFailure.getOrCrash;
        // assert
        expect(
            () => call(), throwsA(const TypeMatcher<UnexpectedValueError>()));
      },
    );
    test(
      'should return value when trying to get value and value is valid',
      () {
        // arrange
        const rightInput = 'abc@ab.de';
        final valueFailure = EmailAddress(rightInput);
        // act
        final result = valueFailure.getOrCrash();
        expect(result, equals(rightInput));
        // assert
      },
    );
  });
  group('getFailureOrCrash', () {
    test(
      'should return value when trying to get ValueFailure and has ValueFailure',
      () {
        // arrange
        const wrongInput = 'abc';
        final valueFailure = EmailAddress(wrongInput);
        // act
        final result = valueFailure.getFailureOrCrash();
        expect(result, equals(const InvalidEmail(wrongInput)));
        // assert
      },
    );
    test(
      'should crash (throw an exception) when trying to get ValueFailure but has value',
      () {
        // arrange
        const rightInput = 'abc@ab.de';
        final valueFailure = EmailAddress(rightInput);
        // act
        final call = valueFailure.getFailureOrCrash;
        // assert
        expect(() => call(), throwsA(const TypeMatcher<UnexpectedError>()));
      },
    );
  });
  group('getFailureOrUnit', () {
    test(
      'should return ValueFailure when trying to get failure',
      () {
        // arrange
        const wrongInput = 'abc';
        final valueFailure = EmailAddress(wrongInput);
        // act
        final result = valueFailure.getFailureOrUnit();
        // assert
        expect(result, equals(const Left(InvalidEmail(wrongInput))));
      },
    );
    test(
      'should return Unit when trying to get failure but there is not failure',
      () {
        // arrange
        const rightInput = 'abc@abc.de';
        final valueFailure = EmailAddress(rightInput);
        // act
        final result = valueFailure.getFailureOrUnit();
        // assert
        expect(result, equals(const Right(unit)));
      },
    );
  });
}
