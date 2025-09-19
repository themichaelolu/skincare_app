


// Future<void> signIn({required Function? afterFetched}) async {
//     state = state.copyWith(isLoading: true, error: null);
//     try {
//       final user = await _controller.signIn();
//       if (user != null) {
//         state = state.copyWith(user: user, isLoading: false);
//         afterFetched?.call(); // Safely call afterFetched if not null
//         developer.log('$user');
//       } else {
//         state = state.copyWith(isLoading: false);
//       }
//     } on FirebaseAuthException catch (error) {
//       state = state.copyWith(isLoading: false, error: error.toString());
//     }
//   }