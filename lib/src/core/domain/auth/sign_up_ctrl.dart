import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../repositories/app_exception.dart';
import 'gen_prov.dart';

part 'sign_up_ctrl.g.dart';

@riverpod
class SignUpController extends _$SignUpController {
  @override
    FutureOr<dynamic> build() {
      return null;
    }

  Future<dynamic> googleSignUp({
    required String email,
    required password,
   
    Function? afterFetched,
  }) async {
    final service = ref.read(authServiceProvider);
    try {
      state = const AsyncValue.loading();
      final signUp = await service.signUp(email: email, password: password);
      if (signUp.toString().contains('Success')) {
        state = AsyncValue.data(signUp);
        afterFetched?.call();
      } else {
        throw AppException('$signUp');
      }
    } catch (e, s) {
      state = AsyncError(e, s);
      return null;
    }
    return null;
  }
}
