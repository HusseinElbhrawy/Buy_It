import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final auth = FirebaseAuth.instance;

  Future<UserCredential> signUp(
      {required String email, required String password}) async {
    final authResult = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return authResult;
  }

  Future<UserCredential> signIn(
      {required String email, required String password}) async {
    final authResult =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    return authResult;
  }
}
