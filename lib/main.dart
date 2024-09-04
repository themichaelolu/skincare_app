import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skincare_app/firebase_options.dart';
import 'package:skincare_app/src/features/onboarding/onboarding.dart';
import 'package:skincare_app/src/themes/light_text_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(
    BuildContext context,
  ) {
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
        home: const OnboardingView(),
        routes: const {
          // '/onboarding' =>  OnboardingView();
        },
      ),
    );
  }
}
