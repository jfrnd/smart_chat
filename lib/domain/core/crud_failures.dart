// Package imports:
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import 'package:smart_chat/domain/core/errors.dart';

part 'crud_failures.freezed.dart';

@freezed
class CrudFailure with _$CrudFailure {
  const factory CrudFailure.notSignedIn() = NotSignedIn;
  const factory CrudFailure.dataSchemaError() = DataSchemaError;
  const factory CrudFailure.unexpected({String? info}) = Unexpected;
  const factory CrudFailure.imageFailure() = ImageFailure;
  const factory CrudFailure.insufficientPermission() = InsufficientPermission;
  const factory CrudFailure.unableToUpdate({String? info}) = UnableToUpdate;
  const factory CrudFailure.doesNotExist() = DoesNotExist;
  const factory CrudFailure.dataBaseNotSynchonWarning({String? info}) =
      _DataBaseNotSynchonWarnning;
}

CrudFailure convertToCrudFailure(Object e) {
  if (e is FirebaseException && e.message!.contains('PERMISSION_DENIED')) {
    return const CrudFailure.insufficientPermission();
  } else if (e is TypeError ||
      e is StateError &&
          e.message.contains(
              'field does not exist within the DocumentSnapshotPlatform')) {
    return const CrudFailure.dataSchemaError();
  } else if (e is NotAuthenticatedError) {
    return const CrudFailure.notSignedIn();
  } else {
    return CrudFailure.unexpected(info: e.toString());
  }
}
