import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:umodzi/utils/constants/app_icons.dart';
import 'package:umodzi/utils/helpers/validation.dart';

import '../../../../component/button/common_button.dart';
import '../../../../component/text/common_text.dart';
import '../../../../component/text_field/common_phone_number_text_filed.dart';
import '../../../../component/text_field/common_text_field.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_images.dart';
import '../controller/sign_in_controller.dart';
import '../../../../config/route/app_routes.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SignInController>();

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
                    text: 'Sign in now',
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.center,
                    color: AppColors.color333333,
                  ),
                  SizedBox(height: 6.h),
                  CommonText(
                    text: 'Sign in to access your account and continue enjoying all features.',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.color6A7282,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32.h),

                  CommonText(
                    text: 'Choose Sign In Option',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.color333333,
                  ),
                  SizedBox(height: 4.h),

                  Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildOptionIcon(
                            icon: AppIcons.email,
                            isSelected: controller.selectedOption.value == 0,
                            onTap: () => controller.selectOption(0),
                          ),
                          SizedBox(width: 24.w),
                          _buildOptionIcon(
                            icon: AppIcons.phone,
                            isSelected: controller.selectedOption.value == 1,
                            onTap: () => controller.selectOption(1),
                          ),
                        ],
                      )),
                  SizedBox(height: 30.h),

                  Obx(() {
                    if (controller.selectedOption.value == 0) {
                      return _buildEmailSignIn(controller);
                    } else {
                      return _buildPhoneSignIn(controller);
                    }
                  }),

                  SizedBox(height: 24.h),

                  GetBuilder<SignInController>(
                    builder: (controller) => CommonButton(
                      isLoading: controller.isLoading,
                      buttonColor: Colors.black,
                      titleText: controller.selectedOption.value == 0 ? 'Sign In' : 'Next',
                      onTap: () => controller.isLoading
                          ? null
                          : _formKey.currentState!.validate()
                              ? controller.signInUser()
                              : null,
                    ),
                  ),

                  SizedBox(height: 24.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CommonText(
                        text: "Don't have an account? ",
                        fontSize: 14,
                        color: AppColors.color333333,
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.signUp),
                        child: const CommonText(
                          text: "Sign Up",
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

  Widget _buildOptionIcon({
    required String icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(
            icon,
            height: isSelected ? 24.sp : 20.sp,
            width: isSelected ? 24.sp : 20.sp,
            color: isSelected ? const Color(0xFFA53200) : const Color(0xFF99A1AF),
          ),
          SizedBox(height: 4.h),
          if (isSelected)
            Container(
              height: 2.h,
              width: 24.w,
              color: const Color(0xFFA53200),
            )
          else
            SizedBox(height: 2.h),
        ],
      ),
    );
  }

  Widget _buildEmailSignIn(SignInController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonTextField(
          title: 'Email',
          hintText: 'Please enter your email address.',
          controller: controller.emailController,
          keyboardType: TextInputType.emailAddress,
          validator: AppValidation.email,
        ),
        SizedBox(height: 20.h),
        CommonTextField(
          title: 'Password',
          hintText: 'Please enter your password.',
          isPassword: true,
          controller: controller.passwordController,
          validator: AppValidation.password,
        ),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Obx(() => Checkbox(
                      value: controller.rememberMe.value,
                      onChanged: (value) => controller.toggleRememberMe(value),
                      activeColor: const Color(0xFFA53200),
                      visualDensity: VisualDensity.compact,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    )),
                const CommonText(
                  text: 'Remember Me',
                  fontSize: 14,
                  color: Color(0xFF333333),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.forgotPassword, arguments: 0);
              },
              child: const CommonText(
                text: 'Forgot Password?',
                fontSize: 14,
                color: Color(0xFFD32F2F),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPhoneSignIn(SignInController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          text: 'Phone Number',
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.color333333,
        ),
        SizedBox(height: 12.h),
        CommonPhoneNumberTextFiled(
          controller: controller.phoneController,
          countryChange: controller.onCountryChange,
          initialCountryCode: controller.initialISOCode,
        ),
        SizedBox(height: 16.h),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.forgotPassword, arguments: 1);
            },
            child: const CommonText(
              text: 'Forgot Password?',
              fontSize: 14,
              color: Color(0xFFD32F2F),
            ),
          ),
        ),
        SizedBox(height: 24.h),
      ],
    );
  }


}
