// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:smart_chat/domain/core/value_failure.dart';
import 'package:smart_chat/domain/core/value_object.dart';

class Digits extends ValueObject<int> {
  @override
  final Either<ValueFailure, int> value;

  static const int ALLOWED_NUMBER_OF_DIGITS = 3;

  factory Digits(int input) {
    return Digits._(validateDigits(
      input,
      ALLOWED_NUMBER_OF_DIGITS,
    ));
  }

  factory Digits.empty() => Digits(0);

  const Digits._(this.value);
}

Either<ValueFailure, int> validateDigits(
  int input,
  int allowedNumberOfDigits,
) {
  if (input < 0 || input > allowedNumberOfDigits) {
    return left(const NumberOfDigitsNotAllowed());
  } else {
    return right(input);
  }
}

class NumberOfDigitsNotAllowed extends ValueFailure<String> {
  @override
  final String failureInfo;

  const NumberOfDigitsNotAllowed(
      {this.failureInfo = 'Please choose another number of digits.'});

  @override
  String toString() => failureInfo;
}
