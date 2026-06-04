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
  
  RxInt timerSeconds = 90.obs; // 1 minute 30 seconds
  Timer? _timer;
  RxBool canResend = false.obs;

  final ApiClient apiClient = DioApiClient();
  bool isLoading = false;
  bool isResending = false;
  
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
    canResend.value = false;
    timerSeconds.value = 90;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timerSeconds.value > 0) {
        timerSeconds.value--;
      } else {
        canResend.value = true;
        _timer?.cancel();
      }
    });
  }

  Future<void> resendOtp() async {
    if (isResending) return;

    try {
      isResending = true;
      update();

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
        AppSnackbar.error(
          title: 'Error',
          message: response.message,
        );
      }
    } catch (e) {
      AppSnackbar.error(title: 'Error', message: e.toString());
    } finally {
      isResending = false;
      if (!isClosed) {
        update();
      }
    }
  }

  Future<void> verifyOtp() async {
    final otp = otpController.text;
    
    if (otp.isEmpty) {
      AppSnackbar.error(title: 'Validation Error', message: 'OTP field cannot be empty');
      return;
    }

    if (otp.length < 4) {
      AppSnackbar.error(title: 'Validation Error', message: 'Please enter a 4-digit OTP');
      return;
    }

    if (isLoading) return;

    try {
      isLoading = true;
      update();

      Map<String, dynamic> body = {
        type == 'email' ? 'email' : 'phoneNumber': identity,
        'oneTimeCode': int.tryParse(otp) ?? otp,
      };

      final response = await apiClient.post(ApiEndPoint.verifyOtp, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = response.data['data'] ?? {};
        final verifyToken = data['verifyToken'];

        if (verifyToken != null) {
          // Saving token to local storage just like SignInController
          await LocalStorage.setString(LocalStorageKeys.token, verifyToken);
        }

        Get.toNamed(AppRoutes.resetPassword);

        AppSnackbar.success(
          title: 'Success',
          message: response.message,
        );
      } else {
        AppSnackbar.error(
          title: 'Error',
          message: response.message,
        );
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
