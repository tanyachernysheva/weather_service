import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_service/repositories/authRepo/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo authRepo;

  AuthBloc({required this.authRepo}) : super(const AuthDataState()) {
    on<_SignInEvent>(_signIn);
  }

  Future<void> _signIn(_SignInEvent event, Emitter<AuthState> emit) async {
    try {
      final email = event.email;
      final password = event.password;

      await authRepo.signIn(email: email, password: password);

      emit(const AuthDataState(isLogin: true));
    } catch (error, stackTrace) {
      emit(AuthErrorState(message: error.toString()));

      log(stackTrace.toString());
    }
  }
}
