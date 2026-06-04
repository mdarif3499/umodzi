import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../component/button/common_button.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';
import '../controller/forgot_otp_controller.dart';

class ForgotOtpScreen extends StatelessWidget {
  const ForgotOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ForgotOtpController>();

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
                        color: const Color(0xFFA53200).withOpacity(0.08),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: 16.sp,
                        color: const Color(0xFFA53200),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40.h),

                CommonText(
                  text: 'OTP Verification',
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.center,
                  color: AppColors.color333333,
                ),
                SizedBox(height: 6.h),
                CommonText(
                  text: 'Please enter the 4-digit code sent to your\n${controller.type}.',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.color6A7282,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.h),
                CommonText(
                  text: controller.identity,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.color333333,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40.h),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CommonText(
                      text: 'OTP Code',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      bottom: 8.h,
                      color: AppColors.color333333,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: MaterialPinField(
                        length: 4,
                        pinController: controller.pinController,
                        onChanged: (value) {},
                        theme: MaterialPinTheme(
                          shape: MaterialPinShape.outlined,
                          borderRadius: BorderRadius.circular(8.r),
                          cellSize: Size(53.w, 50.h),
                          spacing: 8.w,
                          borderColor: const Color(0xFFF2F2F2),
                          focusedBorderColor: const Color(0xFFA53200),
                          filledBorderColor: const Color(0xFFF2F2F2),
                          fillColor: const Color(0xFFF2F2F2),
                          focusedFillColor: const Color(0xFFF2F2F2),
                          filledFillColor: Colors.white,
                          textStyle: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 45.h),

                // --- Verify Button ---
                GetBuilder<ForgotOtpController>(
                  builder: (controller) => CommonButton(
                    isLoading: controller.isLoading,
                    buttonColor: AppColors.black,
                    titleText: 'Verify',
                    onTap: () {
                      controller.verifyOtp();
                    },
                  ),
                ),
                SizedBox(height: 12.h),

                // --- Resend Section ---
                CommonText(
                  text: "Don't receive the code?",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.color333333,
                ),
                SizedBox(height: 12.h),

                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 8.h,
                        ),
                        decoration: BoxDecoration(
                          color:  const Color(0xFFf0ded7),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          children: [
                            _timerBox(controller.minutes, 'minutes'),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 8.w),
                              height: 30.h,
                              width: 2,
                              color: AppColors.white,
                            ),
                            _timerBox(controller.seconds, 'seconds'),
                          ],
                        ),
                      ),
                      SizedBox(width: 16.w),
                      GetBuilder<ForgotOtpController>(
                        builder: (controller) => controller.isResending 
                        ? SizedBox(
                          height: 20.h,
                          width: 20.w,
                          child: const CircularProgressIndicator(strokeWidth: 2, color: Color(0xFFA53200)),
                        )
                        : GestureDetector(
                          onTap: controller.canResend.value
                              ? () => controller.resendOtp()
                              : null,
                          child: CommonText(
                            text: 'Resend',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: controller.canResend.value
                                ? const Color(0xFFA53200)
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _timerBox(String value, String label) {
    return Column(
      children: [
        CommonText(
          text: value,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF003757),
        ),
        CommonText(text: label, fontSize: 10.sp, color: const Color(0xFF003757)),
      ],
    );
  }
}
