import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../config/route/app_routes.dart';
import '../../../../services/api/api_client.dart';
import '../../../../services/api/api_service.dart';
import '../../../../utils/app_snackbar.dart';

class ForgotPasswordController extends GetxController {
  RxInt selectedOption = 0.obs;

  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  final ApiClient apiClient = DioApiClient();
  RxBool isLoading = false.obs;

  void selectOption(int index) {
    selectedOption.value = index;
  }

  Future<void> forgotPassword() async {
    if (isLoading.value) return;

    final String identity = selectedOption.value == 0 
        ? emailController.text.trim() 
        : phoneController.text.trim();

    if (identity.isEmpty) {
      AppSnackbar.error(title: 'Error', message: 'Please enter your ${selectedOption.value == 0 ? 'email' : 'phone number'}');
      return;
    }

    try {
      isLoading.value = true;

      Map<String, String> body = {};
      if (selectedOption.value == 0) {
        body = {'email': identity};
      } else {
        body = {'phoneNumber': identity};
      }

      final response = await apiClient.post(ApiEndPoint.forgotPassword, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.toNamed(AppRoutes.forgotOtp, arguments: {
          'identity': identity,
          'type': selectedOption.value == 0 ? 'email' : 'phone'
        });
        AppSnackbar.success(title: 'Success', message: 'OTP sent successfully');
      } else {
        AppSnackbar.error(title: 'Error', message: response.message);
      }
    } catch (e) {
      AppSnackbar.error(title: 'Error', message: 'Something went wrong. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is int) {
      selectedOption.value = Get.arguments;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
