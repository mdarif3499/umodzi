import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../component/text/common_text.dart';
import '../../../utils/constants/app_colors.dart';

class PayPendingSectionCard extends StatelessWidget {
  final String title;
  final Widget content;

  const PayPendingSectionCard({
    super.key,
    required this.title,
    required this.content,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            text: title,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.color333333,
          ),
          SizedBox(height: 12.h),
          content,
        ],
      ),
    );
  }
}
