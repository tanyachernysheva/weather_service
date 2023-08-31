part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  const AuthState();
}

final class AuthDataState extends AuthState {
  final bool isLogin;

  const AuthDataState({this.isLogin = false});
}

final class AuthErrorState extends AuthState {
  final String? message;

  const AuthErrorState({this.message});
}
