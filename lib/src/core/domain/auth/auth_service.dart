import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') { 
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Password is incorrect';
      } else if (e.code == 'invalid-credential') {
        return 'Email/password is incorrect';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'An account already exists with that email.';
      } else if (e.code == 'network-request-failed') {
        return 'Network failed';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }
}
