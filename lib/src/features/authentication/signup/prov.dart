import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpState extends StateNotifier<bool> {
  SignUpState() : super(false);

  void startLoading() => state = true;

  void stopLoading() => state = false;
}

final signUpStateProvider = StateNotifierProvider<SignUpState, bool>((ref) {
  return SignUpState();
});