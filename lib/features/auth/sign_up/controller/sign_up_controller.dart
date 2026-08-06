import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../config/route/app_routes.dart';
import '../../../../services/api/api_client.dart';
import '../../../../services/api/api_service.dart';
import '../../../../utils/app_snackbar.dart';

class SignUpController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final countryCodeController = TextEditingController(text: "+265");
  String initialISOCode = 'MW';

  final ApiClient apiClient = DioApiClient();
  bool isLoading = false;

  void onCountryChange(Country value) {
    countryCodeController.text = "+${value.dialCode}";
  }
  Future<void> signUpUser() async {
    if (isLoading) return;

    try {
      isLoading = true;
      update();

      Map<String, dynamic> body = {
        "name": nameController.text.trim(),
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
        "phone": phoneController.text.trim(),
        "countryCode": countryCodeController.text.trim(),
      };
      final response = await apiClient.post(ApiEndPoint.signUp, body: body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        AppSnackbar.success(title: 'Success', message: response.message);
        Get.toNamed(AppRoutes.otp, arguments: {
          'identity': emailController.text.trim(),
          'type': 'email'
        });
      } else {
        AppSnackbar.error(title: 'Error', message: response.message);
      }
    } catch (e) {
      debugPrint("SIGNUP_ERROR: $e");
      AppSnackbar.error(title: 'Error', message: e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }
  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    countryCodeController.dispose();
    super.onClose();
  }
}
