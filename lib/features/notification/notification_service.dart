import 'dart:developer';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:umodzi/services/storage/storage_services.dart';
import '../../firebase_options.dart';
import '../../services/storage/storage_keys.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  log('🔥 Background message received: ${message.messageId}');
}

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel _androidChannel =
  AndroidNotificationChannel(
    'high_importance_channel',
    'Important Notifications',
    description: 'Used for important notifications',
    importance: Importance.max,
  );

  Future<void> init() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

    NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
    log('🔔 Permission Status: ${settings.authorizationStatus}');

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    await _handleTokens();
    await _createNotificationChannel();
    await _initializeLocalNotifications();

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('📨 Foreground message received: ${message.notification?.body}');

      if (Platform.isAndroid) {
        _showLocalNotification(message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage msg) {
      log('📩 Notification clicked (background): ${msg.data}');
    });

    final initialMsg = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMsg != null) {
      log('🚀 Opened from terminated: ${initialMsg.data}');
    }
  }

  Future<void> _handleTokens() async {
    try {
      if (Platform.isIOS) {
        String? apnsToken = await FirebaseMessaging.instance.getAPNSToken();
        log("📱 APNs Token: $apnsToken");
      }

      final fcmToken = await FirebaseMessaging.instance.getToken();
      log("🎯 FCM Token: $fcmToken");

      if (fcmToken != null) {
        await LocalStorage.setString(LocalStorageKeys.fcmToken, fcmToken);
      }
    } catch (e) {
      log("⚠️ Token error: $e");
    }
  }

  Future<void> _createNotificationChannel() async {
    if (Platform.isAndroid) {
      final androidPlugin = _localNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
      await androidPlugin?.createNotificationChannel(_androidChannel);
    }
  }

  Future<void> _initializeLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
        android: androidSettings,
        iOS: iosSettings
    );

    await _localNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) {
        log('✅ Notification tapped: ${details.payload}');
      },
    );
  }

  void _showLocalNotification(RemoteMessage message) {
    final n = message.notification;
    final data = message.data;

    final title = n?.title ?? data['title'] ?? '';
    final body = n?.body ?? data['body'] ?? '';

    final String displayTitle = "\u200f$title";
    final String displayBody = "\u200f$body";

    final int notificationId = message.messageId != null
        ? message.messageId.hashCode
        : DateTime.now().millisecondsSinceEpoch ~/ 1000;

    final android = AndroidNotificationDetails(
      _androidChannel.id,
      _androidChannel.name,
      channelDescription: _androidChannel.description,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: BigTextStyleInformation(
        displayBody,
        htmlFormatBigText: false,
        contentTitle: displayTitle,
        htmlFormatContentTitle: false,
      ),
    );

    final ios = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    _localNotificationsPlugin.show(
      notificationId,
      Platform.isIOS ? "\u202E$title\u202C" : displayTitle,
      Platform.isIOS ? "\u202E$body\u202C" : displayBody,
      NotificationDetails(android: android, iOS: ios),
      payload: data.toString(),
    );
  }
}