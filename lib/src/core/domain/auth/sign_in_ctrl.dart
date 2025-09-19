import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skincare_app/src/core/domain/auth/gen_prov.dart';
import 'package:skincare_app/src/core/repositories/app_exception.dart';

part 'sign_in_ctrl.g.dart';

@riverpod
class LoginController extends _$LoginController {
  @override
  FutureOr<dynamic> build() {
    return null;
  }

  Future<dynamic> signIn({
    required String email,
    required password,
    required BuildContext context,
    Function? afterFetched,
  }) async {
    final service = ref.read(authServiceProvider);
    try {
      state = const AsyncValue.loading();
      final login = await service.login(email: email, password: password);
      if (login.toString().contains('Success')) {
        state = AsyncValue.data(login);
        afterFetched?.call();
      } else {
        throw AppException('$login');
      }
    } catch (e, s) {
      state = AsyncError(e, s);
      return null;
    }
    return null;
  }
}
