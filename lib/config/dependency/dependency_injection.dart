import 'package:get/get.dart';
import '../../features/auth/forgot_password/controller/forgot_otp_controller.dart';
import '../../features/auth/forgot_password/controller/forgot_password_controller.dart';
import '../../features/auth/forgot_password/controller/reset_password_controller.dart';
import '../../features/auth/sign_in/controller/otp_controller.dart';
import '../../features/auth/sign_in/controller/sign_in_controller.dart';
import '../../features/auth/sign_up/controller/sign_up_controller.dart';
import '../../features/profile/controller/profile_controller.dart';
import '../../features/profile/controller/report_event_controller.dart';
import '../../features/home/controller/home_controller.dart';

class DependencyInjection extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController(), fenix: true);
    Get.lazyPut(() => SignUpController(), fenix: true);
    Get.lazyPut(() => OtpController(), fenix: true);
    Get.lazyPut(() => ForgotPasswordController(), fenix: true);
    Get.lazyPut(() => ForgotOtpController(), fenix: true);
    Get.lazyPut(() => ResetPasswordController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => ReportEventController(), fenix: true);
    
    // HomeController যুক্ত করা হলো
    Get.lazyPut(() => HomeController(), fenix: true);
  }
}
