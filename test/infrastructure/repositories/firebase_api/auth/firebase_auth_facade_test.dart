// Package imports:
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kt_dart/kt.dart';
import 'package:matcher/matcher.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:smart_chat/domain/core/auth_failure.dart';
import 'package:smart_chat/domain/core/errors.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/user/email_address.dart';
import 'package:smart_chat/infrastructure/repositories/firebase_api/auth/firebase_auth_facade.dart';
import '../../../../fixtures/email_address.dart';
import '../../../../fixtures/password.dart';
import '../../../../fixtures/user.dart';

import 'package:firebase_auth_mocks/firebase_auth_mocks.dart'
    as firebase_auth_mocks;
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart'
    as google_sign_in_mocks;


class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockUserCredential extends Mock implements UserCredential {}

class MockUser extends Mock implements User {}

class MockAdditionalUserInfo extends Mock implements AdditionalUserInfo {}

void main() {
  late FirebaseAuthFacade firebaseAuthFacade;
  late MockFirebaseAuth mockFireBaseAuth;
  late MockGoogleSignIn mockGoogleSignIn;
  late MockUserCredential mockUserCredential;
  late MockUser mockUser;
  late MockAdditionalUserInfo mockAdditionalUserInfo;
  const fakeUserId = "1";

  setUp(() {
    registerFallbackValue<AuthCredential>(
      const AuthCredential(
        providerId: 'providerId',
        signInMethod: 'signInMethod',
      ),
    );

    mockFireBaseAuth = MockFirebaseAuth();
    mockGoogleSignIn = MockGoogleSignIn();
    mockUserCredential = MockUserCredential();
    mockUser = MockUser();
    mockAdditionalUserInfo = MockAdditionalUserInfo();
    firebaseAuthFacade = FirebaseAuthFacade(mockFireBaseAuth, mockGoogleSignIn);

    when(() => mockUserCredential.user).thenReturn(mockUser);
    when(() => mockUserCredential.additionalUserInfo)
        .thenReturn(mockAdditionalUserInfo);
    when(() => mockUser.uid).thenReturn(fakeUserId);
    when(() => mockUser.email).thenReturn("");
  });

  void setUpFireBaseAuthCreateUserWithEmailAndPasswordSuccessful() {
    when(() => mockFireBaseAuth.createUserWithEmailAndPassword(
        email: VALID_EMAIL,
        password: VALID_PASSWORD)).thenAnswer((_) async => mockUserCredential);
  }

  void setUpFireBaseAuthCreateUserWithEmailAndPasswordUnsuccessful() {
    when(() => mockFireBaseAuth.createUserWithEmailAndPassword(
        email: VALID_EMAIL, password: VALID_PASSWORD)).thenAnswer(
      (_) async => throw FirebaseAuthException(code: 'any'),
    );
  }

  void setUpFireBaseAuthSignInWithEmailAndPasswordSuccessful() {
    when(() => mockFireBaseAuth.signInWithEmailAndPassword(
          email: VALID_EMAIL,
          password: VALID_PASSWORD,
        )).thenAnswer((_) async => mockUserCredential);
  }

  void setUpFireBaseAuthSignInWithEmailAndPasswordUnsuccessful() {
    when(() => mockFireBaseAuth.signInWithEmailAndPassword(
              email: VALID_EMAIL,
              password: VALID_PASSWORD,
            ))
        .thenAnswer((_) async =>
            throw FirebaseAuthException(message: 'any', code: 'any'));
  }

  group('signOut()', () {
    test(
      'should call googleSignIn.signOut and firebaseAuth.signOut',
      () async {
        // arrange
        when(() => mockFireBaseAuth.signOut()).thenAnswer((_) async {});
        when(() => mockGoogleSignIn.signOut()).thenAnswer((_) async => null);
        // act
        firebaseAuthFacade.signOut();
        // assert
        verify(() => mockGoogleSignIn.signOut());
        verify(() => mockFireBaseAuth.signOut());
      },
    );
  });
  group('registerWithEmailAndPassword()', () {
    test(
      'should call firebaseAuthFacade.createUserWithEmailAndPassword()',
      () async {
        // arrange
        setUpFireBaseAuthCreateUserWithEmailAndPasswordSuccessful();
        // act
        firebaseAuthFacade.registerWithEmailAndPassword(
          emailAddress: validEmail,
          password: validPassword,
        );
        // assert
        verify(() => mockFireBaseAuth.createUserWithEmailAndPassword(
              email: VALID_EMAIL,
              password: VALID_PASSWORD,
            ));
      },
    );

    test(
      'should return Right(fakeUserId) when registering with valid email and password was successful',
      () async {
        // arrange
        setUpFireBaseAuthCreateUserWithEmailAndPasswordSuccessful();
        // act
        final result = await firebaseAuthFacade.registerWithEmailAndPassword(
          emailAddress: validEmail,
          password: validPassword,
        );
        // assert
        verify(() => mockFireBaseAuth.createUserWithEmailAndPassword(
              email: VALID_EMAIL,
              password: VALID_PASSWORD,
            ));
        expect(result, equals(Right(UniqueId.fromUniqueString(fakeUserId))));
      },
    );

    test(
      'should return Left(AuthFailure) when registering with valid email and password was unsuccessful',
      () async {
        // arrange
        setUpFireBaseAuthCreateUserWithEmailAndPasswordUnsuccessful();
        // act
        final result = await firebaseAuthFacade.registerWithEmailAndPassword(
          emailAddress: validEmail,
          password: validPassword,
        );
        // assert
        verify(() => mockFireBaseAuth.createUserWithEmailAndPassword(
              email: VALID_EMAIL,
              password: VALID_PASSWORD,
            ));
        expect(result, equals(const Left(AuthFailure.serverError())));
      },
    );
  });
  group('signInWithEmailAndPassword()', () {
    test(
      'should call firebaseAuthFacade.signInWithEmailAndPassword()',
      () {
        // arrange
        setUpFireBaseAuthSignInWithEmailAndPasswordSuccessful();
        // act
        firebaseAuthFacade.signInWithEmailAndPassword(
          emailAddress: validEmail,
          password: validPassword,
        );
        // assert
        verify(() => mockFireBaseAuth.signInWithEmailAndPassword(
              email: VALID_EMAIL,
              password: VALID_PASSWORD,
            ));
      },
    );

    test(
      'should return Right(fakeUserId) when signing in with valid email and password was successful',
      () async {
        // arrange
        setUpFireBaseAuthSignInWithEmailAndPasswordSuccessful();
        // act
        final result = await firebaseAuthFacade.signInWithEmailAndPassword(
          emailAddress: validEmail,
          password: validPassword,
        );
        // assert
        verify(() => mockFireBaseAuth.signInWithEmailAndPassword(
              email: VALID_EMAIL,
              password: VALID_PASSWORD,
            ));
        expect(result, equals(Right(UniqueId.fromUniqueString(fakeUserId))));
      },
    );

    test(
      'should return Left(AuthFailure) when signing in with valid email and password was unsuccessful',
      () async {
        // arrange
        setUpFireBaseAuthSignInWithEmailAndPasswordUnsuccessful();
        // act
        final result = await firebaseAuthFacade.signInWithEmailAndPassword(
          emailAddress: validEmail,
          password: validPassword,
        );
        // assert
        verify(() => mockFireBaseAuth.signInWithEmailAndPassword(
              email: VALID_EMAIL,
              password: VALID_PASSWORD,
            ));
        expect(result, equals(const Left(AuthFailure.serverError())));
      },
    );
  });
  group('signInWithGoogle()', () {
    test(
      'should return Left(AuthFailure.cancelledByUser) when user cancels GoogleSignIn',
      () async {
        // arrange
        when(() => mockGoogleSignIn.signIn()).thenAnswer((_) async => null);
        // act
        final result = await firebaseAuthFacade.signInWithGoogle();
        // assert
        verify(() => mockGoogleSignIn.signIn());
        expect(result, equals(const Left(AuthFailure.cancelledByUser())));
      },
    );
    test(
      'should return Left(AuthFailure) when signing in with Google was unsuccessful',
      () async {
        // arrange
        when(() => mockGoogleSignIn.signIn()).thenAnswer((_) async =>
            throw FirebaseAuthException(message: 'any', code: 'any'));
        // act
        final result = await firebaseAuthFacade.signInWithGoogle();
        // assert
        verify(() => mockGoogleSignIn.signIn());
        expect(result, equals(const Left(AuthFailure.serverError())));
      },
    );

    test(
      '''should return Right(KtPair(fakeUserId,true)) 
      when signing in with Google was successful and account is new''',
      () async {
        // arrange
        final googleSignIn = google_sign_in_mocks.MockGoogleSignIn();
        final signInAccount = await googleSignIn.signIn();

        when(() => mockAdditionalUserInfo.isNewUser).thenReturn(true);

        when(() => mockGoogleSignIn.signIn())
            .thenAnswer((_) async => signInAccount);

        when(() => mockFireBaseAuth.signInWithCredential(any()))
            .thenAnswer((_) async => mockUserCredential);

        // act
        final result = await firebaseAuthFacade.signInWithGoogle();
        // assert
        verify(() => mockGoogleSignIn.signIn());
        verify(() => mockFireBaseAuth.signInWithCredential(any()));
        expect(
          result,
          equals(
            Right(
              KtTriple(
                UniqueId.fromUniqueString(
                  fakeUserId,
                ),
                EmailAddress.empty(),
                true,
              ),
            ),
          ),
        );
      },
    );
  });
  group('getSignedInUserId()', () {
    test(
      'should throw NotAuthenticatedError',
      () async {
        // arrange
        when(() => mockFireBaseAuth.currentUser).thenReturn(null);
        // act
        final call = firebaseAuthFacade.getSignedInUserId;
        // assert
        expect(call(), throwsA(const TypeMatcher<NotAuthenticatedError>()));
      },
    );
    test(
      'should return dummyUser id',
      () async {
        // arrange
        final firebaseUser = firebase_auth_mocks.MockUser(
          uid: dummyUserOne.id.getOrCrash(),
          email: dummyUserOne.email.getOrCrash(),
        );
        when(() => mockFireBaseAuth.currentUser).thenReturn(firebaseUser);
        // act
        final result = await firebaseAuthFacade.getSignedInUserId();
        // assert
        verify(() => mockFireBaseAuth.currentUser);
        expect(result, equals(dummyUserOne.id));
      },
    );
  });
  group('watchUserState()', () {
    // test(
    //   'should stream a user',
    //   () async {
    //     // arrange
    //     when(() => mockFireBaseAuth.userChanges)
    //         .thenAnswer((_) => Stream.value(mockUser));
    //     // act
    //     final stream = firebaseAuthFacade.watchUserState();
    //     // assert
    //     expectLater(stream, emits(true));
    //   },
    // );

    // test(
    //   'should stream a user',
    //   () async {
    //     // arrange
    //     when(() => mockFireBaseAuth.userChanges)
    //         .thenAnswer((_) => Stream.value(null));
    //     // act
    //     final stream = firebaseAuthFacade.watchUserState();
    //     // assert
    //     expectLater(stream, emits(false));
    //   },
    // );
  });
}
