import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_service/repositories/authRepo/auth_repo.dart';
import 'package:weather_service/screens/auth_screen/bloc/auth_bloc.dart';
import 'package:weather_service/screens/weather_screen/weather_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late final AuthBloc _bloc;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool notVisible = true;

  @override
  void initState() {
    _bloc = AuthBloc(authRepo: FirebaseAuthRepo());

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message ?? '')));
                }

                if (state is AuthDataState && state.isLogin == true) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WeatherScreen()));
                }
              },
              bloc: _bloc,
              builder: (context, state) {
                return Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const SizedBox(
                        height: 26,
                      ),
                      Text(
                        'Вход',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Text(
                        'Введите данные для входа',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      //? Email Field
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Введите email';
                          }
                          return null;
                        },
                        controller: _emailController,
                        decoration: const InputDecoration(hintText: 'Email'),
                      ),
                      const SizedBox(
                        height: 24,
                      ),

                      //? Password Field
                      TextFormField(
                        obscureText: notVisible,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Введите пароль';
                          }

                          if (value.length < 6) {
                            return 'Пароль должен содержать не менее 6 символов';
                          }
                          return null;
                        },
                        controller: _passwordController,
                        decoration: InputDecoration(
                          hintText: 'Пароль',
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  notVisible = !notVisible;
                                });
                              },
                              icon: notVisible
                                  ? const Icon(Icons.visibility_outlined)
                                  : const Icon(Icons.visibility_off)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _bloc.add(AuthEvent.signIn(
                                email: _emailController.text,
                                password: _passwordController.text,
                              ));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Войти'),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
