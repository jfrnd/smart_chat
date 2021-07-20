// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import 'package:smart_chat/domain/core/errors.dart';
import 'package:smart_chat/domain/core/value_failure.dart';
import 'package:smart_chat/domain/core/valueobjects/value_failures.dart';

@immutable
abstract class ValueObject<T> {
  const ValueObject();

  Either<ValueFailure<dynamic>, T> get value;

  T getOrCrash() {
    return value.fold(
      (l) => throw UnexpectedValueError(l),
      (r) => r,
    );
  }

  ValueFailure<dynamic> getFailureOrCrash() {
    return value.fold(
      (f) => f,
      (r) => throw UnexpectedError('Is not a ValueFailure'),
    );
  }

  Either<ValueFailure<dynamic>, Unit> getFailureOrUnit() {
    return value.fold(
      (f) => left(f),
      (r) => right(unit),
    );
  }

  bool isValid() => value.isRight();
  bool isInvalid() => value.isLeft();

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ValueObject<T> && o.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return value.fold((l) => l.toString(), (r) => r.toString());
  }
}

abstract class StringValueObject<T> extends ValueObject<String> {
  const StringValueObject();

  bool get isBlank =>
      value.fold((failure) => failure is EmptyString, (value) => false);
}
