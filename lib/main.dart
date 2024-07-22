import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logging/logging.dart';
import 'package:skincare_app/src/core/router/router_base.dart';
import 'package:skincare_app/src/features/onboarding/onboarding.dart';
import 'package:skincare_app/src/themes/light_text_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context,) {
   
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xffF9FBF2),
          textTheme: lightTextTheme,
          useMaterial3: true,
          fontFamily: 'Satoshi',
        ),
        restorationScopeId: 'app',
      routes: {
        // '/onboarding' =>  OnboardingView();
      },
      ),
      
    );
  }
}
