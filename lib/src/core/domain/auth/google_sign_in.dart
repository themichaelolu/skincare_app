import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skincare_app/src/core/domain/auth/google_sign_in_controller.dart';

import 'package:skincare_app/src/core/repositories/app_exception.dart';

part 'google_sign_in.g.dart';

@riverpod
class GoogleSignInController extends _$GoogleSignInController {
  @override
  FutureOr<dynamic> build() {
    return null;
  }

  Future<dynamic> signIn({required Function? afterFetched}) async {
    try {
      state = const AsyncValue.loading();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        throw AppException('Sign-in cancelled by user.');
        // return null;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // ignore: unnecessary_null_comparison
      if (googleAuth == null) {
        throw AppException('Authentication error occurred.');
        // return null;
      }

      if (googleAuth.accessToken != null) {
        ref.read(googleSignInClassProvider.notifier).signIn();
        state = AsyncValue.data(googleAuth);
        afterFetched?.call();
        debugPrint('User: $googleUser');
        return googleAuth;
        
      } else {
        throw AppException('An unknown error occurred during sign-in.');
        //   return null;
      }
    } on Exception catch (error, stackTrace) {
      debugPrint(
          'Something went wrong signing-in with  google\n $error \n $stackTrace');

      state = AsyncError(error, stackTrace);
      return null;
    }
  }
}
