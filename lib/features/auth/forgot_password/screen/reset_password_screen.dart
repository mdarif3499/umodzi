import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../component/button/common_button.dart';
import '../../../../component/text/common_text.dart';
import '../../../../component/text_field/common_text_field.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_icons.dart';
import '../../../../config/route/app_routes.dart';
import '../../../../utils/helpers/validation.dart';
import '../controller/reset_password_controller.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  // Use Get.find since it is already put in DependencyInjection
  final controller = Get.find<ResetPasswordController>();

  @override
  Widget build(BuildContext context) {
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
              child: const Icon(Icons.arrow_back_ios_new,
                  color: Color(0xFFA53200), size: 18),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20.h),
                CommonText(
                  text: 'Reset Password',
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.color333333,
                ),
                SizedBox(height: 8.h),
                const CommonText(
                  text: 'Enter your new password',
                  fontSize: 16,
                  color: AppColors.color6A7282,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40.h),

                CommonTextField(
                  title: 'New Password',
                  hintText: 'Please enter your password.',
                  isPassword: true,
                  controller: controller.passwordController,
                  validator: AppValidation.password,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: CommonText(
                    text: 'Password must be at least 8 characters long',
                    fontSize: 12.sp,
                    color: AppColors.color6A7282,
                    top: 8.h,
                  ),
                ),
                SizedBox(height: 20.h),
                CommonTextField(
                  title: 'Confirm New Password',
                  hintText: 'Please re-enter your password.',
                  isPassword: true,
                  controller: controller.confirmPasswordController,
                  validator: (value) => AppValidation.confirmPassword(
                    value,
                    controller.passwordController,
                  ),
                ),

                SizedBox(height: 40.h),
                GetBuilder<ResetPasswordController>(
                  builder: (controller) => CommonButton(
                    isLoading: controller.isLoading,
                    buttonColor: Colors.black,
                    titleText: 'Confirm',
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        // Unfocus text fields before API call to prevent disposed controller issues
                        FocusManager.instance.primaryFocus?.unfocus();
                        
                        bool success = await controller.resetPassword();
                        if (success) {
                          _showSuccessDialog(context);
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

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
                  width: 44.sp,
                ),
              ),
              SizedBox(height: 20.h),
              CommonText(
                text: 'Verification complete!',
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.center,
                color: AppColors.color333333,
              ),
              SizedBox(height: 11.h),
              CommonText(
                text: 'Everything is set! Let\'s get started',
                fontSize: 14.sp,
                color: AppColors.color6A7282,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
        ),
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        // Unfocus keyboards before navigation and clearing controllers
        FocusManager.instance.primaryFocus?.unfocus();
        Get.toNamed(AppRoutes.signIn);
      }
    });
  }
}
