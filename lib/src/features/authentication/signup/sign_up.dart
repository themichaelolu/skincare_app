import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skincare_app/src/core/utils/app_assets/app_assets.dart';
import 'package:skincare_app/src/core/utils/constants/app_colors.dart';
import 'package:skincare_app/src/core/utils/constants/app_sizes.dart';
import 'package:skincare_app/src/core/utils/constants/extensions.dart';
import 'package:skincare_app/src/core/utils/constants/textfield.dart';
import 'package:skincare_app/src/features/onboarding/onboarding.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key, this.goToLogin,});
  final VoidCallback? goToLogin;

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final userNameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Form(
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
                        onTap: () => widget.goToLogin?.call(),
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
