import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin localNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initFLutterLocalNotification() async {
  tz_data.initializeTimeZones();

  const AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: androidInitializationSettings,
  );

  await localNotificationsPlugin.initialize(settings: initializationSettings);

  final AndroidFlutterLocalNotificationsPlugin? androidPlugin =
      localNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();

  await androidPlugin?.requestNotificationsPermission();

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'cart_reminder_channel',
    'Cart Reminders',
    description: 'Reminders for products added to cart',
    importance: Importance.high,
  );

  await androidPlugin?.createNotificationChannel(channel);
}

Future<void> callNotification({
  required String title,
  required String body,
}) async {
  final prefs = await SharedPreferences.getInstance();

  final notificationsEnabled = prefs.getBool('notifications_enabled') ?? true;

  if (!notificationsEnabled) {
    print('notifications are disabled ');
    return;
  }

  const AndroidNotificationDetails android = AndroidNotificationDetails(
    'reminder_channel',
    'Reminders',
    channelDescription: 'Local Notification',
    importance: Importance.high,
    priority: Priority.high,
  );

  const NotificationDetails detail = NotificationDetails(android: android);

  await localNotificationsPlugin.show(
    id: 0,
    title: title,
    body: body,
    notificationDetails: detail,
  );
}

Future<void> scheduleCartNotification({required String productName}) async {
  final prefs = await SharedPreferences.getInstance();

  final notificationsEnabled = prefs.getBool('notifications_enabled') ?? true;

  if (!notificationsEnabled) {
    print('Notifications are disabled');
    return;
  }

  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'cart_reminder_channel',
    'Cart Reminders',
    channelDescription: 'Reminders for products added to cart',
    importance: Importance.high,
    priority: Priority.high,
  );

  const NotificationDetails details = NotificationDetails(
    android: androidDetails,
  );

  final scheduledTime = tz.TZDateTime.now(
    tz.local,
  ).add(const Duration(seconds: 10));

  await localNotificationsPlugin.zonedSchedule(
    id: productName.hashCode,
    title: 'Donot forget your cart',
    body: '$productName is still waiting in your cart.',
    scheduledDate: scheduledTime,
    notificationDetails: details,
    androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
  );
}

Future<void> savePendingCartProduct({required String productName}) async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setString('pending_product_name', productName);
}

Future<void> getFCMToken() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  String? generatedFcmtoken = await messaging.getToken();

  print('FCM Token: $generatedFcmtoken');
}
