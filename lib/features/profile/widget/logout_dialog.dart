import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:umodzi/component/button/common_button.dart';
import 'package:umodzi/component/text/common_text.dart';
import 'package:umodzi/config/route/app_routes.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      backgroundColor: Colors.white,
      contentPadding: EdgeInsets.all(24.sp),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CommonText(
            text: 'Log Out?',
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFFA53200),
          ),
          SizedBox(height: 12.h),
          const CommonText(
            text: 'Are you sure you want to log out?',
            fontSize: 14,
            color: Color(0xFF333333),
            textAlign: TextAlign.center,
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
                  onTap: () => Get.back(),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: CommonButton(
                  titleText: 'Yes',
                  buttonColor: const Color(0xFFD40808),
                  buttonHeight: 40,
                  onTap: () {
                    Get.back();
                    Get.toNamed(AppRoutes.signIn);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
