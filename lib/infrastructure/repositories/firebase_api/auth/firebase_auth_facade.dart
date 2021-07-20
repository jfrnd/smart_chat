// Package imports:
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/core/auth_failure.dart';
import 'package:smart_chat/domain/core/errors.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/user/email_address.dart';
import 'package:smart_chat/domain/entities/user/password.dart';
import 'package:smart_chat/domain/repositories/api/i_auth_facade.dart';

// Project imports:


@LazySingleton(as: IAuthFacade)
class FirebaseAuthFacade implements IAuthFacade {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  FirebaseAuthFacade(
    this._firebaseAuth,
    this._googleSignIn,
  );

  @override
  Future<void> signOut() => Future.wait(
        [
          _googleSignIn.signOut(),
          _firebaseAuth.signOut(),
        ],
      );

  @override
  Future<Either<AuthFailure, UniqueId>> registerWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  }) async {
    final emailAddressStr = emailAddress.getOrCrash();
    final passwordStr = password.getOrCrash();

    try {
      final userId = await _firebaseAuth
          .createUserWithEmailAndPassword(
        email: emailAddressStr,
        password: passwordStr,
      )
          .then((userCredential) {
        return UniqueId.fromUniqueString(userCredential.user!.uid);
      });
      return right(userId);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return left(const AuthFailure.emailAlreadyInUse());
      } else {
        return left(const AuthFailure.serverError());
      }
    }
  }

  @override
  Future<Either<AuthFailure, UniqueId>> signInWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  }) async {
    final emailAddressStr = emailAddress.getOrCrash();
    final passwordStr = password.getOrCrash();

    try {
      final userId = await _firebaseAuth
          .signInWithEmailAndPassword(
        email: emailAddressStr,
        password: passwordStr,
      )
          .then((userCredential) {
        return UniqueId.fromUniqueString(userCredential.user!.uid);
      });
      return right(userId);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password' || e.code == 'user-not-found') {
        return left(const AuthFailure.invalidEmailAndPasswordCombination());
      } else {
        return left(const AuthFailure.serverError());
      }
    }
  }

  @override
  Future<Either<AuthFailure, KtTriple<UniqueId, EmailAddress, bool>>>
      signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return left(const AuthFailure.cancelledByUser());
      }

      final googleAuthentication = await googleUser.authentication;

      final authCredential = GoogleAuthProvider.credential(
        idToken: googleAuthentication.idToken,
        accessToken: googleAuthentication.accessToken,
      );

      final userCredential = await _firebaseAuth
          .signInWithCredential(authCredential)
          .then((userCredential) async {
        return userCredential;
      });
      final isNewUser = userCredential.additionalUserInfo!.isNewUser;
      final userId = UniqueId.fromUniqueString(userCredential.user!.uid);
      final email = EmailAddress(userCredential.user!.email!);
      return right(KtTriple(userId, email, isNewUser));
    } on FirebaseAuthException catch (_) {
      return left(const AuthFailure.serverError());
    }
  }

  @override
  Future<UniqueId> getSignedInUserId() async {
    final firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser == null) throw NotAuthenticatedError();
    final userId = UniqueId.fromUniqueString(firebaseUser.uid);
    return userId;
  }

  @override
  Stream<bool> watchUserState() async* {
    yield* _firebaseAuth.userChanges().map((user) => user != null);
  }
}
