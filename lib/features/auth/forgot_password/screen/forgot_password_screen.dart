import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:umodzi/utils/helpers/validation.dart';
import '../../../../component/button/common_button.dart';
import '../../../../component/text/common_text.dart';
import '../../../../component/text_field/common_text_field.dart';
import '../../../../utils/constants/app_colors.dart';
import '../controller/forgot_password_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final controller = Get.find<ForgotPasswordController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(8.r),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFA53200).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Color(0xFFA53200),
                size: 18,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20.h),
                CommonText(
                  text: 'Forgot password',
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.color333333,
                ),
                SizedBox(height: 8.h),
                Obx(
                  () => CommonText(
                    text: controller.selectedOption.value == 0
                        ? 'Enter your email account to reset your password'
                        : 'Enter your phone number to reset your password',
                    fontSize: 16.sp,
                    color: AppColors.color6A7282,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 40.h),
                Obx(() {
                  if (controller.selectedOption.value == 0) {
                    return CommonTextField(
                      title: 'Email',
                      hintText: 'Please enter your email address.',
                      controller: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: AppValidation.email,
                    );
                  } else {
                    return CommonTextField(
                      title: 'Phone number',
                      hintText: 'Please enter your phone number.',
                      controller: controller.phoneController,
                      keyboardType: TextInputType.phone,
                      validator: AppValidation.required,
                    );
                  }
                }),
                SizedBox(height: 40.h),
                Obx(() => CommonButton(
                  isLoading: controller.isLoading.value,
                  buttonColor: Colors.black,
                  titleText: 'Reset Password',
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      controller.forgotPassword();
                    }
                  },
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
