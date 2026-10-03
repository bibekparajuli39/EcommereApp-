import 'package:firebase_auth/firebase_auth.dart';
import 'package:nana/core/routes/app_routes.dart';
import 'package:nana/core/services/api_service.dart';
import 'package:nana/features/auth/bloc/auth_bloc.dart';
import 'package:nana/features/auth/repositories/auth_repositories.dart';
import 'package:nana/features/cart/bloc/cart_bloc.dart';
import 'package:nana/features/cart/bloc/cart_event.dart';
import 'package:nana/features/cart/repositories/cart_repositories.dart';
import 'package:nana/features/product/bloc/product_bloc.dart';
import 'package:nana/features/product/bloc/product_event.dart';
import 'package:nana/features/product/repositories/proudct_repository.dart';
import 'package:nana/features/services/local_notification_service.dart';
import 'package:nana/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

@pragma('vm:entry-point')
Future<void> _backgroundHandler(RemoteMessage message) async {
  // ignore: avoid_print
  print('#${message.notification?.title}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GoogleSignIn.instance.initialize(
    clientId:
        '915211954713-onr4acale80q5m87nhgueae4i3r5scgb.apps.googleusercontent.com',
  );
  runApp(
    MultiBlocProvider(
      providers: [
        // auth
        BlocProvider(
          create: (_) => AuthBloc(AuthRepositories(FirebaseAuth.instance)),
        ),
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
