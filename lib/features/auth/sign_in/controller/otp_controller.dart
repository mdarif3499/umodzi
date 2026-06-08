import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../config/route/app_routes.dart';
import '../../../../services/api/api_client.dart';
import '../../../../services/api/api_service.dart';
import '../../../../utils/app_snackbar.dart';

class OtpController extends GetxController {
  final otpController = TextEditingController();
  late final PinInputController pinController;
  
  RxInt timerSeconds = 30.obs;
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
    timerSeconds.value = 30;
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

      final response = await apiClient.post(ApiEndPoint.resendOtp, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        startTimer();
        AppSnackbar.success(
          title: 'Success',
          message: 'OTP has been resent successfully',
        );
      } else {
        AppSnackbar.error(title: 'Error', message: response.message);
      }
    } catch (e) {
      AppSnackbar.error(title: 'Error', message: 'Failed to resend OTP');
    } finally {
      isResending.value = false;
    }
  }

  Future<void> verifyOtp(BuildContext context, Function onSuccess) async {
    final otp = otpController.text.trim();
    
    if (otp.isEmpty || otp.length < 4) {
      AppSnackbar.error(title: 'Invalid OTP', message: 'Please enter a 4-digit OTP');
      return;
    }

    if (isLoading.value) return;

    try {
      isLoading.value = true;

      Map<String, dynamic> body = {
        type == 'email' ? 'email' : 'phoneNumber': identity,
        'oneTimeCode': int.tryParse(otp) ?? otp,
      };

      final response = await apiClient.post(ApiEndPoint.verifyEmail, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        onSuccess();
      } else {
        AppSnackbar.error(title: 'Error', message: response.message);
      }
    } catch (e) {
      AppSnackbar.error(title: 'Error', message: 'Something went wrong');
    } finally {
      isLoading.value = false;
    }
  }

  String get timerText {
    String seconds = timerSeconds.value.toString().padLeft(2, '0');
    return "Resend in 00:$seconds s";
  }

  @override
  void onClose() {
    _timer?.cancel();
    otpController.dispose();
    pinController.dispose();
    super.onClose();
  }
}
