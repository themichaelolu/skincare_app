import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skincare_app/dashboard.dart';
import 'package:skincare_app/src/core/utils/constants/app_colors.dart';
import 'package:skincare_app/src/core/utils/constants/app_sizes.dart';
import 'package:skincare_app/src/core/utils/constants/extensions.dart';
import 'package:skincare_app/src/features/home/home.dart';
import 'package:skincare_app/src/features/onboarding/onboarding.dart';

import '../../../core/utils/constants/textfield.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key, this.goToPickSkinType,});

  final VoidCallback? goToPickSkinType;

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hey There!\nWelcome back',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                20.h.verticalSpace,
                TextFieldWidget(
                  labelText: 'Email address',
                  hintText: 'Please enter your email address',
                  controller: emailCtrl,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Required';
                    } else if (!value.toString().isValidEmail) {
                      return 'Enter valid email';
                    } else {
                      return null;
                    }
                  },
                ),
                10.h.verticalSpace,
                TextFieldWidget(
                  labelText: 'Password',
                  hintText: 'Please enter your password',
                  controller: emailCtrl,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ' Required';
                    } else if (!value.toString().isValidPassword) {
                      return 'Enter valid email';
                    } else {
                      return null;
                    }
                  },
                ),
                10.h.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    InkWell(
                      child: Text(
                        'Forgot password?',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.textGreyColor,
                            ),
                      ),
                    )
                  ],
                ),
                20.h.verticalSpace,
                ButtonWidget(
                  onTap: () => Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => const DashboardBaseView(),)),
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
                20.h.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account? '),
                    InkWell(
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
