import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skincare_app/dashboard.dart';
import 'package:skincare_app/src/core/domain/auth/sign_in_ctrl.dart';
import 'package:skincare_app/src/core/repositories/async_value_ui.dart';
import 'package:skincare_app/src/core/utils/constants/app_colors.dart';
import 'package:skincare_app/src/core/utils/constants/app_sizes.dart';
import 'package:skincare_app/src/core/utils/constants/extensions.dart';
import 'package:skincare_app/src/features/authentication/signup/sign_up.dart';
import 'package:skincare_app/src/features/onboarding/onboarding.dart';

import '../../../core/utils/constants/textfield.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({
    super.key,
    this.goToPickSkinType,
  });

  final VoidCallback? goToPickSkinType;

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  Future<void> loginUser() async {
    ref.read(loginControllerProvider.notifier).signIn(
        email: emailCtrl.text,
        password: passwordCtrl.text,
        afterFetched: () =>
            Navigator.of(context).pushReplacement(CupertinoPageRoute(
              builder: (context) => const DashboardBaseView(),
            )),
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      loginControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    final loginState = ref.watch(loginControllerProvider);

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 20.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hey There!\nWelcome back',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                TextFieldWidget(
                  labelText: 'Email address',
                  hintText: 'Please enter your email address',
                  controller: emailCtrl,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    } else if (!value.toString().isValidEmail) {
                      return 'Enter valid email';
                    } else {
                      return null;
                    }
                  },
                ),
                TextFieldWidget(
                  labelText: 'Password',
                  hintText: 'Please enter your password',
                  controller: passwordCtrl,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return ' Required';
                    } else {
                      return null;
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    InkWell(
                      child: Text(
                        'Forgot password?',
                        style:
                            Theme.of(context).textTheme.bodyMedium?.copyWith(),
                      ),
                    )
                  ],
                ),
                ButtonWidget(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      loginUser();
                    }
                    // ref.read(loginStateProvider.notifier).startLoading();
                    // if (_formKey.currentState!.validate()) {
                    //   final message = await AuthService().login(
                    //     email: emailCtrl.text.trim(),
                    //     password: passwordCtrl.text.trim(),
                    //   );
                    //   ref.read(loginStateProvider.notifier).stopLoading();
                    //   if (message!.contains('Success')) {
                    //     Navigator.of(context).pushReplacement(
                    //         CupertinoPageRoute(builder: (context) {
                    //       return const PickSkinTypeView();
                    //     }));
                    //   } else {
                    //     showDialog(
                    //       context: context,
                    //       builder: (context) {
                    //         return AlertDialog(
                    //           backgroundColor:
                    //               Theme.of(context).scaffoldBackgroundColor,
                    //           title: const Text('Error'),
                    //           content: Text(message),
                    //           actions: [
                    //             TextButton(
                    //                 onPressed: () {
                    //                   Navigator.pop(context);
                    //                 },
                    //                 child: const Text(
                    //                   'Close',
                    //                   style: TextStyle(
                    //                     color: AppColors.primaryColor,
                    //                   ),
                    //                 ))
                    //           ],
                    //         );
                    //       },
                    //     );
                    //   }
                    // }
                  },
                  height: 45.h,
                  width: screenSize(context).width,
                  color: Colors.green,
                  child: loginState.isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          'Continue',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account? '),
                    InkWell(
                      onTap: () => Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (context) {
                            return const SignUpView();
                          },
                        ),
                      ),
                      child: Text(
                        'Create one',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.primaryColor,
                            ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
