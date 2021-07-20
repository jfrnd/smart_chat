// Package imports:
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kt_dart/kt.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:smart_chat/application/sign_in_form/sign_in_form_bloc.dart';
import 'package:smart_chat/domain/core/auth_failure.dart';
import 'package:smart_chat/domain/core/value_failure.dart';
import 'package:smart_chat/domain/core/valueobjects/value_failures.dart';
import 'package:smart_chat/domain/entities/user/email_address.dart';
import 'package:smart_chat/domain/entities/user/password.dart';
import 'package:smart_chat/domain/repositories/auth/i_auth_repo.dart';
import '../../fixtures/email_address.dart';
import '../../fixtures/password.dart';

class MockIAuthRepo extends Mock implements IAuthRepo {}

void main() {
  late SignInFormBloc bloc;
  late MockIAuthRepo authRepo;

  setUp(() {
    authRepo = MockIAuthRepo();
    bloc = SignInFormBloc(authRepo);
  });

  tearDown(() {
    bloc.close();
  });

  group('initialState()', () {
    test('initialState should contain invalid email', () {
      //arrange
      const expectedValue =
          Left<ValueFailure<String>, String>(InvalidEmail(''));
      //act
      final result = bloc.state.emailAddress.getFailureOrUnit();
      // assert
      expect(result, equals(expectedValue));
    });

    test('initialState should contain invalid password', () {
      //arrange
      final expectedValue = Left(TooShortString(listOf(
        '',
        0,
        Password.MIN_LENGTH_PASSWORD,
      )));
      // act
      final result = bloc.state.password.getFailureOrUnit();
      // assert
      expect(result, equals(expectedValue));
    });

    test('initialState should not show error messages', () {
      // act
      final result = bloc.state.showErrorMessages;
      // assert
      expect(result, equals(false));
    });

    test('initialState should not be isSubmitting', () {
      // act
      final result = bloc.state.isSubmitting;
      // assert
      expect(result, equals(false));
    });

    test('initialState should not contain an auth failure', () {
      // act
      final result = bloc.state.authFailureOrSuccessOption;
      // assert
      expect(result, equals(none()));
    });
  });

  group('emailChanged()', () {
    blocTest(
      '''should emit:
      [authFailureOrSuccessOption: none,
      emailAddress: changed to a]
      ''',
      build: () => bloc,
      act: (_) => bloc.add(const SignInFormEvent.emailChanged('a')),
      expect: () => [
        SignInFormState.initial().copyWith(
            emailAddress: EmailAddress('a'), authFailureOrSuccessOption: none())
      ],
    );
  });

  group('passwordChanged()', () {
    blocTest(
      '''should emit:
      [authFailureOrSuccessOption: none,
      password: changed to a]
      ''',
      build: () => bloc,
      act: (_) => bloc.add(const SignInFormEvent.passwordChanged('a')),
      expect: () => [
        SignInFormState.initial().copyWith(
          password: Password('a'),
          authFailureOrSuccessOption: none(),
        )
      ],
    );
  });

  group('signInWithGooglePressed()', () {
    blocTest(
      '''should emit:
      [isSubmitting, !authFailureOrSuccessOption],
      [!isSubmitting, authFailureOrSuccessOption]
      when signInWithGoogle failed''',
      build: () {
        when(() => authRepo.signInWithGoogle())
            .thenAnswer((_) async => const Left(AuthFailure.serverError()));
        return bloc;
      },
      act: (_) => bloc.add(const SignInFormEvent.signInWithGooglePressed()),
      expect: () => [
        SignInFormState.initial()
            .copyWith(isSubmitting: true, authFailureOrSuccessOption: none()),
        SignInFormState.initial().copyWith(
            isSubmitting: false,
            authFailureOrSuccessOption:
                some(const Left(AuthFailure.serverError())))
      ],
    );
  });

  group('registerWithEmailAndPasswordPressed()', () {
    blocTest(
      '''should emit:
       [!isSubmitting, showErrorMessages]
       when trying to register with wrong credentials''',
      build: () => bloc,
      act: (_) =>
          bloc.add(const SignInFormEvent.registerWithEmailAndPasswordPressed()),
      expect: () => [
        // SignInFormState.initial()
        //     .copyWith(isSubmitting: false, showErrorMessages: true)
        bloc.state.copyWith(isSubmitting: false, showErrorMessages: true)
      ],
    );
    blocTest(
      '''should emit:
      [isSubmitting]
      [!isSubmitting, showErrorMessages, authFailureOption]
      when trying to register with valid Email and Password return server error''',
      build: () {
        when(
          () => authRepo.registerWithEmailAndPassword(
            emailAddress: validEmail,
            password: validPassword,
          ),
        ).thenAnswer((_) async => const Left(AuthFailure.serverError()));
        return bloc;
      },
      act: (_) {
        bloc.add(const SignInFormEvent.emailChanged(VALID_EMAIL));
        bloc.add(const SignInFormEvent.passwordChanged(VALID_PASSWORD));
        bloc.add(const SignInFormEvent.registerWithEmailAndPasswordPressed());
      },
      expect: () => [
        SignInFormState.initial().copyWith(
          emailAddress: validEmail,
        ),
        SignInFormState.initial().copyWith(
          emailAddress: validEmail,
          password: validPassword,
        ),
        SignInFormState.initial().copyWith(
            emailAddress: validEmail,
            password: validPassword,
            isSubmitting: true),
        SignInFormState.initial().copyWith(
            emailAddress: validEmail,
            password: validPassword,
            isSubmitting: false,
            showErrorMessages: true,
            authFailureOrSuccessOption:
                optionOf(const Left(AuthFailure.serverError()))),
      ],
    );
    blocTest(
      '''should emit:
      [isSubmitting]
      [!isSubmitting, showErrorMessages, authSuccessOption]
      when trying to register with valid Email and Password is successful''',
      build: () {
        when(
          () => authRepo.registerWithEmailAndPassword(
            emailAddress: validEmail,
            password: validPassword,
          ),
        ).thenAnswer((_) async => const Right(unit));
        return bloc;
      },
      act: (_) {
        bloc.add(const SignInFormEvent.emailChanged(VALID_EMAIL));
        bloc.add(const SignInFormEvent.passwordChanged(VALID_PASSWORD));
        bloc.add(const SignInFormEvent.registerWithEmailAndPasswordPressed());
      },
      expect: () => [
        SignInFormState.initial().copyWith(
          emailAddress: validEmail,
        ),
        SignInFormState.initial()
            .copyWith(emailAddress: validEmail, password: validPassword),
        SignInFormState.initial().copyWith(
            emailAddress: validEmail,
            password: validPassword,
            isSubmitting: true),
        SignInFormState.initial().copyWith(
          emailAddress: validEmail,
          password: validPassword,
          isSubmitting: false,
          showErrorMessages: true,
          authFailureOrSuccessOption: optionOf(const Right(unit)),
        ),
      ],
    );
  });

  group('signInWithEmailAndPasswordPressed()', () {
    blocTest(
        'should emit state [!isSubmitting, showErrorMessages] when trying to sign in with wrong credentials',
        build: () => bloc,
        act: (_) =>
            bloc.add(const SignInFormEvent.signInWithEmailAndPasswordPressed()),
        expect: () => [
              SignInFormState.initial().copyWith(
                isSubmitting: false,
                showErrorMessages: true,
              )
            ]);
    blocTest(
      '''should emit:
      [isSubmitting]
      [!isSubmitting, showErrorMessages, authFailureOption]
      when trying to sign in with valid Email and Password was unsuccessful''',
      build: () {
        when(() => authRepo.signInWithEmailAndPassword(
              emailAddress: validEmail,
              password: validPassword,
            )).thenAnswer((_) async => const Left(AuthFailure.serverError()));
        return bloc;
      },
      act: (_) {
        bloc.add(const SignInFormEvent.emailChanged(VALID_EMAIL));
        bloc.add(const SignInFormEvent.passwordChanged(VALID_PASSWORD));
        bloc.add(const SignInFormEvent.signInWithEmailAndPasswordPressed());
      },
      expect: () => [
        SignInFormState.initial().copyWith(
          emailAddress: validEmail,
        ),
        SignInFormState.initial()
            .copyWith(emailAddress: validEmail, password: validPassword),
        SignInFormState.initial().copyWith(
            emailAddress: validEmail,
            password: validPassword,
            isSubmitting: true),
        SignInFormState.initial().copyWith(
          emailAddress: validEmail,
          password: validPassword,
          isSubmitting: false,
          showErrorMessages: true,
          authFailureOrSuccessOption:
              optionOf(const Left(AuthFailure.serverError())),
        ),
      ],
    );

    blocTest(
      '''should emit:
      [isSubmitting]
      [!isSubmitting, showErrorMessages, authSuccessOption]
      when signing in with Email and Password was successful''',
      build: () {
        when(() => authRepo.signInWithEmailAndPassword(
              emailAddress: validEmail,
              password: validPassword,
            )).thenAnswer((_) async => const Right(unit));
        return bloc;
      },
      act: (_) {
        bloc.add(const SignInFormEvent.emailChanged(VALID_EMAIL));
        bloc.add(const SignInFormEvent.passwordChanged(VALID_PASSWORD));
        bloc.add(const SignInFormEvent.signInWithEmailAndPasswordPressed());
      },
      expect: () => [
        SignInFormState.initial().copyWith(
          emailAddress: validEmail,
        ),
        SignInFormState.initial()
            .copyWith(emailAddress: validEmail, password: validPassword),
        SignInFormState.initial().copyWith(
            emailAddress: validEmail,
            password: validPassword,
            isSubmitting: true),
        SignInFormState.initial().copyWith(
          emailAddress: validEmail,
          password: validPassword,
          isSubmitting: false,
          showErrorMessages: true,
          authFailureOrSuccessOption: optionOf(const Right(unit)),
        ),
      ],
    );
  });
}
