// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:smart_chat/domain/core/value_failure.dart';
import 'package:smart_chat/domain/core/value_object.dart';
import 'package:smart_chat/domain/core/valueobjects/value_validators.dart';

class QuestionBody extends StringValueObject {
  @override
  final Either<ValueFailure, String> value;

  static const int QUESTION_BODY_MAX_LENGTH = 80;

  factory QuestionBody(String input) {
    return QuestionBody._(validateQuestionBody(
      input.trim(),
      QUESTION_BODY_MAX_LENGTH,
    ));
  }
  static QuestionBody genericCreate({String? input}) =>
      input != null ? QuestionBody(input) : QuestionBody.empty();

  factory QuestionBody.empty() => QuestionBody('');

  const QuestionBody._(this.value);
}

Either<ValueFailure, String> validateQuestionBody(
  String input,
  int maxLength,
) {
  return validateNotEmptySingleLineMaxLength(input, maxLength).fold(
    (f) => left(f),
    (str) => right(str.appendQuestionMark()),
  );
}

extension QuestionX on String {
  String appendQuestionMark() => endsWith('?') ? this : '$this?';
}
