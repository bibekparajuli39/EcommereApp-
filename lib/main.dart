import 'package:app_project/core/routes/app_routes.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'App',
      theme: ThemeData(
        colorScheme: .fromSeed(
          seedColor: const Color.fromARGB(255, 244, 244, 245),
        ),
      ),
      debugShowCheckedModeBanner: false,

      routerConfig: AppRoutes.router,
    );
  }
}
