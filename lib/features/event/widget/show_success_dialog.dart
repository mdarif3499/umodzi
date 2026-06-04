import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../component/text/common_text.dart';
import '../../../utils/constants/app_icons.dart';

void showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),

        ),
        elevation: 0,
        backgroundColor: Colors.white,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                AppIcons.successIcon,
                height: 60.h,
                width: 60.w,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 24.h),

              CommonText(
                text: 'Payment Successful',
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              SizedBox(height: 12.h),

              CommonText(
                text: 'Your contribution has been successfully completed. Thank you for supporting this cause.',
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF64748B),

                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    },
  );
}