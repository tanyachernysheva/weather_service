part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {
  const AuthEvent();

  const factory AuthEvent.signIn(
      {required String email, required String password}) = _SignInEvent;
}

final class _SignInEvent implements AuthEvent {
  final String email;
  final String password;

  const _SignInEvent({
    required this.email,
    required this.password,
  });
}
