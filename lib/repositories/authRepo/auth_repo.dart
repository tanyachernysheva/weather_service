import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthRepo {
  Future<UserCredential?> signIn(
      {required String email, required String password});
}

class FirebaseAuthRepo implements AuthRepo {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Future<UserCredential?> signIn({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);

    return userCredential;
  }
}
