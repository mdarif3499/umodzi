import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:umodzi/component/button/common_button.dart';
import 'package:umodzi/component/text/common_text.dart';
import 'package:umodzi/component/text_field/common_text_field.dart';


class DeleteAccountDialog extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onDelete;

  const DeleteAccountDialog({
    super.key,
    required this.controller,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      contentPadding: EdgeInsets.all(24.sp),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CommonText(
            text: 'Delete Account?',
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFFD32F2F),
          ),
          SizedBox(height: 12.h),
          const CommonText(
            text: 'This will permanently delete your account. Continue?',
            fontSize: 14,
            color: Color(0xFF333333),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.h),
          CommonTextField(
            hintText: 'Enter your password',
            isPassword: true,
            controller: controller,
          ),
          SizedBox(height: 24.h),
          Row(
            children: [
              Expanded(
                child: CommonButton(
                  titleText: 'No',
                  buttonColor: Colors.white,
                  titleColor: Colors.black,
                  borderColor: Colors.grey.shade300,
                  buttonHeight: 40,
                  onTap: () {
                    Get.back();


                  }),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: CommonButton(
                  titleText: 'Yes',
                  buttonColor: const Color(0xFFD32F2F),
                  buttonHeight: 40,
                  onTap: onDelete,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
