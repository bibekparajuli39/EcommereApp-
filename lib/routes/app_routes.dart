import 'package:app_project/features/auth/screens/signup_screen.dart';
import 'package:app_project/features/cart/screens/cart_screen.dart';
import 'package:app_project/features/onboarding/screens/onboarding.dart';
import 'package:app_project/features/product/screens/product_screen.dart';
import 'package:app_project/routes/route.dart';
import 'package:app_project/features/navbar/bottom_navbar.dart';
import 'package:app_project/features/auth/screens/login_screen.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: Routes.onboarding,
        builder: (BuildContext context, GoRouterState state) {
          return OnboardingScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            path: Routes.login,
            builder: (BuildContext context, GoRouterState state) {
              return LoginScreen();
            },
          ),
          GoRoute(
            path: Routes.home,
            builder: (BuildContext context, GoRouterState state) {
              return BottomNavbar();
            },
          ),
          GoRoute(
            path: Routes.product,
            builder: (BuildContext context, GoRouterState state) {
              return ProductScreen();
            },
          ),
          GoRoute(
            path: Routes.cart,
            builder: (BuildContext context, GoRouterState state) {
              return CartScreen();
            },
          ),
          GoRoute(
            path: Routes.signup,
            builder: (BuildContext context, GoRouterState state) {
              return SignupScreen();
            },
          ),
        ],
      ),
    ],
  );
}
