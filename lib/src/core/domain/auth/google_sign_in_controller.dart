import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'google_sign_in_controller.g.dart';



@riverpod
class GoogleSignInClass extends _$GoogleSignInClass {

    @override
  FutureOr<dynamic> build() {
    return null;
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn();



  Future<GoogleSignInAccount?> signIn() async {
    try {
      return await _googleSignIn.signIn();
    } catch (error) {
      debugPrint('Error during Google sign-in: $error');
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
    } catch (error) {
      debugPrint('Error during Google sign-out: $error');
    }
  }

 Future <GoogleSignInAccount?>? getcurrentUser() async{
    return  _googleSignIn.currentUser;
  }

 
}
