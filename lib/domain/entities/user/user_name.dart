// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:smart_chat/domain/core/value_failure.dart';
import 'package:smart_chat/domain/core/value_object.dart';
import 'package:smart_chat/domain/core/valueobjects/value_validators.dart';

class UserName extends StringValueObject {
  @override
  final Either<ValueFailure, String> value;

  static const int USER_NAME_MAX_LENGTH = 40;

  factory UserName(String input) {
    return UserName._(validateNotEmptySingleLineMaxLength(
        input.trim(), USER_NAME_MAX_LENGTH));
  }
  static UserName genericCreate({String? input}) =>
      input != null ? UserName(input) : UserName.empty();

  const UserName._(this.value);

  factory UserName.empty() => UserName('');
}
