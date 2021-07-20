// Project imports:


// Project imports:
import 'value_failure.dart';

class NotAuthenticatedError extends Error {}

class UnexpectedValueError extends Error {
  final ValueFailure valueFailure;

  UnexpectedValueError(this.valueFailure);

  @override
  String toString() {
    const explanation =
        'Encountered a ValueFailure at an unrecoverable point. Terminating.';
    return Error.safeToString('$explanation Failure was: $valueFailure');
  }
}

class UnexpectedError extends Error {
  final String msg;

  UnexpectedError(this.msg);

  @override
  String toString() {
    const explanation =
        'Encountered an Error at an unrecoverable point. Terminating.';
    return Error.safeToString('$explanation Error was: $msg');
  }
}
