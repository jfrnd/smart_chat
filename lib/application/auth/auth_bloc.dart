// Dart imports:
import 'dart:async';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

// Project imports:
import 'package:smart_chat/domain/entities/user/user.dart';
import 'package:smart_chat/domain/repositories/auth/i_auth_repo.dart';

// Project imports:

part 'auth_event.dart';

part 'auth_state.dart';

part 'auth_bloc.freezed.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepo _authRepo;

  AuthBloc(this._authRepo) : super(const AuthState.initial());

  StreamSubscription<User?>? _streamSubscription;

  @override
  Future<void> close() async {
    await _streamSubscription?.cancel();
    return super.close();
  }

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    yield* event.map(
      authStateChanged: (e) async* {
        if (e.signedIn) {
          yield const AuthState.authenticated();
        } else {
          yield const AuthState.unauthenticated();
        }
      },
      watchAuthState: (e) async* {
        await _streamSubscription?.cancel();
        _authRepo.watchUserState().listen((signedIn) {
          add(AuthEvent.authStateChanged(signedIn));
        });
      },
      signedOut: (e) async* {
        await _authRepo.signOut();
      },
    );
  }
}
