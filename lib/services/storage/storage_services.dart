import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/route/app_routes.dart';
import '../../utils/log/app_log.dart';
import 'storage_keys.dart';

class LocalStorage {

  static String token = "";
  static String refreshToken = "";
  static bool isLogIn = false;
  static String userId = "";
  static String myImage = "";
  static String myName = "";
  static String myEmail = "";
  static String role = "";
  static String plan = "";
  static String adminId = "";

  static SharedPreferences? preferences;

  static Future<SharedPreferences> _getStorage() async {
    preferences ??= await SharedPreferences.getInstance();
    return preferences!;
  }

  static Future<void> getAllPrefData() async {
    final localStorage = await _getStorage();

    token = localStorage.getString(LocalStorageKeys.token) ?? "";
    refreshToken = localStorage.getString(LocalStorageKeys.refreshToken) ?? "";
    isLogIn = localStorage.getBool(LocalStorageKeys.isLogIn) ?? false;
    userId = localStorage.getString(LocalStorageKeys.userId) ?? "";
    myImage = localStorage.getString(LocalStorageKeys.myImage) ?? "";
    myName = localStorage.getString(LocalStorageKeys.myName) ?? "";
    myEmail = localStorage.getString(LocalStorageKeys.myEmail) ?? "";
    role = localStorage.getString(LocalStorageKeys.role) ?? "";
    plan = localStorage.getString(LocalStorageKeys.plan) ?? "";
    adminId = localStorage.getString(LocalStorageKeys.adminId) ?? "";

    appLog(userId, source: "Local Storage");
  }



  static Future<void> setValue(String key, dynamic value) async {
    if (value is String) {
      await preferences?.setString(key, value);
    } else if (value is bool) {
      await preferences?.setBool(key, value);
    } else if (value is int) {
      await preferences?.setInt(key, value);
    } else if (value is double) {
      await preferences?.setDouble(key, value);
    }
  }

  /// Generic Get Method
  /// Eta diye jekono key er value read kora jabe
  static dynamic getValue(String key) {
    return preferences?.get(key);
  }

  /// Remove All Data From SharedPreferences
  static Future<void> removeAllPrefData() async {
    final localStorage = await _getStorage();
    await localStorage.clear();
    _resetLocalStorageData();
    // Get.offAllNamed(AppRoutes.signIn);
    await getAllPrefData();
  }

  // Reset LocalStorage Data
  static void _resetLocalStorageData() {
    final localStorage = preferences!;
    localStorage.setString(LocalStorageKeys.token, "");
    localStorage.setString(LocalStorageKeys.refreshToken, "");
    localStorage.setString(LocalStorageKeys.userId, "");
    localStorage.setString(LocalStorageKeys.myImage, "");
    localStorage.setString(LocalStorageKeys.myName, "");
    localStorage.setString(LocalStorageKeys.myEmail, "");
    localStorage.setBool(LocalStorageKeys.isLogIn, false);
    localStorage.setString(LocalStorageKeys.role, "");
    localStorage.setString(LocalStorageKeys.plan, "");
    localStorage.setString(LocalStorageKeys.adminId, "");
  }

  // Save Data To SharedPreferences
  static Future<void> setString(String key, String value) async {
    final localStorage = await _getStorage();
    await localStorage.setString(key, value);

    // Update static variables to be available immediately without re-reading all
    if (key == LocalStorageKeys.token) token = value;
    if (key == LocalStorageKeys.refreshToken) refreshToken = value;
    if (key == LocalStorageKeys.userId) userId = value;
    if (key == LocalStorageKeys.myImage) myImage = value;
    if (key == LocalStorageKeys.myName) myName = value;
    if (key == LocalStorageKeys.myEmail) myEmail = value;
    if (key == LocalStorageKeys.role) role = value;
    if (key == LocalStorageKeys.plan) plan = value;
    if (key == LocalStorageKeys.adminId) adminId = value;
  }

  static Future<void> setBool(String key, bool value) async {
    final localStorage = await _getStorage();
    await localStorage.setBool(key, value);
    if (key == LocalStorageKeys.isLogIn) isLogIn = value;
  }

  static Future<void> setInt(String key, int value) async {
    final localStorage = await _getStorage();
    await localStorage.setInt(key, value);
  }
}
