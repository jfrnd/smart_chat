// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:smart_chat/domain/core/value_failure.dart';
import 'package:smart_chat/domain/core/value_object.dart';

class EmailAddress extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory EmailAddress(String input) {
    return EmailAddress._(
      validateEmailAddress(input),
    );
  }

  factory EmailAddress.empty() => EmailAddress('');

  const EmailAddress._(this.value);
}

Either<ValueFailure<String>, String> validateEmailAddress(String input) {
  const emailRegex =
      r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
  if (RegExp(emailRegex).hasMatch(input)) {
    return Right(input);
  } else {
    return Left(InvalidEmail(input));
  }
}

class InvalidEmail extends ValueFailure<String> {
  @override
  final String failureInfo;

  const InvalidEmail(this.failureInfo);

  @override
  String toString() => 'Invalid Email: $failureInfo';
}
