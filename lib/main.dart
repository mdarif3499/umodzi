import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:umodzi/services/storage/storage_services.dart';
import 'package:umodzi/utils/log/app_log.dart';
import 'app.dart';
import 'config/core/global_error_handler.dart';
import 'config/dependency/dependency_injection.dart';
import 'features/notification/notification_service.dart';
import 'services/socket/socket_service.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    try {
      await NotificationService().init();
      appLog("🔥 Firebase & Notification Service Initialized Successfully");
    } catch (e) {
      appLog("Firebase/Notification Error: $e");
    }

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
  try {
    final dI = DependencyInjection();
    dI.dependencies();

    await Future.wait([
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]),
      LocalStorage.getAllPrefData(),
    ]);

    if (LocalStorage.token.isNotEmpty) {
      Future.delayed(const Duration(milliseconds: 500), () {
        SocketService.connect();
      });
    }
  } catch (e, stack) {
    globalError(e, stack);
  }
}