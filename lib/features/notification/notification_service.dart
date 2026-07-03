import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:umodzi/services/storage/storage_services.dart';
import '../../firebase_options.dart';
import '../../services/storage/storage_keys.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  log("🔥 Handling a background message: ${message.messageId}");
}

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // ১. ব্যাকগ্রাউন্ড মেসেজ হ্যান্ডলার সেট করা
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // ২. পারমিশন রিকোয়েস্ট করা
    NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    log('🔔 Permission Status: ${settings.authorizationStatus}');

    // ৩. FCM টোকেন সংগ্রহ করা
    final fcmToken = await FirebaseMessaging.instance.getToken();
    log("🎯 FCM Token: $fcmToken");
    if (fcmToken != null) {
      await LocalStorage.setString(LocalStorageKeys.fcmToken, fcmToken);
    }

    // ৪. লোকাল নোটিফিকেশন ইনিশিয়ালাইজ করা (ফোরগ্রাউন্ডে দেখানোর জন্য)
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidSettings);
    
    await _localNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (details) {
        log("📩 Notification Tapped: ${details.payload}");
      },
    );

    // ৫. ফোরগ্রাউন্ড মেসেজ লিসেনার
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('📬 Foreground Message: ${message.notification?.title}');
      _showLocalNotification(message);
    });
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    const androidDetails = AndroidNotificationDetails(
      'umodzi_channel',
      'Umodzi Notifications',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );

    const notificationDetails = NotificationDetails(android: androidDetails);

    await _localNotificationsPlugin.show(
      message.hashCode,
      message.notification?.title,
      message.notification?.body,
      notificationDetails,
      payload: message.data.toString(),
    );
  }
}