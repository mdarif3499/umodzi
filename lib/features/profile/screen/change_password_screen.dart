import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:umodzi/component/button/common_button.dart';
import 'package:umodzi/component/text/common_text.dart';
import 'package:umodzi/component/text_field/common_text_field.dart';
import '../controller/change_password_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
 Widget build(BuildContext context) {
    final controller = Get.put(ChangePasswordController());

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
                color:  Color(0xFFA53200).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child:  Icon(Icons.arrow_back_ios_new,
                  color: Color(0xFFA53200), size: 18),
            ),
          ),
        ),
        title: CommonText(
          text: 'Change Password',
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            SizedBox(height: 32.h),
            CommonTextField(
              title: 'Current Password',
              hintText: 'Please enter your current password.',
              isPassword: true,
              controller: controller.currentPasswordController,
            ),
            SizedBox(height: 20.h),
            CommonTextField(
              title: 'New Password',
              hintText: 'Please enter your new password.',
              isPassword: true,
              controller: controller.newPasswordController,
            ),
            SizedBox(height: 20.h),
            CommonTextField(
              title: 'Re-enter New Password',
              hintText: 'Re-enter your new password.',
              isPassword: true,
              controller: controller.confirmPasswordController,
            ),
             Spacer(),
            Obx(() => CommonButton(
              titleText: 'Save all Changes',
              buttonColor: Colors.black,
              isLoading: controller.isLoading.value,
              onTap: () => controller.changePassword(),
            )),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
