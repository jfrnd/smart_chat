// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:smart_chat/domain/core/errors.dart';
import 'package:smart_chat/domain/core/value_failure.dart';
import 'package:smart_chat/domain/core/value_object.dart';
import 'package:smart_chat/domain/entities/answer_item/answer_item_value.dart';

class TimeValue extends ValueObject<String> {
  @override
  final Either<ValueFailure, String> value;

  factory TimeValue({int hh = 0, int mm = 0, int ss = 0}) {
    final hours = hh.toString().padLeft(2, '0');
    final minutes = mm.toString().padLeft(2, '0');
    final seconds = ss.toString().padLeft(2, '0');
    final timeValue = '$hours:$minutes:$seconds';
    return TimeValue._(validateInput(timeValue));
  }
  factory TimeValue.fromString(String input) {
    return TimeValue._(validateInput(input));
  }

  factory TimeValue.fromItemValue(AnswerItemValue input) {
    return TimeValue.fromString(input.getOrCrash());
  }

  factory TimeValue.empty() {
    return const TimeValue._(Right('00:00:00'));
  }

  String toDisplayedString({
    bool hideSeconds = false,
    bool hideHours = false,
  }) {
    final time = getOrCrash();
    final hours = hideHours ? '' : time.substring(0, 3);
    final minutes = time.substring(3, 5);
    final seconds = hideSeconds ? '' : time.substring(5, 8);
    return hours + minutes + seconds;
  }

  int get hh => value.fold(
        (failure) => throw UnexpectedValueError(failure),
        (str) => int.parse(str.substring(0, 2)),
      );
  int get mm => value.fold(
        (failure) => throw UnexpectedValueError(failure),
        (str) => int.parse(str.substring(3, 5)),
      );
  int get ss => value.fold(
        (failure) => throw UnexpectedValueError(failure),
        (str) => int.parse(str.substring(6, 8)),
      );

  const TimeValue._(this.value);
}

Either<ValueFailure<String>, String> validateInput(String input) {
  const timeRegex = r"(?:[0-9]\d):(?:[0-5]\d):(?:[0-5]\d)";
  if (input.length == 8 && RegExp(timeRegex).hasMatch(input)) {
    return Right(input);
  } else {
    return Left(InvalidTimeValue(input));
  }
}

class InvalidTimeValue extends ValueFailure<String> {
  @override
  final String failureInfo;

  const InvalidTimeValue(this.failureInfo);

  @override
  String toString() => '$failureInfo is not a valid Time Value';
}
