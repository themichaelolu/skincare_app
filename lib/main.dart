import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logging/logging.dart';
import 'package:skincare_app/src/core/router/router_base.dart';
import 'package:skincare_app/src/themes/light_text_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

final rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
final log = Logger('Getteasy App');

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xffF9FBF2),
          textTheme: lightTextTheme,
          useMaterial3: true,
          fontFamily: 'Satoshi',
        ),
        routeInformationProvider: goRouter.routeInformationProvider,
        routeInformationParser: goRouter.routeInformationParser,
        routerDelegate: goRouter.routerDelegate,
        restorationScopeId: 'app',
        scaffoldMessengerKey: rootScaffoldMessengerKey,
      ),
    );
  }
}
