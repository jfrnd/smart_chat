// Package imports:
import 'package:dartz/dartz.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/core/value_failure.dart';
import 'package:smart_chat/domain/core/value_object.dart';
import 'package:smart_chat/domain/core/valueobjects/language_code.dart';
import 'package:smart_chat/domain/core/valueobjects/numeric_value.dart';
import 'package:smart_chat/domain/core/valueobjects/time_value.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/answer_option/answer_option.dart';
import 'package:smart_chat/domain/entities/question/question_type.dart';

class AnswerItemValue extends StringValueObject {
  @override
  final Either<ValueFailure, String> value;

  factory AnswerItemValue.fromAnswerOptionId(UniqueId answerOptionId) {
    return answerOptionId.value.fold(
      (failure) => AnswerItemValue._(Left(failure)),
      (value) => AnswerItemValue._(Right(value)),
    );
  }

  factory AnswerItemValue.fromNumericValue(NumericValue input) {
    return input.value.fold(
      (failure) => AnswerItemValue._(Left(failure)),
      (value) => AnswerItemValue._(Right(value.toString())),
    );
  }

  factory AnswerItemValue.fromTimeValue(TimeValue input) {
    return input.value.fold(
      (failure) => AnswerItemValue._(Left(failure)),
      (value) => AnswerItemValue._(Right(value.toString())),
    );
  }

  factory AnswerItemValue.fromString(String input) {
    return AnswerItemValue._(Right(input));
  }

  factory AnswerItemValue.empty() {
    return const AnswerItemValue._(Right(''));
  }

  factory AnswerItemValue.yes() {
    return const AnswerItemValue._(Right(YES));
  }
  factory AnswerItemValue.no() {
    return const AnswerItemValue._(Right(NO));
  }

  const AnswerItemValue._(this.value);
}

extension AnswerItemValuesX on KtList<AnswerItemValue> {
  KtList<AnswerOption> convertToAnswerOptions(KtList<AnswerOption> options) {
    return map((it) => UniqueId.fromUniqueString(it.getOrCrash()))
        .map((id) => options.findById(id) ?? AnswerOption.error());
  }

  KtList<AnswerItemValue> filterTextInput(
    String textInput,
    KtList<AnswerOption> answerOptionPool,
    LanguageCode languageCode,
  ) {
    return convertToAnswerOptions(answerOptionPool)
        .filter(
          (it) => it
              .getTranslationAsString(languageCode)
              .toLowerCase()
              .contains(textInput),
        )
        .asAnswerItemBodies(const QuestionType.multipleChoice());
  }
}

extension AnswerItemValueX on AnswerItemValue {
  UniqueId toUniqueId() {
    return UniqueId.fromUniqueString(getOrCrash());
  }

  NumericValue toNumericValue() {
    return NumericValue(double.parse(getOrCrash()));
  }

  TimeValue toTimeValue() {
    return TimeValue.fromString(getOrCrash());
  }
}
