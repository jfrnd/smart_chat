// Flutter imports:
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:another_flushbar/flushbar_helper.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/value_failure.dart';

void showCrudFailureMessage(CrudFailure? failure, BuildContext context) {
  if (failure != null) {
    FlushbarHelper.createError(
      message: failure.map(
        doesNotExist: (_) => 'Document does not exist',
        insufficientPermission: (_) => 'Insufficient permissions ❌',
        unableToUpdate: (_) =>
            "Couldn't update the note. Was it deleted from another device?",
        unexpected: (_) => 'Unexpected error occured, please contact support.',
        imageFailure: (_) => 'ImageFailure?',
        notSignedIn: (_) => 'Not Signed In.',
        dataSchemaError: (_) => 'DataSchemaError',
        dataBaseNotSynchonWarning: (_) =>
            'WARNING: Database not syncrhon anymore. Please contact support.',
      ),
    ).show(context);
  }
}

void showValueFailureMessage(ValueFailure? failure, BuildContext context) {
  if (failure != null) {
    FlushbarHelper.createError(message: failure.toString()).show(context);
  }
}
