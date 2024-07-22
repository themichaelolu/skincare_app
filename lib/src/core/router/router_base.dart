// import 'package:flutter/material.dart';

// import 'package:go_router/go_router.dart';
// import 'package:skincare_app/dashboard.dart';
// import 'package:skincare_app/src/core/domain/products/products.dart';
// import 'package:skincare_app/src/core/router/nav_observer.dart';
// import 'package:skincare_app/src/core/router/not_found_page.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
// import 'package:skincare_app/src/features/authentication/login/login.dart';
// import 'package:skincare_app/src/features/authentication/signup/sign_up.dart';
// import 'package:skincare_app/src/features/cart/cart.dart';
// import 'package:skincare_app/src/features/cart/liked_products.dart';
// import 'package:skincare_app/src/features/explore/explore.dart';
// import 'package:skincare_app/src/features/home/home.dart';
// import 'package:skincare_app/src/features/home/product_detail.dart';
// import 'package:skincare_app/src/features/onboarding/build_routine.dart';
// import 'package:skincare_app/src/features/onboarding/pick_skin_goals.dart';
// import 'package:skincare_app/src/features/onboarding/pick_skin_type.dart';

// import '../../features/onboarding/onboarding.dart';

// part 'router_base.g.dart';

// final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
// final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

// @Riverpod(keepAlive: true)
// GoRouter goRouter(GoRouterRef ref) => GoRouter(
//         routes: $appRoutes,
//         initialLocation: '/onboarding',
//         errorBuilder: (context, state) => NotFoundScreen(
//               error: state.error!,
//             ).build(context),
//         observers: <NavigatorObserver>[
//           NavObserver(),
//         ]);

// @TypedGoRoute<OnboardingViewRoute>(path: '/onboarding')
// class OnboardingViewRoute extends GoRouteData {
//   const OnboardingViewRoute();

//   @override
//   Widget build(BuildContext context, GoRouterState state) =>
//       OnboardingView(goToSignUp: () => const SignUpViewRoute().go(context));
// }

// @TypedGoRoute<SignUpViewRoute>(path: '/signUp')
// class SignUpViewRoute extends GoRouteData {
//   const SignUpViewRoute();

//   @override
//   Widget build(BuildContext context, GoRouterState state) => SignUpView(
//         goToLogin: () => LoginViewRoute().go(context),
//       );
// }

// @TypedGoRoute<LoginViewRoute>(path: '/login')
// class LoginViewRoute extends GoRouteData {
//   @override
//   Widget build(BuildContext context, GoRouterState state) => LoginView(
//         goToPickSkinType: () => PickSkinTypeViewRoute().go(context),
//       );
// }

// @TypedGoRoute<PickSkinTypeViewRoute>(path: '/pickSkinType')
// class PickSkinTypeViewRoute extends GoRouteData {
//   @override
//   Widget build(BuildContext context, GoRouterState state) => PickSkinTypeView(
//         goToSkinGoals: () => PickSkinGoalsViewRoute().push(context),
//       );
// }

// @TypedGoRoute<PickSkinGoalsViewRoute>(path: '/pickSkinGoals')
// class PickSkinGoalsViewRoute extends GoRouteData {
//   @override
//   Widget build(BuildContext context, GoRouterState state) => PickSkinGoalsView(
//         goBack: () => PickSkinTypeViewRoute().go(context),
//         goToBuildRoutine: () => BuildRoutineViewRoute().push(context),
//       );
// }

// @TypedGoRoute<BuildRoutineViewRoute>(path: '/buildRoutine')
// class BuildRoutineViewRoute extends GoRouteData {
//   @override
//   Widget build(BuildContext context, GoRouterState state) => BuildRoutineView(
//         goBack: () => PickSkinGoalsViewRoute().go(context),
//         goHome: () => HomeBaseViewRoute().go(context),
//       );
// }

// class HomeBaseViewRoute extends GoRouteData {
//   @override
//   Widget build(BuildContext context, GoRouterState state) => HomeBaseView(
//         goToDetails: () => const ProductDetailViewRoute().push(context),
//       );
// }

// @TypedGoRoute<ProductDetailViewRoute>(
//   path: '/productDetail',
// )
// class ProductDetailViewRoute extends GoRouteData {
//   const ProductDetailViewRoute({
//     this.$extra,
//   });

//   final Product? $extra;

//   @override
//   Widget build(BuildContext context, GoRouterState state) => ProductDetailView(
//         product: $extra,
//         goToCart: () => CartBaseViewRoute().push(context),
//       );
// }

// class CartBaseViewRoute extends GoRouteData {
//   static final GlobalKey<NavigatorState> $navigatorKey = shellNavigatorKey;
//   @override
//   Widget build(BuildContext context, GoRouterState state) =>
//       const CartBaseView();
// }

// @TypedShellRoute<DashboardBaseRoute>(routes: <TypedRoute<RouteData>>[
//   TypedGoRoute<HomeBaseViewRoute>(
//     path: '/home',
//   ),
//   TypedGoRoute<CartBaseViewRoute>(
//     path: '/cart',
//     routes: <TypedGoRoute<GoRouteData>>[],
//   ),
//   TypedGoRoute<ExploreViewRoute>(
//       path: '/explore', routes: <TypedGoRoute<GoRouteData>>[]),
//   TypedGoRoute<LikedProductsViewRoute>(
//       path: '/liked', routes: <TypedGoRoute<GoRouteData>>[]),
// ])
// class DashboardBaseRoute extends ShellRouteData {
//   const DashboardBaseRoute();
//   static final GlobalKey<NavigatorState> $navigatorKey = shellNavigatorKey;

//   @override
//   Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
//     return DashboardBaseView(
//       child: navigator,
//       goToHome: () => HomeBaseViewRoute().go(context),
//       goToExplore: () => ExploreViewRoute().go(context),
//       goToCart: () => CartBaseViewRoute().go(context),
//       goToLikedProducts: () => LikedProductsViewRoute().go(context),
//     );
//   }
// }

// class LikedProductsViewRoute extends GoRouteData {
//   @override
//   Widget build(BuildContext context, GoRouterState state) =>
//       const LikedProductsView();
// }

// class ExploreViewRoute extends GoRouteData {
//   @override
//   Widget build(BuildContext context, GoRouterState state) =>
//       const ExploreView();
// }
