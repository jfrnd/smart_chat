// Package imports:
import 'package:dartz/dartz.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/core/auth_failure.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/user/email_address.dart';
import 'package:smart_chat/domain/entities/user/password.dart';

abstract class IAuthFacade {
  Future<UniqueId> getSignedInUserId();

  Stream<bool> watchUserState();

  Future<Either<AuthFailure, UniqueId>> registerWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  });

  Future<Either<AuthFailure, UniqueId>> signInWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  });

  Future<Either<AuthFailure, KtTriple<UniqueId, EmailAddress, bool>>>
      signInWithGoogle();

  Future<void> signOut();
}
