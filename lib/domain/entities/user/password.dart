// Package imports:
import 'package:dartz/dartz.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/core/value_failure.dart';
import 'package:smart_chat/domain/core/value_object.dart';
import 'package:smart_chat/domain/core/valueobjects/value_validators.dart';

class Password extends ValueObject<String> {
  @override
  final Either<ValueFailure<KtList>, String> value;

  static const int MIN_LENGTH_PASSWORD = 6;

  factory Password(String input) {
    return Password._(
      validateMinLength(input, MIN_LENGTH_PASSWORD),
    );
  }

  const Password._(this.value);
}
