import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:umodzi/services/storage/storage_services.dart';
import 'package:umodzi/utils/device_utils.dart';
import 'package:umodzi/utils/log/app_log.dart';
import 'app.dart';
import 'config/core/global_error_handler.dart';
import 'config/dependency/dependency_injection.dart';
import 'features/notification/notification_service.dart';
import 'firebase_options.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      appLog("🔥 Firebase Initialized Successfully");
    } catch (e) {
      if (e.toString().contains('duplicate-app')) {
        appLog("ℹ️ Firebase already running, skipping re-initialization.");
      } else {
        appLog("❌ Firebase Init Error: $e");
      }
    }

    await LocalStorage.init();

    await DeviceUtils.getAndSaveDeviceId();
    appLog("📱 Device ID Captured and Saved");

    await NotificationService().init();
    appLog("🔔 Notification Service Initialized");

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    await _preAppInitialization();

    FlutterError.onError = (details) => globalError(details.exception, details.stack);

    runApp(const MyApp());
  }, (error, stack) => globalError(error, stack));
}

Future<void> _preAppInitialization() async {
  final dI = DependencyInjection();
  dI.dependencies();
  await LocalStorage.getAllPrefData();
}