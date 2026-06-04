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
  bool isLoading = false;

  void selectOption(int index) {
    selectedOption.value = index;
  }

  Future<void> forgotPassword() async {
    if (isLoading) return;

    try {
      isLoading = true;
      update();

      Map<String, String> body = {};
      if (selectedOption.value == 0) {
        body = {'email': emailController.text.trim()};
      } else {
        body = {'phoneNumber': phoneController.text.trim()};
      }

      final response = await apiClient.post(ApiEndPoint.forgotPassword, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.toNamed(AppRoutes.forgotOtp, arguments: {
          'identity': selectedOption.value == 0 ? emailController.text.trim() : phoneController.text.trim(),
          'type': selectedOption.value == 0 ? 'email' : 'phone'
        });
        AppSnackbar.success(title: 'Success', message: response.message);
      } else {
        AppSnackbar.error(title: 'Error', message: response.message);
      }
    } catch (e) {
      AppSnackbar.error(title: 'Error', message: e.toString());
    } finally {
      isLoading = false;
      if (!isClosed) {
        update();
      }
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
