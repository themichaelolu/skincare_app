import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:skincare_app/src/core/router/nav_observer.dart';
import 'package:skincare_app/src/core/router/not_found_page.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skincare_app/src/features/authentication/login/login.dart';
import 'package:skincare_app/src/features/authentication/signup/sign_up.dart';
import 'package:skincare_app/src/features/onboarding/pick_skin_type.dart';

import '../../features/onboarding/onboarding.dart';

part 'router_base.g.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

@Riverpod(keepAlive: true)
GoRouter goRouter(GoRouterRef ref) => GoRouter(
        routes: $appRoutes,
        initialLocation: '/onboarding',
        errorBuilder: (context, state) => NotFoundScreen(
              error: state.error!,
            ).build(context),
        observers: <NavigatorObserver>[
          NavObserver(),
        ]);

@TypedGoRoute<OnboardingViewRoute>(path: '/onboarding')
class OnboardingViewRoute extends GoRouteData {
  const OnboardingViewRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      OnboardingView(goToSignUp: () => const SignUpViewRoute().go(context));
}

@TypedGoRoute<SignUpViewRoute>(path: '/signUp')
class SignUpViewRoute extends GoRouteData {
  const SignUpViewRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => SignUpView(
        goToLogin: () => LoginViewRoute().go(context),
      );
}

@TypedGoRoute<LoginViewRoute>(path: '/login')
class LoginViewRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) =>  LoginView(
    goToPickSkinType: () => PickSkinTypeViewRoute().go(context),
  );
}


@TypedGoRoute<PickSkinTypeViewRoute>(path: '/pickSkinType')
class PickSkinTypeViewRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) => const PickSkinTypeView();
}
