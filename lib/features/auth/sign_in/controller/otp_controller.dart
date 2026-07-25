import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../services/api/api_client.dart';
import '../../../../services/api/api_service.dart';
import '../../../../services/socket/socket_service.dart';
import '../../../../services/storage/storage_keys.dart';
import '../../../../services/storage/storage_services.dart';
import '../../../../utils/app_snackbar.dart';

class OtpController extends GetxController {
  final otpController = TextEditingController();
  late final PinInputController pinController;
  
  RxInt timerSeconds = 90.obs;
  Timer? _timer;
  RxBool canResend = false.obs;

  final ApiClient apiClient = DioApiClient();
  RxBool isLoading = false.obs;
  RxBool isResending = false.obs;
  
  RxString identity = ''.obs;
  RxString type = ''.obs;

  @override
  void onInit() {
    super.onInit();
    pinController = PinInputController(textController: otpController);
    
    if (Get.arguments != null) {
      if (Get.arguments is Map) {
        identity.value = (Get.arguments['identity'] ?? '').toString().trim();
        type.value = (Get.arguments['type'] ?? '').toString().trim();
      }
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
    
    if (identity.value.isEmpty) {
      AppSnackbar.error(title: 'Error', message: 'Email or phone is missing. Please restart the process.');
      return;
    }

    try {
      isResending.value = true;
      
      Map<String, String> body = {
        type.value == 'email' ? 'email' : 'phone': identity.value,
      };

      debugPrint("RESEND_OTP_LOG: Body: $body");

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
      debugPrint("RESEND_OTP_ERROR: $e");
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
        type.value == 'email' ? 'email' : 'phone': identity.value,
        'oneTimeCode': int.tryParse(otp) ?? otp,
      };

      final response = await apiClient.post(ApiEndPoint.verifyEmail, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = response.data['data'] ?? {};

        final String accessToken = data["accessToken"] ?? "";
        await LocalStorage.setString(LocalStorageKeys.token, accessToken);
        await LocalStorage.setString(
            LocalStorageKeys.refreshToken, data["refreshToken"] ?? "");

        if (accessToken.isNotEmpty) {
          try {
            Map<String, dynamic> payload = Jwt.parseJwt(accessToken);

            final String uId = (payload["id"] ?? "").toString();
            if (uId.isNotEmpty) {
              await LocalStorage.setString(LocalStorageKeys.userId, uId);
            }

            if (payload["email"] != null) {
              await LocalStorage.setString(
                  LocalStorageKeys.myEmail, payload["email"].toString());
            }
            if (payload["role"] != null) {
              await LocalStorage.setString(
                  LocalStorageKeys.role, payload["role"].toString());
            }
          } catch (e) {
            debugPrint("OTP_VERIFY_LOG: Error decoding token: $e");
          }
        }

        await LocalStorage.setBool(LocalStorageKeys.isLogIn, true);

        SocketService.connect();
        SocketService.emit('authenticate', accessToken);

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
