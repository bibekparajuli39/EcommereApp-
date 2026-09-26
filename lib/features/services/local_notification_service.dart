import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

//Step 1: Creating instance of FLutter Local Notification Plugin
final FlutterLocalNotificationsPlugin localNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// to initialize Flutter Local Notifications.
Future<void> initFLutterLocalNotification() async {
  // Step 2:  Configuring Android notification settings.
  const AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  // Step 3: Creating general initialization settings for android
  final InitializationSettings initializationSettings = InitializationSettings(
    android: androidInitializationSettings,
  );

  // Step 4:Initialize the notification plugin.
  // This prepares the plugin so we can show notifications later.
  await localNotificationsPlugin.initialize(settings: initializationSettings);

  // Step 4: Ask the user for permission to send notifications.
  // This is required on newer versions of Android.
  await localNotificationsPlugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >()
      ?.requestNotificationsPermission();
}
// final FlutterLocalNotificationsPlugin localNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// Future<void> initFlutterLocalNotification() async {
//   // step 2
//   const AndroidInitializationSettings androidInitializationSettings =
//       AndroidInitializationSettings('@mipmap/ic_launcher');
//   // step 3
//   final InitializationSettings initializationSettings = InitializationSettings(
//     android: androidInitializationSettings,
//   );
//   await localNotificationsPlugin.initialize(settings: initializationSettings);
//   await localNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//         AndroidFlutterLocalNotificationsPlugin
//       >()
//       ?.requestNotificationsPermission();
// }
Future<void> callNotification({
  required String title,
  required String body,
}) async {
  // Intialized notification
  const android = AndroidNotificationDetails(
    'reminder_channel',
    'Reminders',
    channelDescription: 'Local Notification',
    importance: Importance.high,
    priority: Priority.high,
  );
  // detail for notification like title,body for descritpion
  const detail = NotificationDetails(android: android);
  await localNotificationsPlugin.show(
    id: 0,
    title: title,
    body: body,

    notificationDetails: detail,
  );
}

Future<void> getFCMToken() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  String? generatedFcmtoken = await messaging.getToken();
  print('FCM Token: $generatedFcmtoken');
}
