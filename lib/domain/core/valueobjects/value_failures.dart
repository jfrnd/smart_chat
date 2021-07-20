// Package imports:
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/core/value_failure.dart';

class TooShortString extends ValueFailure<KtList> {
  // 0: Input
  // 1: Actual length
  // 2: Minimum length
  @override
  final KtList failureInfo;

  const TooShortString(this.failureInfo);

  @override
  String toString() =>
      'ValueFailure: The input "${failureInfo[0]}" is ${failureInfo[1]} characters long but the minimum length is ${failureInfo[2]}.';
}

class TooLongString extends ValueFailure<KtList> {
  // 0: Input
  // 1: Actual length
  // 2: Maximum length
  @override
  final KtList failureInfo;

  const TooLongString(this.failureInfo);

  @override
  String toString() => failureInfo.get(0) as String;

  String toInfoString() =>
      'ValueFailure: The input "${failureInfo[0]}" is ${failureInfo[1]} characters long but the maximum length is ${failureInfo[2]}.';
}

class InvalidStringLength extends ValueFailure<KtList> {
  // 0: Input
  // 1: Actual length
  // 2: Fixed length
  @override
  final KtList failureInfo;

  const InvalidStringLength(this.failureInfo);

  @override
  String toString() =>
      'ValueFailure: The input "${failureInfo[0]}" is ${failureInfo[1]} characters long but has to have a length of ${failureInfo[2]}.';
}

class EmptyString extends ValueFailure<String> {
  @override
  final String failureInfo;

  const EmptyString(
      {this.failureInfo = 'ValueFailure: String must not be an empty String.'});

  @override
  String toString() => failureInfo;
}

class MultipleLines extends ValueFailure<String> {
  @override
  final String failureInfo;

  const MultipleLines({this.failureInfo = 'ValueFailure: String should be a SingleLine String.'});

  @override
  String toString() => failureInfo;
}
