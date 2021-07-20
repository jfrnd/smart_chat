// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:smart_chat/domain/core/valueobjects/time_value.dart';

void main() {
  group('instantiation', () {
    test(
      'should return 01:01:01',
      () {
        // act
        final result = TimeValue(hh: 1, mm: 1, ss: 1);
        // assert
        expect(result.value, equals(const Right('01:01:01')));
      },
    );
    test(
      'should return InvalidTimeValue when hours smaller than 0',
      () {
        // act
        final result = TimeValue(hh: -1, mm: 1, ss: 1);
        // assert
        expect(result.value, equals(const Left(InvalidTimeValue('-1:01:01'))));
      },
    );

    test(
      'should return InvalidTimeValue when seconds greater than 59',
      () {
        // act
        final result = TimeValue(hh: 1, mm: 1, ss: 60);
        // assert
        expect(result.value, equals(const Left(InvalidTimeValue('01:01:60'))));
      },
    );
  });

  group('fromString', () {
    test(
      'should return valid TimeValue Object',
      () {
        // act
        final result = TimeValue.fromString('99:59:59');
        // assert
        expect(result.value, equals(const Right('99:59:59')));
      },
    );
    test(
      'should return InvalidTimeValue when hours are greater than 99',
      () {
        // arrange
        const invalidInput = '100:59:59';
        // act
        final result = TimeValue.fromString(invalidInput);
        // assert
        expect(
            result.value, equals(const Left(InvalidTimeValue(invalidInput))));
      },
    );
    test(
      'should return InvalidTimeValue when minutes are greater than 59',
      () {
        // arrange
        const invalidInput = '10:60:59';
        // act
        final result = TimeValue.fromString(invalidInput);
        // assert
        expect(
            result.value, equals(const Left(InvalidTimeValue(invalidInput))));
      },
    );
    test(
      'should return InvalidTimeValue when : is missing',
      () {
        // arrange
        const invalidInput = '10:59959';
        // act
        final result = TimeValue.fromString(invalidInput);
        // assert
        expect(
            result.value, equals(const Left(InvalidTimeValue(invalidInput))));
      },
    );
  });
  group('toDisplayedString', () {
    test(
      'should return 10:05',
      () {
        // arrange
        final time = TimeValue(hh: 10, mm: 5, ss: 12);
        // act
        final result = time.toDisplayedString(hideSeconds: true);

        // assert
        expect(result, equals('10:05'));
      },
    );
    test(
      'should return 00:30',
      () {
        // arrange
        final time = TimeValue(ss: 30);
        // act
        final result = time.toDisplayedString(hideHours: true);

        // assert
        expect(result, equals('00:30'));
      },
    );
    test(
      'should return 30',
      () {
        // arrange
        final time = TimeValue(mm: 30);
        // act
        final result =
            time.toDisplayedString(hideHours: true, hideSeconds: true);

        // assert
        expect(result, equals('30'));
      },
    );
  });
}
