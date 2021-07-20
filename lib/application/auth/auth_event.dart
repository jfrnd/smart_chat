part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.authStateChanged(bool signedIn) = AuthStateChanged;
  const factory AuthEvent.watchAuthState() = WatchAuthState;
  const factory AuthEvent.signedOut() = SignedOut;
}
