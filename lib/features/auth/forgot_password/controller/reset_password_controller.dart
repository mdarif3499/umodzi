import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../services/api/api_client.dart';
import '../../../../services/api/api_service.dart';
import '../../../../services/storage/storage_services.dart';
import '../../../../utils/app_snackbar.dart';

class ResetPasswordController extends GetxController {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final ApiClient apiClient = DioApiClient();
  bool isLoading = false;

  Future<bool> resetPassword() async {
    if (isLoading) return false;

    if (LocalStorage.token.isEmpty) {
      AppSnackbar.error(title: 'Error', message: 'Verification token is missing. Please verify OTP again.');
      return false;
    }

    try {
      isLoading = true;
      update();

      // Body structure: newPassword and confirmPassword only
      Map<String, dynamic> body = {
        'newPassword': passwordController.text,
        'confirmPassword': confirmPasswordController.text,
      };

      // Sending the token in headers with the key 'token' as requested
      final response = await apiClient.post(
        ApiEndPoint.resetPassword,
        body: body,
        headers: {
          'token': LocalStorage.token,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        AppSnackbar.error(
          title: 'Error',
          message: response.message,
        );
        return false;
      }
    } catch (e) {
      AppSnackbar.error(title: 'Error', message: e.toString());
      return false;
    } finally {
      isLoading = false;
      if (!isClosed) {
        update();
      }
    }
  }

  @override
  void onClose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
