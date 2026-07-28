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
    try {
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

      NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      ).timeout(const Duration(seconds: 8), onTimeout: () {
        log('🔔 Permission Request Timeout');
        return const NotificationSettings(
          authorizationStatus: AuthorizationStatus.notDetermined,
          alert: AppleNotificationSetting.disabled,
          announcement: AppleNotificationSetting.disabled,
          badge: AppleNotificationSetting.disabled,
          carPlay: AppleNotificationSetting.disabled,
          criticalAlert: AppleNotificationSetting.disabled,
          sound: AppleNotificationSetting.disabled,
          lockScreen: AppleNotificationSetting.disabled,
          notificationCenter: AppleNotificationSetting.disabled,
          showPreviews: AppleShowPreviewSetting.never,
          timeSensitive: AppleNotificationSetting.disabled,
          providesAppNotificationSettings: AppleNotificationSetting.disabled,
        );
      });
      
      log('🔔 Permission Status: ${settings.authorizationStatus}');

      final fcmToken = await FirebaseMessaging.instance.getToken().timeout(
        const Duration(seconds: 8),
        onTimeout: () {
          log("🎯 FCM Token Timeout");
          return null;
        },
      );
      
      if (fcmToken != null) {
        log("🎯 FCM Token: $fcmToken");
        await LocalStorage.setString(LocalStorageKeys.fcmToken, fcmToken);
      }

      const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
      const initSettings = InitializationSettings(android: androidSettings);
      
      await _localNotificationsPlugin.initialize(
        initSettings,
        onDidReceiveNotificationResponse: (details) {
          log("📩 Notification Tapped: ${details.payload}");
        },
      );

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        log('📬 Foreground Message: ${message.notification?.title}');
        _showLocalNotification(message);
      });
    } catch (e) {
      log("❌ NotificationService Init Error: $e");
    }
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    try {
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
    } catch (e) {
      log("❌ Local Notification Show Error: $e");
    }
  }
}
