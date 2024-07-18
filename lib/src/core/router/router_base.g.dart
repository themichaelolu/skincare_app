// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router_base.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $onboardingViewRoute,
      $signUpViewRoute,
      $loginViewRoute,
      $pickSkinTypeViewRoute,
    ];

RouteBase get $onboardingViewRoute => GoRouteData.$route(
      path: '/onboarding',
      factory: $OnboardingViewRouteExtension._fromState,
    );

extension $OnboardingViewRouteExtension on OnboardingViewRoute {
  static OnboardingViewRoute _fromState(GoRouterState state) =>
      const OnboardingViewRoute();

  String get location => GoRouteData.$location(
        '/onboarding',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $signUpViewRoute => GoRouteData.$route(
      path: '/signUp',
      factory: $SignUpViewRouteExtension._fromState,
    );

extension $SignUpViewRouteExtension on SignUpViewRoute {
  static SignUpViewRoute _fromState(GoRouterState state) =>
      const SignUpViewRoute();

  String get location => GoRouteData.$location(
        '/signUp',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $loginViewRoute => GoRouteData.$route(
      path: '/login',
      factory: $LoginViewRouteExtension._fromState,
    );

extension $LoginViewRouteExtension on LoginViewRoute {
  static LoginViewRoute _fromState(GoRouterState state) => LoginViewRoute();

  String get location => GoRouteData.$location(
        '/login',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $pickSkinTypeViewRoute => GoRouteData.$route(
      path: '/pickSkinType',
      factory: $PickSkinTypeViewRouteExtension._fromState,
    );

extension $PickSkinTypeViewRouteExtension on PickSkinTypeViewRoute {
  static PickSkinTypeViewRoute _fromState(GoRouterState state) =>
      PickSkinTypeViewRoute();

  String get location => GoRouteData.$location(
        '/pickSkinType',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$goRouterHash() => r'0b6742a48b59fb79d861fdfcc8fdd54c460b9ad4';

/// See also [goRouter].
@ProviderFor(goRouter)
final goRouterProvider = Provider<GoRouter>.internal(
  goRouter,
  name: r'goRouterProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$goRouterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GoRouterRef = ProviderRef<GoRouter>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
