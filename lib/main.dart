import 'package:app_project/core/routes/app_routes.dart';
import 'package:app_project/core/services/api_service.dart';
import 'package:app_project/features/cart/bloc/cart_bloc.dart';
import 'package:app_project/features/cart/bloc/cart_event.dart';
import 'package:app_project/features/cart/repositories/cart_repositories.dart';
import 'package:app_project/features/product/bloc/product_bloc.dart';
import 'package:app_project/features/product/bloc/product_event.dart';
import 'package:app_project/features/product/repositories/proudct_repository.dart';
import 'package:app_project/features/services/local_notification_service.dart';
import 'package:app_project/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@pragma('vm:entry-point')
Future<void> _backgroundHandler(RemoteMessage message) async {
  print('#${message.notification?.title}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiBlocProvider(
      providers: [
        // Cart BLoC
        BlocProvider(
          create: (context) => CartBloc(CartRepositories())..add(LoadCart()),
        ),

        // Product BLoC
        BlocProvider(
          create: (context) =>
              ProductBloc(ProudctRepository(ApiService()))..add(GetProducts()),
        ),
      ],
      child: const MyApp(),
    ),
  );
  // calling initialize for local notification
  await initFLutterLocalNotification();
  await getFCMToken();

  // Calling existing message
  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {
      callNotification(
        title: message.notification?.title ?? '',
        body: message.notification?.body ?? '',
      );
    }
  });
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
