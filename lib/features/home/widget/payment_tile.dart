import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:umodzi/component/text/common_text.dart';
import 'package:umodzi/utils/constants/app_colors.dart';

class PaymentTile extends StatelessWidget {
  final String image;
  final String title;
  final String date;
  final String amount;
  final bool showDivider;

  const PaymentTile({
    super.key,
    required this.image,
    required this.title,
    required this.date,
    required this.amount,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16.r),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: const BoxDecoration(
                  color: Color(0xFFF0FDF4),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(image, width: 24.w, height: 24.h),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: title,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                    SizedBox(height: 2.h),
                    CommonText(
                      text: date,
                      fontSize: 12.sp,
                      color: AppColors.textSecondaryColor,
                    ),
                  ],
                ),
              ),
              CommonText(
                text: amount,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            indent: 72.w, // Aligning divider after the icon
            endIndent: 16.w,
            color: const Color(0xFFF1F5F9),
          ),
      ],
    );
  }
}
