import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skincare_app/dashboard.dart';

import 'package:skincare_app/src/core/domain/auth/google_sign_in.dart';
import 'package:skincare_app/src/core/domain/auth/sign_up_ctrl.dart';
import 'package:skincare_app/src/core/domain/cloud_firestore/cloud_firestore.dart';
import 'package:skincare_app/src/core/repositories/async_value_ui.dart';
import 'package:skincare_app/src/core/utils/app_assets/app_assets.dart';
import 'package:skincare_app/src/core/utils/constants/app_colors.dart';
import 'package:skincare_app/src/core/utils/constants/app_sizes.dart';
import 'package:skincare_app/src/core/utils/constants/extensions.dart';
import 'package:skincare_app/src/core/utils/constants/textfield.dart';
import 'package:skincare_app/src/features/authentication/login/login.dart';
import 'package:skincare_app/src/features/onboarding/onboarding.dart';

class SignUpView extends ConsumerStatefulWidget {
  const SignUpView({
    super.key,
  });

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final userNameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  CloudFirestoreService? service;

  @override
  void initState() {
    service = CloudFirestoreService(db: FirebaseFirestore.instance);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> signUpUser() async {
      ref.read(signUpControllerProvider.notifier).googleSignUp(
            email: emailCtrl.text,
            password: passwordCtrl.text,
            afterFetched: () => Navigator.of(context).pushReplacement(
              CupertinoPageRoute(
                builder: (context) => const DashboardBaseView(),
              ),
            ),
          );
    }

    ref.listen(signUpControllerProvider,
        (_, state) => state.showAlertDialogOnError(context),);

    final providerState = ref.watch(signUpControllerProvider);

    ref.listen(googleSignInControllerProvider,
        (_, state) => state.showAlertDialogOnError(context),);

    final googleState = ref.watch(googleSignInControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                spacing: 20,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hey There!\nSign Up to Start',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  TextFieldWidget(
                    labelText: 'Name',
                    hintText: 'Please enter your name',
                    controller: nameCtrl,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Required';
                      }
                      return null;
                    },
                  ),
                  TextFieldWidget(
                    labelText: 'Email address',
                    hintText: 'Please enter your email address',
                    controller: emailCtrl,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ' Required';
                      } else if (!value.toString().isValidEmail) {
                        return 'Enter valid email';
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFieldWidget(
                    labelText: 'Username',
                    hintText: 'Please choose a username',
                    controller: userNameCtrl,
                  ),
                  TextFieldWidget(
                    isPasswordField: true,
                    labelText: 'Password',
                    hintText: 'Please enter a password',
                    controller: passwordCtrl,
                  ),
                  ButtonWidget(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        signUpUser();
                        // ref.read(signUpStateProvider.notifier).startLoading();
                        // final message = await AuthService().signUp(
                        //   email: emailCtrl.text.trim(),
                        //   password: passwordCtrl.text.trim(),
                        // );
                        // ref.read(signUpStateProvider.notifier).stopLoading();
                        // if (message!.contains('Success')) {
                        //   Navigator.of(context).pushReplacement(
                        //       CupertinoPageRoute(builder: (context) {
                        //     return const DashboardBaseView();
                        //   }));
                        // } else {
                        //   showDialog(
                        //     context: context,
                        //     builder: (context) {
                        //       return AlertDialog(
                        //         backgroundColor:
                        //             Theme.of(context).scaffoldBackgroundColor,
                        //         title: const Text('Error'),
                        //         content: Text(message),
                        //         actions: [
                        //           TextButton(
                        //               onPressed: () {
                        //                 Navigator.pop(context);
                        //               },
                        //               child: const Text(
                        //                 'Close',
                        //                 style: TextStyle(
                        //                   color: AppColors.primaryColor,
                        //                 ),
                        //               ))
                        //         ],
                        //       );
                        //     },
                        //   );
                        // }
                      }
                    },
                    height: 45.h,
                    width: screenSize(context).width,
                    color: AppColors.primaryColor,
                    child: providerState.isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            'Continue',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Colors.white,
                                ),
                          ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(
                        width: 135,
                        child: Divider(
                          color: AppColors.textGreyColor,
                        ),
                      ),
                      Text(
                        'or',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textGreyColor,
                            ),
                      ),
                      const SizedBox(
                        width: 135,
                        child: Divider(
                          color: AppColors.textGreyColor,
                        ),
                      ),
                    ],
                  ),
                  ButtonWidget(
                      onTap: () async {
                        await ref
                            .read(googleSignInControllerProvider.notifier)
                            .signIn(afterFetched: () {
                          return Navigator.of(context).pushReplacement(
                            CupertinoPageRoute(
                              builder: (context) {
                                return const DashboardBaseView();
                              },
                            ),
                          );
                        });
                      },
                      height: 45.h,
                      width: screenSize(context).width,
                      border: Border.all(color: AppColors.textGreyColor),
                      child: googleState.isLoading
                          ? const CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(AppAssets.googleIcon),
                                5.w.horizontalSpace,
                                const Text(
                                  'Continue with Google',
                                )
                              ],
                            )),
                  ButtonWidget(
                      height: 45.h,
                      width: screenSize(context).width,
                      border: Border.all(color: AppColors.textGreyColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AppAssets.appleIcon),
                          5.w.horizontalSpace,
                          const Text(
                            'Continue with Apple',
                          )
                        ],
                      )),
                  Row(
                    spacing: 5.w,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?'),
                      InkWell(
                        onTap: () => Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const LoginView(),
                          ),
                        ),
                        child: Text(
                          'Sign In',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
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
        ),
      ),
    );
  }
}
