import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import '../services/storage/storage_keys.dart';
import '../services/storage/storage_services.dart';
import 'log/app_log.dart';

class DeviceUtils {
  static Future<void> getAndSaveDeviceId() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String? deviceId;

    try {
      appLog("📱 Attempting to retrieve device ID...", source: "DeviceUtils");
      
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceId = androidInfo.id;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceId = iosInfo.identifierForVendor;
      }
      if (deviceId != null) {
        await LocalStorage.setString(LocalStorageKeys.deviceId, deviceId);
        appLog("✅ Device ID Saved: $deviceId", source: "DeviceUtils");
      } else {
        appLog("⚠️ Device ID could not be retrieved.", source: "DeviceUtils");
      }
    } catch (e) {
      appLog("❌ Failed to get device ID: $e", source: "DeviceUtils");
      appLog("💡 Tip: Stop the app and Run it again (Full Restart) to fix MissingPluginException.", source: "DeviceUtils");
    }
  }
}