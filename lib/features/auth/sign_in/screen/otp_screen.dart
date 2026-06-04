import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:umodzi/utils/constants/app_icons.dart';
import '../../../../component/button/common_button.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';
import '../controller/otp_controller.dart';
import '../../../../config/route/app_routes.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OtpController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                SizedBox(height: 20.h),
                // --- Custom Back Button ---
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0x14A53200),                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: 16.sp,
                        color: const Color(0xFFA53200),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40.h),

                // --- Title and Subtitle ---
                const CommonText(
                  text: 'Enter Your OTP',
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.center,
                  color: AppColors.color333333,
                ),
                SizedBox(height: 6.h),
                CommonText(
                  text: 'Enter the code we sent to your phone',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.color6A7282,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32.h),

                // --- OTP Field (MaterialPinField v9.3.0) ---
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: MaterialPinField(
                    length: 4,
                    pinController: controller.pinController,
                    onChanged: (value) {},
                    theme: MaterialPinTheme(
                      shape: MaterialPinShape.circle,
                      cellSize: Size(72.h, 72.h),
                      spacing: 12.w,
                      // Border Colors
                      borderColor: Color(0xFF6A7282),
                      focusedBorderColor: const Color(0xFFA53200),
                      filledBorderColor: Colors.grey.shade300,
                      // Fill Colors
                      fillColor: Colors.white,
                      focusedFillColor: const Color(0xFFA53200),
                      filledFillColor: Colors.white,

                      // Text Style
                      textStyle: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32.h),

                // --- Next Button ---
                CommonButton(
                  buttonColor: Colors.black,
                  titleText: 'Next',
                  onTap: () {
                    _showSuccessDialog(context);
                  },
                ),
                SizedBox(height: 40.h),

                // --- Resend Section ---
                CommonText(
                  text: "Don't receive the code?",
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.color6A7282,
                ),
                SizedBox(height: 8.h),
                Obx(() => GestureDetector(
                      onTap: controller.canResend.value
                          ? () => controller.startTimer()
                          : null,
                      child: CommonText(
                        text: controller.canResend.value
                            ? 'Resend OTP'
                            : controller.timerText,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFE43730),
                      ),
                    )),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- Success Dialog ---
  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
        content: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF4CAF50),
                ),
                child: Image.asset(
                  AppIcons.checkI,

                  height: 44.sp,
                  width: 44,
                ),
              ),
              SizedBox(height: 20.h),
              const CommonText(
                text: 'Verification complete!',
                fontSize: 20,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.center,
                color: AppColors.color333333,
              ),
              SizedBox(height: 11.h),
              CommonText(
                text: 'Everything is set! Let\'s get started',
                fontSize: 16,
                color: AppColors.color6A7282,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w500,

              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
    
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed(AppRoutes.navBarScreen);
    });
  }
}
