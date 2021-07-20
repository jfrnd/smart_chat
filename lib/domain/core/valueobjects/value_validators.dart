// Package imports:
import 'package:dartz/dartz.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/core/value_failure.dart';
import 'package:smart_chat/domain/core/valueobjects/value_failures.dart';

Either<ValueFailure<KtList>, String> validateMinLength(
  String input,
  int minLength,
) {
  if (input.length < minLength) {
    return Left(TooShortString(listOf(input, input.length, minLength)));
  } else {
    return Right(input);
  }
}

Either<ValueFailure<KtList>, String> validateMaxLength(
  String input,
  int maxLength,
) {
  if (input.length > maxLength) {
    return Left(TooLongString(listOf(input, input.length, maxLength)));
  } else {
    return Right(input);
  }
}

Either<ValueFailure<KtList>, String> validateFixedLength(
  String input,
  int fixedLength,
) {
  if (input.length != fixedLength) {
    return Left(InvalidStringLength(listOf(input, input.length, fixedLength)));
  } else {
    return Right(input);
  }
}

Either<ValueFailure<String>, String> validateStringNotEmpty(String input) {
  if (input.isEmpty) {
    return const Left(EmptyString());
  } else {
    return Right(input);
  }
}

Either<ValueFailure<String>, String> validateSingleLine(String input) {
  if (input.contains('\n')) {
    return const Left(MultipleLines());
  } else {
    return Right(input);
  }
}

Either<ValueFailure, String> validateNotEmptySingleLineMaxLength(
    String input, int maxLength) {
  return validateStringNotEmpty(input).fold(
    (f) => left(f),
    (_) => validateSingleLine(input).fold(
      (f) => left(f),
      (_) => validateMaxLength(input, maxLength).fold(
        (f) => left(f),
        (str) => right(str),
      ),
    ),
  );
}
