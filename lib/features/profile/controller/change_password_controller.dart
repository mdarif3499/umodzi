import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:umodzi/config/route/app_routes.dart';
import '../../../config/api/api_end_point.dart';
import '../../../services/api/api_client.dart';
import '../../../services/api/api_service.dart';
import '../../../utils/app_snackbar.dart';

class ChangePasswordController extends GetxController {
  final ApiClient apiClient = DioApiClient();

  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final RxBool isLoading = false.obs;

  Future<void> changePassword() async {
    final currentPassword = currentPasswordController.text.trim();
    final newPassword = newPasswordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (currentPassword.isEmpty ||
        newPassword.isEmpty ||
        confirmPassword.isEmpty) {
      AppSnackbar.error(title: "Required", message: "Please fill all fields");
      return;
    }

    if (newPassword.length < 8) {
      AppSnackbar.error(
          title: "Invalid",
          message: "New password must be at least 8 characters");
      return;
    }

    if (newPassword != confirmPassword) {
      AppSnackbar.error(title: "Mismatch", message: "Passwords do not match");
      return;
    }

    try {
      isLoading.value = true;

      final Map<String, dynamic> body = {
        "currentPassword": currentPassword,
        "newPassword": newPassword,
        "confirmPassword": confirmPassword,
      };

      final response = await apiClient.post(
        ApiEndPoint.changePassword,
        body: body,
      );

      if (response.isSuccess) {
        AppSnackbar.success(title: "Success", message: response.message);
        _clearFields();
        Get.toNamed(AppRoutes.navBarScreen);
      } else {
        AppSnackbar.error(title: "Error", message: response.message);
      }
    } catch (e) {
      AppSnackbar.error(title: "Error", message: "Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void _clearFields() {
    currentPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
  }

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
