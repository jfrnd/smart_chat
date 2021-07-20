// Package imports:
import 'package:dartz/dartz.dart';
import 'package:uuid/uuid.dart';

// Project imports:
import 'package:smart_chat/domain/core/value_failure.dart';
import 'package:smart_chat/domain/core/value_object.dart';

// Project imports:

class UniqueId extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory UniqueId() {
    return UniqueId._(
      right(const Uuid().v1()),
    );
  }

  factory UniqueId.fromUniqueString(String uniqueId) {
    return UniqueId._(
      right(uniqueId),
    );
  }

  factory UniqueId.dummy() => UniqueId.fromUniqueString('dummy');

  factory UniqueId.fromCurrentTime() {
    return UniqueId._(
      right(DateTime.now().toIso8601String()),
    );
  }

  const UniqueId._(this.value);
}
