// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:smart_chat/domain/core/value_failure.dart';
import 'package:smart_chat/domain/core/value_object.dart';
import 'package:smart_chat/domain/core/valueobjects/value_validators.dart';

class AnswerOptionBody extends StringValueObject {
  @override
  final Either<ValueFailure, String> value;

  static const int ANSWER_OPTION_BODY_MAX_LENGTH = 15;

  factory AnswerOptionBody(String input) {
    return AnswerOptionBody._(validateNotEmptySingleLineMaxLength(
      input,
      ANSWER_OPTION_BODY_MAX_LENGTH,
    ));
  }

  static AnswerOptionBody genericCreate({String? input}) =>
      input != null ? AnswerOptionBody(input) : AnswerOptionBody.empty();

  factory AnswerOptionBody.empty() => AnswerOptionBody('');

  const AnswerOptionBody._(this.value);
}
