import 'package:app_project/core/routes/route.dart';
import 'package:app_project/features/auth/screens/auth_screen.dart';

import 'package:app_project/features/auth/screens/login_screen.dart';
import 'package:app_project/features/auth/screens/signup_screen.dart';
import 'package:app_project/features/cart/screens/cart_screen.dart';
import 'package:app_project/features/navbar/bottom_navbar/bottom_navbar_screen.dart';
import 'package:app_project/features/onboarding/screens/onboarding.dart';

import 'package:app_project/features/product/models/product_model/product_model.dart';

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
      GoRoute(
        path: Routes.auth,
        builder: (BuildContext context, GoRouterState state) {
          return const AuthScreen();
        },
      ),

      // Home
      GoRoute(
        path: Routes.home,
        builder: (context, state) {
          return const BottomNavbar();
        },
      ),

      // builder: (context, state) {
      //     return BlocProvider(
      //       create: (context) =>
      //           ProductBloc(ProudctRepository(ApiService()))
      //             ..add(GetProducts()),
      //       child: const ProductScreen(),
      //     );
      //   },

      // Product
      GoRoute(
        path: Routes.product,
        builder: (BuildContext context, GoRouterState state) {
          return const ProductScreen();
        },

        // builder: (context, state) {
        //     return BlocProvider(
        //       create: (context) => ProductBloc(
        //         // repository/usecase here
        //       )..add(FetchProducts()),
        //       child: const ProductScreen(),
        //     );
        //   },
      ),

      // Cart
      GoRoute(
        path: Routes.cart,
        builder: (BuildContext context, GoRouterState state) {
          // final product = state.extra as ProductModel;
          return CartScreen();
        },
      ),
      // Onboarding
      GoRoute(
        path: Routes.productDetail,
        builder: (BuildContext context, GoRouterState state) {
          final products = state.extra as ProductModel?;
          if (products == null) {
            return const Scaffold(
              body: Center(child: Text('Product not found')),
            );
          }

          return ProductDetailScreen(product: products);
        },
      ),
    ],
  );
}
