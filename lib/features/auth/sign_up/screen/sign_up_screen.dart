import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../component/button/common_button.dart';
import '../../../../component/text/common_text.dart';
import '../../../../component/text_field/common_phone_number_text_filed.dart';
import '../../../../component/text_field/common_text_field.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_images.dart';
import '../../../../utils/helpers/validation.dart';
import '../controller/sign_up_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SignUpController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 40.h),
                  // Logo
                  Center(
                    child: Image.asset(
                      AppImages.appLogoP,
                      height: 68.h,
                      width: 68.w,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 12.h),

                  const CommonText(
                    text: 'Sign up now',
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.center,
                    color: AppColors.color333333,
                  ),
                  SizedBox(height: 6.h),
                  CommonText(
                    text: 'Create an account to access all features.',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.color6A7282,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32.h),

                  CommonTextField(
                    title: 'Full Name',
                    hintText: 'Please enter your full name.',
                    controller: controller.nameController,
                    validator: AppValidation.required,
                  ),
                  SizedBox(height: 20.h),

                  CommonTextField(
                    title: 'Email',
                    hintText: 'Please enter your email address.',
                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: AppValidation.email,
                  ),
                  SizedBox(height: 20.h),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: CommonText(
                      text: "Phone Number",
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: AppColors.color333333,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  CommonPhoneNumberTextFiled(
                    controller: controller.phoneController,
                    countryChange: controller.onCountryChange,
                    initialCountryCode: controller.initialISOCode,
                  ),

                  CommonTextField(
                    title: 'Password',
                    hintText: 'Please enter your password.',
                    isPassword: true,
                    controller: controller.passwordController,
                    validator: AppValidation.password,
                  ),
                  SizedBox(height: 30.h),

                  GetBuilder<SignUpController>(
                    builder: (controller) => CommonButton(
                      isLoading: controller.isLoading,
                      buttonColor: Colors.black,
                      titleText: 'Sign Up',
                      onTap: () => controller.isLoading
                          ? null
                          : _formKey.currentState!.validate()
                              ? controller.signUpUser()
                              : null,
                    ),
                  ),

                  SizedBox(height: 24.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CommonText(
                        text: "Already have an account? ",
                        fontSize: 14,
                        color: AppColors.color333333,
                      ),
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: const CommonText(
                          text: "Sign In",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFA53200),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
