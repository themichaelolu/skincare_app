import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skincare_app/dashboard.dart';
import 'package:skincare_app/src/core/domain/cloud_firestore/cloud_firestore.dart';
import 'package:skincare_app/src/core/utils/app_assets/app_assets.dart';
import 'package:skincare_app/src/core/utils/constants/app_colors.dart';
import 'package:skincare_app/src/core/utils/constants/app_sizes.dart';
import 'package:skincare_app/src/core/utils/constants/extensions.dart';
import 'package:skincare_app/src/core/utils/constants/textfield.dart';
import 'package:skincare_app/src/features/authentication/login/login.dart';
import 'package:skincare_app/src/features/onboarding/onboarding.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({
    super.key,
  });

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final userNameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  CloudFirestoreService? service;

  @override
  void initState() {
    service = CloudFirestoreService(FirebaseFirestore.instance);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hey There!\nSign Up to Start',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  20.h.verticalSpace,
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
                  10.h.verticalSpace,
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
                  10.h.verticalSpace,
                  TextFieldWidget(
                    labelText: 'Username',
                    hintText: 'Please choose a username',
                    controller: userNameCtrl,
                  ),
                  10.h.verticalSpace,
                  TextFieldWidget(
                    isPasswordField: true,
                    labelText: 'Password',
                    hintText: 'Please enter a password',
                    controller: passwordCtrl,
                  ),
                  20.h.verticalSpace,
                  ButtonWidget(
                    onTap: () async {
                      final userName = userNameCtrl.text.trim();
                      final name = nameCtrl.text.trim();

                      service?.add({
                        'name': name,
                        'username': userName,
                      });

                      String message = '';

                      try {
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: emailCtrl.text,
                                password: passwordCtrl.text);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          message = 'Password is too weak';
                        } else if (e.code == 'email-already-in-use') {
                          message = 'An account already exists with this email';
                        }
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              title: const Text('Error'),
                              content: Text(message),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'CLOSE',
                                      style: TextStyle(
                                        color: AppColors.primaryColor,
                                      ),
                                    ))
                              ],
                            );
                          },
                        );
                      } catch (e) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              title: const Text('Error'),
                              content: Text(message),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Failed: $e',
                                      style: TextStyle(
                                        color: AppColors.primaryColor,
                                      ),
                                    ))
                              ],
                            );
                          },
                        );
                      }
                    },
                    height: 45.h,
                    width: screenSize(context).width,
                    color: Colors.green,
                    child: Text(
                      'Continue',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                  10.h.verticalSpace,
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
                  10.h.verticalSpace,
                  ButtonWidget(
                      height: 45.h,
                      width: screenSize(context).width,
                      border: Border.all(color: AppColors.textGreyColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AppAssets.googleIcon),
                          5.w.horizontalSpace,
                          const Text(
                            'Continue with Google',
                          )
                        ],
                      )),
                  10.h.verticalSpace,
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
                  20.h.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account? '),
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
