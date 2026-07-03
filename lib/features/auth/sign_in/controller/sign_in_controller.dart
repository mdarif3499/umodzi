import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decode/jwt_decode.dart';

import '../../../../config/api/api_end_point.dart';
import '../../../../config/route/app_routes.dart';
import '../../../../services/api/api_client.dart';
import '../../../../services/api/api_service.dart';
import '../../../../services/socket/socket_service.dart';
import '../../../../services/storage/storage_keys.dart';
import '../../../../services/storage/storage_services.dart';
import '../../../../utils/app_snackbar.dart';

class SignInController extends GetxController {
  RxInt selectedOption = 0.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  RxBool rememberMe = false.obs;

  void selectOption(int index) {
    selectedOption.value = index;
  }

  void toggleRememberMe(bool? value) {
    rememberMe.value = value ?? false;
  }

  final ApiClient apiClient = DioApiClient();
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    _loadSavedCredentials();
  }

  // Saved credentials load korar jonno
  void _loadSavedCredentials() {
    bool isRemember = LocalStorage.getBool(LocalStorageKeys.rememberMe);
    if (isRemember) {
      rememberMe.value = true;
      emailController.text = LocalStorage.getString(LocalStorageKeys.myEmail);
      passwordController.text = LocalStorage.getString(LocalStorageKeys.password);
    }
  }

  Future<void> signInUser() async {
    if (isLoading) return;

    try {
      isLoading = true;
      update();

      final String fcmToken = LocalStorage.getString(LocalStorageKeys.fcmToken);
      final String deviceId = LocalStorage.getString(LocalStorageKeys.deviceId);
      final String deviceType = Platform.isAndroid ? 'android' : 'ios';

      Map<String, dynamic> body = {
        'fcmToken': fcmToken,
        'deviceId': deviceId,
        'deviceType': deviceType,
      };

      if (selectedOption.value == 0) {
        body.addAll({
          'email': emailController.text.trim(),
          'password': passwordController.text.trim(),
        });
      } else {
        body.addAll({
          'phoneNumber': phoneController.text.trim(),
        });
      }

      final response = await apiClient.post(ApiEndPoint.signIn, body: body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data['data'] ?? {};
        
        final String accessToken = data["accessToken"] ?? "";
        await LocalStorage.setString(LocalStorageKeys.token, accessToken);
        await LocalStorage.setString(LocalStorageKeys.refreshToken, data["refreshToken"] ?? "");
        
        // Remember Me logic
        if (rememberMe.value) {
          await LocalStorage.setBool(LocalStorageKeys.rememberMe, true);
          await LocalStorage.setString(LocalStorageKeys.myEmail, emailController.text.trim());
          await LocalStorage.setString(LocalStorageKeys.password, passwordController.text.trim());
        } else {
          await LocalStorage.setBool(LocalStorageKeys.rememberMe, false);
          await LocalStorage.remove(LocalStorageKeys.password);
        }

        if (accessToken.isNotEmpty) {
          try {
            Map<String, dynamic> payload = Jwt.parseJwt(accessToken);

            final String uId = (payload["id"] ?? "").toString();
            if (uId.isNotEmpty) {
              await LocalStorage.setString(LocalStorageKeys.userId, uId);
            }

            if (payload["email"] != null) await LocalStorage.setString(LocalStorageKeys.myEmail, payload["email"].toString());
            if (payload["role"] != null) await LocalStorage.setString(LocalStorageKeys.role, payload["role"].toString());

          } catch (e) {
            debugPrint("SIGNIN_LOG: Error decoding token: $e");
          }
        }

        await LocalStorage.setBool(LocalStorageKeys.isLogIn, true);

        SocketService.connect();
        SocketService.emit('authenticate', accessToken);

        if (!rememberMe.value) {
          emailController.clear();
          passwordController.clear();
        }
        phoneController.clear();

        Get.offAllNamed(AppRoutes.navBarScreen);
        AppSnackbar.success(title: 'Success', message: response.message);
      } else {
        AppSnackbar.error(title: 'Error', message: response.message);
      }
    } catch (e) {
      debugPrint("SIGNIN_ERROR: $e");
      AppSnackbar.error(title: 'Error', message: e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
