import 'dart:async';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpController extends GetxController {
  // pin_code_fields 9.3.0 এর জন্য নতুন PinInputController
  final pinController = PinInputController();
  
  RxInt timerSeconds = 30.obs;
  Timer? _timer;
  RxBool canResend = false.obs;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    canResend.value = false;
    timerSeconds.value = 30;
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

  String get timerText {
    String seconds = timerSeconds.value.toString().padLeft(2, '0');
    return "Resend in 00:$seconds s";
  }

  @override
  void onClose() {
    _timer?.cancel();
    pinController.dispose();
    super.onClose();
  }
}
