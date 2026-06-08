import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../config/route/app_routes.dart';
import '../../../../services/api/api_client.dart';
import '../../../../services/api/api_service.dart';
import '../../../../services/storage/storage_keys.dart';
import '../../../../services/storage/storage_services.dart';
import '../../../../utils/app_snackbar.dart';

class ForgotOtpController extends GetxController {
  final otpController = TextEditingController();
  late final PinInputController pinController;
  
  RxInt timerSeconds = 90.obs;
  Timer? _timer;
  RxBool canResend = false.obs;

  final ApiClient apiClient = DioApiClient();
  RxBool isLoading = false.obs;
  RxBool isResending = false.obs;
  
  String identity = '';
  String type = '';

  @override
  void onInit() {
    super.onInit();
    pinController = PinInputController(textController: otpController);
    
    if (Get.arguments != null && Get.arguments is Map) {
      identity = Get.arguments['identity'] ?? '';
      type = Get.arguments['type'] ?? '';
    }
    startTimer();
  }

  void startTimer() {
    _timer?.cancel();
    canResend.value = false;
    timerSeconds.value = 90;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timerSeconds.value > 0) {
        timerSeconds.value--;
      } else {
        canResend.value = true;
        timer.cancel();
      }
    });
  }

  Future<void> resendOtp() async {
    if (isResending.value) return;

    try {
      isResending.value = true;
      
      Map<String, String> body = {
        type == 'email' ? 'email' : 'phoneNumber': identity,
      };

      final response = await apiClient.post(ApiEndPoint.forgotPassword, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        startTimer();
        AppSnackbar.success(
          title: 'Success',
          message: 'A new OTP has been sent to your $type',
        );
      } else {
        AppSnackbar.error(title: 'Error', message: response.message);
      }
    } catch (e) {
      AppSnackbar.error(title: 'Error', message: 'Failed to resend OTP. Please try again.');
    } finally {
      isResending.value = false;
    }
  }

  Future<void> verifyOtp() async {
    final otp = otpController.text.trim();
    
    if (otp.isEmpty || otp.length < 4) {
      AppSnackbar.error(title: 'Invalid OTP', message: 'Please enter a valid 4-digit code');
      return;
    }

    if (isLoading.value) return;

    try {
      isLoading.value = true;

      Map<String, dynamic> body = {
        type == 'email' ? 'email' : 'phoneNumber': identity,
        'oneTimeCode': int.tryParse(otp) ?? otp,
      };

      final response = await apiClient.post(ApiEndPoint.verifyOtp, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = response.data['data'] ?? {};
        final verifyToken = data['verifyToken'];

        if (verifyToken != null) {
          await LocalStorage.setString(LocalStorageKeys.token, verifyToken);
        }

        Get.toNamed(AppRoutes.resetPassword);
      } else {
        AppSnackbar.error(title: 'Verification Failed', message: response.message);
      }
    } catch (e) {
      AppSnackbar.error(title: 'Error', message: 'Something went wrong. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  String get minutes => (timerSeconds.value ~/ 60).toString().padLeft(2, '0');
  String get seconds => (timerSeconds.value % 60).toString().padLeft(2, '0');

  @override
  void onClose() {
    _timer?.cancel();
    otpController.dispose();
    pinController.dispose();
    super.onClose();
  }
}
