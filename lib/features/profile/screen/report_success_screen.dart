import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:umodzi/component/button/common_button.dart';
import 'package:umodzi/component/text/common_text.dart';
import 'package:umodzi/utils/constants/app_colors.dart';
import 'package:umodzi/utils/constants/app_icons.dart';

class ReportSuccessScreen extends StatelessWidget {
  const ReportSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Success Icon
              Container(
                height: 120.h,
                width: 120.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:  Color(0xFF4CAF50).withValues(alpha: 0.1),
                ),
                child: Center(
                  child: SizedBox(
                    height: 137.h,
                    width: 137.w,

                 child: Image.asset(
                    AppIcons.successfulI,
                  ),
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              
               CommonText(
                text: 'Report Submitted Successfully',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12.h),
               CommonText(
                text: 'Your report has been sent to the admin. They will review it and contact you if needed.',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.color6A7282,
                textAlign: TextAlign.center,
              ),
              
              SizedBox(height: 80.h),
              
              CommonButton(
                titleText: 'Back to Settings',
                buttonColor: Colors.white,
                titleColor: AppColors.textSecondaryColor,
                borderColor: Colors.grey.shade300,
                showIcon: true,
                onTap: () => Get.back(),
              ),
              SizedBox(height: 16.h),
              
              CommonButton(
                titleText: 'Submit Another Report',
                buttonColor: Colors.black,
                showIcon: true,
                onTap: () => Get.back(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
