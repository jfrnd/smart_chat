// Package imports:
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:smart_chat/application/auth/auth_bloc.dart';
import 'package:smart_chat/domain/repositories/auth/i_auth_repo.dart';

class MockIAuthRepo extends Mock implements IAuthRepo {}

void main() {
  late AuthBloc bloc;
  late MockIAuthRepo authRepo;

  setUp(() {
    authRepo = MockIAuthRepo();
    bloc = AuthBloc(authRepo);
  });

  tearDown(() {
    reset(authRepo);
    bloc.close();
  });

  group('signedOut()', () {
    blocTest(
      'should call authFacade.signOut()',
      build: () {
        when(() => authRepo.signOut()).thenAnswer((_) async => unit);
        return bloc;
      },
      act: (_) => bloc.add(const AuthEvent.signedOut()),
      verify: (_) => verify(() => authRepo.signOut()),
      expect: () => [],
    );
  });
  group('authStateChanged()', () {
    blocTest(
      'should emit: [Unauthenticated]',
      build: () => bloc,
      act: (_) => bloc.add(const AuthEvent.authStateChanged(false)),
      expect: () => [const AuthState.unauthenticated()],
    );

    blocTest(
      'should emit: [Authenticated]',
      build: () => bloc,
      act: (_) => bloc.add(const AuthEvent.authStateChanged(true)),
      expect: () => [const AuthState.authenticated()],
    );
  });
  group('watchAuthState()', () {
    blocTest(
      'should emit: [Unauthenticated] when not logged in',
      build: () {
        when(() => authRepo.watchUserState())
            .thenAnswer((_) => Stream.value(false));
        return bloc;
      },
      act: (_) => bloc.add(const AuthEvent.watchAuthState()),
      expect: () => [const AuthState.unauthenticated()],
    );

    blocTest(
      'should emit: [Authenticated] when logged in',
      build: () {
        when(() => authRepo.watchUserState())
            .thenAnswer((_) => Stream.value(true));
        return bloc;
      },
      act: (_) => bloc.add(const AuthEvent.watchAuthState()),
      expect: () => [const AuthState.authenticated()],
    );
  });
}
