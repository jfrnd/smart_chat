// Package imports:
import 'package:dartz/dartz.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/core/value_failure.dart';
import 'package:smart_chat/domain/core/value_object.dart';

const MONDAY = 'monday';
const TUESDAY = 'tuesday';
const WEDNESDAY = 'wednesday';
const THURSDAY = 'thursday';
const FRIDAY = 'friday';
const SATURDAY = 'saturday';
const SUNDAY = 'sunday';
const DAILY = 'daily';

const dateRegex =
    r"""^(19|20)\d\d[- /.](0[1-9]|1[012])[- /.](0[1-9]|[12][0-9]|3[01])$""";

final KtList<String> possibleFrequencies = listOf(
  DAILY,
);

class SubscriptionFrequency extends StringValueObject {
  @override
  final Either<ValueFailure, String> value;

  factory SubscriptionFrequency(String input) {
    return SubscriptionFrequency._(validateSubscriptionFrequency(input));
  }

  factory SubscriptionFrequency.empty() => SubscriptionFrequency('');
  factory SubscriptionFrequency.daily() => SubscriptionFrequency(DAILY);
  factory SubscriptionFrequency.monday() => SubscriptionFrequency(MONDAY);
  factory SubscriptionFrequency.tuesday() => SubscriptionFrequency(TUESDAY);
  factory SubscriptionFrequency.wednesday() => SubscriptionFrequency(WEDNESDAY);
  factory SubscriptionFrequency.thursday() => SubscriptionFrequency(THURSDAY);
  factory SubscriptionFrequency.friday() => SubscriptionFrequency(FRIDAY);
  factory SubscriptionFrequency.saturday() => SubscriptionFrequency(SATURDAY);
  factory SubscriptionFrequency.sunday() => SubscriptionFrequency(SUNDAY);

  SubscriptionFrequency plusOneDay() {
    if (isMonday) return SubscriptionFrequency(TUESDAY);
    if (isTuesday) return SubscriptionFrequency(WEDNESDAY);
    if (isWednesday) return SubscriptionFrequency(THURSDAY);
    if (isThursday) return SubscriptionFrequency(FRIDAY);
    if (isFriday) return SubscriptionFrequency(SATURDAY);
    if (isSaturday) return SubscriptionFrequency(SUNDAY);
    if (isSunday) return SubscriptionFrequency(MONDAY);
    if (isDaily) return SubscriptionFrequency(DAILY);
    if (isFixedDate) {
      final curDatePlusOne = toDateTime().add(const Duration(days: 1));
      return SubscriptionFrequency(curDatePlusOne.toIso8601String().substring(0, 10));
    } else {
      return this;
    }
  }

  SubscriptionFrequency minusOneDay() {
    if (isMonday) return SubscriptionFrequency(SUNDAY);
    if (isTuesday) return SubscriptionFrequency(MONDAY);
    if (isWednesday) return SubscriptionFrequency(TUESDAY);
    if (isThursday) return SubscriptionFrequency(WEDNESDAY);
    if (isFriday) return SubscriptionFrequency(THURSDAY);
    if (isSaturday) return SubscriptionFrequency(FRIDAY);
    if (isSunday) return SubscriptionFrequency(SATURDAY);
    if (isDaily) return SubscriptionFrequency(DAILY);
    if (isFixedDate) {
      final curDateMinusOne = toDateTime().add(const Duration(days: -1));
      return SubscriptionFrequency(
          curDateMinusOne.toIso8601String().substring(0, 10));
    } else {
      return this;
    }
  }

  DateTime toDateTime() {
    final year = getOrCrash().substring(0, 4);
    final month = getOrCrash().substring(5, 7);
    final day = getOrCrash().substring(8, 10);
    return DateTime(
      int.parse(year),
      int.parse(month),
      int.parse(day),
    );
  }

  bool get isFixedDate => value.fold(
        (f) => false,
        (str) => RegExp(dateRegex).hasMatch(str),
      );

  bool get isMonday => value.fold(
        (f) => false,
        (str) => str == MONDAY,
      );
  bool get isTuesday => value.fold(
        (f) => false,
        (str) => str == TUESDAY,
      );
  bool get isWednesday => value.fold(
        (f) => false,
        (str) => str == WEDNESDAY,
      );
  bool get isThursday => value.fold(
        (f) => false,
        (str) => str == THURSDAY,
      );
  bool get isFriday => value.fold(
        (f) => false,
        (str) => str == FRIDAY,
      );
  bool get isSaturday => value.fold(
        (f) => false,
        (str) => str == SATURDAY,
      );
  bool get isSunday => value.fold(
        (f) => false,
        (str) => str == SUNDAY,
      );
  bool get isDaily => value.fold(
        (f) => false,
        (str) => str == DAILY,
      );

  const SubscriptionFrequency._(this.value);
}

Either<ValueFailure, String> validateSubscriptionFrequency(
  String input,
) {
  return validateFrequencySubscription(input).fold(
    (f) => validateDateSubscription(input),
    (str) => right(str),
  );
}

Either<ValueFailure, String> validateFrequencySubscription(
  String input,
) {
  if (possibleFrequencies.contains(input)) {
    return right(input);
  } else {
    return left(InvalidFrequency(input));
  }
}

Either<ValueFailure<String>, String> validateDateSubscription(String input) {
  if (RegExp(dateRegex).hasMatch(input)) {
    return Right(input);
  } else {
    return Left(InvaliDate(input));
  }
}

class InvalidFrequency extends ValueFailure<String> {
  @override
  final String failureInfo;

  const InvalidFrequency(this.failureInfo);

  @override
  String toString() => 'Invalid Frequency: $failureInfo';
}

class InvaliDate extends ValueFailure<String> {
  @override
  final String failureInfo;

  const InvaliDate(this.failureInfo);

  @override
  String toString() => 'Invalid Date: $failureInfo';
}
