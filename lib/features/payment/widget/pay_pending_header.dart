import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../component/text/common_text.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/temp_image.dart';

class PayPendingHeader extends StatelessWidget {
  const PayPendingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Image.asset(
          TempImage.family,
          height: 240.h,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 45.h,
          left: 20.w,
          right: 20.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: CircleAvatar(
                  radius: 20.r,
                  backgroundColor: Colors.black.withOpacity(0.3),
                  child: Icon(Icons.arrow_back_ios_new,
                      color: Colors.white, size: 16.sp),
                ),
              ),
              CommonText(
                text: 'Event Details',
                color: AppColors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(width: 40.w),
            ],
          ),
        ),
      ],
    );
  }
}
