// Package imports:
import 'package:dartz/dartz.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/core/errors.dart';
import 'package:smart_chat/domain/core/value_failure.dart';
import 'package:smart_chat/domain/core/value_object.dart';

class SubscriptionTime extends ValueObject<String> {
  @override
  final Either<ValueFailure, String> value;

  factory SubscriptionTime({int hh = 0, int mm = 0}) {
    final hours = hh.toString().padLeft(2, '0');
    final minutes = mm.toString().padLeft(2, '0');
    final timeValue = '$hours:$minutes';
    if (hh < 0 || hh > 23 || mm < 0 || mm > 59) {
      return SubscriptionTime._(Left(InvalidSubscriptionTimeValue(timeValue)));
    } else {
      return SubscriptionTime._(Right(timeValue));
    }
  }

  factory SubscriptionTime.fromString(String input) {
    final hh = int.parse(input.substring(0, 2));
    final mm = int.parse(input.substring(3, 5));
    return SubscriptionTime(hh: hh, mm: mm);
  }

  factory SubscriptionTime.empty() {
    return const SubscriptionTime._(Right('00:00'));
  }

  int get hh => value.fold(
        (failure) => throw UnexpectedValueError(failure),
        (str) => int.parse(str.substring(0, 2)),
      );
  int get mm => value.fold(
        (failure) => throw UnexpectedValueError(failure),
        (str) => int.parse(str.substring(3, 5)),
      );

  const SubscriptionTime._(this.value);
}

class InvalidSubscriptionTimeValue extends ValueFailure<String> {
  @override
  final String failureInfo;

  const InvalidSubscriptionTimeValue(this.failureInfo);

  @override
  String toString() => '$failureInfo is not a valid SubscriptionTimeValue';
}

final possibleTimes = [
  SubscriptionTime(hh: 0),
  SubscriptionTime(hh: 0, mm: 30),
  SubscriptionTime(hh: 1),
  SubscriptionTime(hh: 1, mm: 30),
  SubscriptionTime(hh: 2),
  SubscriptionTime(hh: 2, mm: 30),
  SubscriptionTime(hh: 3),
  SubscriptionTime(hh: 3, mm: 30),
  SubscriptionTime(hh: 4),
  SubscriptionTime(hh: 4, mm: 30),
  SubscriptionTime(hh: 5),
  SubscriptionTime(hh: 5, mm: 30),
  SubscriptionTime(hh: 6),
  SubscriptionTime(hh: 6, mm: 30),
  SubscriptionTime(hh: 7),
  SubscriptionTime(hh: 7, mm: 30),
  SubscriptionTime(hh: 8),
  SubscriptionTime(hh: 8, mm: 30),
  SubscriptionTime(hh: 9),
  SubscriptionTime(hh: 9, mm: 30),
  SubscriptionTime(hh: 10),
  SubscriptionTime(hh: 10, mm: 30),
  SubscriptionTime(hh: 11),
  SubscriptionTime(hh: 11, mm: 30),
  SubscriptionTime(hh: 12),
  SubscriptionTime(hh: 12, mm: 30),
  SubscriptionTime(hh: 13),
  SubscriptionTime(hh: 13, mm: 30),
  SubscriptionTime(hh: 14),
  SubscriptionTime(hh: 14, mm: 30),
  SubscriptionTime(hh: 15),
  SubscriptionTime(hh: 15, mm: 30),
  SubscriptionTime(hh: 16),
  SubscriptionTime(hh: 16, mm: 30),
  SubscriptionTime(hh: 17),
  SubscriptionTime(hh: 17, mm: 30),
  SubscriptionTime(hh: 18),
  SubscriptionTime(hh: 18, mm: 30),
  SubscriptionTime(hh: 19),
  SubscriptionTime(hh: 19, mm: 30),
  SubscriptionTime(hh: 20),
  SubscriptionTime(hh: 20, mm: 30),
  SubscriptionTime(hh: 21),
  SubscriptionTime(hh: 21, mm: 30),
  SubscriptionTime(hh: 22),
  SubscriptionTime(hh: 22, mm: 30),
  SubscriptionTime(hh: 23),
  SubscriptionTime(hh: 23, mm: 30),
];
