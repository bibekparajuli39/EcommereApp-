import 'package:app_project/core/routes/route.dart';
import 'package:app_project/features/auth/screens/login_screen.dart';
import 'package:app_project/features/auth/screens/signup_screen.dart';
import 'package:app_project/features/cart/screens/cart_screen.dart';
import 'package:app_project/features/navbar/bottom_navbar/bottom_navbar_screen.dart';
import 'package:app_project/features/onboarding/screens/onboarding.dart';
import 'package:app_project/features/product/screens/product_detail_screen.dart';
import 'package:app_project/features/product/screens/product_screen.dart';
import 'package:app_project/features/startup/startup_screen.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    initialLocation: Routes.startup,

    routes: <RouteBase>[
      // Startup
      GoRoute(
        path: Routes.startup,
        builder: (BuildContext context, GoRouterState state) {
          return const StartupScreen();
        },
      ),

      // Onboarding
      GoRoute(
        path: Routes.onboarding,
        builder: (BuildContext context, GoRouterState state) {
          return const OnboardingScreen();
        },
      ),

      // Signup
      GoRoute(
        path: Routes.signup,
        builder: (BuildContext context, GoRouterState state) {
          return const SignupScreen();
        },
      ),

      // Login
      GoRoute(
        path: Routes.login,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
      ),

      // Home
      GoRoute(
        path: Routes.home,
        builder: (BuildContext context, GoRouterState state) {
          return const BottomNavbar();
        },
      ),

      // Product
      GoRoute(
        path: Routes.product,
        builder: (BuildContext context, GoRouterState state) {
          return const ProductScreen();
        },
      ),

      // Cart
      GoRoute(
        path: Routes.cart,
        builder: (BuildContext context, GoRouterState state) {
          return const CartScreen();
        },
      ),
      // Onboarding
      GoRoute(
        path: Routes.productDetail,
        builder: (BuildContext context, GoRouterState state) {
          return const ProductDetailScreen();
        },
      ),
    ],
  );
}
